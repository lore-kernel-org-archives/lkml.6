Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54003C4167B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E7320854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="H74Acpsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E7320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeILXi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:38:57 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52716 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbeILXi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:38:57 -0400
Received: from trochilidae.toradex.int (75-146-58-181-Washington.hfc.comcastbusiness.net [75.146.58.181])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5D8685C0119;
        Wed, 12 Sep 2018 20:33:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536777189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xcBGiVYeRuO8SpRzPH8PsD3Jx7Ax0kkYjdX+hS/T348=;
        b=H74AcpsgP/0N1vi1IOggh69KoIYrMFRlby8nkPe2RJi55RwrHTc63wn157L0YCFWhmtfCp
        Y0Ah65EEjchazgWPJetKbaoNtTtKA/vPQG83xAqFfUUTPXUmQ74L5/JO3ZfKHqBkN1EvtJ
        OR99CrMvZQCxzJ4LUd2TDAt4fFJGJ6c=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 8/8] ARM: dts: imx6qdl-apalis: add GPIO I2C node for DDC
Date:   Wed, 12 Sep 2018 11:32:22 -0700
Message-Id: <20180912183222.25414-9-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the DDC signals are controlled by the DWC HDMI I2C
master to be used for HDMI (DVI on the Apalis Evaluation Board).
However, the Apalis Evaluation board also allows to route the Apalis
DDC I2C to the LVDS or the VGA connector. By default, the signal
is routed to DVI (HDMI), and therefor the current default settings
are sensible.

To ease customization and to prepare for carrier boards with other
needs, add a GPIO I2C DDC node.

E.g. to reroute the Apalis DDC to the VGA connector on the Apalis
Evaluation Board, the following changes can be used:

vga {
	...
	ddc-i2c-bus = <&i2cddc>;
};

&hdmi {
	/delete-property/ pinctrl-0;
};

&i2cddc {
	status = "okay";
};

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index e8d0407e3e18..8340391796df 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -61,6 +61,18 @@
 		status = "disabled";
 	};
 
+	/* DDC_I2C: I2C2_SDA/SCL on MXM3 205/207 */
+	i2cddc: i2c@0 {
+		compatible = "i2c-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c_ddc>;
+		gpios = <&gpio3 16 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio2 30 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+		status = "disabled";
+	};
+
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+V3.3";
@@ -688,6 +700,14 @@
 		>;
 	};
 
+	pinctrl_i2c_ddc: gpioi2cddcgrp {
+		fsl,pins = <
+			/* DDC bitbang */
+			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x1b0b0
+			MX6QDL_PAD_EIM_D16__GPIO3_IO16 0x1b0b0
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
-- 
2.18.0

