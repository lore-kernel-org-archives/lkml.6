Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8530C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C6821780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aOTFjgPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C6821780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbeKNS1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:27:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbeKNS1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1JqJLn1LqwELTBE6WlK9i6JU03ho/EMh1xHdgC/i7Ig=; b=aOTFjgPfWVeFjwLt2NCm4PjcNJ
        NaL3B+pEciRmRbOHkVuZqPunccEG2tK4Imy1on2lrBN6pXG3jK5Qu2ThvZpJkbX59S1IrU5d8vIek
        x9qFuMci0zsqr3B5nqG7XumYlXMq49qCeCDuxgXwirG4yW5ZZaJGceqrZsj4E0zNqxuQM6/FmZYNe
        f4kL1zEY9ihYYbUFlYJeD5gaeGlsF4Tb/TD2W7pH85A/5sNDCcZtCTi6g4ZOw3x3wBY5o4hQjctTL
        mXd010VAsyVr23D1RKvBz6B9JYLavjHcXPdYaABa4e6D7ukhJAELvKUrhBV/239vUIV8ISrxi5kC6
        jhnhOzcg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqTW-00057V-QH; Wed, 14 Nov 2018 08:24:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/34] powerpc/dma: remove dma_nommu_mmap_coherent
Date:   Wed, 14 Nov 2018 09:23:10 +0100
Message-Id: <20181114082314.8965-31-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coherent cache version of this function already is functionally
identicall to the default version, and by defining the
arch_dma_coherent_to_pfn hook the same is ture for the noncoherent
version as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/dma-mapping.h |  4 ----
 arch/powerpc/kernel/dma-iommu.c        |  1 -
 arch/powerpc/kernel/dma-swiotlb.c      |  1 -
 arch/powerpc/kernel/dma.c              | 19 -------------------
 arch/powerpc/mm/dma-noncoherent.c      |  7 +++++--
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 arch/powerpc/platforms/pseries/vio.c   |  1 -
 7 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 16d45518d9bb..f19c486e7b3f 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -25,10 +25,6 @@ extern void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 extern void __dma_nommu_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_handle,
 				       unsigned long attrs);
-extern int dma_nommu_mmap_coherent(struct device *dev,
-				    struct vm_area_struct *vma,
-				    void *cpu_addr, dma_addr_t handle,
-				    size_t size, unsigned long attrs);
 int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction direction,
 		unsigned long attrs);
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 4937b39e246b..5b15e53ee43d 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -172,7 +172,6 @@ int dma_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
 const struct dma_map_ops dma_iommu_ops = {
 	.alloc			= dma_iommu_alloc_coherent,
 	.free			= dma_iommu_free_coherent,
-	.mmap			= dma_nommu_mmap_coherent,
 	.map_sg			= dma_iommu_map_sg,
 	.unmap_sg		= dma_iommu_unmap_sg,
 	.dma_supported		= dma_iommu_dma_supported,
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index b3266f7a6915..03df252ff5fb 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -42,7 +42,6 @@ unsigned int ppc_swiotlb_enable;
 const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.alloc = __dma_nommu_alloc_coherent,
 	.free = __dma_nommu_free_coherent,
-	.mmap = dma_nommu_mmap_coherent,
 	.map_sg = swiotlb_map_sg_attrs,
 	.unmap_sg = swiotlb_unmap_sg_attrs,
 	.dma_supported = swiotlb_dma_supported,
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 5c83a34f288f..a6590aa77181 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -113,24 +113,6 @@ void __dma_nommu_free_coherent(struct device *dev, size_t size,
 }
 #endif /* !CONFIG_NOT_COHERENT_CACHE */
 
-int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
-			     void *cpu_addr, dma_addr_t handle, size_t size,
-			     unsigned long attrs)
-{
-	unsigned long pfn;
-
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	pfn = __dma_get_coherent_pfn((unsigned long)cpu_addr);
-#else
-	pfn = page_to_pfn(virt_to_page(cpu_addr));
-#endif
-	return remap_pfn_range(vma, vma->vm_start,
-			       pfn + vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot);
-}
-
 int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction direction,
 		unsigned long attrs)
@@ -196,7 +178,6 @@ static inline void dma_nommu_sync_single(struct device *dev,
 const struct dma_map_ops dma_nommu_ops = {
 	.alloc				= __dma_nommu_alloc_coherent,
 	.free				= __dma_nommu_free_coherent,
-	.mmap				= dma_nommu_mmap_coherent,
 	.map_sg				= dma_nommu_map_sg,
 	.dma_supported			= dma_nommu_dma_supported,
 	.map_page			= dma_nommu_map_page,
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index e955539686a4..ee95da19c82d 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -30,6 +30,7 @@
 #include <linux/types.h>
 #include <linux/highmem.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/export.h>
 
 #include <asm/tlbflush.h>
@@ -400,14 +401,16 @@ EXPORT_SYMBOL(__dma_sync_page);
 
 /*
  * Return the PFN for a given cpu virtual address returned by
- * __dma_nommu_alloc_coherent. This is used by dma_mmap_coherent()
+ * __dma_nommu_alloc_coherent.
  */
-unsigned long __dma_get_coherent_pfn(unsigned long cpu_addr)
+long arch_dma_coherent_to_pfn(struct device *dev, void *vaddr,
+		dma_addr_t dma_addr)
 {
 	/* This should always be populated, so we don't test every
 	 * level. If that fails, we'll have a nice crash which
 	 * will be as good as a BUG_ON()
 	 */
+	unsigned long cpu_addr = (unsigned long)vaddr;
 	pgd_t *pgd = pgd_offset_k(cpu_addr);
 	pud_t *pud = pud_offset(pgd, cpu_addr);
 	pmd_t *pmd = pmd_offset(pud, cpu_addr);
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 6fedbf349fce..5fdfc1a6435c 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -414,6 +414,7 @@ config NOT_COHERENT_CACHE
 	bool
 	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || \
 		GAMECUBE_COMMON || AMIGAONE
+	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	default n if PPC_47x
 	default y
 
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index ea3a9745c812..63dbc4cfe60d 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -603,7 +603,6 @@ static void vio_dma_iommu_unmap_sg(struct device *dev,
 static const struct dma_map_ops vio_dma_mapping_ops = {
 	.alloc             = vio_dma_iommu_alloc_coherent,
 	.free              = vio_dma_iommu_free_coherent,
-	.mmap		   = dma_nommu_mmap_coherent,
 	.map_sg            = vio_dma_iommu_map_sg,
 	.unmap_sg          = vio_dma_iommu_unmap_sg,
 	.map_page          = vio_dma_iommu_map_page,
-- 
2.19.1

