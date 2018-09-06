Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B05C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476A420861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="OkDaMZ3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476A420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeIGEZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:25:01 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:50542 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeIGEZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:25:01 -0400
Received: from trochilidae.toradex.int (75-146-58-181-Washington.hfc.comcastbusiness.net [75.146.58.181])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5C61E5C00FA;
        Fri,  7 Sep 2018 01:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536277624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=Dl4CLM6q7zOJqIy8RkTGv4ePUE33y8Gam9cCZdubahQ=;
        b=OkDaMZ3MiRm9EtFOY9vJ1KIuo1/iMz7YnWjGYhYuRttxY/CfpLWq7SPBCb/uWHCmttEdiz
        BRgW0+wmFS2GDrSwY6j6VFD58QVVNmhJ6bwE3vrg05/rOMj6PPKcHhvxxc/hC0L31kIaKK
        JyncySS4OShBx9c507VFJG/00X/11Kw=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: dts: imx6q-apalis: mux RESET_MOCI# signal
Date:   Thu,  6 Sep 2018 16:46:58 -0700
Message-Id: <20180906234658.12205-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl properties on the IOMUXC node get overwritten by the
carrier board level device tree, hence the pinctrl_reset_moci
pinctrl does not get applied.

Associate the pinctrl_reset_moci pinctrl with the PCIe node where
we also make use of the pin as a reset GPIO.

Since the pin is muxed as a GPIO by default not muxing it explicitly
worked fine in practise.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 2 ++
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 2 ++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 2 ++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 4 ----
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 707ac9a46115..0edd3043d9c1 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -196,6 +196,8 @@
 };
 
 &pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_reset_moci>;
 	/* active-high meaning opposite of regular PERST# active-low polarity */
 	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 	reset-gpio-active-high;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index 4e1c8feaef82..b94bb687be6b 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -196,6 +196,8 @@
 };
 
 &pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_reset_moci>;
 	/* active-high meaning opposite of regular PERST# active-low polarity */
 	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 	reset-gpio-active-high;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 469e3d0e2827..302fd6adc8a7 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -200,6 +200,8 @@
 };
 
 &pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_reset_moci>;
 	/* active-high meaning opposite of regular PERST# active-low polarity */
 	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 	reset-gpio-active-high;
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 05f07ea3e8c8..3dc99dd8dde1 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -482,10 +482,6 @@
 };
 
 &iomuxc {
-	/* pins used on module */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_reset_moci>;
-
 	pinctrl_apalis_gpio1: gpio2io04grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D4__GPIO2_IO04 0x130b0
-- 
2.18.0

