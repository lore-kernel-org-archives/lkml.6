Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F78C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A82020811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S7UbB51h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbfBMHCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:02:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388901AbfBMHCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HZUGhVljFuQpfecXprAlMr7+HkJ6Bp3NiHSypms/FgQ=; b=S7UbB51h9ayy08ZNJqJz3QxWIq
        mBMTVqSoKtl/mVGf+Zweo2C2OdrD/MLzQGUkw2LynSj6FxJr2F2ooOJMgBRbNJ6tUGC2jpFW5viq7
        54talKvEr0FCzOBdKV9T2e8vRv8P7HMZLWNdI7QDUKHRjjYeNc3+QVgj78Zc8AI1HSaXy1C8APjor
        gA8B41dMRuCt3oI1h+D+OTEpdPuoRLSYSv8OIuk4uTrPmeqfoTiSHfXhbF6UHKAqzRCrtmHjbnjF/
        GCa/FDxkt3grzLUuI3BjSvfUWqgLFcm47HyLuyP9/Me1hu5/hDMzh96mAuPkuUse55xZ+avxIWmT4
        hnwrUj2Q==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoZ5-0000j6-6Y; Wed, 13 Feb 2019 07:02:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH 27/32] powerpc/dma: use the dma-direct allocator for coherent platforms
Date:   Wed, 13 Feb 2019 08:01:28 +0100
Message-Id: <20190213070133.11259-28-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic code allows a few nice things such as node local allocations
and dipping into the CMA area.  The lookup of the right zone for a given
dma mask works a little different, but the results should be the same.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/pgtable.h |  1 -
 arch/powerpc/kernel/dma-iommu.c    |  5 +--
 arch/powerpc/kernel/dma-swiotlb.c  |  4 +-
 arch/powerpc/kernel/dma.c          | 69 +++---------------------------
 arch/powerpc/mm/mem.c              | 22 ----------
 5 files changed, 9 insertions(+), 92 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index dad1d27e196d..505550fb2935 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -66,7 +66,6 @@ extern unsigned long empty_zero_page[];
 
 extern pgd_t swapper_pg_dir[];
 
