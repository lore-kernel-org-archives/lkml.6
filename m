Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A29C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F5820663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ANNDydSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfANJmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfANJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xsc9aH6zbuPjrryZknS3I+kVBG3yxdrHRFdqm+uzQ+g=; b=ANNDydSaloE/bosKEYf3i0ue0C
        isgQlGCNyZnmd1e40z/mfIH0Amq/nCQnHOD9ZFYSpN8p7CZlcvo6otOB401o27m4iNK4rDlODMHuk
        tk1rI1ZrXOYbUgOUcAgOx/M5ARfNNl3VYfycQH62FMvz6Hx8gDQpCbLw7CBhL+wdVBSLPHnXvrIMn
        0MRlaJW/52ObolnP12zibCItg8Ve1nd3MhfnewgdYpvgj3ajYRhcouHM1zoiIalXr8geLegGsgXCm
        WYpJz0ORfp3kvmF/MyXG66uj12z2+u2z6vMZ3zLTzo2Ct0pK+ZK+kmTBexQeUI0BfGM49clhlJ0dH
        Ny5bpdDg==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giylO-0006Wo-4M; Mon, 14 Jan 2019 09:42:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] dma-iommu: factor atomic pool allocations into helpers
Date:   Mon, 14 Jan 2019 10:41:50 +0100
Message-Id: <20190114094159.27326-11-hch@lst.de>
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

This keeps the code together and will simplify compiling the code
out on architectures that are always dma coherent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 51 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 95d30b96e5bd..fdd283f45656 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -666,6 +666,35 @@ static int iommu_dma_get_sgtable_remap(struct sg_table *sgt, void *cpu_addr,
 			GFP_KERNEL);
 }
 
+static void iommu_dma_free_pool(struct device *dev, size_t size,
+		void *vaddr, dma_addr_t dma_handle)
+{
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), dma_handle, size);
+	dma_free_from_pool(vaddr, PAGE_ALIGN(size));
+}
+
+static void *iommu_dma_alloc_pool(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	bool coherent = dev_is_dma_coherent(dev);
+	struct page *page;
+	void *vaddr;
+
+	vaddr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+	if (!vaddr)
+		return NULL;
+
+	*dma_handle = __iommu_dma_map(dev, page_to_phys(page), size,
+			dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs),
+			iommu_get_domain_for_dev(dev));
+	if (*dma_handle == DMA_MAPPING_ERROR) {
+		dma_free_from_pool(vaddr, PAGE_ALIGN(size));
+		return NULL;
+	}
+
+	return vaddr;
+}
+
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
@@ -974,21 +1003,18 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		 * get the virtually contiguous buffer we need by way of a
 		 * physically contiguous allocation.
 		 */
-		if (coherent) {
-			page = alloc_pages(gfp, get_order(size));
-			addr = page ? page_address(page) : NULL;
-		} else {
-			addr = dma_alloc_from_pool(size, &page, gfp);
-		}
-		if (!addr)
+		if (!coherent)
+			return iommu_dma_alloc_pool(dev, iosize, handle, gfp,
+					attrs);
+
+		page = alloc_pages(gfp, get_order(size));
+		if (!page)
 			return NULL;
 
+		addr = page_address(page);
 		*handle = __iommu_dma_map_page(dev, page, 0, iosize, ioprot);
 		if (*handle == DMA_MAPPING_ERROR) {
-			if (coherent)
-				__free_pages(page, get_order(size));
-			else
-				dma_free_from_pool(addr, size);
+			__free_pages(page, get_order(size));
 			addr = NULL;
 		}
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
@@ -1042,8 +1068,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	 * Hence how dodgy the below logic looks...
 	 */
 	if (dma_in_atomic_pool(cpu_addr, size)) {
-		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
-		dma_free_from_pool(cpu_addr, size);
+		iommu_dma_free_pool(dev, size, cpu_addr, handle);
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		struct page *page = vmalloc_to_page(cpu_addr);
 
-- 
2.20.1

