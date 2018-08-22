Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1D2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE6A208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE6A208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeHWAKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:10:08 -0400
Received: from shell.v3.sk ([90.176.6.54]:53327 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbeHWAKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:10:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AABD0B5BAD;
        Wed, 22 Aug 2018 22:43:41 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GpcI8k25AVLd; Wed, 22 Aug 2018 22:43:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2A0C6B5B8A;
        Wed, 22 Aug 2018 22:43:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wL2g8O5V3OSE; Wed, 22 Aug 2018 22:43:13 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D72EBB5B90;
        Wed, 22 Aug 2018 22:43:12 +0200 (CEST)
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
Subject: [PATCH 07/14] USB: EHCI: ehci-mv: remove private_init
Date:   Wed, 22 Aug 2018 22:43:00 +0200
Message-Id: <20180822204307.13251-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unused.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/ehci-mv.c           | 4 ----
 include/linux/platform_data/mv_usb.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 77a4ab1dcd07..705d1b43b2dd 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -203,9 +203,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		device_wakeup_enable(hcd->self.controller);
 	}
 
-	if (pdata->private_init)
-		pdata->private_init(ehci_mv->op_regs, ehci_mv->phy_regs);
-
 	dev_info(&pdev->dev,
 		 "successful find EHCI device with regs 0x%p irq %d"
 		 " working in %s mode\n", hcd->regs, hcd->irq,
@@ -260,7 +257,6 @@ static const struct platform_device_id ehci_id_table[] = {
 static void mv_ehci_shutdown(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-	struct ehci_hcd_mv *ehci_mv = hcd_to_ehci_hcd_mv(hcd);
 
 	if (!hcd->rh_registered)
 		return;
diff --git a/include/linux/platform_data/mv_usb.h b/include/linux/platform_data/mv_usb.h
index 98b7925f1a2d..c0f624aca81c 100644
--- a/include/linux/platform_data/mv_usb.h
+++ b/include/linux/platform_data/mv_usb.h
@@ -48,6 +48,5 @@ struct mv_usb_platform_data {
 	int	(*phy_init)(void __iomem *regbase);
 	void	(*phy_deinit)(void __iomem *regbase);
 	int	(*set_vbus)(unsigned int vbus);
-	int     (*private_init)(void __iomem *opregs, void __iomem *phyregs);
 };
 #endif
-- 
2.17.1

