Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4827C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E5A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VwLCN2yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfANJma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfANJmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KSMtAgdJ5lvy/aUzmLA/Zn0/Lsgfs7BwIKR+wKJ1jI4=; b=VwLCN2yrhmHeaZvyOTNxeQ/XDH
        N9zurhkN9jXiofchIlOHbWC/Hk1TOykVL8QGOgbr/hthrpRqXfNyfgN/6Mi1ZXZbfpl9owpUY4it8
        i9PEYsE32IqaR/R2G+TuuSn2LP4pcdeBaxYBeHWoElpSY5O2igJWXyXNvCnGjnUdMe9EgcvGHQq6s
        R461TJwVwiUu6oOOnJM61KLp0ejiJcAvVf8k9NSe4ftOb6sq0fu2XXpvX1cIvs5jM9L7FDEpyNCzb
        CtecUjsWpE7wdSBSgFHn2acB0oQSIpRp+U57hCNMKvQQ+bRpqDv8dinlADri36pqqKd1o9PQ4n4K9
        z2ogF4aQ==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giyl8-0006GY-Dj; Mon, 14 Jan 2019 09:42:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/19] dma-iommu: move the arm64 wrappers to common code
Date:   Mon, 14 Jan 2019 10:41:45 +0100
Message-Id: <20190114094159.27326-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114094159.27326-1-hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing really arm64 specific in the iommu_dma_ops
implementation, so move it to dma-iommu.c and keep a lot of symbols
self-contained.  Note the implementation does depend on the
DMA_DIRECT_REMAP infrastructure for now, so we'll have to make the
DMA_IOMMU support depend on it, but this will be relaxed soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 384 +-----------------------------------
 drivers/iommu/Kconfig       |   1 +
 drivers/iommu/dma-iommu.c   | 378 ++++++++++++++++++++++++++++++++---
 include/linux/dma-iommu.h   |  43 +---
 4 files changed, 359 insertions(+), 447 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 75fe7273a1e4..fffba9426ee4 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -27,6 +27,7 @@
 #include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/dma-contiguous.h>
+#include <linux/dma-iommu.h>
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
 #include <linux/pci.h>
@@ -58,37 +59,6 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 	__dma_flush_area(page_address(page), size);
 }
 
