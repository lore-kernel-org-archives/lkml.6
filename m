Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B66BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4190120883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qYFWYOJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4190120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbeIQVG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:06:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQVG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dOqDmXn118yuMflikXsPItevmSuJgUWWUAkwttWo6hs=; b=qYFWYOJztpE8jrd0c57fRLiPn
        /GJCvdlcuKWpfZAqjPNKVgf7nL3vZLOvrE+bru7fJCMQKsG29xWRRcY2udDk1LsdyhzBhzGPN0SmJ
        kbcrdQILtHJsbWPi70I0/8hjsHNzoPE/F9I00WIKZ64vxcMpF8sZz8qzNRqWXm18cemJiO5BZNISJ
        7KpykyDf7MJhxbxRx8FRF0qbXUWdgny08SSuARfDUYoWv2L2F4ZuQKHxdh2Dxw5IUTWg0tjgOmfBW
        oKjjFMNukgGO/wDexezVpva6XW8xWqY71JNzx9MkMl/T6tJiKZYiije66qKyApN/V4841y6SgXJdx
        3PwWqjSPw==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1vbo-0006DJ-9N; Mon, 17 Sep 2018 15:38:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] swiotlb: merge swiotlb_unmap_page and unmap_single
Date:   Mon, 17 Sep 2018 17:38:22 +0200
Message-Id: <20180917153826.28052-6-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180917153826.28052-1-hch@lst.de>
References: <20180917153826.28052-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 11dbcd80b4a6..15335f3a1bf3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -765,9 +765,9 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
  * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
-static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
-			 size_t size, enum dma_data_direction dir,
-			 unsigned long attrs)
+void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs)
 {
 	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
 
@@ -790,13 +790,6 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 	dma_mark_clean(phys_to_virt(paddr), size);
 }
 
-void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
-			size_t size, enum dma_data_direction dir,
-			unsigned long attrs)
-{
-	unmap_single(hwdev, dev_addr, size, dir, attrs);
-}
-
 /*
  * Make physical memory consistent for a single streaming mode DMA translation
  * after a transfer.
@@ -900,7 +893,7 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i)
-		unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir,
+		swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
 }
 
-- 
2.18.0

