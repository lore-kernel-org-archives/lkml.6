Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeCERrh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:47:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeCERrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:47:22 -0500
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] swiotlb: remove swiotlb_{alloc,free}_coherent
Date: Mon,  5 Mar 2018 09:46:55 -0800
Message-Id: <20180305174655.9878-14-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305174655.9878-1-hch@lst.de>
References: <20180305174655.9878-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused now that everyone uses swiotlb_{alloc,free}.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h |  8 --------
 lib/swiotlb.c           | 38 --------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 5b1f2a00491c..965be92c33b5 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -72,14 +72,6 @@ void *swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
 void swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs);
 
-extern void
-*swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-			dma_addr_t *dma_handle, gfp_t flags);
-
-extern void
-swiotlb_free_coherent(struct device *hwdev, size_t size,
-		      void *vaddr, dma_addr_t dma_handle);
-
 extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 8b06b4485e65..15954b86f09e 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -157,13 +157,6 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
-/* Note that this doesn't work with highmem page */
-static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
-				      volatile void *address)
-{
-	return phys_to_dma(hwdev, virt_to_phys(address));
-}
-
 static bool no_iotlb_memory;
 
 void swiotlb_print_info(void)
@@ -752,28 +745,6 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	return NULL;
 }
 
-void *
-swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-		       dma_addr_t *dma_handle, gfp_t flags)
-{
-	int order = get_order(size);
-	unsigned long attrs = (flags & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0;
-	void *ret;
-
-	ret = (void *)__get_free_pages(flags, order);
-	if (ret) {
-		*dma_handle = swiotlb_virt_to_bus(hwdev, ret);
-		if (dma_coherent_ok(hwdev, *dma_handle, size)) {
-			memset(ret, 0, size);
-			return ret;
-		}
-		free_pages((unsigned long)ret, order);
-	}
-
-	return swiotlb_alloc_buffer(hwdev, size, dma_handle, attrs);
-}
-EXPORT_SYMBOL(swiotlb_alloc_coherent);
-
 static bool swiotlb_free_buffer(struct device *dev, size_t size,
 		dma_addr_t dma_addr)
 {
@@ -793,15 +764,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 	return true;
 }
 
-void
-swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
-		      dma_addr_t dev_addr)
-{
-	if (!swiotlb_free_buffer(hwdev, size, dev_addr))
-		free_pages((unsigned long)vaddr, get_order(size));
-}
-EXPORT_SYMBOL(swiotlb_free_coherent);
-
 static void
 swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
 	     int do_panic)
-- 
2.14.2