-#ifdef CONFIG_IOMMU_DMA
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
-static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
-			      unsigned long pfn, size_t size)
-{
-	int ret = -ENXIO;
-	unsigned long nr_vma_pages = vma_pages(vma);
-	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-
-	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      vma->vm_end - vma->vm_start,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
-}
-#endif /* CONFIG_IOMMU_DMA */
-
 static int __init arm64_dma_init(void)
 {
 	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
@@ -100,364 +70,18 @@ static int __init arm64_dma_init(void)
 arch_initcall(arm64_dma_init);
 
 #ifdef CONFIG_IOMMU_DMA
-#include <linux/dma-iommu.h>
-#include <linux/platform_device.h>
-#include <linux/amba/bus.h>
-
-static void *__iommu_alloc_attrs(struct device *dev, size_t size,
-				 dma_addr_t *handle, gfp_t gfp,
-				 unsigned long attrs)
-{
-	bool coherent = dev_is_dma_coherent(dev);
-	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
-	size_t iosize = size;
-	void *addr;
-
-	if (WARN(!dev, "cannot create IOMMU mapping for unknown device\n"))
-		return NULL;
-
-	size = PAGE_ALIGN(size);
-
-	/*
-	 * Some drivers rely on this, and we probably don't want the
-	 * possibility of stale kernel data being read by devices anyway.
-	 */
-	gfp |= __GFP_ZERO;
-
-	if (!gfpflags_allow_blocking(gfp)) {
-		struct page *page;
-		/*
-		 * In atomic context we can't remap anything, so we'll only
-		 * get the virtually contiguous buffer we need by way of a
-		 * physically contiguous allocation.
-		 */
-		if (coherent) {
-			page = alloc_pages(gfp, get_order(size));
-			addr = page ? page_address(page) : NULL;
-		} else {
-			addr = dma_alloc_from_pool(size, &page, gfp);
-		}
-		if (!addr)
-			return NULL;
-
-		*handle = iommu_dma_map_page(dev, page, 0, iosize, ioprot);
-		if (*handle == DMA_MAPPING_ERROR) {
-			if (coherent)
-				__free_pages(page, get_order(size));
-			else
-				dma_free_from_pool(addr, size);
-			addr = NULL;
-		}
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
-		struct page *page;
-
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), gfp & __GFP_NOWARN);
-		if (!page)
-			return NULL;
-
-		*handle = iommu_dma_map_page(dev, page, 0, iosize, ioprot);
-		if (*handle == DMA_MAPPING_ERROR) {
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
-			return NULL;
-		}
-		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
-						   prot,
-						   __builtin_return_address(0));
-		if (addr) {
-			if (!coherent)
-				__dma_flush_area(page_to_virt(page), iosize);
-			memset(addr, 0, size);
-		} else {
-			iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
-		}
-	} else {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
-		struct page **pages;
-
-		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
-					handle);
-		if (!pages)
-			return NULL;
-
-		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
-					      __builtin_return_address(0));
-		if (!addr)
-			iommu_dma_free(dev, pages, iosize, handle);
-	}
-	return addr;
-}
-
-static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-			       dma_addr_t handle, unsigned long attrs)
-{
-	size_t iosize = size;
-
-	size = PAGE_ALIGN(size);
-	/*
-	 * @cpu_addr will be one of 4 things depending on how it was allocated:
-	 * - A remapped array of pages for contiguous allocations.
-	 * - A remapped array of pages from iommu_dma_alloc(), for all
-	 *   non-atomic allocations.
-	 * - A non-cacheable alias from the atomic pool, for atomic
-	 *   allocations by non-coherent devices.
-	 * - A normal lowmem address, for atomic allocations by
-	 *   coherent devices.
-	 * Hence how dodgy the below logic looks...
-	 */
-	if (dma_in_atomic_pool(cpu_addr, size)) {
-		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
-		dma_free_from_pool(cpu_addr, size);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		struct page *page = vmalloc_to_page(cpu_addr);
-
-		iommu_dma_unmap_page(dev, handle, iosize, 0, attrs);
-		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else if (is_vmalloc_addr(cpu_addr)){
-		struct vm_struct *area = find_vm_area(cpu_addr);
-
-		if (WARN_ON(!area || !area->pages))
-			return;
-		iommu_dma_free(dev, area->pages, iosize, &handle);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else {
-		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
-		__free_pages(virt_to_page(cpu_addr), get_order(size));
-	}
-}
-
-static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
-			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			      unsigned long attrs)
-{
-	struct vm_struct *area;
-	int ret;
-
-	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
-
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
-		return __swiotlb_mmap_pfn(vma, pfn, size);
-	}
-
-	area = find_vm_area(cpu_addr);
-	if (WARN_ON(!area || !area->pages))
-		return -ENXIO;
-
-	return iommu_dma_mmap(area->pages, size, vma);
-}
-
-static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
-			       void *cpu_addr, dma_addr_t dma_addr,
-			       size_t size, unsigned long attrs)
-{
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct vm_struct *area = find_vm_area(cpu_addr);
-
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		struct page *page = vmalloc_to_page(cpu_addr);
-		return __swiotlb_get_sgtable_page(sgt, page, size);
-	}
-
-	if (WARN_ON(!area || !area->pages))
-		return -ENXIO;
-
-	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
-					 GFP_KERNEL);
-}
-
-static void __iommu_sync_single_for_cpu(struct device *dev,
-					dma_addr_t dev_addr, size_t size,
-					enum dma_data_direction dir)
-{
-	phys_addr_t phys;
-
-	if (dev_is_dma_coherent(dev))
-		return;
-
-	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dev_addr);
-	arch_sync_dma_for_cpu(dev, phys, size, dir);
-}
-
-static void __iommu_sync_single_for_device(struct device *dev,
-					   dma_addr_t dev_addr, size_t size,
-					   enum dma_data_direction dir)
-{
-	phys_addr_t phys;
-
-	if (dev_is_dma_coherent(dev))
-		return;
-
-	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dev_addr);
-	arch_sync_dma_for_device(dev, phys, size, dir);
-}
-
-static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	bool coherent = dev_is_dma_coherent(dev);
-	int prot = dma_info_to_prot(dir, coherent, attrs);
-	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
-
-	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    dev_addr != DMA_MAPPING_ERROR)
-		__dma_map_area(page_address(page) + offset, size, dir);
-
-	return dev_addr;
-}
-
-static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
-			       size_t size, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
-
-	iommu_dma_unmap_page(dev, dev_addr, size, dir, attrs);
-}
-
-static void __iommu_sync_sg_for_cpu(struct device *dev,
-				    struct scatterlist *sgl, int nelems,
-				    enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	if (dev_is_dma_coherent(dev))
-		return;
-
-	for_each_sg(sgl, sg, nelems, i)
-		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
-}
-
-static void __iommu_sync_sg_for_device(struct device *dev,
-				       struct scatterlist *sgl, int nelems,
-				       enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	if (dev_is_dma_coherent(dev))
-		return;
-
-	for_each_sg(sgl, sg, nelems, i)
-		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
-}
-
-static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
-				int nelems, enum dma_data_direction dir,
-				unsigned long attrs)
-{
-	bool coherent = dev_is_dma_coherent(dev);
-
-	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
-
-	return iommu_dma_map_sg(dev, sgl, nelems,
-				dma_info_to_prot(dir, coherent, attrs));
-}
-
-static void __iommu_unmap_sg_attrs(struct device *dev,
-				   struct scatterlist *sgl, int nelems,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
-
-	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
-}
-
-static const struct dma_map_ops iommu_dma_ops = {
-	.alloc = __iommu_alloc_attrs,
-	.free = __iommu_free_attrs,
-	.mmap = __iommu_mmap_attrs,
-	.get_sgtable = __iommu_get_sgtable,
-	.map_page = __iommu_map_page,
-	.unmap_page = __iommu_unmap_page,
-	.map_sg = __iommu_map_sg_attrs,
-	.unmap_sg = __iommu_unmap_sg_attrs,
-	.sync_single_for_cpu = __iommu_sync_single_for_cpu,
-	.sync_single_for_device = __iommu_sync_single_for_device,
-	.sync_sg_for_cpu = __iommu_sync_sg_for_cpu,
-	.sync_sg_for_device = __iommu_sync_sg_for_device,
-	.map_resource = iommu_dma_map_resource,
-	.unmap_resource = iommu_dma_unmap_resource,
-};
-
-static int __init __iommu_dma_init(void)
-{
-	return iommu_dma_init();
-}
-arch_initcall(__iommu_dma_init);
-
-static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				  const struct iommu_ops *ops)
-{
-	struct iommu_domain *domain;
-
-	if (!ops)
-		return;
-
-	/*
-	 * The IOMMU core code allocates the default DMA domain, which the
-	 * underlying IOMMU driver needs to support via the dma-iommu layer.
-	 */
-	domain = iommu_get_domain_for_dev(dev);
-
-	if (!domain)
-		goto out_err;
-
-	if (domain->type == IOMMU_DOMAIN_DMA) {
-		if (iommu_dma_init_domain(domain, dma_base, size, dev))
-			goto out_err;
-
-		dev->dma_ops = &iommu_dma_ops;
-	}
-
-	return;
-
-out_err:
-	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
-		 dev_name(dev));
-}
-
 void arch_teardown_dma_ops(struct device *dev)
 {
 	dev->dma_ops = NULL;
 }
