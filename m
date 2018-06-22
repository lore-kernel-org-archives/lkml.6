Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5590C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBF924413
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBF924413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933898AbeFVOwd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:52:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54356 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933346AbeFVOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:52:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D0E90288FEE
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 1/1] ARM: dts: imx53: PPD: Add fixed-regulator information
Date:   Fri, 22 Jun 2018 16:52:25 +0200
Message-Id: <20180622145225.17883-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information about 3V3 power rail to avoid kernel warnings,
that dummy regulators have been added.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx53-ppd.dts | 37 +++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 4ddef5abda56..e0bbb70b42c6 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -140,6 +140,26 @@
 		regulator-always-on;
 	};
 
+	reg_3v3: regulator-3v3 {
+		/* TPS54320 */
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_3v3_lcd: regulator-3v3-lcd {
+		/* MIC2009 */
+		compatible = "regulator-fixed";
+		regulator-name = "LCD_3V3";
+		vin-supply = <&reg_3v3>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	pwm_bl: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm2 0 50000>;
@@ -154,6 +174,7 @@
 				     234 237 239 242 244 247 249 252 255>;
 		default-brightness-level = <0>;
 		enable-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3_lcd>;
 	};
 
 	leds {
@@ -198,8 +219,9 @@
 		};
 	};
 
-	usbphy2: usbphy2 {
+	usbphy2: usbphy-2 {
 		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_3v3>;
 		reset-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
 		clock-names = "main_clk";
 		clock-frequency = <24000000>;
@@ -208,8 +230,9 @@
 		assigned-clock-parents = <&clks IMX5_CLK_OSC>;
 	};
 
-	usbphy3: usbphy3 {
+	usbphy3: usbphy-3 {
 		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_3v3>;
 		reset-gpios = <&gpio2 19 GPIO_ACTIVE_LOW>;
 		clock-names = "main_clk";
 
@@ -221,6 +244,7 @@
 
 	panel-lvds0 {
 		compatible = "nvd,9128";
+		power-supply = <&reg_3v3_lcd>;
 
 		port {
 			panel_in_lvds0: endpoint {
@@ -230,6 +254,14 @@
 	};
 };
 
+&usbphy0 {
+	vcc-supply = <&reg_3v3>;
+};
+
+&usbphy1 {
+	vcc-supply = <&reg_3v3>;
+};
+
 &audmux {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>;
@@ -409,6 +441,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
+	phy-supply = <&reg_3v3>;
 	phy-mode = "rmii";
 	phy-reset-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>;
 	status = "okay";
-- 
2.17.1

