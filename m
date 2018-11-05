Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8484C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F65320896
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RlVLDzmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F65320896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeKEVji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:39:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WtOoQACujRoeqRVMfwffW62gslMl1Yjj0c8jJ+sQtQU=; b=RlVLDzmierUCy/UJanBS270nwr
        4mjFpOJxGAyBq1OCuXopBx+uSTEh+NLN0MugWESEDwNbq0iEqJ+qBiv4WrApasB/1F1tRJLCxNrUd
        lEwPLIyJguOBVGTP/RN7wVDoAJy1c5MrWg4jpEzSEq7PBXu9Fz2L0kxGo9Zu7o+5SfvfbBr+mTY+o
        huGHrq9q4nmQHcmcJrWM2lJ9rU/4Xsam6bPHTKW4bdBAVMBm5kChnbNDqf73LK03M6kgC5XzoyqVH
        OtqSbds39zu67mwweOOWJ8PIwD3K7hKMBoN0yr3H9Rd7JO1HAunXgn8pbvdliFA8P5nsNtdZWogfG
        j8frPT+A==;
Received: from 213-225-37-95.nat.highway.a1.net ([213.225.37.95] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJdrM-0003u3-TO; Mon, 05 Nov 2018 12:20:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] csky: use the generic remapping dma alloc implementation
Date:   Mon,  5 Nov 2018 13:19:31 +0100
Message-Id: <20181105121931.13481-10-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The csky code was largely copied from arm/arm64, so switch to the
generic arm64-based implementation instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/csky/Kconfig          |   2 +-
 arch/csky/mm/dma-mapping.c | 142 +------------------------------------
 2 files changed, 3 insertions(+), 141 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index c0cf8e948821..ea74f3a9eeaf 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -8,7 +8,7 @@ config CSKY
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select DMA_DIRECT_OPS
-	select DMA_REMAP
+	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
 	select DW_APB_TIMER_OF
diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index ad4046939713..80783bb71c5c 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -14,73 +14,13 @@
 #include <linux/version.h>
 #include <asm/cache.h>
 
-static struct gen_pool *atomic_pool;
-static size_t atomic_pool_size __initdata = SZ_256K;
-
-static int __init early_coherent_pool(char *p)
-{
-	atomic_pool_size = memparse(p, &p);
-	return 0;
-}
-early_param("coherent_pool", early_coherent_pool);
-
 static int __init atomic_pool_init(void)
 {
-	struct page *page;
-	size_t size = atomic_pool_size;
-	void *ptr;
-	int ret;
-
-	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
-	if (!atomic_pool)
-		BUG();
-
-	page = alloc_pages(GFP_KERNEL, get_order(size));
-	if (!page)
-		BUG();
-
-	ptr = dma_common_contiguous_remap(page, size, VM_ALLOC,
-					  pgprot_noncached(PAGE_KERNEL),
-					  __builtin_return_address(0));
-	if (!ptr)
-		BUG();
-
-	ret = gen_pool_add_virt(atomic_pool, (unsigned long)ptr,
-				page_to_phys(page), atomic_pool_size, -1);
-	if (ret)
-		BUG();
-
-	gen_pool_set_algo(atomic_pool, gen_pool_first_fit_order_align, NULL);
-
-	pr_info("DMA: preallocated %zu KiB pool for atomic coherent pool\n",
-		atomic_pool_size / 1024);
-
-	pr_info("DMA: vaddr: 0x%x phy: 0x%lx,\n", (unsigned int)ptr,
-		page_to_phys(page));
-
-	return 0;
+	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
 }
 postcore_initcall(atomic_pool_init);
 
-static void *csky_dma_alloc_atomic(struct device *dev, size_t size,
-				   dma_addr_t *dma_handle)
-{
-	unsigned long addr;
-
-	addr = gen_pool_alloc(atomic_pool, size);
-	if (addr)
-		*dma_handle = gen_pool_virt_to_phys(atomic_pool, addr);
-
-	return (void *)addr;
-}
-
-static void csky_dma_free_atomic(struct device *dev, size_t size, void *vaddr,
-				 dma_addr_t dma_handle, unsigned long attrs)
-{
-	gen_pool_free(atomic_pool, (unsigned long)vaddr, size);
-}
-
-static void __dma_clear_buffer(struct page *page, size_t size)
+void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	if (PageHighMem(page)) {
 		unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -107,84 +47,6 @@ static void __dma_clear_buffer(struct page *page, size_t size)
 	}
 }
 
-static void *csky_dma_alloc_nonatomic(struct device *dev, size_t size,
-				      dma_addr_t *dma_handle, gfp_t gfp,
-				      unsigned long attrs)
-{
-	void  *vaddr;
-	struct page *page;
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-	if (DMA_ATTR_NON_CONSISTENT & attrs) {
-		pr_err("csky %s can't support DMA_ATTR_NON_CONSISTENT.\n", __func__);
-		return NULL;
-	}
-
-	if (IS_ENABLED(CONFIG_DMA_CMA))
-		page = dma_alloc_from_contiguous(dev, count, get_order(size),
-						 gfp);
-	else
-		page = alloc_pages(gfp, get_order(size));
-
-	if (!page) {
-		pr_err("csky %s no more free pages.\n", __func__);
-		return NULL;
-	}
-
-	*dma_handle = page_to_phys(page);
-
-	__dma_clear_buffer(page, size);
-
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
-		return page;
-
-	vaddr = dma_common_contiguous_remap(page, PAGE_ALIGN(size), VM_USERMAP,
-		pgprot_noncached(PAGE_KERNEL), __builtin_return_address(0));
-	if (!vaddr)
-		BUG();
-
-	return vaddr;
-}
-
-static void csky_dma_free_nonatomic(
-	struct device *dev,
-	size_t size,
-	void *vaddr,
-	dma_addr_t dma_handle,
-	unsigned long attrs
-	)
-{
-	struct page *page = phys_to_page(dma_handle);
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-	if ((unsigned int)vaddr >= VMALLOC_START)
-		dma_common_free_remap(vaddr, size, VM_USERMAP);
-
-	if (IS_ENABLED(CONFIG_DMA_CMA))
-		dma_release_from_contiguous(dev, page, count);
-	else
-		__free_pages(page, get_order(size));
-}
-
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		     gfp_t gfp, unsigned long attrs)
-{
-	if (gfpflags_allow_blocking(gfp))
-		return csky_dma_alloc_nonatomic(dev, size, dma_handle, gfp,
-						attrs);
-	else
-		return csky_dma_alloc_atomic(dev, size, dma_handle);
-}
-
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		   dma_addr_t dma_handle, unsigned long attrs)
-{
-	if (!addr_in_gen_pool(atomic_pool, (unsigned int) vaddr, size))
-		csky_dma_free_nonatomic(dev, size, vaddr, dma_handle, attrs);
-	else
-		csky_dma_free_atomic(dev, size, vaddr, dma_handle, attrs);
-}
-
 static inline void cache_op(phys_addr_t paddr, size_t size,
 			    void (*fn)(unsigned long start, unsigned long end))
 {
-- 
2.19.1

