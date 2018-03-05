Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeCERsa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:48:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeCERrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:47:15 -0500
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] x86: use generic swiotlb_ops
Date: Mon,  5 Mar 2018 09:46:46 -0800
Message-Id: <20180305174655.9878-5-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305174655.9878-1-hch@lst.de>
References: <20180305174655.9878-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic swiotlb dma ops were based on the x86 ones and provide
equivalent functionality, so use them.

Also fix the sta2x11 case.  For that SOC the dma map ops need an
additional physical to dma address translations.  For swiotlb buffers
that is done throught the phys_to_dma helper, but the sta2x11_dma_ops
also added an additional translation on the return value from
x86_swiotlb_alloc_coherent, which is only correct if that functions
returns a direct allocation and not a swiotlb buffer.  With the
generic swiotlb and dma-direct code phys_to_dma is not always used
and the separate sta2x11_dma_ops can be replaced with a simple
bit that marks if the additional physical to dma address translation
is needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/device.h  |  3 +++
 arch/x86/include/asm/swiotlb.h |  8 -------
 arch/x86/kernel/pci-swiotlb.c  | 47 +-----------------------------------------
 arch/x86/pci/sta2x11-fixup.c   | 46 +++++------------------------------------
 4 files changed, 9 insertions(+), 95 deletions(-)

diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
index 5e12c63b47aa..812bd6c5d602 100644
--- a/arch/x86/include/asm/device.h
+++ b/arch/x86/include/asm/device.h
@@ -6,6 +6,9 @@ struct dev_archdata {
 #if defined(CONFIG_INTEL_IOMMU) || defined(CONFIG_AMD_IOMMU)
 	void *iommu; /* hook for IOMMU specific extension */
 #endif
+#ifdef CONFIG_STA2X11
+	bool is_sta2x11 : 1;
+#endif
 };
 
 #if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
diff --git a/arch/x86/include/asm/swiotlb.h b/arch/x86/include/asm/swiotlb.h
index 1c6a6cb230ff..ff6c92eff035 100644
--- a/arch/x86/include/asm/swiotlb.h
+++ b/arch/x86/include/asm/swiotlb.h
@@ -27,12 +27,4 @@ static inline void pci_swiotlb_late_init(void)
 {
 }
 #endif
-
-extern void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-					dma_addr_t *dma_handle, gfp_t flags,
-					unsigned long attrs);
-extern void x86_swiotlb_free_coherent(struct device *dev, size_t size,
-					void *vaddr, dma_addr_t dma_addr,
-					unsigned long attrs);
-
 #endif /* _ASM_X86_SWIOTLB_H */
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index bcb6a9bf64ad..661583662430 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -17,51 +17,6 @@
 
 int swiotlb __read_mostly;
 
-void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-					dma_addr_t *dma_handle, gfp_t flags,
-					unsigned long attrs)
-{
-	void *vaddr;
-
-	/*
-	 * Don't print a warning when the first allocation attempt fails.
-	 * swiotlb_alloc_coherent() will print a warning when the DMA
-	 * memory allocation ultimately failed.
-	 */
-	flags |= __GFP_NOWARN;
-
-	vaddr = dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
-	if (vaddr)
-		return vaddr;
-
-	return swiotlb_alloc_coherent(hwdev, size, dma_handle, flags);
-}
-
-void x86_swiotlb_free_coherent(struct device *dev, size_t size,
-				      void *vaddr, dma_addr_t dma_addr,
-				      unsigned long attrs)
-{
-	if (is_swiotlb_buffer(dma_to_phys(dev, dma_addr)))
-		swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-	else
-		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
-}
-
-static const struct dma_map_ops x86_swiotlb_dma_ops = {
-	.mapping_error = swiotlb_dma_mapping_error,
-	.alloc = x86_swiotlb_alloc_coherent,
-	.free = x86_swiotlb_free_coherent,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.dma_supported = NULL,
-};
-
 /*
  * pci_swiotlb_detect_override - set swiotlb to 1 if necessary
  *
@@ -111,7 +66,7 @@ void __init pci_swiotlb_init(void)
 {
 	if (swiotlb) {
 		swiotlb_init(0);
-		dma_ops = &x86_swiotlb_dma_ops;
+		dma_ops = &swiotlb_dma_ops;
 	}
 }
 
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 6c712fe11bdc..eac58e03f43c 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -159,43 +159,6 @@ static dma_addr_t a2p(dma_addr_t a, struct pci_dev *pdev)
 	return p;
 }
 
-/**
- * sta2x11_swiotlb_alloc_coherent - Allocate swiotlb bounce buffers
- *     returns virtual address. This is the only "special" function here.
- * @dev: PCI device
- * @size: Size of the buffer
- * @dma_handle: DMA address
- * @flags: memory flags
- */
-static void *sta2x11_swiotlb_alloc_coherent(struct device *dev,
-					    size_t size,
-					    dma_addr_t *dma_handle,
-					    gfp_t flags,
-					    unsigned long attrs)
-{
-	void *vaddr;
-
-	vaddr = x86_swiotlb_alloc_coherent(dev, size, dma_handle, flags, attrs);
-	*dma_handle = p2a(*dma_handle, to_pci_dev(dev));
-	return vaddr;
-}
-
-/* We have our own dma_ops: the same as swiotlb but from alloc (above) */
-static const struct dma_map_ops sta2x11_dma_ops = {
-	.alloc = sta2x11_swiotlb_alloc_coherent,
-	.free = x86_swiotlb_free_coherent,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.mapping_error = swiotlb_dma_mapping_error,
-	.dma_supported = dma_direct_supported,
-};
-
 /* At setup time, we use our own ops if the device is a ConneXt one */
 static void sta2x11_setup_pdev(struct pci_dev *pdev)
 {
@@ -205,7 +168,8 @@ static void sta2x11_setup_pdev(struct pci_dev *pdev)
 		return;
 	pci_set_consistent_dma_mask(pdev, STA2X11_AMBA_SIZE - 1);
 	pci_set_dma_mask(pdev, STA2X11_AMBA_SIZE - 1);
-	pdev->dev.dma_ops = &sta2x11_dma_ops;
+	pdev->dev.dma_ops = &swiotlb_dma_ops;
+	pdev->dev.archdata.is_sta2x11 = true;
 
 	/* We must enable all devices as master, for audio DMA to work */
 	pci_set_master(pdev);
@@ -225,7 +189,7 @@ bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	struct sta2x11_mapping *map;
 
-	if (dev->dma_ops != &sta2x11_dma_ops) {
+	if (!dev->archdata.is_sta2x11) {
 		if (!dev->dma_mask)
 			return false;
 		return addr + size - 1 <= *dev->dma_mask;
@@ -249,7 +213,7 @@ bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
  */
 dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	if (dev->dma_ops != &sta2x11_dma_ops)
+	if (!dev->archdata.is_sta2x11)
 		return paddr;
 	return p2a(paddr, to_pci_dev(dev));
 }
@@ -261,7 +225,7 @@ dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
  */
 phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	if (dev->dma_ops != &sta2x11_dma_ops)
+	if (!dev->archdata.is_sta2x11)
 		return daddr;
 	return a2p(daddr, to_pci_dev(dev));
 }
-- 
2.14.2
