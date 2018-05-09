Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964960AbeEIPfP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:35:15 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53542 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935346AbeEIPfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:35:14 -0400
X-Auth-Info: Wld2mUJT1fEFuLGJx83nY7+xu9MZ99356KRSCfYz1wo=
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards from K+P
Date: Wed,  9 May 2018 17:34:28 +0200
Message-Id: <20180509153428.1440-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit provides support for HSC and DDC boards from
Kieback&Peter GmbH vendor.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/Makefile         |   2 +
 arch/arm/boot/dts/imx53-kp-ddc.dts | 146 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx53-kp-hsc.dts |  53 ++++++++++
 arch/arm/boot/dts/imx53-kp.dtsi    | 191 +++++++++++++++++++++++++++++++++++++
 4 files changed, 392 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-kp-ddc.dts
 create mode 100644 arch/arm/boot/dts/imx53-kp-hsc.dts
 create mode 100644 arch/arm/boot/dts/imx53-kp.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fbc04b0db781..00854a5b6ac4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -360,6 +360,8 @@ dtb-$(CONFIG_SOC_IMX51) += \
 dtb-$(CONFIG_SOC_IMX53) += \
 	imx53-ard.dtb \
 	imx53-cx9020.dtb \
+	imx53-kp-ddc.dtb \
+	imx53-kp-hsc.dtb \
 	imx53-m53evk.dtb \
 	imx53-mba53.dtb \
 	imx53-ppd.dtb \
