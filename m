Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4885C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CF82086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N8TUp/N9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CF82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeH2KTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:19:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeH2KTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cyQFMiJfaylbpBA4Ci3mbH3s9TBrSMR7z8iUFQSa7ao=; b=N8TUp/N9mxZ9wQ98R5p78rNNK
        jaDu3kXQ2EbitXOoN3e5uovUQkW0EywHmSDb+QVAWaCJ/iJt2ieYYMCIewYPzTyuOWT79eFSn2bMX
        nUTktU97FGB/NIwN7wMrzqaYYPYZm27Idc/M/npVuxbjwRp4HnJ9fwJi0yvD/KbTDNeJmS4vojUgQ
        h7BNacM2WQRR2xztYTbH2bWaVnPUCQWp0CAjOkPj+ehYnFFAgVEmOgSb8qjYo2DRbsbK3WqI9qTRi
        7mTYlpfwYHaS2z2hLLQ0GNKHvILd3lZl7y+l9iW1BUYtyEFR/LywvPLMX8dOVYYcJufcbuH//VOQf
        O6gAjTe9Q==;
Received: from 213-225-12-4.nat.highway.a1.net ([213.225.12.4] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1futtj-0002j1-R7; Wed, 29 Aug 2018 06:24:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Meelis Roos <mroos@linux.ee>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sparc: set a default 32-bit dma mask for OF devices
Date:   Wed, 29 Aug 2018 08:24:00 +0200
Message-Id: <20180829062401.8701-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829062401.8701-1-hch@lst.de>
References: <20180829062401.8701-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This keeps the historic default behavior for devices without a DMA mask,
but removes the warning about a lacking DMA mask for doing DMA without
a mask.

Reported-by: Meelis Roos <mroos@linux.ee>
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/of_device_32.c | 5 +++++
 arch/sparc/kernel/of_device_64.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 3641a294ed54..7f3dec7e1e78 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
 #include <asm/leon.h>
 #include <asm/leon_amba.h>
 
@@ -381,6 +382,10 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 	else
 		dev_set_name(&op->dev, "%08x", dp->phandle);
 
+	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	op->dev.dma_mask = &op->dma_mask;
+	op->dma_mask = DMA_BIT_MASK(32);
+
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
 		       dp->full_name);
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 44e4d4435bed..d94c31822da1 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -2,6 +2,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/mod_devicetable.h>
@@ -675,6 +676,9 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 		dev_set_name(&op->dev, "root");
 	else
 		dev_set_name(&op->dev, "%08x", dp->phandle);
+	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	op->dev.dma_mask = &op->dma_mask;
+	op->dma_mask = DMA_BIT_MASK(32);
 
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
-- 
2.18.0

