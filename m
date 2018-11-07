Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A6BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7706820862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7706820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeKHDwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:52:17 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:49030 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbeKHDwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:52:17 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 8EDF6BFCAE;
        Wed,  7 Nov 2018 19:20:41 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id BFA04C1096; Wed,  7 Nov 2018 19:20:40 +0100 (CET)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 05746C1070;
        Wed,  7 Nov 2018 19:17:59 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH NOT FOR MERGE v3 8/8] ARM: dts: sun7i-a20-bananapi: Add bindings for the LeMaker 3.5" LCD
Date:   Wed,  7 Nov 2018 19:18:43 +0100
Message-Id: <20181107181843.27628-9-contact@paulk.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107181843.27628-1-contact@paulk.fr>
References: <20181107181843.27628-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the backlight panel, power, pwm and tcon0 device-tree bindings
required for supporting the 3.5" LCD from LeMaker on the BananaPi M1.

The brightness levels are adjusted with a gamma curve using a 1.8 power,
with indices from 0 to 100 and values ranging from 0 to 255, such as:
level = (index / 100)^1.8 * 255

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 71 ++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 70dfc4ac0bb5..ac6c3e988203 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -48,6 +48,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "LeMaker Banana Pi";
@@ -63,6 +64,57 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 0>;
+		/* This table uses a gamma curve with a 1.8 power. */
+		brightness-levels = <  0   1   1   1   1   1   2   2
+				       3   3   4   5   6   6   7   8
+				       9  11  12  13  14  15  17  18
+				      20  21  23  24  26  27  29  31
+				      33  35  37  39  41  43  45  47
+				      49  51  54  56  58  61  63  66
+				      68  71  73  76  79  81  84  87
+				      90  93  96  99 102 105 108 111
+				     114 117 121 124 127 131 134 138
+				     141 145 148 152 156 159 163 167
+				     171 175 178 182 186 190 194 198
+				     203 207 211 215 219 224 228 233
+				     237 241 246 250 255>;
+		default-brightness-level = <50>;
+		enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+	};
+
+	panel: panel {
+		compatible = "lemaker,bl035-rgb-002";
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
+		regulator-name = "panel-power";
+		regulator-min-microvolt = <10400000>;
+		regulator-max-microvolt = <10400000>;
+		gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
+		enable-active-high;
+		regulator-boot-on;
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -275,6 +327,12 @@
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins_a>;
+	status = "okay";
+};
+
 #include "axp209.dtsi"
 
 &reg_dcdc2 {
@@ -322,6 +380,19 @@
 	status = "okay";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd0_rgb888_pins>;
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
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.19.1

