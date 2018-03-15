Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeCOLnJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:43:09 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59408 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751964AbeCOLlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:41:42 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] ARM: dts: sun9i: cubieboard4: Enable VGA display output
Date: Thu, 15 Mar 2018 19:41:36 +0800
Message-Id: <20180315114136.24747-9-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315114136.24747-1-wens@csie.org>
References: <20180315114136.24747-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cubieboard4 has a dumb VGA DAC connected to the output of LCD0,
providing VGA output through the onboard VGA connector. The DDC lines
are connected to i2c3.

The VGA DAC is a GM7123, which is compatible with Analog Devices'
ADV7123, except it only takes 3.3V power, and has a lower standby power
consumption. The datasheet found online lists "Chengdu GoldTel Electronical
Technology Co., Ltd." as its designer. The company changed its name in
2014 to "Chengdu Corpro Technology Co., Ltd.". Their website lists similar
ICs, but not actually the GM7123.

Enable the display pipeline with the VGA DAC and connector, and i2c3
for DDC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 68 +++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 31b06ecbc306..85da85faf869 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -74,6 +74,52 @@
 		};
 	};
 
+	vga-connector {
+		compatible = "vga-connector";
+		label = "vga";
+		ddc-i2c-bus = <&i2c3>;
+
+		port {
+			vga_con_in: endpoint {
+				remote-endpoint = <&vga_dac_out>;
+			};
+		};
+	};
+
+	vga-dac {
+		compatible = "corpro,gm7123", "adi,adv7123", "dumb-vga-dac";
+		vdd-supply = <&reg_dcdc1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+
+				vga_dac_in: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&tcon0_out_vga>;
+				};
+			};
+
+			port@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+
+				vga_dac_out: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&vga_con_in>;
+				};
+			};
+		};
+	};
+
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
@@ -83,6 +129,16 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -402,6 +458,18 @@
 
 #include "axp809.dtsi"
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd0_rgb888_pins>;
+};
+
+&tcon0_out {
+	tcon0_out_vga: endpoint@0 {
+		reg = <0>;
+		remote-endpoint = <&vga_dac_in>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.16.2
