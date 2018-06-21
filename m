Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C39C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3612C223D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ikPar9SD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3612C223D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934039AbeFUV3R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:29:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933945AbeFUV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u8BTn218/t3eDoWCzJWmHuqJemJyGCmVAnA9recO0+4=; b=ikPar9SD/Pc79to3I5GKp7dos
        BMLGzmyAUeG+eI9fXXrfQpYLcWEZ7U7kVGnXq9LYifa9O12tELxcuN+OFXufRwjQ0ob34MHYSZSbP
        O869KjLB/Pc/nsdOiJFHkYUl0CHzkplIafUqIwBgd2pCH9xoHmMbUl+W0pYEJ2LPNDyb15fr4qEo8
        TqWIPKFsUD0gkL6yd+nF57f3IuuiiIRTs8dEP1PuuF6Kp4NwQUXuakyLfikQnAizwBMY8TJNj+5N/
        Eg76+xr8Q8p7V0rhAaVX4fip8w1AeIaI5NIU7qsspBLd9metSORtfnbm9j2ePWJTdRPmsYulSrM+h
        5vbKWI7ZQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78e-0001bW-NY; Thu, 21 Jun 2018 21:29:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 10/26] rsxx: Convert to new IDA API
Date:   Thu, 21 Jun 2018 14:28:19 -0700
Message-Id: <20180621212835.5636-11-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the custom spinlock and the call to ida_pre_get.
Also add a call to ida_free() in the card remove routine, which I believe
fixes a bug in this driver.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/rsxx/core.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index b7d71914a32a..f2c631ce793c 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -58,7 +58,6 @@ MODULE_PARM_DESC(sync_start, "On by Default: Driver load will not complete "
 			     "until the card startup has completed.");
 
 static DEFINE_IDA(rsxx_disk_ida);
-static DEFINE_SPINLOCK(rsxx_ida_lock);
 
 /* --------------------Debugfs Setup ------------------- */
 
@@ -771,19 +770,10 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	card->dev = dev;
 	pci_set_drvdata(dev, card);
 
-	do {
-		if (!ida_pre_get(&rsxx_disk_ida, GFP_KERNEL)) {
-			st = -ENOMEM;
-			goto failed_ida_get;
-		}
-
-		spin_lock(&rsxx_ida_lock);
-		st = ida_get_new(&rsxx_disk_ida, &card->disk_id);
-		spin_unlock(&rsxx_ida_lock);
-	} while (st == -EAGAIN);
-
-	if (st)
+	st = ida_alloc(&rsxx_disk_ida, GFP_KERNEL);
+	if (st < 0)
 		goto failed_ida_get;
+	card->disk_id = st;
 
 	st = pci_enable_device(dev);
 	if (st)
@@ -985,9 +975,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 failed_dma_mask:
 	pci_disable_device(dev);
 failed_enable:
-	spin_lock(&rsxx_ida_lock);
-	ida_remove(&rsxx_disk_ida, card->disk_id);
-	spin_unlock(&rsxx_ida_lock);
+	ida_free(&rsxx_disk_ida, card->disk_id);
 failed_ida_get:
 	kfree(card);
 
@@ -1050,6 +1038,7 @@ static void rsxx_pci_remove(struct pci_dev *dev)
 	pci_disable_device(dev);
 	pci_release_regions(dev);
 
+	ida_free(&rsxx_disk_ida, card->disk_id);
 	kfree(card);
 }
 
-- 
2.17.1

