Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE85C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D7B20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JK26CyNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D7B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJHPOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:14:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJHPOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nNGSlBXCZ158aSzeuSFBZW55a/QSpVHdQKonrDlziGE=; b=JK26CyNSasIlpakoGYtN3BTI84
        d3g1k5MTIV44J8p0zvzgxs5CQqz5dHDH+PlB7+XEFEkVWpjf66bt72Geep+IaNhp5Q8g0xWAXjVhj
        WjCxdoHoJ4oZDAUU1PDXVYJKIRf3fFhNwA1lhofA06m6CejHoBHidW9MlOejnQBdzQvIvVkXdHhew
        xzOCOSb3TmiKprnjrxvuIVETBf7S1YhEVMdEVctYsUcWt/TWvsXlgVffF2ATd5t7aKsuhphlqx1Qv
        CFy2hD1XhIowwWGeHV5YjDuqXsH5DThJQ+K+5eZZ8RuVgd397JEXexMiJeob5dEmtAXkiRDr3eZLU
        uDTrqrTA==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9QVk-0002Py-Pv; Mon, 08 Oct 2018 08:03:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] arm64: use the generic swiotlb_dma_ops
Date:   Mon,  8 Oct 2018 10:02:46 +0200
Message-Id: <20181008080246.20543-11-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008080246.20543-1-hch@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the generic swiotlb code supports non-coherent DMA we can switch
to it for arm64.  For that we need to refactor the existing
alloc/free/mmap/pgprot helpers to be used as the architecture hooks,
and implement the standard arch_sync_dma_for_{device,cpu} hooks for
cache maintaincance in the streaming dma hooks, which also implies
using the generic dma_coherent flag in struct device.

Note that we need to keep the old is_device_dma_coherent function around
for now, so that the shared arm/arm64 Xen code keeps working.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/Kconfig                   |   4 +
 arch/arm64/include/asm/device.h      |   1 -
 arch/arm64/include/asm/dma-mapping.h |   7 +-
 arch/arm64/mm/dma-mapping.c          | 257 +++++----------------------
 4 files changed, 56 insertions(+), 213 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..c4db5131d837 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -11,6 +11,8 @@ config ARM64
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_COHERENT_TO_PFN
+	select ARCH_HAS_DMA_MMAP_PGPROT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
@@ -24,6 +26,8 @@ config ARM64
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 5a5fa47a6b18..3dd3d664c5c5 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -23,7 +23,6 @@ struct dev_archdata {
 #ifdef CONFIG_XEN
 	const struct dma_map_ops *dev_dma_ops;
 #endif
-	bool dma_coherent;
 };
 
 struct pdev_archdata {
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index b7847eb8a7bb..c41f3fb1446c 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -44,10 +44,13 @@ void arch_teardown_dma_ops(struct device *dev);
 #define arch_teardown_dma_ops	arch_teardown_dma_ops
 #endif
 
-/* do not use this function in a driver */
+/*
+ * Do not use this function in a driver, it is only provided for
+ * arch/arm/mm/xen.c, which is used by arm64 as well.
+ */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
-	return dev->archdata.dma_coherent;
+	return dev->dma_coherent;
 }
 
 #endif	/* __KERNEL__ */
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index eee6cfcfde9e..3c75d69b54e7 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/genalloc.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/dma-contiguous.h>
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
@@ -32,16 +33,6 @@
 
 #include <asm/cacheflush.h>
 
-static int swiotlb __ro_after_init;
-
-static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
-				 bool coherent)
-{
-	if (!coherent || (attrs & DMA_ATTR_WRITE_COMBINE))
-		return pgprot_writecombine(prot);
-	return prot;
-}
-
 static struct gen_pool *atomic_pool __ro_after_init;
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
@@ -91,18 +82,16 @@ static int __free_from_pool(void *start, size_t size)
 	return 1;
 }
 
-static void *__dma_alloc(struct device *dev, size_t size,
-			 dma_addr_t *dma_handle, gfp_t flags,
-			 unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t flags, unsigned long attrs)
 {
 	struct page *page;
 	void *ptr, *coherent_ptr;
-	bool coherent = is_device_dma_coherent(dev);
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);
+	pgprot_t prot = pgprot_writecombine(PAGE_KERNEL);
 
 	size = PAGE_ALIGN(size);
 