-
-#else
-
-static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				  const struct iommu_ops *iommu)
-{ }
-
-#endif  /* CONFIG_IOMMU_DMA */
+#endif
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
 	dev->dma_coherent = coherent;
-	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
+	if (iommu)
+		iommu_setup_dma_ops(dev, dma_base, size, iommu);
 
 #ifdef CONFIG_XEN
 	if (xen_initial_domain()) {
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d9a25715650e..8b13fb7d0263 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -94,6 +94,7 @@ config IOMMU_DMA
 	select IOMMU_API
 	select IOMMU_IOVA
 	select NEED_SG_DMA_LENGTH
+	depends on DMA_DIRECT_REMAP
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d6a437385b26..e0ffe22775ac 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -21,6 +21,7 @@
 
 #include <linux/acpi_iort.h>
 #include <linux/device.h>
+#include <linux/dma-contiguous.h>
 #include <linux/dma-iommu.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
@@ -80,11 +81,6 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 	return cookie;
 }
 
-int iommu_dma_init(void)
-{
-	return iova_cache_get();
-}
-
 /**
  * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
  * @domain: IOMMU domain to prepare for DMA-API usage
@@ -286,7 +282,7 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
  * to ensure it is an invalid IOVA. It is safe to reinitialise a domain, but
  * any change which could make prior IOVAs invalid will fail.
  */
-int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
+static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		u64 size, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -338,7 +334,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	return iova_reserve_iommu_regions(dev, domain);
 }
