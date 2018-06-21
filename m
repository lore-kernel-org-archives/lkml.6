Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95ABC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1872240E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ntTpH7BD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1872240E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933858AbeFUVaf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:30:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933991AbeFUV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=omgzzMx1J+Hfd5X9RmHLAvs+yg1SHAbIpfDV56GPEcg=; b=ntTpH7BDuL2OvKVRfR94gA+US
        R0JctUW2u1KaaAaSyarybunGB6kHfpWoKKdrBoVtOfFFduLp0gFsPT2BoeGLy9LhozfQ+moatqs+m
        mmuFfasrHO1D/wt0+EUyY3kT3HA/IJ665vkj1HjD3LUgUPEilc56+tyU5h3qHJP9meP2WOrueqS7V
        4BVx22DachMOv5VgpeAfOybTgnyqfRsLATQjT13023bpyoRPjQALCy713geBT8uElKuvlwNwVBhvf
        gKUSYlzrGB/wDDBgVbAQlkQIksx+GHfd8rQ/RjgFw8RqOo+Dmhw2jtU/oKH+VI2dTE+yAriBTKkNW
        vv+gjUy6A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78e-0001bd-SZ; Thu, 21 Jun 2018 21:29:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/26] cb710: Convert to new IDA API
Date:   Thu, 21 Jun 2018 14:28:20 -0700
Message-Id: <20180621212835.5636-12-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminates the custom spinlock and the call to ida_pre_get.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/misc/cb710/core.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
index 4d4acf763b65..2c43fd09d602 100644
--- a/drivers/misc/cb710/core.c
+++ b/drivers/misc/cb710/core.c
@@ -16,7 +16,6 @@
 #include <linux/gfp.h>
 
 static DEFINE_IDA(cb710_ida);
-static DEFINE_SPINLOCK(cb710_ida_lock);
 
 void cb710_pci_update_config_reg(struct pci_dev *pdev,
 	int reg, uint32_t mask, uint32_t xor)
@@ -205,7 +204,6 @@ static int cb710_probe(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
 	struct cb710_chip *chip;
-	unsigned long flags;
 	u32 val;
 	int err;
 	int n = 0;
@@ -256,18 +254,10 @@ static int cb710_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	do {
-		if (!ida_pre_get(&cb710_ida, GFP_KERNEL))
-			return -ENOMEM;
-
-		spin_lock_irqsave(&cb710_ida_lock, flags);
-		err = ida_get_new(&cb710_ida, &chip->platform_id);
-		spin_unlock_irqrestore(&cb710_ida_lock, flags);
-
-		if (err && err != -EAGAIN)
-			return err;
-	} while (err);
-
+	err = ida_alloc(&cb710_ida, GFP_KERNEL);
+	if (err < 0)
+		return err;
+	chip->platform_id = err;
 
 	dev_info(&pdev->dev, "id %d, IO 0x%p, IRQ %d\n",
 		chip->platform_id, chip->iobase, pdev->irq);
@@ -308,7 +298,6 @@ static int cb710_probe(struct pci_dev *pdev,
 static void cb710_remove_one(struct pci_dev *pdev)
 {
 	struct cb710_chip *chip = pci_get_drvdata(pdev);
-	unsigned long flags;
 
 	cb710_unregister_slot(chip, CB710_SLOT_SM);
 	cb710_unregister_slot(chip, CB710_SLOT_MS);
@@ -317,9 +306,7 @@ static void cb710_remove_one(struct pci_dev *pdev)
 	BUG_ON(atomic_read(&chip->slot_refs_count) != 0);
 #endif
 
-	spin_lock_irqsave(&cb710_ida_lock, flags);
-	ida_remove(&cb710_ida, chip->platform_id);
-	spin_unlock_irqrestore(&cb710_ida_lock, flags);
+	ida_free(&cb710_ida, chip->platform_id);
 }
 
 static const struct pci_device_id cb710_pci_tbl[] = {
-- 
2.17.1

