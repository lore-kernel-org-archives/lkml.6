Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeBHKHD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:07:03 -0500
Received: from hermes.aosc.io ([199.195.250.187]:36749 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbeBHKHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:07:00 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v5] ARM: sun8i: h2+: add support for Banana Pi M2 Zero board
Date: Thu,  8 Feb 2018 18:06:13 +0800
Message-Id: <20180208100613.4761-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Banana Pi M2 Zero board is a H2+-based board by Sinovoip, with a form
factor and GPIO holes similar to Raspberry Pi Zero.

It features:
- Allwinner H2+ SoC
- Single-chip (16-bit) 512MiB DDR3 DRAM
- Ampak AP6212 Wi-Fi/Bluetooth module
- MicroSD slot
- Two MicroUSB Type-B ports (one can only be used to power the board and
  the other features OTG functionality)
- Two keys, a reset and a GPIO-connected key.
- HDMI Type-C (miniHDMI) connector connected to the HDMI part of H2+.
- CSI connector to connect the camera sensor provided by Sinovoip.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v5:
- Fix SPDX license identifier position.

Changes in v4:
- Use SPDX license identifier.

Changes in v3:
- Add comments about Vbus problem in &usbphy node.

Changes in v2:
- Use high active SD card detect on the production batch.

 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 125 +++++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38543dc..d5a17e6e8b0f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -974,6 +974,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a83t-cubietruck-plus.dtb \
 	sun8i-a83t-tbs-a711.dtb \
 	sun8i-h2-plus-orangepi-r1.dtb \
+	sun8i-h2-plus-bananapi-m2-zero.dtb \
 	sun8i-h2-plus-orangepi-zero.dtb \
 	sun8i-h3-bananapi-m2-plus.dtb \
 	sun8i-h3-beelink-x2.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
new file mode 100644
index 000000000000..1cdbd9a3ef57
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Based on sun8i-h3-bananapi-m2-plus.dts, which is:
+ *   Copyright (C) 2016 Chen-Yu Tsai <wens@csie.org>
+ */
+
+/dts-v1/;
+#include "sun8i-h3.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Banana Pi BPI-M2-Zero";
+	compatible = "sinovoip,bpi-m2-zero", "allwinner,sun8i-h2-plus";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+
+		pwr_led {
+			label = "bananapi-m2-zero:red:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
+			default-state = "on";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+
+		sw4 {
+			label = "power";
+			linux,code = <BTN_0>;
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	/*
+	 * On the production batch of this board the card detect GPIO is
+	 * high active (card inserted), although on the early samples it's
+	 * low active.
+	 */
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+	/*
+	 * There're two micro-USB connectors, one is power-only and another is
+	 * OTG. The Vbus of these two connectors are connected together, so
+	 * the external USB device will be powered just by the power input
+	 * from the power-only USB port.
+	 */
+	status = "okay";
+};
-- 
2.15.1
