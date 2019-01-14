Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E11EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CA120663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XZq3TRkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfANJmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+EswiF0OsyNVcO96bwolvO+4J18eR4F8KfsGgFyU67Y=; b=XZq3TRkFX7k5GPJrO7cRIVPsGA
        7GXWY0LIVFTEqfqzSAmtYrsdcB5yL8InNJEp4i86p3fYR75wZSEa2lzaMAvLubVL3RkXuSK9BrCXz
        ouzyQpX6RDWIFhOImK3EE160JyhXb2PVDxk5mszAZ5Z/DRniwuwQoDzpfAgbcNE4ut/hugfgRHQk8
        abHeDXuaFj8+BwWNCrqGE/CKG8lOvO6enz3It40PLBonxy8YoItB3d22fJSWrX4rfQmVrvGDlBjpu
        TaiYbnKnsPLJQ0uEjSFBDJz/XwjkEK2lrCQUDFgN56gSCXrlfMQB2cab3bL3jcHtwkdLgJlhpQyBp
        jQmp59qg==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giyl2-0006AY-4M; Mon, 14 Jan 2019 09:42:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] dma-iommu: don't use a scatterlist in iommu_dma_alloc
Date:   Mon, 14 Jan 2019 10:41:43 +0100
Message-Id: <20190114094159.27326-4-hch@lst.de>
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

Directly iterating over the pages makes the code a bit simpler and
prepares for the following changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 40 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6b43c1..4f5546a103d8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -30,6 +30,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
+#include <linux/highmem.h>
 #include <linux/vmalloc.h>
 
 struct iommu_dma_msi_page {
@@ -549,9 +550,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	struct page **pages;
-	struct sg_table sgt;
 	dma_addr_t iova;
-	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
+	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap, i;
+	size_t mapped = 0;
 
 	*handle = DMA_MAPPING_ERROR;
 
@@ -576,32 +577,25 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (!iova)
 		goto out_free_pages;
 
-	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
-		goto out_free_iova;
+	for (i = 0; i < count; i++) {
+		phys_addr_t phys = page_to_phys(pages[i]);
 
-	if (!(prot & IOMMU_CACHE)) {
-		struct sg_mapping_iter miter;
-		/*
-		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
-		 * sufficient here, so skip it by using the "wrong" direction.
-		 */
-		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
-		while (sg_miter_next(&miter))
-			flush_page(dev, miter.addr, page_to_phys(miter.page));
-		sg_miter_stop(&miter);
-	}
+		if (!(prot & IOMMU_CACHE)) {
+			void *vaddr = kmap_atomic(pages[i]);
 
-	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
-			< size)
-		goto out_free_sg;
+			flush_page(dev, vaddr, phys);
+			kunmap_atomic(vaddr);
+		}
+
+		if (iommu_map(domain, iova + mapped, phys, PAGE_SIZE, prot))
+			goto out_unmap;
+		mapped += PAGE_SIZE;
+	}
 
 	*handle = iova;
-	sg_free_table(&sgt);
 	return pages;
-
-out_free_sg:
-	sg_free_table(&sgt);
-out_free_iova:
+out_unmap:
+	iommu_unmap(domain, iova, mapped);
 	iommu_dma_free_iova(cookie, iova, size);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
-- 
2.20.1

