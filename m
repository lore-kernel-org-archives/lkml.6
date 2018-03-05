Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932538AbeCERto (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:49:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeCERrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:47:14 -0500
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] x86: remove dma_alloc_coherent_mask
Date: Mon,  5 Mar 2018 09:46:44 -0800
Message-Id: <20180305174655.9878-3-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305174655.9878-1-hch@lst.de>
References: <20180305174655.9878-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These days all devices (including the ISA fallback device) have a coherent
DMA mask set, so remove the workaround.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/dma-mapping.h | 18 ++----------------
 arch/x86/kernel/pci-dma.c          | 10 ++++------
 arch/x86/mm/mem_encrypt.c          |  4 +---
 drivers/xen/swiotlb-xen.c          | 16 +---------------
 4 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 6277c83c0eb1..545bf3721bc0 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -44,26 +44,12 @@ extern void dma_generic_free_coherent(struct device *dev, size_t size,
 				      void *vaddr, dma_addr_t dma_addr,
 				      unsigned long attrs);
 
-static inline unsigned long dma_alloc_coherent_mask(struct device *dev,
-						    gfp_t gfp)
-{
-	unsigned long dma_mask = 0;
-
-	dma_mask = dev->coherent_dma_mask;
-	if (!dma_mask)
-		dma_mask = (gfp & GFP_DMA) ? DMA_BIT_MASK(24) : DMA_BIT_MASK(32);
-
-	return dma_mask;
-}
-
 static inline gfp_t dma_alloc_coherent_gfp_flags(struct device *dev, gfp_t gfp)
 {
-	unsigned long dma_mask = dma_alloc_coherent_mask(dev, gfp);
-
-	if (dma_mask <= DMA_BIT_MASK(24))
+	if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
 		gfp |= GFP_DMA;
 #ifdef CONFIG_X86_64
-	if (dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
+	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
 		gfp |= GFP_DMA32;
 #endif
        return gfp;
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index df7ab02f959f..b59820872ec7 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -80,13 +80,10 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t flag,
 				 unsigned long attrs)
 {
-	unsigned long dma_mask;
 	struct page *page;
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	dma_addr_t addr;
 
-	dma_mask = dma_alloc_coherent_mask(dev, flag);
-
 again:
 	page = NULL;
 	/* CMA can be used only in the context which permits sleeping */
@@ -95,7 +92,7 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 						 flag);
 		if (page) {
 			addr = phys_to_dma(dev, page_to_phys(page));
-			if (addr + size > dma_mask) {
+			if (addr + size > dev->coherent_dma_mask) {
 				dma_release_from_contiguous(dev, page, count);
 				page = NULL;
 			}
@@ -108,10 +105,11 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 
 	addr = phys_to_dma(dev, page_to_phys(page));
-	if (addr + size > dma_mask) {
+	if (addr + size > dev->coherent_dma_mask) {
 		__free_pages(page, get_order(size));
 
-		if (dma_mask < DMA_BIT_MASK(32) && !(flag & GFP_DMA)) {
+		if (dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
+		    !(flag & GFP_DMA)) {
 			flag = (flag & ~GFP_DMA32) | GFP_DMA;
 			goto again;
 		}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 1a53071e2e17..75dc8b525c12 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -203,12 +203,10 @@ void __init sme_early_init(void)
 static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		       gfp_t gfp, unsigned long attrs)
 {
-	unsigned long dma_mask;
 	unsigned int order;
 	struct page *page;
 	void *vaddr = NULL;
 
-	dma_mask = dma_alloc_coherent_mask(dev, gfp);
 	order = get_order(size);
 
 	/*
@@ -226,7 +224,7 @@ static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		 * mask with it already cleared.
 		 */
 		addr = __sme_clr(phys_to_dma(dev, page_to_phys(page)));
-		if ((addr + size) > dma_mask) {
+		if ((addr + size) > dev->coherent_dma_mask) {
 			__free_pages(page, get_order(size));
 		} else {
 			vaddr = page_address(page);
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 5bb72d3f8337..e1c60899fdbc 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -53,20 +53,6 @@
  * API.
  */
 
-#ifndef CONFIG_X86
-static unsigned long dma_alloc_coherent_mask(struct device *dev,
-					    gfp_t gfp)
-{
-	unsigned long dma_mask = 0;
-
-	dma_mask = dev->coherent_dma_mask;
-	if (!dma_mask)
-		dma_mask = (gfp & GFP_DMA) ? DMA_BIT_MASK(24) : DMA_BIT_MASK(32);
-
-	return dma_mask;
-}
-#endif
-
 #define XEN_SWIOTLB_ERROR_CODE	(~(dma_addr_t)0x0)
 
 static char *xen_io_tlb_start, *xen_io_tlb_end;
@@ -328,7 +314,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		return ret;
 
 	if (hwdev && hwdev->coherent_dma_mask)
-		dma_mask = dma_alloc_coherent_mask(hwdev, flags);
+		dma_mask = hwdev->coherent_dma_mask;
 
 	/* At this point dma_handle is the physical address, next we are
 	 * going to set it to the machine address.
-- 
2.14.2
