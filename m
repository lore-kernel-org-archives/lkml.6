Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932823AbeE2JuX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:50:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50070 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932516AbeE2JtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:49:22 -0400
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 3/3] [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display
Date: Tue, 29 May 2018 11:49:16 +0200
Message-Id: <eba350219d6521c5c84986c68f7f0045dcac9aea.1527587352.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.e73f3ed1a9adc36fc1648d563cd967ec99219839.1527587352.git-series.maxime.ripard@bootlin.com>
References: <cover.e73f3ed1a9adc36fc1648d563cd967ec99219839.1527587352.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.e73f3ed1a9adc36fc1648d563cd967ec99219839.1527587352.git-series.maxime.ripard@bootlin.com>
References: <cover.e73f3ed1a9adc36fc1648d563cd967ec99219839.1527587352.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BananaPi M2M has an optional 1280x720 DSI panel. Since that panel is
optional, we can only show a DT patch that would show how to enable it.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts | 48 +++++++++++++++++++++-
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index 0dbdb29a8fff..16ee662b06d6 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -44,6 +44,7 @@
 #include "sun8i-a33.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "BananaPi M2 Magic";
@@ -81,6 +82,23 @@
 		};
 	};
 
+	pwm_bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <8>;
+		enable-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PG10 */
+	};
+
+	reg_panel: reg-panel {
+		compatible = "regulator-fixed";
+		regulator-name = "panel";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* PB07 */
+		enable-active-high;
+	};
+
 	reg_vcc5v0: vcc5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0";
@@ -120,6 +138,26 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	status = "okay";
+
+	panel@0 {
+		compatible = "bananapi,lhr050h41", "ilitek,ili9881c";
+		reg = <0>;
+		reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+		power-supply = <&reg_panel>;
+		backlight = <&pwm_bl>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -178,6 +216,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -290,6 +334,10 @@
 	status = "okay";
 };
 
+&tcon0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_b>;
-- 
git-series 0.9.1
