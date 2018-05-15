Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbeEOSGx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:06:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752971AbeEOSFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:05:43 -0400
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] swiotlb: merge swiotlb_unmap_page and unmap_single
Date: Tue, 15 May 2018 20:05:20 +0200
Message-Id: <20180515180523.3038-4-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515180523.3038-1-hch@lst.de>
References: <20180515180523.3038-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 4d36340bc4f9..2ebbc7204061 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -814,9 +814,9 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
  * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
-static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
-			 size_t size, enum dma_data_direction dir,
-			 unsigned long attrs)
+void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs)
 {
 	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
 
@@ -839,13 +839,6 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 	dma_mark_clean(phys_to_virt(paddr), size);
 }
 
-void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
-			size_t size, enum dma_data_direction dir,
-			unsigned long attrs)
-{
-	unmap_single(hwdev, dev_addr, size, dir, attrs);
-}
-
 /*
  * Make physical memory consistent for a single streaming mode DMA translation
  * after a transfer.
@@ -949,7 +942,7 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i)
-		unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir,
+		swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
 }
 
-- 
2.17.0
