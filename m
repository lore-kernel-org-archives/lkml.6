Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeCWRtm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:49:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCWRtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:49:40 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, mingo@elte.hu
Cc: konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH] swiotlb: swiotlb_{alloc,free}_buffer should depend on CONFIG_DMA_DIRECT_OPS
Date: Fri, 23 Mar 2018 18:49:30 +0100
Message-Id: <20180323174930.17767-1-hch@lst.de>
X-Mailer: git-send-email 2.14.2
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise we might get unused symbol warnings for configs that built
swiotlb.c only for use by xen-swiotlb.c and that don't otherwise select
CONFIG_DMA_DIRECT_OPS, which is possible on arm.

Fixes: 16e73adbca76 ("dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 15954b86f09e..47aeb04c1997 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -692,6 +692,7 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 	}
 }
 
+#ifdef CONFIG_DMA_DIRECT_OPS
 static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
 		size_t size)
 {
@@ -763,6 +764,7 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 				 DMA_ATTR_SKIP_CPU_SYNC);
 	return true;
 }
+#endif
 
 static void
 swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
-- 
2.14.2
