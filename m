Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeBCPu5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 10:50:57 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:56434 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752103AbeBCPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 10:50:42 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou
Date: Sat,  3 Feb 2018 16:50:16 +0100
Message-Id: <20180203155016.51909-3-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180203155016.51909-1-klaus.goger@theobroma-systems.com>
References: <20180203155016.51909-1-klaus.goger@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the NXP SGTL5000 audio codec on the RK3399-Q7 EVK baseboard
Haikou.

The i2s0_2ch_bus definition is only done in the SoM dtsi as it is
missing the LRCK_RX pin (that is used otherwise) and therefore not
generic enough for the SoC dtsi.

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

---

Changes in v2:
- reordered entries as suggested in review
- removed a conflicting i2s definition in rk3399-puma-haikou.dts
  i2s0 was already enabled in rk3399-puma.dtsi as it should be,
  so reuse it and fix the incorrect rockchip,*-channels values
- add a patch to the series that definies a generic i2s0-2ch-bus
- overwrite the generic pin definition of i2s0-2ch-bus with a specific
  one used in the Haikou with RK3399-Q7 setup.

 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 59 +++++++++++++++++++---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 25 +++++++++
 2 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 9a7486058455..0e2fe2ae75ee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -61,6 +61,24 @@
 		};
 	};
 
+	i2s0_sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Haikou,I2S-codec";
+		simple-audio-card,mclk-fs = <512>;
+
+		simple-audio-card,codec {
+			clocks = <&sgtl5000_clk>;
+			sound-dai = <&sgtl5000>;
+		};
+
+		simple-audio-card,cpu {
+			bitclock-master;
+			frame-master;
+			sound-dai = <&i2s0>;
+		};
+	};
+
 	dc_12v: dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
@@ -89,6 +107,28 @@
 		regulator-name = "vcc5v0_otg";
 		regulator-always-on;
 	};
+
+	vdda_codec: vdda-codec {
+		compatible = "regulator-fixed";
+		regulator-name = "vdda_codec";
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vddd_codec: vddd-codec {
+		compatible = "regulator-fixed";
+		regulator-name = "vddd_codec";
+		regulator-boot-on;
+		regulator-min-microvolt = <1600000>;
+		regulator-max-microvolt = <1600000>;
+	};
+
+	sgtl5000_clk: sgtl5000-oscillator  {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency  = <24576000>;
+	};
 };
 
 &i2c1 {
@@ -110,6 +150,17 @@
 &i2c4 {
 	status = "okay";
 	clock-frequency = <400000>;
+
+	sgtl5000: codec@0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&sgtl5000_clk>;
+		#sound-dai-cells = <0>;
+		VDDA-supply = <&vdda_codec>;
+		VDDIO-supply = <&vdda_codec>;
+		VDDD-supply = <&vddd_codec>;
+		status = "okay";
+	};
 };
 
 &i2c6 {
@@ -117,14 +168,6 @@
 	clock-frequency = <400000>;
 };
 
-&i2s0 {
-	status = "okay";
-	rockchip,playback-channels = <8>;
-	rockchip,capture-channels = <8>;
-	#sound-dai-cells = <0>;
-	status = "okay";
-};
-
 &pcie_phy {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 1fc5060d7027..fb57da126169 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -435,6 +435,14 @@
 	};
 };
 
+&i2s0 {
+	pinctrl-0 = <&i2s0_2ch_bus>;
+	rockchip,playback-channels = <2>;
+	rockchip,capture-channels = <2>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
 &io_domains {
 	status = "okay";
 	bt656-supply = <&vcc_1v8>;
@@ -461,6 +469,23 @@
 		};
 	};
 
+	i2s0 {
+		/*
+		 * As Q7 does not specify neither a global nor a RX clock for I2S these
+		 * signals are not used. Furthermore I2S0_LRCK_RX is used as GPIO.
+		 * Therefore we have to redefine the i2s0_2ch_bus definition to prevent
+		 * conflicts.
+		 */
+		/delete-node/ i2s0_2ch_bus;
+		i2s0_2ch_bus: i2s0-2ch-bus {
+			rockchip,pins =
+				<RK_GPIO3 RK_PD0 RK_FUNC_1 &pcfg_pull_none>,
+				<RK_GPIO3 RK_PD2 RK_FUNC_1 &pcfg_pull_none>,
+				<RK_GPIO3 RK_PD3 RK_FUNC_1 &pcfg_pull_none>,
+				<RK_GPIO3 RK_PD7 RK_FUNC_1 &pcfg_pull_none>;
+		};
+	};
+
 	leds {
 		led_pin_module: led-module-gpio {
 			rockchip,pins =
-- 
2.11.0
