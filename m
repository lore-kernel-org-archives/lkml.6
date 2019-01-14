Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471D7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F24020663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CkqWKvRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfANJmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfANJmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sKbhagjY2vhF6l1jNqLZ2zsIzXRti5cDkFXCA9YVAMQ=; b=CkqWKvRQh2RBymmoM0Q/pn0RYg
        EWvPK0fkkKICR7S4IWIsvG8QEw7K52xOC6yg98gFO9JtOFgG0sSjdXBNvQd9rxkszBf5gGc9+Uj2m
        47/Rd957VxBuLXaGRV5cI4nyoOLFN+LMS69XT7t7Ewe90NA5WkskdTjU9zeEs+S4hU+9K8QX8vIA6
        sHhRcf8iWyMpPgl2z35ue4u3JlctPOT03rErtIaAPihJKCJ+ktZ4FOYSIzir3vDbeHxOtQ0ZS+IEX
        d5XkTueVqoelEKnG7tfF66WoxEDPCpvDLh+mex9omPvOZzD0zIWzmBStqGRan+O55pFSVLnVkPqu6
        1FqTKD4Q==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giylE-0006NL-HH; Mon, 14 Jan 2019 09:42:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] dma-iommu: fix and refactor iommu_dma_get_sgtable
Date:   Mon, 14 Jan 2019 10:41:47 +0100
Message-Id: <20190114094159.27326-8-hch@lst.de>
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

The current iommu_dma_get_sgtable code does not properly handle memory
from the page allocator that hasn't been remapped, which can happen in
the rare case of allocations for a coherent device that aren't allowed
to block.

Fix this by replacing iommu_dma_get_sgtable with a slightly tweaked copy
of dma_common_get_sgtable with special handling for the remapped array
of pages allocated from __iommu_dma_alloc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 49 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 26f479d49103..8f3dc6ab3da1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -620,6 +620,18 @@ static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
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
@@ -1080,37 +1092,24 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			user_count << PAGE_SHIFT, vma->vm_page_prot);
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

