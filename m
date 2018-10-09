Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842AAC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4760A2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BzQh9QHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4760A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeJIUnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:43:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbeJIUnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6xV/WpKVguy+7dNBIsuEqczBqEePEOdZd5rcV9GeR8s=; b=BzQh9QHz3roG6GtLk9xod+o2+R
        QgEu+Yj0yhhbto0eCEpx65EdHrcciCT04Ks8VJeT3OtrGSnRTJI21Q2xY5lD76QOxNEyCcw0/O4T3
        Ywtegp3xx1ZV3Nj3egui3CbzlOQuqPejD5flsBXtd4TzJVp2Es++u0xT7/PStAiuW6j5+ceDAx3xw
        CVSUn1kDOtg2Ys0EtScNRd5fwoKqfxOPfi7igYzMzMTv9WznNK4pJuoB/W58JDobYtxGVLRBF5whO
        WGHPxBKXrYKlo6Khd61o0hWj05EE6qhx3yeFyNgA9xxMcMPuu5rGAX4HAWpk1UXL1JSu7SqtRh/fV
        4GhmwyZg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9s1I-0001Ko-H0; Tue, 09 Oct 2018 13:25:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/33] powerpc/dma: remove the iommu fallback for coherent allocations
Date:   Tue,  9 Oct 2018 15:24:47 +0200
Message-Id: <20181009132500.17643-21-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All iommu capable platforms now always use the iommu code with the
internal bypass, so there is not need for this magic anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig      |  4 ---
 arch/powerpc/kernel/dma.c | 68 ++-------------------------------------
 2 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 06996df07cad..7097019d8907 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -119,9 +119,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config ARCH_HAS_DMA_SET_COHERENT_MASK
-        bool
-
 config PPC
 	bool
 	default y
@@ -129,7 +126,6 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
-	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 78ef4076e15c..bef91b8ad064 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -114,51 +114,6 @@ void __dma_nommu_free_coherent(struct device *dev, size_t size,
 }
 #endif /* !CONFIG_NOT_COHERENT_CACHE */
 
-static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t flag,
-				       unsigned long attrs)
-{
-	struct iommu_table *iommu;
-
-	/* The coherent mask may be smaller than the real mask, check if
-	 * we can really use the direct ops
-	 */
-	if (dma_nommu_dma_supported(dev, dev->coherent_dma_mask))
-		return __dma_nommu_alloc_coherent(dev, size, dma_handle,
-						   flag, attrs);
-
-	/* Ok we can't ... do we have an iommu ? If not, fail */
-	iommu = get_iommu_table_base(dev);
-	if (!iommu)
-		return NULL;
-
-	/* Try to use the iommu */
-	return iommu_alloc_coherent(dev, iommu, size, dma_handle,
-				    dev->coherent_dma_mask, flag,
-				    dev_to_node(dev));
-}
-
-static void dma_nommu_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle,
-				     unsigned long attrs)
-{
-	struct iommu_table *iommu;
-
-	/* See comments in dma_nommu_alloc_coherent() */
-	if (dma_nommu_dma_supported(dev, dev->coherent_dma_mask))
-		return __dma_nommu_free_coherent(dev, size, vaddr, dma_handle,
-						  attrs);
-	/* Maybe we used an iommu ... */
-	iommu = get_iommu_table_base(dev);
-
-	/* If we hit that we should have never allocated in the first
-	 * place so how come we are freeing ?
-	 */
-	if (WARN_ON(!iommu))
-		return;
-	iommu_free_coherent(iommu, size, vaddr, dma_handle);
-}
-
 int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 			     void *cpu_addr, dma_addr_t handle, size_t size,
 			     unsigned long attrs)
@@ -228,8 +183,8 @@ static inline void dma_nommu_sync_single(struct device *dev,
 #endif
 
 const struct dma_map_ops dma_nommu_ops = {
-	.alloc				= dma_nommu_alloc_coherent,
-	.free				= dma_nommu_free_coherent,
+	.alloc				= __dma_nommu_alloc_coherent,
+	.free				= __dma_nommu_free_coherent,
 	.mmap				= dma_nommu_mmap_coherent,
 	.map_sg				= dma_nommu_map_sg,
 	.dma_supported			= dma_nommu_dma_supported,
@@ -243,25 +198,6 @@ const struct dma_map_ops dma_nommu_ops = {
 };
 EXPORT_SYMBOL(dma_nommu_ops);
 
-int dma_set_coherent_mask(struct device *dev, u64 mask)
-{
-	if (!dma_supported(dev, mask)) {
-		/*
-		 * We need to special case the direct DMA ops which can
-		 * support a fallback for coherent allocations. There
-		 * is no dma_op->set_coherent_mask() so we have to do
-		 * things the hard way:
-		 */
-		if (get_dma_ops(dev) != &dma_nommu_ops ||
-		    get_iommu_table_base(dev) == NULL ||
-		    !dma_iommu_dma_supported(dev, mask))
-			return -EIO;
-	}
-	dev->coherent_dma_mask = mask;
-	return 0;
-}
-EXPORT_SYMBOL(dma_set_coherent_mask);
-
 int dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	if (ppc_md.dma_set_mask)
-- 
2.19.0