-	if (!coherent && !gfpflags_allow_blocking(flags)) {
+	if (!gfpflags_allow_blocking(flags)) {
 		struct page *page = NULL;
 		void *addr = __alloc_from_pool(size, &page, flags);
 
@@ -116,10 +105,6 @@ static void *__dma_alloc(struct device *dev, size_t size,
 	if (!ptr)
 		goto no_mem;
 
-	/* no need for non-cacheable mapping if coherent */
-	if (coherent)
-		return ptr;
-
 	/* remove any dirty cache lines on the kernel alias */
 	__dma_flush_area(ptr, size);
 
@@ -138,125 +123,50 @@ static void *__dma_alloc(struct device *dev, size_t size,
 	return NULL;
 }
 
-static void __dma_free(struct device *dev, size_t size,
-		       void *vaddr, dma_addr_t dma_handle,
-		       unsigned long attrs)
-{
-	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
-
-	size = PAGE_ALIGN(size);
-
-	if (!is_device_dma_coherent(dev)) {
-		if (__free_from_pool(vaddr, size))
-			return;
-		vunmap(vaddr);
-	}
-	dma_direct_free_pages(dev, size, swiotlb_addr, dma_handle, attrs);
-}
-
-static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
-				     unsigned long offset, size_t size,
-				     enum dma_data_direction dir,
-				     unsigned long attrs)
-{
-	dma_addr_t dev_addr;
-
-	dev_addr = swiotlb_map_page(dev, page, offset, size, dir, attrs);
-	if (!is_device_dma_coherent(dev) &&
-	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
-
-	return dev_addr;
-}
-
-
-static void __swiotlb_unmap_page(struct device *dev, dma_addr_t dev_addr,
-				 size_t size, enum dma_data_direction dir,
-				 unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
 {
-	if (!is_device_dma_coherent(dev) &&
-	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
-	swiotlb_unmap_page(dev, dev_addr, size, dir, attrs);
+	if (__free_from_pool(vaddr, PAGE_ALIGN(size)))
+		return;
+	vunmap(vaddr);
+	dma_direct_free_pages(dev, size, vaddr, dma_handle, attrs);
 }
 
-static int __swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
-				  int nelems, enum dma_data_direction dir,
-				  unsigned long attrs)
+long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
+		dma_addr_t dma_addr)
 {
-	struct scatterlist *sg;
-	int i, ret;
-
-	ret = swiotlb_map_sg_attrs(dev, sgl, nelems, dir, attrs);
-	if (!is_device_dma_coherent(dev) &&
-	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		for_each_sg(sgl, sg, ret, i)
-			__dma_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
-				       sg->length, dir);
-
-	return ret;
+	return __phys_to_pfn(dma_to_phys(dev, dma_addr));
 }
 
-static void __swiotlb_unmap_sg_attrs(struct device *dev,
-				     struct scatterlist *sgl, int nelems,
-				     enum dma_data_direction dir,
-				     unsigned long attrs)
+pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
+		unsigned long attrs)
 {
-	struct scatterlist *sg;
-	int i;
-
-	if (!is_device_dma_coherent(dev) &&
-	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		for_each_sg(sgl, sg, nelems, i)
-			__dma_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
-					 sg->length, dir);
-	swiotlb_unmap_sg_attrs(dev, sgl, nelems, dir, attrs);
+	if (!dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_WRITE_COMBINE))
+		return pgprot_writecombine(prot);
+	return prot;
 }
 
-static void __swiotlb_sync_single_for_cpu(struct device *dev,
-					  dma_addr_t dev_addr, size_t size,
-					  enum dma_data_direction dir)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	if (!is_device_dma_coherent(dev))
-		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
-	swiotlb_sync_single_for_cpu(dev, dev_addr, size, dir);
+	__dma_map_area(phys_to_virt(paddr), size, dir);
 }
 
-static void __swiotlb_sync_single_for_device(struct device *dev,
-					     dma_addr_t dev_addr, size_t size,
-					     enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	swiotlb_sync_single_for_device(dev, dev_addr, size, dir);
-	if (!is_device_dma_coherent(dev))
-		__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
+	__dma_unmap_area(phys_to_virt(paddr), size, dir);
 }
 
-static void __swiotlb_sync_sg_for_cpu(struct device *dev,
-				      struct scatterlist *sgl, int nelems,
-				      enum dma_data_direction dir)
+static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
+				      struct page *page, size_t size)
 {
-	struct scatterlist *sg;
-	int i;
-
-	if (!is_device_dma_coherent(dev))
-		for_each_sg(sgl, sg, nelems, i)
-			__dma_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
-					 sg->length, dir);
-	swiotlb_sync_sg_for_cpu(dev, sgl, nelems, dir);
-}
+	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 
-static void __swiotlb_sync_sg_for_device(struct device *dev,
-					 struct scatterlist *sgl, int nelems,
-					 enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
 
-	swiotlb_sync_sg_for_device(dev, sgl, nelems, dir);
-	if (!is_device_dma_coherent(dev))
-		for_each_sg(sgl, sg, nelems, i)
-			__dma_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
-				       sg->length, dir);
+	return ret;
 }
 
 static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
@@ -277,74 +187,6 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
 	return ret;
 }
 
