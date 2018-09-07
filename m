Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF327C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A43020869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A43020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeIGJIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:08:06 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:39950 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbeIGJHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:07:42 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id DA90A5FD94; Fri,  7 Sep 2018 12:19:50 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Jonathan Liu <net147@gmail.com>
Subject: [PATCH v2 6/6] [DO NOT MERGE] ARM: dts: sun7i: bananapi-m1-plus: Enable Bananapi 7" 800x480 RGB LCD panel
Date:   Fri,  7 Sep 2018 12:19:48 +0800
Message-Id: <20180907041948.19913-7-wens@csie.org>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
 .../boot/dts/sun7i-a20-bananapi-m1-plus.dts   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index 763cb03033c4..9fa58adade56 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -47,6 +47,7 @@
 #include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Banana Pi BPI-M1-Plus";
@@ -71,6 +72,29 @@
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
+		power-supply = <&reg_vcc5v0>; /* Actually driven from IPSOUT */
+		/* This doesn't do anything for this particular connector */
+		enable-gpios = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
+
+		port {
+			backlight = <&lcd_backlight>;
+
+			lcd_panel_input: endpoint {
+				remote-endpoint = <&tcon0_out_lcd>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -173,6 +197,20 @@
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
@@ -249,6 +287,12 @@
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
@@ -278,6 +322,18 @@
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
2.19.0.rc1