-int dma_pfn_limit_to_zone(u64 pfn_limit);
 extern void paging_init(void);
 
 /*
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 67fbfaa4e3b2..c75ba4e3a50c 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -40,8 +40,7 @@ static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 				      unsigned long attrs)
 {
 	if (dma_iommu_alloc_bypass(dev))
-		return __dma_nommu_alloc_coherent(dev, size, dma_handle, flag,
-				attrs);
+		return dma_direct_alloc(dev, size, dma_handle, flag, attrs);
 	return iommu_alloc_coherent(dev, get_iommu_table_base(dev), size,
 				    dma_handle, dev->coherent_dma_mask, flag,
 				    dev_to_node(dev));
@@ -52,7 +51,7 @@ static void dma_iommu_free_coherent(struct device *dev, size_t size,
 				    unsigned long attrs)
 {
 	if (dma_iommu_alloc_bypass(dev))
-		__dma_nommu_free_coherent(dev, size, vaddr, dma_handle, attrs);
+		dma_direct_free(dev, size, vaddr, dma_handle, attrs);
 	else
 		iommu_free_coherent(get_iommu_table_base(dev), size, vaddr,
 				dma_handle);
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 6d2677b2daa6..3a15a7d945e9 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -32,8 +32,8 @@ unsigned int ppc_swiotlb_enable;
  * for everything else.
  */
 const struct dma_map_ops powerpc_swiotlb_dma_ops = {
-	.alloc = __dma_nommu_alloc_coherent,
-	.free = __dma_nommu_free_coherent,
+	.alloc = dma_direct_alloc,
+	.free = dma_direct_free,
 	.map_sg = dma_direct_map_sg,
 	.unmap_sg = dma_direct_unmap_sg,
 	.dma_supported = dma_direct_supported,
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index a3546a82f6d7..f983f8d435a6 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -27,70 +27,6 @@
  * default the offset is PCI_DRAM_OFFSET.
  */
 
-static u64 __maybe_unused get_pfn_limit(struct device *dev)
-{
-	u64 pfn = (dev->coherent_dma_mask >> PAGE_SHIFT) + 1;
-
-#ifdef CONFIG_SWIOTLB
-	if (dev->bus_dma_mask && dev->dma_ops == &powerpc_swiotlb_dma_ops)
-		pfn = min_t(u64, pfn, dev->bus_dma_mask >> PAGE_SHIFT);
-#endif
-
-	return pfn;
-}
-
-#ifndef CONFIG_NOT_COHERENT_CACHE
-void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
-				  dma_addr_t *dma_handle, gfp_t flag,
-				  unsigned long attrs)
-{
-	void *ret;
-	struct page *page;
-	int node = dev_to_node(dev);
-#ifdef CONFIG_FSL_SOC
-	u64 pfn = get_pfn_limit(dev);
-	int zone;
-
-	/*
-	 * This code should be OK on other platforms, but we have drivers that
-	 * don't set coherent_dma_mask. As a workaround we just ifdef it. This
-	 * whole routine needs some serious cleanup.
-	 */
-
-	zone = dma_pfn_limit_to_zone(pfn);
-	if (zone < 0) {
-		dev_err(dev, "%s: No suitable zone for pfn %#llx\n",
-			__func__, pfn);
-		return NULL;
-	}
-
-	switch (zone) {
-#ifdef CONFIG_ZONE_DMA
-	case ZONE_DMA:
-		flag |= GFP_DMA;
-		break;
-#endif
-	};
-#endif /* CONFIG_FSL_SOC */
-
-	page = alloc_pages_node(node, flag, get_order(size));
-	if (page == NULL)
-		return NULL;
-	ret = page_address(page);
-	memset(ret, 0, size);
-	*dma_handle = phys_to_dma(dev,__pa(ret));
-
-	return ret;
-}
-
-void __dma_nommu_free_coherent(struct device *dev, size_t size,
-				void *vaddr, dma_addr_t dma_handle,
-				unsigned long attrs)
-{
-	free_pages((unsigned long)vaddr, get_order(size));
-}
-#endif /* !CONFIG_NOT_COHERENT_CACHE */
-
 int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction direction,
 		unsigned long attrs)
@@ -163,8 +99,13 @@ static inline void dma_nommu_sync_single(struct device *dev,
 #endif
 
 const struct dma_map_ops dma_nommu_ops = {
+#ifdef CONFIG_NOT_COHERENT_CACHE
 	.alloc				= __dma_nommu_alloc_coherent,
 	.free				= __dma_nommu_free_coherent,
+#else
+	.alloc				= dma_direct_alloc,
+	.free				= dma_direct_free,
+#endif
 	.map_sg				= dma_nommu_map_sg,
 	.unmap_sg			= dma_nommu_unmap_sg,
 	.dma_supported			= dma_direct_supported,
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 81f251fc4169..f6787f90e158 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -69,15 +69,12 @@ pte_t *kmap_pte;
 EXPORT_SYMBOL(kmap_pte);
 pgprot_t kmap_prot;
 EXPORT_SYMBOL(kmap_prot);
-#define TOP_ZONE ZONE_HIGHMEM
 
 static inline pte_t *virt_to_kpte(unsigned long vaddr)
 {
 	return pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr),
 			vaddr), vaddr), vaddr);
 }
-#else
-#define TOP_ZONE ZONE_NORMAL
 #endif
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
@@ -228,25 +225,6 @@ static int __init mark_nonram_nosave(void)
  */
 static unsigned long max_zone_pfns[MAX_NR_ZONES];
 
-/*
- * Find the least restrictive zone that is entirely below the
- * specified pfn limit.  Returns < 0 if no suitable zone is found.
- *
- * pfn_limit must be u64 because it can exceed 32 bits even on 32-bit
- * systems -- the DMA limit can be higher than any possible real pfn.
- */
-int dma_pfn_limit_to_zone(u64 pfn_limit)
-{
-	int i;
-
-	for (i = TOP_ZONE; i >= 0; i--) {
-		if (max_zone_pfns[i] <= pfn_limit)
-			return i;
-	}
-
-	return -EPERM;
-}
-
 /*
  * paging_init() sets up the page tables - in fact we've already done this.
  */
-- 
2.20.1