-EXPORT_SYMBOL(iommu_dma_init_domain);
 
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
@@ -349,7 +344,7 @@ EXPORT_SYMBOL(iommu_dma_init_domain);
  *
  * Return: corresponding IOMMU API page protection flags
  */
-int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
+static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 		     unsigned long attrs)
 {
 	int prot = coherent ? IOMMU_CACHE : 0;
@@ -508,17 +503,17 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 }
 
 /**
- * iommu_dma_free - Free a buffer allocated by iommu_dma_alloc()
+ * iommu_dma_free - Free a buffer allocated by __iommu_dma_alloc()
  * @dev: Device which owns this buffer
- * @pages: Array of buffer pages as returned by iommu_dma_alloc()
+ * @pages: Array of buffer pages as returned by __iommu_dma_alloc()
  * @size: Size of buffer in bytes
  * @handle: DMA address of buffer
  *
  * Frees both the pages associated with the buffer, and the array
  * describing them
  */
-void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
-		dma_addr_t *handle)
+static void __iommu_dma_free(struct device *dev, struct page **pages,
+		size_t size, dma_addr_t *handle)
 {
 	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
 	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
@@ -526,7 +521,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 }
 
 /**
- * iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
+ * __iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
  * @dev: Device to allocate memory for. Must be a real device
  *	 attached to an iommu_dma_domain
  * @size: Size of buffer in bytes
@@ -541,8 +536,8 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  * Return: Array of struct page pointers describing the buffer,
  *	   or NULL on failure.
  */
-struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		unsigned long attrs, int prot, dma_addr_t *handle)
+static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
+		gfp_t gfp, unsigned long attrs, int prot, dma_addr_t *handle)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -597,16 +592,16 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 }
 
 /**
- * iommu_dma_mmap - Map a buffer into provided user VMA
- * @pages: Array representing buffer from iommu_dma_alloc()
+ * __iommu_dma_mmap - Map a buffer into provided user VMA
+ * @pages: Array representing buffer from __iommu_dma_alloc()
  * @size: Size of buffer in bytes
  * @vma: VMA describing requested userspace mapping
  *
  * Maps the pages of the buffer in @pages into @vma. The caller is responsible
  * for verifying the correct size and protection of @vma beforehand.
  */
-
-int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
+static int __iommu_dma_mmap(struct page **pages, size_t size,
+		struct vm_area_struct *vma)
 {
 	unsigned long uaddr = vma->vm_start;
 	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -621,6 +616,58 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 	return ret;
 }
 
+static void iommu_dma_sync_single_for_cpu(struct device *dev,
+		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
+{
+	phys_addr_t phys;
+
+	if (dev_is_dma_coherent(dev))
+		return;
+
+	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
+	arch_sync_dma_for_cpu(dev, phys, size, dir);
+}
+
+static void iommu_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
+{
+	phys_addr_t phys;
+
+	if (dev_is_dma_coherent(dev))
+		return;
+
+	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
+	arch_sync_dma_for_device(dev, phys, size, dir);
+}
+
+static void iommu_dma_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nelems,
+		enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (dev_is_dma_coherent(dev))
+		return;
+
+	for_each_sg(sgl, sg, nelems, i)
+		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
+}
+
+static void iommu_dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nelems,
+		enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (dev_is_dma_coherent(dev))
+		return;
+
+	for_each_sg(sgl, sg, nelems, i)
+		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
+}
+
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot, struct iommu_domain *domain)
 {
@@ -644,19 +691,44 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	return iova + iova_off;
 }
 
-dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
+static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot)
 {
 	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
 			iommu_get_dma_domain(dev));
 }
 
-void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-		enum dma_data_direction dir, unsigned long attrs)
+static void __iommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
 }
 
+static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+	bool coherent = dev_is_dma_coherent(dev);
+	dma_addr_t dma_handle;
+
+	dma_handle =__iommu_dma_map(dev, phys, size,
+			dma_info_to_prot(dir, coherent, attrs),
+			iommu_get_dma_domain(dev));
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    dma_handle != DMA_MAPPING_ERROR)
+		arch_sync_dma_for_device(dev, phys, size, dir);
+	return dma_handle;
+}
+
+static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), dma_handle, size);
+}
+
 /*
  * Prepare a successfully-mapped scatterlist to give back to the caller.
  *
@@ -739,18 +811,22 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
  * impedance-matching, to be able to hand off a suitably-aligned list,
  * but still preserve the original offsets and sizes for the caller.
  */
