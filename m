Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6173C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B91320663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JO2fOr4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfANJml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfANJmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eRr2GpTEdvFM2fyidP6RWHIVjs2lZ98XGbdv6DhTjNQ=; b=JO2fOr4W+/MrtcS8UN4tBWCdYz
        PO4SPo6kgR2X/Ya0BkCCfYbUQX51aWdvifzNNOjndylUH+246HBiPPsGVt6e9iyqatn9DklHu45tf
        cIp/CgH5Hz0ghLQV9q7xyCxuf7A1p1U1IThmUNHUogY3e7SYbGtcL2gg48TlFvs4qvNyBjrPL4yM5
        JyXM6Oby/l/Pfuxf1agXzFGr2gFEdwoFIMdvB5scIJF32Avz28hnieDh5VPpFVS6aroRxDUnd4LoY
        xHbGMtHS7Fde0fbcp8Uu+9zs1030GIaUKztgo8hEMC7Y/F+D77EatFa6wCnZK8lvcyfr7zRnvPMEB
        NpvsiSDw==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giylK-0006Ti-GZ; Mon, 14 Jan 2019 09:42:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] dma-iommu: refactor page array remap helpers
Date:   Mon, 14 Jan 2019 10:41:49 +0100
Message-Id: <20190114094159.27326-10-hch@lst.de>
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

Move the call to dma_common_pages_remap / dma_common_free_remap  into
__iommu_dma_alloc / __iommu_dma_free and rename those functions to
better describe what they do.  This keeps the functionality that
allocates and remaps a non-contigous array of pages nicely abstracted
out from the calling code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 73 ++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0727c109bcab..95d30b96e5bd 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -526,51 +526,57 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 }
 
 /**
- * iommu_dma_free - Free a buffer allocated by __iommu_dma_alloc()
+ * iommu_dma_free_remap - Free a buffer allocated by iommu_dma_alloc_remap
  * @dev: Device which owns this buffer
- * @pages: Array of buffer pages as returned by __iommu_dma_alloc()
  * @size: Size of buffer in bytes
+ * @cpu_address: Virtual address of the buffer
  * @handle: DMA address of buffer
  *
  * Frees both the pages associated with the buffer, and the array
  * describing them
  */
-static void __iommu_dma_free(struct device *dev, struct page **pages,
-		size_t size, dma_addr_t *handle)
+static void iommu_dma_free_remap(struct device *dev, size_t size,
+		void *cpu_addr, dma_addr_t dma_handle)
 {
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
-	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
-	*handle = DMA_MAPPING_ERROR;
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (WARN_ON(!area || !area->pages))
+		return;
+	__iommu_dma_unmap(iommu_get_dma_domain(dev), dma_handle, size);
+	__iommu_dma_free_pages(area->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
+	dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
 }
 
 /**
- * __iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
+ * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
  * @dev: Device to allocate memory for. Must be a real device
  *	 attached to an iommu_dma_domain
  * @size: Size of buffer in bytes
+ * @dma_handle: Out argument for allocated DMA handle
  * @gfp: Allocation flags
  * @attrs: DMA attributes for this allocation
- * @prot: IOMMU mapping flags
- * @handle: Out argument for allocated DMA handle
  *
  * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
  * but an IOMMU which supports smaller pages might not map the whole thing.
  *
- * Return: Array of struct page pointers describing the buffer,
- *	   or NULL on failure.
+ * Return: Mapped virtual address, or NULL on failure.
  */
-static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
-		gfp_t gfp, unsigned long attrs, int prot, dma_addr_t *handle)
+static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
+	bool coherent = dev_is_dma_coherent(dev);
+	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap, i;
 	struct page **pages;
 	dma_addr_t iova;
-	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap, i;
 	size_t mapped = 0;
+	void *vaddr;
 
-	*handle = DMA_MAPPING_ERROR;
+	*dma_handle = DMA_MAPPING_ERROR;
 
 	min_size = alloc_sizes & -alloc_sizes;
 	if (min_size < PAGE_SIZE) {
@@ -596,16 +602,21 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
 	for (i = 0; i < count; i++) {
 		phys_addr_t phys = page_to_phys(pages[i]);
 
-		if (!(prot & IOMMU_CACHE))
+		if (!(ioprot & IOMMU_CACHE))
 			arch_dma_prep_coherent(pages[i], PAGE_SIZE);
 
-		if (iommu_map(domain, iova + mapped, phys, PAGE_SIZE, prot))
+		if (iommu_map(domain, iova + mapped, phys, PAGE_SIZE, ioprot))
 			goto out_unmap;
 		mapped += PAGE_SIZE;
 	}
 
-	*handle = iova;
-	return pages;
+	vaddr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
+			__builtin_return_address(0));
+	if (!vaddr)
+		goto out_unmap;
+
+	*dma_handle = iova;
+	return vaddr;
 out_unmap:
 	iommu_unmap(domain, iova, mapped);
 	iommu_dma_free_iova(cookie, iova, size);
@@ -1008,18 +1019,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 						    size >> PAGE_SHIFT);
 		}
 	} else {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
-		struct page **pages;
-
-		pages = __iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
-					handle);
-		if (!pages)
-			return NULL;
-
-		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
-					      __builtin_return_address(0));
-		if (!addr)
-			__iommu_dma_free(dev, pages, iosize, handle);
+		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
 	}
 	return addr;
 }
@@ -1033,7 +1033,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	/*
 	 * @cpu_addr will be one of 4 things depending on how it was allocated:
 	 * - A remapped array of pages for contiguous allocations.
-	 * - A remapped array of pages from __iommu_dma_alloc(), for all
+	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
 	 *   non-atomic allocations.
 	 * - A non-cacheable alias from the atomic pool, for atomic
 	 *   allocations by non-coherent devices.
@@ -1051,12 +1051,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else if (is_vmalloc_addr(cpu_addr)){
-		struct vm_struct *area = find_vm_area(cpu_addr);
-
-		if (WARN_ON(!area || !area->pages))
-			return;
-		__iommu_dma_free(dev, area->pages, iosize, &handle);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
+		iommu_dma_free_remap(dev, iosize, cpu_addr, handle);
 	} else {
 		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
 		__free_pages(virt_to_page(cpu_addr), get_order(size));
-- 
2.20.1

