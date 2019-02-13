Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3986CC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022712086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Du58XMas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405105AbfBMSaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:30:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405095AbfBMSaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hdiLQOdoPEaHd3iGuERUuI+RGin5fcrzdccaBdBselU=; b=Du58XMasnlFMWeDi/1aMDyF5wf
        lZVAULSGUi0iljwyiwnrpTLPTf7GSW0voi3NiZM2uFJnM1LP3g1LcGOZ+TMh0//yq81ZdijPBSIrR
        Idparcqxr3515wpo8vmTcQ8JoyNHCMdNTHOqfsQJHXgNhTxTzGxm2BV3SFOgiGUwV24IRi30BoxNy
        riwsmGzOMw52V0F0+rp7mWiDyp3U8clXusN94TkqAu07mYLMPkPQDAU+Oa9Fba2G34Kn8SsnzNceK
        Mu6TagYbj0AhMQlNAEktlrxxYKxT0lSVlNKDIxX0P+kP3AJqCbkHQJifdFCd9aZXZECwpX24VwkMA
        agFkcAZw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtzIC-0008VM-0Y; Wed, 13 Feb 2019 18:29:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/21] dma-iommu: factor contiguous allocations into helpers
Date:   Wed, 13 Feb 2019 19:29:12 +0100
Message-Id: <20190213182920.16764-14-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213182920.16764-1-hch@lst.de>
References: <20190213182920.16764-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This keeps the code together and will simplify using it in different
ways.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 110 ++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ff1ada9f98f5..b8a2159ca31a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -459,6 +459,48 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	return iova + iova_off;
 }
 
+static void iommu_dma_free_contiguous(struct device *dev, size_t size,
+		struct page *page, dma_addr_t dma_handle)
+{
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), dma_handle, size);
+	if (!dma_release_from_contiguous(dev, page, count))
+		__free_pages(page, get_order(size));
+}
+
+
+static void *iommu_dma_alloc_contiguous(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	bool coherent = dev_is_dma_coherent(dev);
+	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned int page_order = get_order(size);
+	struct page *page = NULL;
+
+	if (gfpflags_allow_blocking(gfp))
+		page = dma_alloc_from_contiguous(dev, count, page_order,
+						 gfp & __GFP_NOWARN);
+
+	if (page)
+		memset(page_address(page), 0, PAGE_ALIGN(size));
+	else
+		page = alloc_pages(gfp, page_order);
+	if (!page)
+		return NULL;
+
+	*dma_handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
+			iommu_get_dma_domain(dev));
+	if (*dma_handle == DMA_MAPPING_ERROR) {
+		if (!dma_release_from_contiguous(dev, page, count))
+			__free_pages(page, page_order);
+		return NULL;
+	}
+
+	return page_address(page);
+}
+
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -755,19 +797,6 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
 }
 
-static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, int prot)
-{
-	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
-			iommu_get_dma_domain(dev));
-}
-
-static void __iommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
-}
-
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -992,7 +1021,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	bool coherent = dev_is_dma_coherent(dev);
-	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	size_t iosize = size;
 	void *addr;
 
@@ -1005,7 +1033,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	gfp |= __GFP_ZERO;
 
 	if (!gfpflags_allow_blocking(gfp)) {
-		struct page *page;
 		/*
 		 * In atomic context we can't remap anything, so we'll only
 		 * get the virtually contiguous buffer we need by way of a
@@ -1014,44 +1041,27 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		if (!coherent)
 			return iommu_dma_alloc_pool(dev, iosize, handle, gfp,
 					attrs);
-
-		page = alloc_pages(gfp, get_order(size));
-		if (!page)
-			return NULL;
-
-		addr = page_address(page);
-		*handle = __iommu_dma_map_page(dev, page, 0, iosize, ioprot);
-		if (*handle == DMA_MAPPING_ERROR) {
-			__free_pages(page, get_order(size));
-			addr = NULL;
-		}
+		return iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
+				attrs);
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 		struct page *page;
 
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), gfp & __GFP_NOWARN);
-		if (!page)
+		addr = iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
+				attrs);
+		if (!addr)
 			return NULL;
+		page = virt_to_page(addr);
 
-		*handle = __iommu_dma_map_page(dev, page, 0, iosize, ioprot);
-		if (*handle == DMA_MAPPING_ERROR) {
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
+		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
+				__builtin_return_address(0));
+		if (!addr) {
+			iommu_dma_free_contiguous(dev, iosize, page, *handle);
 			return NULL;
 		}
-		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
-						   prot,
-						   __builtin_return_address(0));
-		if (addr) {
-			if (!coherent)
-				arch_dma_prep_coherent(page, iosize);
-			memset(addr, 0, size);
-		} else {
-			__iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
-		}
+
+		if (!coherent)
+			arch_dma_prep_coherent(page, iosize);
 	} else {
 		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
 	}
@@ -1078,16 +1088,14 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	if (dma_in_atomic_pool(cpu_addr, size)) {
 		iommu_dma_free_pool(dev, size, cpu_addr, handle);
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		struct page *page = vmalloc_to_page(cpu_addr);
-
-		__iommu_dma_unmap_page(dev, handle, iosize, 0, attrs);
-		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
+		iommu_dma_free_contiguous(dev, iosize,
+				vmalloc_to_page(cpu_addr), handle);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else if (is_vmalloc_addr(cpu_addr)){
 		iommu_dma_free_remap(dev, iosize, cpu_addr, handle);
 	} else {
-		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
-		__free_pages(virt_to_page(cpu_addr), get_order(size));
+		iommu_dma_free_contiguous(dev, iosize, virt_to_page(cpu_addr),
+				handle);
 	}
 }
 
-- 
2.20.1

