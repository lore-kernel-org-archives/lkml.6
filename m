Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52CDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9722087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="pGMniGur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfARNbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:31:21 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:36580 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfARNbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:31:21 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9C3975C115F;
        Fri, 18 Jan 2019 14:31:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547818278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Aik6KQzBZfujviPqUffSwTRj+LLZFOQ4Ed9Tw4Zsw6o=;
        b=pGMniGur4JfF1kfAktUVW5jwykUZyQwFl/V2j2lrpu69j13CkT77glb8j5hVXhEHZsUeRQ
        YZsplIh7clwwxx8FffR92D3hdqKFTQshSbJQaq7F9AQR6WyfwiRzPhfiqSWeOq4Tm71n/K
        OsMdVFcfrNXxvus7cSjujLQGXodM2LY=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
        dev@pschenker.ch, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: dts: imx6*-apalis/-colibri: mark I2C recovery GPIOs as open drain
Date:   Fri, 18 Jan 2019 14:31:13 +0100
Message-Id: <20190118133113.19484-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d2d0ad2aec4a ("i2c: imx: use open drain for recovery
GPIO") GPIO lib expects this GPIO to be configured as open drain.
Make sure we define this GPIO as open drain in the device tree.
This gets rid of the following warning:
  gpio-81 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file

Note that currently the i.MX pinctrl driver does not support
enabling open drain directly, so this patch has no effect in
practice. Open drain is enabled by the fixed pinmux entry.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 4 ++--
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 4 ++--
 arch/arm/boot/dts/imx6ull-colibri.dtsi | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index cf66f9ececbd..2d0ed199ed20 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -429,8 +429,8 @@
 	pinctrl-names = "default", "recovery";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	pinctrl-1 = <&pinctrl_i2c3_recovery>;
-	scl-gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio3 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio3 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 87e15e7cb32b..8a27c2a05678 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -298,8 +298,8 @@
 	pinctrl-names = "default", "recovery";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	pinctrl-1 = <&pinctrl_i2c3_recovery>;
-	scl-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 6c63a7384611..9ad1da159768 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -94,16 +94,16 @@
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	sda-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
-	scl-gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
+	sda-gpios = <&gpio1 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio1 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 };
 
 &i2c2 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	pinctrl-1 = <&pinctrl_i2c2_gpio>;
-	sda-gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
-	scl-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
+	sda-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio1 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	ad7879@2c {
-- 
2.20.1

