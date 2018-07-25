Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF79C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BA820882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VKm42qDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BA820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbeGYMta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:49:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbeGYMt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6pLX89OZRbAruz4JuoEEd9Z4y0dEP/gqzp1AF88cdIs=; b=VKm42qDEe+zsBrumInbnejPW1
        opebYDSNAlOhwPLfkZLh47Xr7CNgJcBjjeFi3O3PQB+6ig7izDaSlrghKQFUJLMTVdlx+vzK8n7bX
        BZwrUo1Z6O8kEUWLT8SiMGCEla2Ggw4mkmVMX9dM4Nhm+MFq6FE/xClq0ofIZB+AkLIvXdT0BMse+
        e+A2MIYoBNxaTEOWmurmwD2Ija/Mr3OcUoIfHHjiyzqfdnIm169hZmO+uvYFp8FnULI4vAW4mlaz5
        hSjHkKVVfho+8OxBvViMR5P4kaZ1uTawWbkFlCogaW9VGoy39LoSNxuZn7W0LEJ4p6l9kQWMWlTMX
        x44wAfrSw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiI7Q-0006oS-67; Wed, 25 Jul 2018 11:38:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] swiotlb: do not panic on mapping failures
Date:   Wed, 25 Jul 2018 13:37:58 +0200
Message-Id: <20180725113802.18943-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725113802.18943-1-hch@lst.de>
References: <20180725113802.18943-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All properly written drivers now have error handling in the
dma_map_single / dma_map_page callers.  As swiotlb_tbl_map_single already
prints a useful warning when running out of swiotlb pool swace we can
also remove swiotlb_full entirely as it serves no purpose now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9062b14bc7f4..06cfc4d00325 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -761,34 +761,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 	return true;
 }
 
-static void
-swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
-	     int do_panic)
-{
-	if (swiotlb_force == SWIOTLB_NO_FORCE)
-		return;
-
-	/*
-	 * Ran out of IOMMU space for this operation. This is very bad.
-	 * Unfortunately the drivers cannot handle this operation properly.
-	 * unless they check for dma_mapping_error (most don't)
-	 * When the mapping is small enough return a static buffer to limit
-	 * the damage, or panic when the transfer is too big.
-	 */
-	dev_err_ratelimited(dev, "DMA: Out of SW-IOMMU space for %zu bytes\n",
-			    size);
-
-	if (size <= io_tlb_overflow || !do_panic)
-		return;
-
-	if (dir == DMA_BIDIRECTIONAL)
-		panic("DMA: Random memory could be DMA accessed\n");
-	if (dir == DMA_FROM_DEVICE)
-		panic("DMA: Random memory could be DMA written\n");
-	if (dir == DMA_TO_DEVICE)
-		panic("DMA: Random memory could be DMA read\n");
-}
-
 /*
  * Map a single buffer of the indicated size for DMA in streaming mode.  The
  * physical address to use is returned.
@@ -817,10 +789,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 
 	/* Oh well, have to allocate and map a bounce buffer. */
 	map = map_single(dev, phys, size, dir, attrs);
-	if (map == SWIOTLB_MAP_ERROR) {
-		swiotlb_full(dev, size, dir, 1);
+	if (map == SWIOTLB_MAP_ERROR)
 		return __phys_to_dma(dev, io_tlb_overflow_buffer);
-	}
 
 	dev_addr = __phys_to_dma(dev, map);
 
@@ -948,7 +918,6 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
 			if (map == SWIOTLB_MAP_ERROR) {
 				/* Don't panic here, we expect map_sg users
 				   to do proper error handling. */
-				swiotlb_full(hwdev, sg->length, dir, 0);
 				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
 				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
 						       attrs);
-- 
2.18.0

