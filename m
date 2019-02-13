Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1852C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9303222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Flrm54TB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405144AbfBMSaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:30:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405115AbfBMSaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6jsWXAp7zlE98aG1bFGqBd9Yc9iEnneLxPeRdA272ak=; b=Flrm54TBEDP2Az5lNPwPspydY3
        nUUngeKZlz29qJ6fLByisiXHPSjd1JClnDG8VWwnXs+QtEwfhqPNSP2VsbVc5qCjFHLW2G2Mb1l5k
        jAV3Fb954R4RzOSyQ/6BKZTRzviqqExxxhbIy5EbyFkmznH77MvuIO0e8h5C+0njsD7ED5B19vecN
        v/JCkYdCcwRxyPgPNpo6WG7DoTUlYdPE5+ViD8dgxoJyweM5BcDN/Qy3piYIN1I5asiwTdl89X6DU
        UOFfGHOlhbOCL7rYzCZ6iPrqsKfBjcy01tfMChCfuNrwLp+bZYsXcH1jbP2cWIsb2GyInGUherk2C
        NlyRNc+A==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtzIO-0000oX-Tp; Wed, 13 Feb 2019 18:30:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/21] dma-iommu: don't depend on CONFIG_DMA_DIRECT_REMAP
Date:   Wed, 13 Feb 2019 19:29:17 +0100
Message-Id: <20190213182920.16764-19-hch@lst.de>
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

For entirely dma coherent architectures there is no requirement to ever
remap dma coherent allocation.  Move all the remap and pool code under
CONFIG_DMA_DIRECT_REMAP ifdefs, and drop the Kconfig dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/Kconfig     |  1 -
 drivers/iommu/dma-iommu.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8b13fb7d0263..d9a25715650e 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -94,7 +94,6 @@ config IOMMU_DMA
 	select IOMMU_API
 	select IOMMU_IOVA
 	select NEED_SG_DMA_LENGTH
-	depends on DMA_DIRECT_REMAP
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5f3c70c65d50..35a5c219b82e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -501,6 +501,7 @@ static void *iommu_dma_alloc_contiguous(struct device *dev, size_t size,
 	return page_address(page);
 }
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -783,6 +784,7 @@ static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
 				gfp, attrs);
 	return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
 }
+#endif /* CONFIG_DMA_DIRECT_REMAP */
 
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
@@ -1065,6 +1067,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	 */
 	gfp |= __GFP_ZERO;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (!dev_is_dma_coherent(dev))
 		return iommu_dma_alloc_noncoherent(dev, size, dma_handle, gfp,
 				attrs);
@@ -1072,6 +1075,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 		return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+#endif
 
 	return iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
 }
@@ -1091,6 +1095,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	 *
 	 * Hence how dodgy the below logic looks...
 	 */
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (dma_in_atomic_pool(cpu_addr, PAGE_ALIGN(size))) {
 		iommu_dma_free_pool(dev, size, cpu_addr, dma_handle);
 		return;
@@ -1104,6 +1109,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		page = vmalloc_to_page(cpu_addr);
 		dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
 	} else
+#endif
 		page = virt_to_page(cpu_addr);
 
 	iommu_dma_free_contiguous(dev, size, page, dma_handle);
@@ -1126,11 +1132,13 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (is_vmalloc_addr(cpu_addr)) {
 		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 			return iommu_dma_mmap_remap(cpu_addr, size, vma);
 		pfn = vmalloc_to_pfn(cpu_addr);
 	} else
+#endif
 		pfn = page_to_pfn(virt_to_page(cpu_addr));
 
 	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
@@ -1144,11 +1152,13 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page;
 	int ret;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (is_vmalloc_addr(cpu_addr)) {
 		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 			return iommu_dma_get_sgtable_remap(sgt, cpu_addr, size);
 		page = vmalloc_to_page(cpu_addr);
 	} else
+#endif
 		page = virt_to_page(cpu_addr);
 
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-- 
2.20.1

