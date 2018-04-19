Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDSJcj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:32:39 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:35756 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752788AbeDSJch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:32:37 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Liu <net147@gmail.com>
Subject: [PATCH 6/6] [DO NOT MERGE] ARM: dts: sun7i: bananapi-m1-plus: Enable Bananapi 7" 800x480 RGB LCD panel
Date: Thu, 19 Apr 2018 17:32:25 +0800
Message-Id: <20180419093225.614-7-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419093225.614-1-wens@csie.org>
References: <20180419093225.614-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BPI-M1+ has an FPC connector for connecting an RGB (parallel) or
LVDS LCD panel. One of the compatible panels is a 7" 800x480 RGB panel
from Bananapi. The backlight can be controlled by driving a PWM signal
from the SoC at different duty cycles. The LCD enable pin does not seem
to do anything, but it is nevertheless included for completeness. There
is also a FT5306 capacitive touchscreen controller.

This should not be confused with the other 7" LCD that is LVDS based
and has a resolution of 1024x600.

This patch enables all of the above for the BPI-M1+.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun7i-a20-bananapi-m1-plus.dts   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index 763cb03033c4..58a923bfa6ef 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -47,6 +47,7 @@
 #include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Banana Pi BPI-M1-Plus";
@@ -71,6 +72,34 @@
 		};
 	};
 
+	lcd_backlight: lcd-backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 20000 PWM_POLARITY_INVERTED>; /* 50 kHz */
+		enable-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <8>;
+	};
+
+	lcd_panel: lcd-panel {
+		compatible = "bananapi,s070wv20-ct16", "simple-panel";
+		/* This doesn't do anything for this particular panel */
+		enable-gpios = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			backlight = <&lcd_backlight>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lcd_panel_input: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&tcon0_out_lcd>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -173,6 +202,20 @@
 	status = "okay";
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins_a>;
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5306", "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 7 IRQ_TYPE_EDGE_FALLING>; /* PH7 */
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
+	};
+};
+
 &ir0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir0_rx_pins_a>;
@@ -249,6 +292,12 @@
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins_a>;
+	status = "okay";
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
@@ -278,6 +327,18 @@
 	status = "okay";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd0_rgb888_pins>;
+};
+
+&tcon0_out {
+	tcon0_out_lcd: endpoint@0 {
+		reg = <0>;
+		remote-endpoint = <&lcd_panel_input>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.17.0