diff --git a/arch/arm/boot/dts/imx53-kp-ddc.dts b/arch/arm/boot/dts/imx53-kp-ddc.dts
new file mode 100644
index 000000000000..acaf477a52c5
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-kp-ddc.dts
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2018
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx53-kp.dtsi"
+
+/ {
+	model = "K+P imx53 DDC";
+	compatible = "kiebackpeter,imx53-ddc", "fsl,imx53";
+
+	backlight_lcd: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 50000>;
+		power-supply = <&reg_backlight>;
+		brightness-levels = <0 24 28 32 36
+				     40 44 48 52 56
+				     60 64 68 72 76
+				     80 84 88 92 96 100>;
+		default-brightness-level = <20>;
+	};
+
+	lcd_display: disp1 {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "rgb24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_disp>;
+
+		port@0 {
+			reg = <0>;
+
+			display1_in: endpoint {
+				remote-endpoint = <&ipu_di1_disp1>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			lcd_display_out: endpoint {
+				remote-endpoint = <&lcd_panel_in>;
+			};
+		};
+	};
+
+	lcd_panel: lcd-panel {
+		compatible = "koe,tx14d24vm1bpa";
+		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
+
+	reg_backlight: regulator-backlight {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight-supply";
+		regulator-min-microvolt = <15000000>;
+		regulator-max-microvolt = <15000000>;
+		regulator-always-on;
+	};
+};
+
+&i2c3 {
+	adc@48 {
+		compatible = "ti,ads1015";
+		reg = <0x48>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@4 {
+			reg = <4>;
+			ti,gain = <2>;
+			ti,datarate = <4>;
+		};
+
+		channel@6 {
+			reg = <6>;
+			ti,gain = <2>;
+			ti,datarate = <4>;
+		};
+	};
+
+	gpio_expander2@21 {
+		compatible = "nxp,pcf8574";
+		reg = <0x21>;
+		interrupts = <109>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+};
+
+&iomuxc {
+	imx53-kp-ddc {
+		pinctrl_disp: dispgrp {
+			fsl,pins = <
+				MX53_PAD_EIM_A16__IPU_DI1_DISP_CLK      0x4
+				MX53_PAD_EIM_DA10__IPU_DI1_PIN15        0x4
+				MX53_PAD_EIM_DA9__IPU_DISP1_DAT_0       0x4
+				MX53_PAD_EIM_DA8__IPU_DISP1_DAT_1       0x4
+				MX53_PAD_EIM_DA7__IPU_DISP1_DAT_2       0x4
+				MX53_PAD_EIM_DA6__IPU_DISP1_DAT_3       0x4
+				MX53_PAD_EIM_DA5__IPU_DISP1_DAT_4       0x4
+				MX53_PAD_EIM_DA4__IPU_DISP1_DAT_5       0x4
+				MX53_PAD_EIM_DA3__IPU_DISP1_DAT_6       0x4
+				MX53_PAD_EIM_DA2__IPU_DISP1_DAT_7       0x4
+				MX53_PAD_EIM_DA1__IPU_DISP1_DAT_8       0x4
+				MX53_PAD_EIM_DA0__IPU_DISP1_DAT_9       0x4
+				MX53_PAD_EIM_EB1__IPU_DISP1_DAT_10      0x4
+				MX53_PAD_EIM_EB0__IPU_DISP1_DAT_11      0x4
+				MX53_PAD_EIM_A17__IPU_DISP1_DAT_12      0x4
+				MX53_PAD_EIM_A18__IPU_DISP1_DAT_13      0x4
+				MX53_PAD_EIM_A19__IPU_DISP1_DAT_14      0x4
+				MX53_PAD_EIM_A20__IPU_DISP1_DAT_15      0x4
+				MX53_PAD_EIM_A21__IPU_DISP1_DAT_16      0x4
+				MX53_PAD_EIM_A22__IPU_DISP1_DAT_17      0x4
+				MX53_PAD_EIM_A23__IPU_DISP1_DAT_18      0x4
+				MX53_PAD_EIM_A24__IPU_DISP1_DAT_19      0x4
+				MX53_PAD_EIM_D31__IPU_DISP1_DAT_20      0x4
+				MX53_PAD_EIM_D30__IPU_DISP1_DAT_21      0x4
+				MX53_PAD_EIM_D26__IPU_DISP1_DAT_22      0x4
+				MX53_PAD_EIM_D27__IPU_DISP1_DAT_23      0x4
+				MX53_PAD_GPIO_1__PWM2_PWMO 0x4
+			>;
+		};
+	};
+};
+
+&ipu_di1_disp1 {
+	remote-endpoint = <&display1_in>;
+};
+
+&fec {
+	status = "okay";
+};
+
+&pmic {
+	fsl,mc13xxx-uses-touch;
+};
diff --git a/arch/arm/boot/dts/imx53-kp-hsc.dts b/arch/arm/boot/dts/imx53-kp-hsc.dts
new file mode 100644
index 000000000000..fff358395c9d
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-kp-hsc.dts
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2018
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx53-kp.dtsi"
+
+/ {
+	model = "K+P imx53 HSC";
+	compatible = "kiebackpeter,imx53-hsc", "fsl,imx53";
+
+};
+
+&fec {
+	status = "okay";
+
+	fixed-link { /* RMII fixed link to LAN9303 */
+		speed = <100>;
+		full-duplex;
+	};
+};
+
+&i2c3 {
+	switch: switch@a {
+		compatible = "smsc,lan9303-i2c";
+		reg = <0xa>;
+		reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+		reset-duration = <400>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 { /* RMII fixed link to master */
+				reg = <0>;
+				label = "cpu";
+				ethernet = <&fec>;
+			};
+
+			port@1 { /* external port 1 */
+				reg = <1>;
+				label = "lan1";
+			};
+
+			port@2 { /* external port 2 */
+				reg = <2>;
+				label = "lan2";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx53-kp.dtsi b/arch/arm/boot/dts/imx53-kp.dtsi
new file mode 100644
index 000000000000..86bea3217f18
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-kp.dtsi
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2018
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx53-tqma53.dtsi"
+
+/ {
+	buzzer {
+		compatible = "pwm-beeper";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_buzzer>;
+
+		pwms = <&pwm1 0 500000>;
+	};
+
+	gpio_buttons {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiobuttons>;
+
+		button@1 {
+			label = "Kaltstart";
+			linux,code = <64>; /* KEY_F6 */
+			gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
+		};
+		button@2 {
+			label = "PowerFailInterrupt";
+			linux,code = <65>; /* KEY_F7 */
+			gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led_bus {
+			label = "bus";
+			gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "gpio";
+			default-state = "off";
+		};
+
+		led_error {
+			label = "error";
+			gpios = <&gpio3 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "gpio";
+			default-state = "off";
+		};
+
+		led_flash {
+			label = "flash";
+			gpios = <&gpio5 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+
+	gpio_expander1@22 {
+		compatible = "nxp,pcf8574";
+		reg = <0x22>;
+		interrupts = <109>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kp_common>;
+
+	imx53-kp-common {
+		pinctrl_buzzer: buzzergrp {
+			fsl,pins = <
+				MX53_PAD_SD1_DATA3__PWM1_PWMO 0x1e4
+			>;
+		};
+
+		pinctrl_gpiobuttons: gpiobuttonsgrp {
+			fsl,pins = <
+				MX53_PAD_EIM_RW__GPIO2_26 0x1e4
+				MX53_PAD_EIM_D22__GPIO3_22 0x1e4
+			>;
+		};
+
+		pinctrl_kp_common: kpcommongrp {
+			fsl,pins = <
+				MX53_PAD_EIM_CS0__GPIO2_23 0x1e4
+				MX53_PAD_GPIO_19__GPIO4_5  0x1e4
+				MX53_PAD_PATA_DATA6__GPIO2_6 0x1e4
+				MX53_PAD_PATA_DATA7__GPIO2_7 0xe0
+				MX53_PAD_CSI0_DAT14__GPIO6_0 0x1e4
+				MX53_PAD_CSI0_DAT16__GPIO6_2 0x1e4
+				MX53_PAD_CSI0_DAT18__GPIO6_4 0x1e4
+				MX53_PAD_EIM_D17__GPIO3_17 0x1e4
+				MX53_PAD_EIM_D18__GPIO3_18 0x1e4
+				MX53_PAD_EIM_D21__GPIO3_21 0x1e4
+				MX53_PAD_EIM_D29__GPIO3_29 0x1e4
+				MX53_PAD_EIM_DA11__GPIO3_11 0x1e4
+				MX53_PAD_EIM_DA13__GPIO3_13 0x1e4
+				MX53_PAD_EIM_DA14__GPIO3_14 0x1e4
+				MX53_PAD_SD1_DATA0__GPIO1_16 0x1e4
+				MX53_PAD_SD1_CMD__GPIO1_18 0x1e4
+				MX53_PAD_SD1_CLK__GPIO1_20 0x1e4
+			>;
+		};
+
+		pinctrl_leds: ledgrp {
+			fsl,pins = <
+				MX53_PAD_EIM_EB2__GPIO2_30 0x1d4
+				MX53_PAD_EIM_D28__GPIO3_28 0x1d4
+				MX53_PAD_EIM_WAIT__GPIO5_0 0x1d4
+			>;
+		};
+
+		pinctrl_uart4: uart4grp {
+			fsl,pins = <
+				MX53_PAD_CSI0_DAT12__UART4_TXD_MUX 0x1e4
+				MX53_PAD_CSI0_DAT13__UART4_RXD_MUX 0x1e4
+			>;
+		};
+	};
+};
+
+&pinctrl_uart1 {
+	fsl,pins = <
+		MX53_PAD_EIM_D23__GPIO3_23 0x1e4
+		MX53_PAD_EIM_EB3__GPIO2_31 0x1e4
+		MX53_PAD_EIM_D24__GPIO3_24 0x1e4
+		MX53_PAD_EIM_D25__GPIO3_25 0x1e4
+		MX53_PAD_EIM_D19__GPIO3_19 0x1e4
+		MX53_PAD_EIM_D20__GPIO3_20 0x1e4
+	>;
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbphy0 {
+	status = "disabled";
+};
-- 
2.11.0
