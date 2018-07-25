Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE33C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4EC20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HdfSix08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4EC20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeGYMtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:49:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbeGYMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X/NFpJY+WGqmwbh6p8GFFooFBIafM7PCIlmvmhMQQ9M=; b=HdfSix08UbV0jV/Jnq3HiLZyJ
        cwZ4SV8Q8b2syRAfYy3HgOf/wL5TguQcewpSkJ4HFVmiNdR0KhVTmOISc+gvFHklcjjn0ejROaA2m
        B2gJcT26cQKxuPk47xw4NFpYKGh9T/oNqi8C5/KsgzI3U/xrEsW2kiPlBb2Zrn75zVdbKNYSc1y/X
        xjsrU3EVOzfNJjb/lsXP4fZt4t8+uKLqTSi96Rij+g9nyoq9yTVTI1RdisDSRfYFHyRPByHl7MOxn
        ugKR/hDSrucLJscxAQSrCKveKhCOTkrZifL1rsyuF6s56S1irL92CCdWuaP3yu11nCyArU0Ogumf0
        ez77XoTJg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiI7S-0006oc-JO; Wed, 25 Jul 2018 11:38:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] swiotlb: merge swiotlb_unmap_page and unmap_single
Date:   Wed, 25 Jul 2018 13:37:59 +0200
Message-Id: <20180725113802.18943-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725113802.18943-1-hch@lst.de>
References: <20180725113802.18943-1-hch@lst.de>
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
index 06cfc4d00325..03016221fc64 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -812,9 +812,9 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
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
 
@@ -837,13 +837,6 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
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
@@ -947,7 +940,7 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i)
-		unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir,
+		swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
 }
 
-- 
2.18.0

