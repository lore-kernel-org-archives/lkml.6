Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC46216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NEkh6Ljz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC46216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeI1E55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:57:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeI1E55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LL1+NL15BRYYeK610rr5mCDhwsbJqwa8QEicfQbg/fs=; b=NEkh6LjznbZxCnEE699LB7XxAO
        k4pmNo27nmyF4srjk6uBfHwsWj6QFWt4IXXr7y6L8Lv4on+ZyktJx9RUqgqAbb6UmOhyk2Hqzn2Lv
        hxxwm6IY6s26YMCjYeYs0101MmZHBzNeaVmJ8CSLE76eLe1WdTpcK8/dNCjQVehHSpSGtxP69HwFH
        6K9xTgTdx/GnCGm0UOuux1T/mh/UxWRIc4kjh610NSTcSLv8QtqwLM7Uvtn3QUZRfzbzNkIent3ml
        yS6y9R+SC38ZAFfWXXdJ5qZxOwSXPY9a/uoPqc9wJ6ufvJfZODKtcI3ZO8X6oqa8Km+VE3uTXYLwE
        M/LHZymg==;
Received: from [199.255.44.5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5eu6-0002oG-9q; Thu, 27 Sep 2018 22:37:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
Date:   Thu, 27 Sep 2018 15:35:37 -0700
Message-Id: <20180927223539.28449-4-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927223539.28449-1-hch@lst.de>
References: <20180927223539.28449-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to take the DMA offset and encryption bit into account when
selecting a zone.  User the opportunity to factor out the zone
selection into a helper for reuse.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/direct.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f32b33cfa331..e78548397a92 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -69,6 +69,22 @@ u64 dma_direct_get_required_mask(struct device *dev)
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
+static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
+		u64 *phys_mask)
+{
+	if (force_dma_unencrypted())
+		*phys_mask = __dma_to_phys(dev, dma_mask);
+	else
+		*phys_mask = dma_to_phys(dev, dma_mask);
+
+	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
+	if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+		return GFP_DMA;
+	if (*phys_mask <= DMA_BIT_MASK(32))
+		return GFP_DMA32;
+	return 0;
+}
+
 static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
 	return phys_to_dma_direct(dev, phys) + size - 1 <=
@@ -81,17 +97,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int page_order = get_order(size);
 	struct page *page = NULL;
+	u64 phys_mask;
 	void *ret;
 
 	/* we always manually zero the memory once we are done: */
 	gfp &= ~__GFP_ZERO;
-
-	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
-		gfp |= GFP_DMA;
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
-		gfp |= GFP_DMA32;
-
+	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
+			&phys_mask);
 again:
 	/* CMA can be used only in the context which permits sleeping */
 	if (gfpflags_allow_blocking(gfp)) {
@@ -110,15 +122,14 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		page = NULL;
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-		    dev->coherent_dma_mask < DMA_BIT_MASK(64) &&
+		    phys_mask < DMA_BIT_MASK(64) &&
 		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
 			gfp |= GFP_DMA32;
 			goto again;
 		}
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
-		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
-		    !(gfp & GFP_DMA)) {
+		    phys_mask < DMA_BIT_MASK(32) && !(gfp & GFP_DMA)) {
 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
 			goto again;
 		}
-- 
2.19.0

