Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55379C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A93B20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S4qsKP0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A93B20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437380AbeKWAoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:44:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbeKWAoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bf282GfOWp/JaIi9SWPOLCHGBo2bD6VW/B+mP7iUSLs=; b=S4qsKP0rfS0C/Mp/AZ4mVdXbDx
        rwyEguoDmgy2BiJjDlH5x5+5Wkm4SqqGQcrZG3bmXuumETfumW8LoZUU8dLUbLh21rsd0MO9yrU+Z
        g3yTlO2q+tfCmJ+/Cy8sldi0nBVwhlQpHc+SrK+v3w/p6OcKNeX3XfD3P9tvWg/H9pVw+ayll9ZH4
        S4Uzk3ILKKUE0GluXeGwtu3qU0aa8s+KNruKDeZc9bT2GuQsUW5euNoZNHhgM9zX9a0RNtt2Qscsb
        LpZJLMZ80xxrKtipL20cA08DmlgKuT9BN7kFYGTbkL6iE7zRLOS06a7gTw+BIF6ZgvT1CjgWE4C6F
        ZSk5Iyhg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpal-0000Qq-Dd; Thu, 22 Nov 2018 14:04:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/24] iommu/vt-d: remove the mapping_error dma_map_ops method
Date:   Thu, 22 Nov 2018 15:03:17 +0100
Message-Id: <20181122140320.24080-22-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122140320.24080-1-hch@lst.de>
References: <20181122140320.24080-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return DMA_MAPPING_ERROR instead of 0 on a dma mapping failure and let
the core dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel-iommu.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3b8a7acac7a1..a5704155932d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3617,7 +3617,7 @@ static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
 
 	domain = get_valid_domain_for_dev(dev);
 	if (!domain)
-		return 0;
+		return DMA_MAPPING_ERROR;
 
 	iommu = domain_get_iommu(domain);
 	size = aligned_nrpages(paddr, size);
@@ -3655,7 +3655,7 @@ static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
 		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
 	pr_err("Device %s request: %zx@%llx dir %d --- failed\n",
 		dev_name(dev), size, (unsigned long long)paddr, dir);
-	return 0;
+	return DMA_MAPPING_ERROR;
 }
 
 static dma_addr_t intel_map_page(struct device *dev, struct page *page,
@@ -3756,7 +3756,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 
 	*dma_handle = __intel_map_page(dev, page, 0, size, DMA_BIDIRECTIONAL,
 				       dev->coherent_dma_mask);
-	if (*dma_handle)
+	if (*dma_handle != DMA_MAPPING_ERROR)
 		return page_address(page);
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, order);
@@ -3865,11 +3865,6 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	return nelems;
 }
 
-static int intel_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return !dma_addr;
-}
-
 static const struct dma_map_ops intel_dma_ops = {
 	.alloc = intel_alloc_coherent,
 	.free = intel_free_coherent,
@@ -3877,7 +3872,6 @@ static const struct dma_map_ops intel_dma_ops = {
 	.unmap_sg = intel_unmap_sg,
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
-	.mapping_error = intel_mapping_error,
 	.dma_supported = dma_direct_supported,
 };
 
-- 
2.19.1

