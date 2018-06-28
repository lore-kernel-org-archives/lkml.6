Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13194C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B973A2768C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B973A2768C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965326AbeF1Qg4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:36:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60982 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933996AbeF1Qgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:36:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6515F260CC2
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
Subject: [PATCHv2 1/2] ARM: dts: imx53: PPD: Add fixed-regulator information
Date:   Thu, 28 Jun 2018 18:36:38 +0200
Message-Id: <20180628163639.1078-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information about 3V3 power rail to avoid kernel warnings,
that dummy regulators have been added.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Changes since PATCHv1:
 * split usbphy rename into its own patch
 * drop useless regulator-boot-on
---
 arch/arm/boot/dts/imx53-ppd.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 4ddef5abda56..daed979b6e40 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -140,6 +140,25 @@
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
+	};
+
 	pwm_bl: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm2 0 50000>;
@@ -154,6 +173,7 @@
 				     234 237 239 242 244 247 249 252 255>;
 		default-brightness-level = <0>;
 		enable-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3_lcd>;
 	};
 
 	leds {
@@ -200,6 +220,7 @@
 
 	usbphy2: usbphy2 {
 		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_3v3>;
 		reset-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
 		clock-names = "main_clk";
 		clock-frequency = <24000000>;
@@ -210,6 +231,7 @@
 
 	usbphy3: usbphy3 {
 		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_3v3>;
 		reset-gpios = <&gpio2 19 GPIO_ACTIVE_LOW>;
 		clock-names = "main_clk";
 
@@ -221,6 +243,7 @@
 
 	panel-lvds0 {
 		compatible = "nvd,9128";
+		power-supply = <&reg_3v3_lcd>;
 
 		port {
 			panel_in_lvds0: endpoint {
@@ -230,6 +253,14 @@
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
@@ -409,6 +440,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
+	phy-supply = <&reg_3v3>;
 	phy-mode = "rmii";
 	phy-reset-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>;
 	status = "okay";
-- 
2.18.0

