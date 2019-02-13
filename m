Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D783C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38942086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GVNVZJhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405097AbfBMSaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:30:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbfBMS37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mYRWViteACcCEuuYC5X/ALVlVqKut31Ms1xIZpc1Htw=; b=GVNVZJhHbwFbPKfWs0fmNJdAT1
        4kyh8gdjFKr+Lh2fJPODT5bIXEyaVg2bfFasEeQ7f61YKCffDYXZkDcVM2b5GqbgFm/SyeaNjH272
        i71gvHjHO7gDUtL9J4fiezIhslE7Hh3qKS9S0txijq+hubFU5yt6g2fP+MQj2nT8803Ezl27g8MRO
        Tuq/yy9cXcNqHBpMo1SIkbjzYvV3kqadbCqW36CMfpgI8aKUnPKbq/0hysPELE1Zj1Vj6CpQauLSa
        6hR6HVoJomaaac+T2hy+kEXQKPOEgYws6mhp0YQFDzKAR9zLKmBdJ9n5bsCuSAknGZ3IpRI+3y5z+
        qIpjbBfw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtzI8-0008Pa-GP; Wed, 13 Feb 2019 18:29:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/21] dma-iommu: factor atomic pool allocations into helpers
Date:   Wed, 13 Feb 2019 19:29:11 +0100
Message-Id: <20190213182920.16764-13-hch@lst.de>
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

This keeps the code together and will simplify compiling the code
out on architectures that are always dma coherent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 51 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c1ecb0c3436e..ff1ada9f98f5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -674,6 +674,35 @@ static int iommu_dma_get_sgtable_remap(struct sg_table *sgt, void *cpu_addr,
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
@@ -982,21 +1011,18 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
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
@@ -1050,8 +1076,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
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

