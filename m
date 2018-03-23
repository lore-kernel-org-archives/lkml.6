Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCWTto (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:49:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56565 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCWTtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:49:43 -0400
Date: Fri, 23 Mar 2018 12:48:47 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-038d07a283d62336b32cc23b62aecdf9418cfc11@git.kernel.org>
Cc: thomas.lendacky@amd.com, jdmason@kudzu.us, hpa@zytor.com,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org, joro@8bytes.org,
        tglx@linutronix.de, konrad.wilk@oracle.com, peterz@infradead.org,
        hch@lst.de, torvalds@linux-foundation.org, mulix@mulix.org,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, joro@8bytes.org, hch@lst.de,
        peterz@infradead.org, konrad.wilk@oracle.com, mulix@mulix.org,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        jdmason@kudzu.us, thomas.lendacky@amd.com,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org
In-Reply-To: <20180319103826.12853-3-hch@lst.de>
References: <20180319103826.12853-3-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] x86/dma: Remove dma_alloc_coherent_mask()
Git-Commit-ID: 038d07a283d62336b32cc23b62aecdf9418cfc11
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  038d07a283d62336b32cc23b62aecdf9418cfc11
Gitweb:     https://git.kernel.org/tip/038d07a283d62336b32cc23b62aecdf9418cfc11
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 19 Mar 2018 11:38:14 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 10:01:56 +0100

x86/dma: Remove dma_alloc_coherent_mask()

These days all devices (including the ISA fallback device) have a coherent
DMA mask set, so remove the workaround.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: iommu@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20180319103826.12853-3-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
@@ -95,7 +92,7 @@ again:
 						 flag);
 		if (page) {
 			addr = phys_to_dma(dev, page_to_phys(page));
-			if (addr + size > dma_mask) {
+			if (addr + size > dev->coherent_dma_mask) {
 				dma_release_from_contiguous(dev, page, count);
 				page = NULL;
 			}
@@ -108,10 +105,11 @@ again:
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
index 3a1b5fe4c2ca..f6cd84beb610 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -198,12 +198,10 @@ void __init sme_early_init(void)
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
@@ -221,7 +219,7 @@ static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
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
