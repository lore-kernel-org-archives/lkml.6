Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeA3KaJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:30:09 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:45066 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751718AbeA3KaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:30:07 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH] arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou
Date: Tue, 30 Jan 2018 11:15:31 +0100
Message-Id: <20180130101531.41411-1-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
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

 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 49 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 18 ++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 9a7486058455..060c6be7d7e3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -61,6 +61,22 @@
 		};
 	};
 
+	i2s0_sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Haikou,I2S-codec";
+		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+			frame-master;
+			bitclock-master;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+			clocks = <&sgtl5000_clk>;
+		};
+	};
+
 	dc_12v: dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
@@ -89,6 +105,28 @@
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
@@ -110,6 +148,17 @@
 &i2c4 {
 	status = "okay";
 	clock-frequency = <400000>;
+
+	sgtl5000: codec@0a {
+		#sound-dai-cells = <0>;
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		VDDA-supply = <&vdda_codec>;
+		VDDIO-supply = <&vdda_codec>;
+		VDDD-supply = <&vddd_codec>;
+		clocks = <&sgtl5000_clk>;
+		status = "okay";
+	};
 };
 
 &i2c6 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 1fc5060d7027..a3fcb803ff69 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -435,6 +435,14 @@
 	};
 };
 
+&i2s0 {
+	#sound-dai-cells = <0>;
+	status = "okay";
+	pinctrl-0 = <&i2s0_2ch_bus>;
+	rockchip,playback-channels = <2>;
+	rockchip,capture-channels = <2>;
+};
+
 &io_domains {
 	status = "okay";
 	bt656-supply = <&vcc_1v8>;
@@ -461,6 +469,16 @@
 		};
 	};
 
+	i2s0 {
+		i2s0_2ch_bus: i2s0_2ch_bus {
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
