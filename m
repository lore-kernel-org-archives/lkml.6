Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE313C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30362086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eREybhdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405068AbfBMS3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:29:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405040AbfBMS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kuGpJAl23VAYc7hvGrGlMD07JNzs0WD73O959JASJQA=; b=eREybhdBwibzLcJp7sO79OSLpJ
        hlP4AC5doCoYXdxCgJ3lksi+HeATRH/XYpPTRlK/ggPnWB/5laIZFV8MG2Vk9AzgyGEo+4NFw1V2O
        OAO/3YgnFg7uZV38HZr0fbLF2i6FchvIvI/ICrJfH/Z+/UERddcGiMDtDFlypx+nUb66OdUs7TiC1
        lgKtZDVCbjGLvDtdP2y+36ETnl6/iF+3Q6aWPXd/iyIUa0t222l/4G1PygG5H/84UkC3Iay8nJubk
        NJhKXqzZzfYHazaCxUaUH8+BY1l9eocggN9Zmi0Iaf+0umUCTrkRcV7XkilKix20H3u8yToRLFO38
        t4j/oivw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtzI0-0008DJ-Ol; Wed, 13 Feb 2019 18:29:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/21] dma-iommu: refactor iommu_dma_get_sgtable
Date:   Wed, 13 Feb 2019 19:29:08 +0100
Message-Id: <20190213182920.16764-10-hch@lst.de>
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

Move the vm_area handling into a new iommu_dma_get_sgtable_remap helper.

Inline __iommu_dma_get_sgtable_page into the main function to simplify
the code flow a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 54 +++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ed2ef8409806..7ea9b2fac74b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -626,6 +626,18 @@ static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
 	return ret;
 }
 
+static int iommu_dma_get_sgtable_remap(struct sg_table *sgt, void *cpu_addr,
+		size_t size)
+{
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (WARN_ON(!area || !area->pages))
+		return -ENXIO;
+	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
+			GFP_KERNEL);
+}
+
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
@@ -1085,42 +1097,24 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			vma_pages(vma) << PAGE_SHIFT, vma->vm_page_prot);
 }
 
-static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
-		size_t size)
-{
-	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-
-	if (!ret)
-		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	return ret;
-}
-
 static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct vm_struct *area = find_vm_area(cpu_addr);
-
-	if (!is_vmalloc_addr(cpu_addr)) {
-		struct page *page = virt_to_page(cpu_addr);
-		return __iommu_dma_get_sgtable_page(sgt, page, size);
-	}
-
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		struct page *page = vmalloc_to_page(cpu_addr);
-		return __iommu_dma_get_sgtable_page(sgt, page, size);
-	}
+	struct page *page;
+	int ret;
 
-	if (WARN_ON(!area || !area->pages))
-		return -ENXIO;
+	if (is_vmalloc_addr(cpu_addr)) {
+		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+			return iommu_dma_get_sgtable_remap(sgt, cpu_addr, size);
+		page = vmalloc_to_page(cpu_addr);
+	} else
+		page = virt_to_page(cpu_addr);
 
-	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
-					 GFP_KERNEL);
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return ret;
 }
 
 static const struct dma_map_ops iommu_dma_ops = {
-- 
2.20.1

