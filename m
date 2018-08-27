Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605D9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11726208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T8TjR2z3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11726208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH0MdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:33:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dxooINHSa6qsOeQjHgnkhpVW4j4tF2G8dysoj0mH8zM=; b=T8TjR2z3KoYGxG3LLdUMLpwnF
        zdjvZwPWk8L3yH79BGPS/uUh+YdwXecePoHmlI+SRGYRWdA+RlW5YDyqEf4EWl45YvrCcm5n5JrV5
        G9l3MR3Kbrod1DQzizejrDQvvgrzT3RcGb1NcNTq3ZB3DeqAZloQQWWA1u44ACI2mWIxYPmtKfRG5
        FcA+evCmyNvRCE9v0rE5iDU/pAFJmef9/dX8O5vcityBxQZt5cbN/+CAgQFfJJMpIzpXsvNxB5vwS
        s5PehvwLgz3PKejgECqVonP0rJMjM6IzzXBMv+65GCE7ZJB+SOSJb9f1ZJF9iFj9je6rS9CliPEQO
        0K5VC6wPg==;
Received: from 213-225-1-219.nat.highway.a1.net ([213.225.1.219] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuDBB-0002LS-Ce; Mon, 27 Aug 2018 08:47:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dma-mapping: remove dma_configure
Date:   Mon, 27 Aug 2018 10:47:09 +0200
Message-Id: <20180827084711.23407-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827084711.23407-1-hch@lst.de>
References: <20180827084711.23407-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no good reason for this indirection given that the method
always exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/dd.c           |  8 +++++---
 include/linux/dma-mapping.h |  6 ------
 kernel/dma/mapping.c        | 10 ----------
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index edfc9f0b1180..65128cf8427c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -480,9 +480,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (ret)
 		goto pinctrl_bind_failed;
 
-	ret = dma_configure(dev);
-	if (ret)
-		goto dma_failed;
+	if (dev->bus->dma_configure) {
+		ret = dev->bus->dma_configure(dev);
+		if (ret)
+			goto dma_failed;
+	}
 
 	if (driver_sysfs_add(dev)) {
 		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 1db6a6b46d0d..1c6c7c09bcf2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -754,14 +754,8 @@ dma_mark_declared_memory_occupied(struct device *dev,
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
 #ifdef CONFIG_HAS_DMA
-int dma_configure(struct device *dev);
 void dma_deconfigure(struct device *dev);
 #else
-static inline int dma_configure(struct device *dev)
-{
-	return 0;
-}
-
 static inline void dma_deconfigure(struct device *dev) {}
 #endif
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d2a92ddaac4d..25607ceb4a50 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -328,16 +328,6 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
 }
 #endif
 
-/*
- * enables DMA API use for a device
- */
-int dma_configure(struct device *dev)
-{
-	if (dev->bus->dma_configure)
-		return dev->bus->dma_configure(dev);
-	return 0;
-}
-
 void dma_deconfigure(struct device *dev)
 {
 	of_dma_deconfigure(dev);
-- 
2.18.0

