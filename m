Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E63ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6D220883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NDKkPhtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6D220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbeIQVHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:07:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQVHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RaIixvXUBpvy91fkh3yx4r6Mp9ijHIf5W69N3fMalso=; b=NDKkPhtWmvWLelbHhxleJEqWq
        JVKzVDsvYgawLQr3g1DdL684BvjpFITA0JETYv1cIu4a/lWJw9Fg8WqcbvU9/vmFYqXfcMtJSO6Wt
        1Bxts1ZUmrB6OmikmiO3XOrgSfU/tb4cTBFPQwbaCjEYbgeT44NIu3LHtSdpyIoL2GHgI2fpmJeHL
        BNkhn1Yh+WreE/B5+LgjiuEtJMwFf5e2C1mt6oD/JySrlMBs2eC+YUosc7GVsX/krkP+bKUt56wL+
        MWiBuHIsPKfVeE5xYMbz564DIsisp0vD5DqjFIw4A7JnGRCVe7AR9tRhrj4g1bmEExB779xSLP6AX
        D9OZkGWGw==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1vbr-0006Ee-HV; Mon, 17 Sep 2018 15:38:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs
Date:   Mon, 17 Sep 2018 17:38:23 +0200
Message-Id: <20180917153826.28052-7-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180917153826.28052-1-hch@lst.de>
References: <20180917153826.28052-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to duplicate the code - map_sg is equivalent to map_page
for each page in the scatterlist.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 15335f3a1bf3..15755d7a5242 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -845,37 +845,27 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
  * same here.
  */
 int
-swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
+swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
 		     enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
 
-	BUG_ON(dir == DMA_NONE);
-
 	for_each_sg(sgl, sg, nelems, i) {
-		phys_addr_t paddr = sg_phys(sg);
-		dma_addr_t dev_addr = phys_to_dma(hwdev, paddr);
-
-		if (swiotlb_force == SWIOTLB_FORCE ||
-		    !dma_capable(hwdev, dev_addr, sg->length)) {
-			phys_addr_t map = map_single(hwdev, sg_phys(sg),
-						     sg->length, dir, attrs);
-			if (map == SWIOTLB_MAP_ERROR) {
-				/* Don't panic here, we expect map_sg users
-				   to do proper error handling. */
-				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
-				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
-						       attrs);
-				sg_dma_len(sgl) = 0;
-				return 0;
-			}
-			sg->dma_address = __phys_to_dma(hwdev, map);
-		} else
-			sg->dma_address = dev_addr;
+		sg->dma_address = swiotlb_map_page(dev, sg_page(sg), sg->offset,
+				sg->length, dir, attrs);
+		if (sg->dma_address == DIRECT_MAPPING_ERROR)
+			goto out_error;
 		sg_dma_len(sg) = sg->length;
 	}
+
 	return nelems;
+
+out_error:
+	swiotlb_unmap_sg_attrs(dev, sgl, i, dir,
+			attrs | DMA_ATTR_SKIP_CPU_SYNC);
+	sg_dma_len(sgl) = 0;
+	return 0;
 }
 
 /*
-- 
2.18.0

