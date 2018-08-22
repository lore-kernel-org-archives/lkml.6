Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B14FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB28208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB28208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeHWAKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:10:06 -0400
Received: from shell.v3.sk ([90.176.6.54]:53307 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbeHWAKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:10:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 533C9B5B8D;
        Wed, 22 Aug 2018 22:43:38 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8A3fa56tQZLn; Wed, 22 Aug 2018 22:43:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 91DB1B5238;
        Wed, 22 Aug 2018 22:43:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lyhnl9b2p60P; Wed, 22 Aug 2018 22:43:14 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3582EB5B93;
        Wed, 22 Aug 2018 22:43:13 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 08/14] USB: EHCI: ehci-mv: use phy-pxa-usb
Date:   Wed, 22 Aug 2018 22:43:01 +0200
Message-Id: <20180822204307.13251-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a proper PHY driver, instead of hooks to a board support package.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/devices.c | 11 +---------
 drivers/usb/host/ehci-mv.c  | 44 ++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index d162fabd38e7..822b8be042b9 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -298,21 +298,12 @@ struct platform_device pxa168_device_u2o = {
 
 #if IS_ENABLED(CONFIG_USB_EHCI_MV_U2O)
 struct resource pxa168_u2oehci_resources[] = {
-	/* regbase */
 	[0] = {
-		.start	= PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
+		.start	= PXA168_U2O_REGBASE,
 		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
 		.flags	= IORESOURCE_MEM,
-		.name	= "capregs",
 	},
-	/* phybase */
 	[1] = {
-		.start	= PXA168_U2O_PHYBASE,
-		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "phyregs",
-	},
-	[2] = {
 		.start	= IRQ_PXA168_USB1,
 		.end	= IRQ_PXA168_USB1,
 		.flags	= IORESOURCE_IRQ,
diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 705d1b43b2dd..43b300c90875 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -18,6 +18,9 @@
 
 #include "ehci.h"
 
+/* registers */
+#define U2x_CAPREGS_OFFSET       0x100
+
 #define CAPLENGTH_MASK         (0xff)
 
 #define hcd_to_ehci_hcd_mv(h) ((struct ehci_hcd_mv *)hcd_to_ehci(h)->priv)
@@ -26,13 +29,14 @@ struct ehci_hcd_mv {
 	/* Which mode does this ehci running OTG/Host ? */
 	int mode;
 
-	void __iomem *phy_regs;
+	void __iomem *base;
 	void __iomem *cap_regs;
 	void __iomem *op_regs;
 
 	struct usb_phy *otg;
 
 	struct mv_usb_platform_data *pdata;
+	struct phy *phy;
 
 	struct clk *clk;
 };
@@ -49,22 +53,13 @@ static void ehci_clock_disable(struct ehci_hcd_mv *ehci_mv)
 
 static int mv_ehci_enable(struct ehci_hcd_mv *ehci_mv)
 {
-	int retval;
-
 	ehci_clock_enable(ehci_mv);
-	if (ehci_mv->pdata->phy_init) {
-		retval = ehci_mv->pdata->phy_init(ehci_mv->phy_regs);
-		if (retval)
-			return retval;
-	}
-
-	return 0;
+	return phy_init(ehci_mv->phy);
 }
 
 static void mv_ehci_disable(struct ehci_hcd_mv *ehci_mv)
 {
-	if (ehci_mv->pdata->phy_deinit)
-		ehci_mv->pdata->phy_deinit(ehci_mv->phy_regs);
+	phy_exit(ehci_mv->phy);
 	ehci_clock_disable(ehci_mv);
 }
 
@@ -121,6 +116,14 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	ehci_mv = hcd_to_ehci_hcd_mv(hcd);
 	ehci_mv->pdata = pdata;
 
+	ehci_mv->phy = devm_phy_get(&pdev->dev, "usb");
+	if (IS_ERR(ehci_mv->phy)) {
+		retval = PTR_ERR(ehci_mv->phy);
+		if (retval != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get phy.\n");
+		goto err_put_hcd;
+	}
+
 	ehci_mv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ehci_mv->clk)) {
 		dev_err(&pdev->dev, "error getting clock\n");
@@ -128,17 +131,12 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		goto err_put_hcd;
 	}
 
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phyregs");
-	ehci_mv->phy_regs = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(ehci_mv->phy_regs)) {
-		retval = PTR_ERR(ehci_mv->phy_regs);
-		goto err_put_hcd;
-	}
 
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "capregs");
-	ehci_mv->cap_regs = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(ehci_mv->cap_regs)) {
-		retval = PTR_ERR(ehci_mv->cap_regs);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ehci_mv->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(ehci_mv->base)) {
+		retval = PTR_ERR(ehci_mv->base);
 		goto err_put_hcd;
 	}
 
@@ -148,6 +146,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		goto err_put_hcd;
 	}
 
+	ehci_mv->cap_regs =
+		(void __iomem *) ((unsigned long) ehci_mv->base + U2x_CAPREGS_OFFSET);
 	offset = readl(ehci_mv->cap_regs) & CAPLENGTH_MASK;
 	ehci_mv->op_regs =
 		(void __iomem *) ((unsigned long) ehci_mv->cap_regs + offset);
-- 
2.17.1

