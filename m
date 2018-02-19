Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeBSIUq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:20:46 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:56976 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752062AbeBSITC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:19:02 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH v3 2/2] arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou
Date: Mon, 19 Feb 2018 09:18:54 +0100
Message-Id: <20180219081855.34400-3-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180219081855.34400-1-klaus.goger@theobroma-systems.com>
References: <20180219081855.34400-1-klaus.goger@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the NXP SGTL5000 audio codec on the RK3399-Q7 EVK baseboard
Haikou.

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

---

Changes in v3:
- split i2s0 move from rk3399-puma-haikou.dts to rk3399-puma.dtsi into it's
  own patch
- use dasheѕ in node names
- added missing vin-supply properties to regulators
  had to add an additional regulator to model this correctly
- simple overwrite pins in i2s0_2ch_bus instead of deleting and redefining
  the node

Changes in v2:
- reordered entries as suggested in review
- removed a conflicting i2s definition in rk3399-puma-haikou.dts
  i2s0 was already enabled in rk3399-puma.dtsi as it should be,
  so reuse it and fix the incorrect rockchip,*-channels values
- add a patch to the series that definies a generic i2s0-2ch-bus
- overwrite the generic pin definition of i2s0-2ch-bus with a specific
  one used in the Haikou with RK3399-Q7 setup

 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 63 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 14 +++++
 2 files changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 8fd0d7ba1dc9..7966f7828504 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -61,6 +61,24 @@
 		};
 	};
 
+	i2s0-sound {
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
@@ -80,6 +98,16 @@
 		vin-supply = <&dc_12v>;
 	};
 
+	vcc5v0_baseboard: vcc5v0-baseboard {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
 	vcc5v0_otg: vcc5v0-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -89,6 +117,30 @@
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
+		vin-supply = <&vcc5v0_baseboard>;
+	};
+
+	vddd_codec: vddd-codec {
+		compatible = "regulator-fixed";
+		regulator-name = "vddd_codec";
+		regulator-boot-on;
+		regulator-min-microvolt = <1600000>;
+		regulator-max-microvolt = <1600000>;
+		vin-supply = <&vcc5v0_baseboard>;
+	};
+
+	sgtl5000_clk: sgtl5000-oscillator  {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency  = <24576000>;
+	};
 };
 
 &i2c1 {
@@ -110,6 +162,17 @@
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
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index fc913e2d962f..4a2d06abe9c1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -443,6 +443,20 @@
 	status = "okay";
 };
 
+/*
+ * As Q7 does not specify neither a global nor a RX clock for I2S these
+ * signals are not used. Furthermore I2S0_LRCK_RX is used as GPIO.
+ * Therefore we have to redefine the i2s0_2ch_bus definition to prevent
+ * conflicts.
+ */
+&i2s0_2ch_bus {
+	rockchip,pins =
+		<RK_GPIO3 RK_PD0 RK_FUNC_1 &pcfg_pull_none>,
+		<RK_GPIO3 RK_PD2 RK_FUNC_1 &pcfg_pull_none>,
+		<RK_GPIO3 RK_PD3 RK_FUNC_1 &pcfg_pull_none>,
+		<RK_GPIO3 RK_PD7 RK_FUNC_1 &pcfg_pull_none>;
+};
+
 &io_domains {
 	status = "okay";
 	bt656-supply = <&vcc_1v8>;
-- 
2.11.0
