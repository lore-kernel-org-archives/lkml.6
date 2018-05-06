Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeEFVuH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 17:50:07 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:55018 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeEFVuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 17:50:04 -0400
From: Paul Kocialkowski <contact@paulk.fr>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v3 3/3] ARM: dts: sun7i: Add support for the Ainol AW1 tablet
Date: Sun,  6 May 2018 23:49:01 +0200
Message-Id: <20180506214901.23429-3-contact@paulk.fr>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506214901.23429-1-contact@paulk.fr>
References: <20180506214901.23429-1-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Ainol AW1, an A20-based 7" tablet from Ainol.

The following board-specific features are supported:
* LCD panel
* Backlight
* USB OTG
* Buttons
* Touchscreen (doesn't work without non-free firmware)
* Accelerometer
* Battery

The following are untested:
* Audio output
* Audio speakers
* USB via SPCI connector

The following are not supported:
* Wi-Fi
* Bluetooth
* NAND
* Audio via SPCI connector
* Audio via Bluetooth I2S

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts | 275 ++++++++++++++++++++++
 2 files changed, 276 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e2424957809..4a80971f2bc9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -946,6 +946,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31s-sinovoip-bpi-m2.dtb \
 	sun6i-a31s-yones-toptech-bs1078-v2.dtb
 dtb-$(CONFIG_MACH_SUN7I) += \
+	sun7i-a20-ainol-aw1.dtb \
 	sun7i-a20-bananapi.dtb \
 	sun7i-a20-bananapi-m1-plus.dtb \
 	sun7i-a20-bananapro.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
new file mode 100644
index 000000000000..9a1d54a9f9a0
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
@@ -0,0 +1,275 @@
+/*
+ * Copyright (C) 2018 Paul Kocialkowski <contact@paulk.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0+
+ */
+
+/dts-v1/;
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	model = "Ainol AW1";
+	compatible = "ainol,ainol-aw1", "allwinner,sun7i-a20";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <5>;
+		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+	};
+
+	panel: panel {
+		compatible = "innolux,at070tn90";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-supply = <&panel_power>;
+		backlight = <&backlight>;
+
+		port@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&tcon0_out_panel>;
+			};
+		};
+	};
+
+	panel_power: panel_power {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_power_pin>;
+		regulator-name = "panel-power";
+		regulator-min-microvolt = <10400000>;
+		regulator-max-microvolt = <10400000>;
+		gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+		enable-active-high;
+		regulator-boot-on;
+	};
+};
+
+&codec {
+	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	axp209: pmic@34 {
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+
+	lis3dh: accelerometer@18 {
+		compatible = "st,lis3dh-accel";
+		reg = <0x18>;
+		vdd-supply = <&reg_vcc3v3>;
+		vddio-supply = <&reg_vcc3v3>;
+		st,drdy-int-pin = <1>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	gsl1680: touchscreen@40 {
+		compatible = "silead,gsl1680";
+		reg = <0x40>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
+		power-gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20 */
+		firmware-name = "gsl1680-ainol-aw1.fw";
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <800>;
+		touchscreen-swapped-x-y;
+		touchscreen-inverted-y;
+		silead,max-fingers = <5>;
+	};
+};
+
+&lradc {
+	vref-supply = <&reg_ldo2>;
+	status = "okay";
+
+	button@571 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <571428>;
+	};
+
+	button@761 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <761904>;
+	};
+
+	button@952 {
+		label = "Home";
+		linux,code = <KEY_HOME>;
+		channel = <0>;
+		voltage = <952380>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+	cd-inverted;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&pio {
+	panel_power_pin: panel_power_pin@0 {
+		pins = "PH8";
+		function = "gpio_out";
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins_a>;
+	status = "okay";
+};
+
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd0_rgb666_pins>;
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_panel: endpoint@0 {
+		reg = <0>;
+		remote-endpoint = <&panel_input>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
+
+#include "axp209.dtsi"
+
+&battery_power_supply {
+	status = "okay";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1450000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_usb0_vbus {
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
-- 
2.17.0
