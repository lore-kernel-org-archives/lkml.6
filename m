Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeC1Nfz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:35:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeC1Nfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:35:48 -0400
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: don't clear GFP_ZERO in dma_alloc_attrs
Date: Wed, 28 Mar 2018 15:35:35 +0200
Message-Id: <20180328133535.17302-2-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328133535.17302-1-hch@lst.de>
References: <20180328133535.17302-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert the clearing of __GFP_ZERO in dma_alloc_attrs and move it to
dma_direct_alloc for now.  While most common architectures always zero dma
cohereny allocations (and x86 did so since day one) this is not documented
and at least arc and s390 do not zero without the explicit __GFP_ZERO
argument.

Fixes: 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in common code")
Reported-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Reported-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 8 ++------
 lib/dma-direct.c            | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eb9eab4ecd6d..12fedcba9a9a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -518,12 +518,8 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
 
-	/*
-	 * Let the implementation decide on the zone to allocate from, and
-	 * decide on the way of zeroing the memory given that the memory
-	 * returned should always be zeroed.
-	 */
-	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);
+	/* let the implementation decide on the zone to allocate from: */
+	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
 	if (!arch_dma_alloc_attrs(&dev, &flag))
 		return NULL;
diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 1277d293d4da..c0bba30fef0a 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -59,6 +59,9 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	struct page *page = NULL;
 	void *ret;
 
+	/* we always manually zero the memory once we are done: */
+	gfp &= ~__GFP_ZERO;
+
 	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
 	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
 		gfp |= GFP_DMA;
-- 
2.14.2
