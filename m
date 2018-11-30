Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088C6C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C200720868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dgMw0L6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C200720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeLAAdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:33:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeLAAdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uo0Q98winaBB83hkbU/s9+bS7uoJBORh6pgs2ABTT38=; b=dgMw0L6L2cMJMv+i2XyQpaW0Ub
        qoLAa69Dpwo4bL6bY/Mdq6WJrewp2Vbo2R1v+1tsagN8mWTUI5sgH9E7d3KBMBsIzygVEpTatecQN
        O4SiwOsShrUi6rpeyGzgaM9cRqIhBpzkjgTzasXWr8v/HI5XVVpnSu8BZqg1bkQPkRPPoB3MmjCkA
        15PqNGJCaTzKlEoGt6uvuGiwdgUtNTT/8zbCECg+921wvraD2W5Vx5VVN7eHfWG6I4/2RpBIrigo0
        vnrAW1rngT8mQ6KBODix0GY4BMr70MuArKZmqnj78/1uh8sXRy1e1xIzYDDfIJN7w6mIvgB3bPp1n
        51XSJnMw==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSilw-0004zL-AT; Fri, 30 Nov 2018 13:23:56 +0000
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
Subject: [PATCH 19/23] iommu/vt-d: remove the mapping_error dma_map_ops method
Date:   Fri, 30 Nov 2018 14:22:27 +0100
Message-Id: <20181130132231.16512-20-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
References: <20181130132231.16512-1-hch@lst.de>
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
index 66b4444398ae..0ad67d65bbce 100644
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