-int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, int prot)
+static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	struct scatterlist *s, *prev = NULL;
+	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
 	int i;
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
+
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
 	 * IOVA granules for the IOMMU driver to handle. With some clever
@@ -810,12 +886,16 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	return 0;
 }
 
-void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, unsigned long attrs)
+static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	dma_addr_t start, end;
 	struct scatterlist *tmp;
 	int i;
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
+
 	/*
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
@@ -830,7 +910,7 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 	__iommu_dma_unmap(iommu_get_dma_domain(dev), start, end - start);
 }
 
-dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
+static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_dma_map(dev, phys, size,
@@ -838,12 +918,252 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 			iommu_get_dma_domain(dev));
 }
 
-void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
+static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
 }
 
+static void *iommu_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
+{
+	bool coherent = dev_is_dma_coherent(dev);
+	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	size_t iosize = size;
+	void *addr;
+
+	size = PAGE_ALIGN(size);
+
+	/*
+	 * Some drivers rely on this, and we probably don't want the
+	 * possibility of stale kernel data being read by devices anyway.
+	 */
+	gfp |= __GFP_ZERO;
+
+	if (!gfpflags_allow_blocking(gfp)) {
+		struct page *page;
+		/*
+		 * In atomic context we can't remap anything, so we'll only
+		 * get the virtually contiguous buffer we need by way of a
+		 * physically contiguous allocation.
+		 */
+		if (coherent) {
+			page = alloc_pages(gfp, get_order(size));
+			addr = page ? page_address(page) : NULL;
+		} else {
+			addr = dma_alloc_from_pool(size, &page, gfp);
+		}
+		if (!addr)
+			return NULL;
+
+		*handle = __iommu_dma_map_page(dev, page, 0, iosize, ioprot);
+		if (*handle == DMA_MAPPING_ERROR) {
+			if (coherent)
+				__free_pages(page, get_order(size));
+			else
+				dma_free_from_pool(addr, size);
+			addr = NULL;
+		}
+	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+		struct page *page;
+
+		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
+					get_order(size), gfp & __GFP_NOWARN);
+		if (!page)
+			return NULL;
+
+		*handle = __iommu_dma_map_page(dev, page, 0, iosize, ioprot);
+		if (*handle == DMA_MAPPING_ERROR) {
+			dma_release_from_contiguous(dev, page,
+						    size >> PAGE_SHIFT);
+			return NULL;
+		}
+		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
+						   prot,
+						   __builtin_return_address(0));
+		if (addr) {
+			if (!coherent)
+				arch_dma_prep_coherent(page, iosize);
+			memset(addr, 0, size);
+		} else {
+			__iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
+			dma_release_from_contiguous(dev, page,
+						    size >> PAGE_SHIFT);
+		}
+	} else {
+		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+		struct page **pages;
+
+		pages = __iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
+					handle);
+		if (!pages)
+			return NULL;
+
+		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
+					      __builtin_return_address(0));
+		if (!addr)
+			__iommu_dma_free(dev, pages, iosize, handle);
+	}
+	return addr;
+}
+
+static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t handle, unsigned long attrs)
+{
+	size_t iosize = size;
+
+	size = PAGE_ALIGN(size);
+	/*
+	 * @cpu_addr will be one of 4 things depending on how it was allocated:
+	 * - A remapped array of pages for contiguous allocations.
+	 * - A remapped array of pages from __iommu_dma_alloc(), for all
+	 *   non-atomic allocations.
+	 * - A non-cacheable alias from the atomic pool, for atomic
+	 *   allocations by non-coherent devices.
+	 * - A normal lowmem address, for atomic allocations by
+	 *   coherent devices.
+	 * Hence how dodgy the below logic looks...
+	 */
+	if (dma_in_atomic_pool(cpu_addr, size)) {
+		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
+		dma_free_from_pool(cpu_addr, size);
+	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+		struct page *page = vmalloc_to_page(cpu_addr);
+
+		__iommu_dma_unmap_page(dev, handle, iosize, 0, attrs);
+		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
+		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
+	} else if (is_vmalloc_addr(cpu_addr)){
+		struct vm_struct *area = find_vm_area(cpu_addr);
+
+		if (WARN_ON(!area || !area->pages))
+			return;
+		__iommu_dma_free(dev, area->pages, iosize, &handle);
+		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
+	} else {
+		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
+		__free_pages(virt_to_page(cpu_addr), get_order(size));
+	}
+}
+
+static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
+			      unsigned long pfn, size_t size)
+{
+	int ret = -ENXIO;
+	unsigned long nr_vma_pages = vma_pages(vma);
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+
+	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      pfn + off,
+				      vma->vm_end - vma->vm_start,
+				      vma->vm_page_prot);
+	}
+
+	return ret;
+}
+
+static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+	struct vm_struct *area;
+	int ret;
+
+	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
+
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+		/*
+		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
+		 * hence in the vmalloc space.
+		 */
+		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
+		return __iommu_dma_mmap_pfn(vma, pfn, size);
+	}
+
+	area = find_vm_area(cpu_addr);
+	if (WARN_ON(!area || !area->pages))
+		return -ENXIO;
+
+	return __iommu_dma_mmap(area->pages, size, vma);
+}
+
+static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
+		size_t size)
+{
+	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return ret;
+}
+
+static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+		/*
+		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
+		 * hence in the vmalloc space.
+		 */
+		struct page *page = vmalloc_to_page(cpu_addr);
+		return __iommu_dma_get_sgtable_page(sgt, page, size);
+	}
+
+	if (WARN_ON(!area || !area->pages))
+		return -ENXIO;
+
+	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
+					 GFP_KERNEL);
+}
+
+static const struct dma_map_ops iommu_dma_ops = {
+	.alloc			= iommu_dma_alloc,
+	.free			= iommu_dma_free,
+	.mmap			= iommu_dma_mmap,
+	.get_sgtable		= iommu_dma_get_sgtable,
+	.map_page		= iommu_dma_map_page,
+	.unmap_page		= iommu_dma_unmap_page,
+	.map_sg			= iommu_dma_map_sg,
+	.unmap_sg		= iommu_dma_unmap_sg,
+	.sync_single_for_cpu	= iommu_dma_sync_single_for_cpu,
+	.sync_single_for_device	= iommu_dma_sync_single_for_device,
+	.sync_sg_for_cpu	= iommu_dma_sync_sg_for_cpu,
+	.sync_sg_for_device	= iommu_dma_sync_sg_for_device,
+	.map_resource		= iommu_dma_map_resource,
+	.unmap_resource		= iommu_dma_unmap_resource,
+};
+
+/*
+ * The IOMMU core code allocates the default DMA domain, which the underlying
+ * IOMMU driver needs to support via the dma-iommu layer.
+ */
+void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+		const struct iommu_ops *ops)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (!domain || domain->type != IOMMU_DOMAIN_DMA)
+		goto out_err;
+	if (iommu_dma_init_domain(domain, dma_base, size, dev))
+		goto out_err;
+
+	dev->dma_ops = &iommu_dma_ops;
+	return;
+out_err:
+	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
+		 dev_name(dev));
+}
+
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
 {
@@ -916,3 +1236,5 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 		msg->address_lo += lower_32_bits(msi_page->iova);
 	}
 }