-static int __swiotlb_mmap(struct device *dev,
-			  struct vm_area_struct *vma,
-			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			  unsigned long attrs)
-{
-	int ret;
-	unsigned long pfn = dma_to_phys(dev, dma_addr) >> PAGE_SHIFT;
-
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
-					     is_device_dma_coherent(dev));
-
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
-	return __swiotlb_mmap_pfn(vma, pfn, size);
-}
-
-static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
-				      struct page *page, size_t size)
-{
-	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-
-	if (!ret)
-		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-
-	return ret;
-}
-
-static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
-				 void *cpu_addr, dma_addr_t handle, size_t size,
-				 unsigned long attrs)
-{
-	struct page *page = phys_to_page(dma_to_phys(dev, handle));
-
-	return __swiotlb_get_sgtable_page(sgt, page, size);
-}
-
-static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
-{
-	if (swiotlb)
-		return swiotlb_dma_supported(hwdev, mask);
-	return 1;
-}
-
-static int __swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t addr)
-{
-	if (swiotlb)
-		return dma_direct_mapping_error(hwdev, addr);
-	return 0;
-}
-
-static const struct dma_map_ops arm64_swiotlb_dma_ops = {
-	.alloc = __dma_alloc,
-	.free = __dma_free,
-	.mmap = __swiotlb_mmap,
-	.get_sgtable = __swiotlb_get_sgtable,
-	.map_page = __swiotlb_map_page,
-	.unmap_page = __swiotlb_unmap_page,
-	.map_sg = __swiotlb_map_sg_attrs,
-	.unmap_sg = __swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu = __swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = __swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = __swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = __swiotlb_sync_sg_for_device,
-	.dma_supported = __swiotlb_dma_supported,
-	.mapping_error = __swiotlb_dma_mapping_error,
-};
-
 static int __init atomic_pool_init(void)
 {
 	pgprot_t prot = __pgprot(PROT_NORMAL_NC);
@@ -500,10 +342,6 @@ EXPORT_SYMBOL(dummy_dma_ops);
 
 static int __init arm64_dma_init(void)
 {
-	if (swiotlb_force == SWIOTLB_FORCE ||
-	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
-		swiotlb = 1;
-
 	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
 		   TAINT_CPU_OUT_OF_SPEC,
 		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
@@ -528,7 +366,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				 dma_addr_t *handle, gfp_t gfp,
 				 unsigned long attrs)
 {
-	bool coherent = is_device_dma_coherent(dev);
+	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	size_t iosize = size;
 	void *addr;
@@ -569,7 +407,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 			addr = NULL;
 		}
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
+		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 		struct page *page;
 
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
@@ -596,7 +434,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 						    size >> PAGE_SHIFT);
 		}
 	} else {
-		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
+		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 		struct page **pages;
 
 		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
@@ -658,8 +496,7 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	struct vm_struct *area;
 	int ret;
 
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
-					     is_device_dma_coherent(dev));
+	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
@@ -709,11 +546,11 @@ static void __iommu_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (is_device_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
-	__dma_unmap_area(phys_to_virt(phys), size, dir);
+	arch_sync_dma_for_cpu(dev, phys, size, dir);
 }
 
 static void __iommu_sync_single_for_device(struct device *dev,
@@ -722,11 +559,11 @@ static void __iommu_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (is_device_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
-	__dma_map_area(phys_to_virt(phys), size, dir);
+	arch_sync_dma_for_device(dev, phys, size, dir);
 }
 
 static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
@@ -734,7 +571,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 				   enum dma_data_direction dir,
 				   unsigned long attrs)
 {
-	bool coherent = is_device_dma_coherent(dev);
+	bool coherent = dev_is_dma_coherent(dev);
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
 
@@ -762,11 +599,11 @@ static void __iommu_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (is_device_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev))
 		return;
 
 	for_each_sg(sgl, sg, nelems, i)
-		__dma_unmap_area(sg_virt(sg), sg->length, dir);
+		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
 }
 
 static void __iommu_sync_sg_for_device(struct device *dev,
@@ -776,18 +613,18 @@ static void __iommu_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (is_device_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev))
 		return;
 
 	for_each_sg(sgl, sg, nelems, i)
-		__dma_map_area(sg_virt(sg), sg->length, dir);
+		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
 }
 
 static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 				int nelems, enum dma_data_direction dir,
 				unsigned long attrs)
 {
-	bool coherent = is_device_dma_coherent(dev);
+	bool coherent = dev_is_dma_coherent(dev);
 
 	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
@@ -879,9 +716,9 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
 	if (!dev->dma_ops)
-		dev->dma_ops = &arm64_swiotlb_dma_ops;
+		dev->dma_ops = &swiotlb_dma_ops;
 
-	dev->archdata.dma_coherent = coherent;
+	dev->dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
 
 #ifdef CONFIG_XEN
-- 
2.19.0

