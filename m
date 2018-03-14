Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeCNRxV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:53:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeCNRxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:53:17 -0400
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] dma-direct: handle force decryption for dma coherent buffers in common code
Date: Wed, 14 Mar 2018 18:52:12 +0100
Message-Id: <20180314175213.20256-14-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180314175213.20256-1-hch@lst.de>
References: <20180314175213.20256-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With that in place the generic dma-direct routines can be used to
allocate non-encrypted bounce buffers, and the x86 SEV case can use
the generic swiotlb ops including nice features such as using CMA
allocations.

Note that I'm not too happy about using sev_active() in dma-direct, but
I couldn't come up with a good enough name for a wrapper to make it
worth adding.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/mm/mem_encrypt.c | 73 ++---------------------------------------------
 lib/dma-direct.c          | 32 +++++++++++++++++----
 2 files changed, 29 insertions(+), 76 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 1a05bea831a8..65f45e0ef496 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -200,58 +200,6 @@ void __init sme_early_init(void)
 		swiotlb_force = SWIOTLB_FORCE;
 }
 
-static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		       gfp_t gfp, unsigned long attrs)
-{
-	unsigned int order;
-	struct page *page;
-	void *vaddr = NULL;
-
-	order = get_order(size);
-	page = alloc_pages_node(dev_to_node(dev), gfp, order);
-	if (page) {
-		dma_addr_t addr;
-
-		/*
-		 * Since we will be clearing the encryption bit, check the
-		 * mask with it already cleared.
-		 */
-		addr = __phys_to_dma(dev, page_to_phys(page));
-		if ((addr + size) > dev->coherent_dma_mask) {
-			__free_pages(page, get_order(size));
-		} else {
-			vaddr = page_address(page);
-			*dma_handle = addr;
-		}
-	}
-
-	if (!vaddr)
-		vaddr = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
-
-	if (!vaddr)
-		return NULL;
-
-	/* Clear the SME encryption bit for DMA use if not swiotlb area */
-	if (!is_swiotlb_buffer(dma_to_phys(dev, *dma_handle))) {
-		set_memory_decrypted((unsigned long)vaddr, 1 << order);
-		memset(vaddr, 0, PAGE_SIZE << order);
-		*dma_handle = __sme_clr(*dma_handle);
-	}
-
-	return vaddr;
-}
-
-static void sev_free(struct device *dev, size_t size, void *vaddr,
-		     dma_addr_t dma_handle, unsigned long attrs)
-{
-	/* Set the SME encryption bit for re-use if not swiotlb area */
-	if (!is_swiotlb_buffer(dma_to_phys(dev, dma_handle)))
-		set_memory_encrypted((unsigned long)vaddr,
-				     1 << get_order(size));
-
-	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
-}
-
 static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 {
 	pgprot_t old_prot, new_prot;
@@ -404,20 +352,6 @@ bool sev_active(void)
 }
 EXPORT_SYMBOL(sev_active);
 
-static const struct dma_map_ops sev_dma_ops = {
-	.alloc                  = sev_alloc,
-	.free                   = sev_free,
-	.map_page               = swiotlb_map_page,
-	.unmap_page             = swiotlb_unmap_page,
-	.map_sg                 = swiotlb_map_sg_attrs,
-	.unmap_sg               = swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu    = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu        = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device     = swiotlb_sync_sg_for_device,
-	.mapping_error          = swiotlb_dma_mapping_error,
-};
-
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void)
 {
@@ -428,12 +362,11 @@ void __init mem_encrypt_init(void)
 	swiotlb_update_mem_attributes();
 
 	/*
-	 * With SEV, DMA operations cannot use encryption. New DMA ops
-	 * are required in order to mark the DMA areas as decrypted or
-	 * to use bounce buffers.
+	 * With SEV, DMA operations cannot use encryption, we need to use
+	 * SWIOTLB to bounce buffer DMA operation.
 	 */
 	if (sev_active())
-		dma_ops = &sev_dma_ops;
+		dma_ops = &swiotlb_dma_ops;
 
 	/*
 	 * With SEV, we need to unroll the rep string I/O instructions.
diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index c9e8e21cb334..1277d293d4da 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -9,6 +9,7 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-contiguous.h>
 #include <linux/pfn.h>
+#include <linux/set_memory.h>
 
 #define DIRECT_MAPPING_ERROR		0
 
@@ -20,6 +21,14 @@
 #define ARCH_ZONE_DMA_BITS 24
 #endif
 
+/*
+ * For AMD SEV all DMA must be to unencrypted addresses.
+ */
+static inline bool force_dma_unencrypted(void)
+{
+	return sev_active();
+}
+
 static bool
 check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 		const char *caller)
@@ -37,7 +46,9 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 
 static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	return phys_to_dma(dev, phys) + size - 1 <= dev->coherent_dma_mask;
+	dma_addr_t addr = force_dma_unencrypted() ?
+		__phys_to_dma(dev, phys) : phys_to_dma(dev, phys);
+	return addr + size - 1 <= dev->coherent_dma_mask;
 }
 
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
@@ -46,6 +57,7 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int page_order = get_order(size);
 	struct page *page = NULL;
+	void *ret;
 
 	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
 	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
@@ -78,10 +90,15 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	if (!page)
 		return NULL;
-
-	*dma_handle = phys_to_dma(dev, page_to_phys(page));
-	memset(page_address(page), 0, size);
-	return page_address(page);
+	ret = page_address(page);
+	if (force_dma_unencrypted()) {
+		set_memory_decrypted((unsigned long)ret, 1 << page_order);
+		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
+	} else {
+		*dma_handle = phys_to_dma(dev, page_to_phys(page));
+	}
+	memset(ret, 0, size);
+	return ret;
 }
 
 /*
@@ -92,9 +109,12 @@ void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned int page_order = get_order(size);
 
+	if (force_dma_unencrypted())
+		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 	if (!dma_release_from_contiguous(dev, virt_to_page(cpu_addr), count))
-		free_pages((unsigned long)cpu_addr, get_order(size));
+		free_pages((unsigned long)cpu_addr, page_order);
 }
 
 static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-- 
2.14.2