+
+arch_initcall(iova_cache_get);
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 59e606f78626..5277aa8782bf 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -23,49 +23,14 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_IOMMU_DMA
-int iommu_dma_init(void);
-
 /* Domain management interface for IOMMU drivers */
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 /* Setup call for arch DMA mapping code */
-int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
-		u64 size, struct device *dev);
-
-/* General helpers for DMA-API <-> IOMMU-API interaction */
-int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
-		     unsigned long attrs);
-
-/*
- * These implement the bulk of the relevant DMA mapping callbacks, but require
- * the arch code to take care of attributes and cache maintenance
- */
-struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		unsigned long attrs, int prot, dma_addr_t *handle);
-void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
-		dma_addr_t *handle);
-
-int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma);
-
-dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, int prot);
-int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, int prot);
-
-/*
- * Arch code with no special attribute handling may use these
- * directly as DMA mapping callbacks for simplicity
- */
-void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-		enum dma_data_direction dir, unsigned long attrs);
-void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, unsigned long attrs);
-dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
-void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
+void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+		const struct iommu_ops *ops);
 
 /* The DMA API isn't _quite_ the whole story, though... */
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
@@ -73,9 +38,9 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 #else /* CONFIG_IOMMU_DMA */
 
-static inline int iommu_dma_init(void)
+static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
+		u64 size, const struct iommu_ops *ops)
 {
-	return 0;
 }
 
 static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
-- 
2.20.1

