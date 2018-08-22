Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E357C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C10208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C10208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeHWAKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:10:15 -0400
Received: from shell.v3.sk ([90.176.6.54]:53360 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbeHWAKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:10:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3809FB5B97;
        Wed, 22 Aug 2018 22:43:46 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZKJfPONjqW_S; Wed, 22 Aug 2018 22:43:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B7415B5B9F;
        Wed, 22 Aug 2018 22:43:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KafwWKzl1TPP; Wed, 22 Aug 2018 22:43:16 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4B0BAB5B97;
        Wed, 22 Aug 2018 22:43:14 +0200 (CEST)
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
Subject: [PATCH 11/14] USB: EHCI: ehci-mv: add DT support
Date:   Wed, 22 Aug 2018 22:43:04 +0200
Message-Id: <20180822204307.13251-12-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device tree support.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/ehci-mv.c | 41 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 43b300c90875..f26109eafdbf 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -34,11 +34,11 @@ struct ehci_hcd_mv {
 	void __iomem *op_regs;
 
 	struct usb_phy *otg;
+	struct clk *clk;
 
-	struct mv_usb_platform_data *pdata;
 	struct phy *phy;
 
-	struct clk *clk;
+	int (*set_vbus)(unsigned int vbus);
 };
 
 static void ehci_clock_enable(struct ehci_hcd_mv *ehci_mv)
@@ -100,11 +100,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	int retval = -ENODEV;
 	u32 offset;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "missing platform_data\n");
-		return -ENODEV;
-	}
-
 	if (usb_disabled())
 		return -ENODEV;
 
@@ -114,7 +109,12 @@ static int mv_ehci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hcd);
 	ehci_mv = hcd_to_ehci_hcd_mv(hcd);
-	ehci_mv->pdata = pdata;
+
+	ehci_mv->mode = MV_USB_MODE_HOST;
+	if (pdata) {
+		ehci_mv->mode = pdata->mode;
+		ehci_mv->set_vbus = pdata->set_vbus;
+	}
 
 	ehci_mv->phy = devm_phy_get(&pdev->dev, "usb");
 	if (IS_ERR(ehci_mv->phy)) {
@@ -166,7 +166,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = (struct ehci_caps *) ehci_mv->cap_regs;
 
-	ehci_mv->mode = pdata->mode;
 	if (ehci_mv->mode == MV_USB_MODE_OTG) {
 		ehci_mv->otg = devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
 		if (IS_ERR(ehci_mv->otg)) {
@@ -191,8 +190,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		/* otg will enable clock before use as host */
 		mv_ehci_disable(ehci_mv);
 	} else {
-		if (pdata->set_vbus)
-			pdata->set_vbus(1);
+		if (ehci_mv->set_vbus)
+			ehci_mv->set_vbus(1);
 
 		retval = usb_add_hcd(hcd, hcd->irq, IRQF_SHARED);
 		if (retval) {
@@ -211,8 +210,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	return 0;
 
 err_set_vbus:
-	if (pdata->set_vbus)
-		pdata->set_vbus(0);
+	if (ehci_mv->set_vbus)
+		ehci_mv->set_vbus(0);
 err_disable_clk:
 	mv_ehci_disable(ehci_mv);
 err_put_hcd:
@@ -233,8 +232,8 @@ static int mv_ehci_remove(struct platform_device *pdev)
 		otg_set_host(ehci_mv->otg->otg, NULL);
 
 	if (ehci_mv->mode == MV_USB_MODE_HOST) {
-		if (ehci_mv->pdata->set_vbus)
-			ehci_mv->pdata->set_vbus(0);
+		if (ehci_mv->set_vbus)
+			ehci_mv->set_vbus(0);
 
 		mv_ehci_disable(ehci_mv);
 	}
@@ -265,14 +264,20 @@ static void mv_ehci_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
+static const struct of_device_id ehci_mv_dt_ids[] = {
+	{ .compatible = "marvell,pxau2o-ehci", },
+	{},
+};
+
 static struct platform_driver ehci_mv_driver = {
 	.probe = mv_ehci_probe,
 	.remove = mv_ehci_remove,
 	.shutdown = mv_ehci_shutdown,
 	.driver = {
-		   .name = "mv-ehci",
-		   .bus = &platform_bus_type,
-		   },
+		.name = "mv-ehci",
+		.bus = &platform_bus_type,
+		.of_match_table = ehci_mv_dt_ids,
+	},
 	.id_table = ehci_id_table,
 };
 
-- 
2.17.1

