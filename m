Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932491AbeDXLgZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:36:25 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:36310 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756904AbeDXLea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:34:30 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/7] ARM: dts: sun8i: h3: Split out common board design for ALL-H3-CC
Date: Tue, 24 Apr 2018 19:34:19 +0800
Message-Id: <20180424113424.13196-3-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424113424.13196-1-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Libre Computer Project ALL-H3-CC has three models, all using the
same board design, but with different pin compatible SoCs and amount of
DRAM.

Currently only the H3 1GB DRAM variant is supported. To support the two
other variants, first split the original device tree into a common board
design part and an SoC specific part.

The SoC part only defines which SoC is used and model name, and includes
the SoC specific dtsi file and the common design dtsi file.

Also fix up the SPDX identifier line to use the correct comment style,
and place it on the first line.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 213 +-----------------
 ....dts => sunxi-hx-libretech-all-h3-cc.dtsi} |  11 +-
 2 files changed, 5 insertions(+), 219 deletions(-)
 copy arch/arm/boot/dts/{sun8i-h3-libretech-all-h3-cc.dts => sunxi-hx-libretech-all-h3-cc.dtsi} (95%)

diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
index db6b35bb65ff..eabc2208efdb 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -1,222 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
 #include "sun8i-h3.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
+#include "sunxi-hx-libretech-all-h3-cc.dtsi"
 
 / {
 	model = "Libre Computer Board ALL-H3-CC H3";
 	compatible = "libretech,all-h3-cc-h3", "allwinner,sun8i-h3";
-
-	aliases {
-		ethernet0 = &emac;
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	connector {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con_in: endpoint {
-				remote-endpoint = <&hdmi_out_con>;
-			};
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		pwr_led {
-			label = "librecomputer:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
-			default-state = "on";
-		};
-
-		status_led {
-			label = "librecomputer:blue:status";
-			gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
-		};
-	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-
-		power {
-			label = "power";
-			linux,code = <KEY_POWER>;
-			gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
-		};
-	};
-
-	reg_vcc1v2: vcc1v2 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc1v2";
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&reg_vcc5v0>;
-		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
-		enable-active-high;
-	};
-
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&reg_vcc5v0>;
-	};
-
-	/* This represents the board's 5V input */
-	reg_vcc5v0: vcc5v0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	reg_vcc_dram: vcc-dram {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc-dram";
-		regulator-min-microvolt = <1500000>;
-		regulator-max-microvolt = <1500000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&reg_vcc5v0>;
-		gpio = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
-		enable-active-high;
-	};
-
-	reg_vcc_io: vcc-io {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc-io";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&reg_vcc3v3>;
-		gpio = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL5 */
-	};
-
-	reg_vdd_cpux: vdd-cpux {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd-cpux";
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&reg_vcc5v0>;
-		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
-		enable-active-high;
-	};
-};
-
-&codec {
-	allwinner,audio-routing =
-		"Line Out", "LINEOUT",
-		"MIC1", "Mic",
-		"Mic",  "MBIAS";
-	status = "okay";
-};
-
-&cpu0 {
-	cpu-supply = <&reg_vdd_cpux>;
-};
-
-&de {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&ehci2 {
-	status = "okay";
-};
-
-&ehci3 {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&int_mii_phy>;
-	phy-mode = "mii";
-	allwinner,leds-active-low;
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&hdmi_out {
-	hdmi_out_con: endpoint {
-		remote-endpoint = <&hdmi_con_in>;
-	};
-};
-
-&ir {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
-	status = "okay";
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc_io>;
-	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&ohci2 {
-	status = "okay";
-};
-
-&ohci3 {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbphy {
-	/* VBUS on USB ports are always on */
-	usb0_vbus-supply = <&reg_vcc5v0>;
-	usb1_vbus-supply = <&reg_vcc5v0>;
-	usb2_vbus-supply = <&reg_vcc5v0>;
-	usb3_vbus-supply = <&reg_vcc5v0>;
-	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sunxi-hx-libretech-all-h3-cc.dtsi
similarity index 95%
copy from arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
copy to arch/arm/boot/dts/sunxi-hx-libretech-all-h3-cc.dtsi
index db6b35bb65ff..d4539c12c6e1 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sunxi-hx-libretech-all-h3-cc.dtsi
@@ -1,19 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
+ * Common design for Libre Computer ALL-H3-CC boards
  *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
  */
 
-/dts-v1/;
-#include "sun8i-h3.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 
 / {
-	model = "Libre Computer Board ALL-H3-CC H3";
-	compatible = "libretech,all-h3-cc-h3", "allwinner,sun8i-h3";
-
 	aliases {
 		ethernet0 = &emac;
 		serial0 = &uart0;
-- 
2.17.0
