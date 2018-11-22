Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4033C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB1920866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ag/Tt/DZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB1920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437350AbeKWAoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:44:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbeKWAn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e4mMgcXXcvLyz2AomeJXNZybJ85R0dp/1VHd9R03wIo=; b=ag/Tt/DZ3d0+moru1Xsqqp/4HU
        xrrMDjWfiN1sUb5u78XYyyy/mvK/W9j/w8hf/qKGN3VPREPdbCQYhyDULly8aZWL1TEjY0jZ6SE2F
        oZBWKwsyOhCtiBx43hJpWOAuVyIqRsAWILEujX9i2xj+NCLAssXEwHrsJqFjvTn3gcJVDR7j5+4yR
        LjLfz7ftCXt8iHcvlNCa1iyOUScgPqj3W6RHXpb6tGXNZSOClsDFhf1/FTpSo2F6KMJcbqnXu31Zo
        YvFOeXHKSATnqAUDxlil1vUN6I8OVII/Dp9svqbtsmdE9u25v6gfAWGgWQ/fZMPwQk+t3UkDJnt32
        TsL0fDEQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpaf-0000Md-HF; Thu, 22 Nov 2018 14:04:22 +0000
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
Subject: [PATCH 19/24] iommu: remove the mapping_error dma_map_ops method
Date:   Thu, 22 Nov 2018 15:03:15 +0100
Message-Id: <20181122140320.24080-20-hch@lst.de>
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

Note that the existing code used AMD_IOMMU_MAPPING_ERROR to check from
a 0 return from the IOVA allocator, which is replaced with an explicit
0 as in the implementation and other users of that interface.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/amd_iommu.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..c5d6c7c42b0a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -55,8 +55,6 @@
 #include "amd_iommu_types.h"
 #include "irq_remapping.h"
 
-#define AMD_IOMMU_MAPPING_ERROR	0
-
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
 #define LOOP_TIMEOUT	100000
@@ -2339,7 +2337,7 @@ static dma_addr_t __map_single(struct device *dev,
 	paddr &= PAGE_MASK;
 
 	address = dma_ops_alloc_iova(dev, dma_dom, pages, dma_mask);
-	if (address == AMD_IOMMU_MAPPING_ERROR)
+	if (!address)
 		goto out;
 
 	prot = dir2prot(direction);
@@ -2376,7 +2374,7 @@ static dma_addr_t __map_single(struct device *dev,
 
 	dma_ops_free_iova(dma_dom, address, pages);
 
-	return AMD_IOMMU_MAPPING_ERROR;
+	return DMA_MAPPING_ERROR;
 }
 
 /*
@@ -2427,7 +2425,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	if (PTR_ERR(domain) == -EINVAL)
 		return (dma_addr_t)paddr;
 	else if (IS_ERR(domain))
-		return AMD_IOMMU_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 
 	dma_mask = *dev->dma_mask;
 	dma_dom = to_dma_ops_domain(domain);
@@ -2504,7 +2502,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	npages = sg_num_pages(dev, sglist, nelems);
 
 	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
-	if (address == AMD_IOMMU_MAPPING_ERROR)
+	if (address == DMA_MAPPING_ERROR)
 		goto out_err;
 
 	prot = dir2prot(direction);
@@ -2627,7 +2625,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
 				 size, DMA_BIDIRECTIONAL, dma_mask);
 
-	if (*dma_addr == AMD_IOMMU_MAPPING_ERROR)
+	if (*dma_addr == DMA_MAPPING_ERROR)
 		goto out_free;
 
 	return page_address(page);
@@ -2678,11 +2676,6 @@ static int amd_iommu_dma_supported(struct device *dev, u64 mask)
 	return check_device(dev);
 }
 
-static int amd_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == AMD_IOMMU_MAPPING_ERROR;
-}
-
 static const struct dma_map_ops amd_iommu_dma_ops = {
 	.alloc		= alloc_coherent,
 	.free		= free_coherent,
@@ -2691,7 +2684,6 @@ static const struct dma_map_ops amd_iommu_dma_ops = {
 	.map_sg		= map_sg,
 	.unmap_sg	= unmap_sg,
 	.dma_supported	= amd_iommu_dma_supported,
-	.mapping_error	= amd_iommu_mapping_error,
 };
 
 static int init_reserved_iova_ranges(void)
-- 
2.19.1

