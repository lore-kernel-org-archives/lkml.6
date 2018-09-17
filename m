Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C56ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E1720883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hugKFjhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E1720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbeIQVHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:07:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TDuBpHIFyo0ShhRNgr6aXBWPc4egF8NgD01x3iShbtQ=; b=hugKFjhZeiobqyg0iTCSlZADA
        1zYZI9/aAweenbm8fpIZDD8LeDNbKC/2rQHvBWhJMWkdrCrrsmgkqXShCUxi+RjcJzrt1+lMb6Yp9
        qyiZ2TMPHxfguHax789xeTbqZdeMy+EyvY9RKNIA+juvXxrWl9NDWG9+treEuqZL7pmxZvYR5qOUu
        dp5HojBVmcytJynJX6ppdC7qahSHXyOVdb4hFoYewH92u+d18fWh1v5S7v9jJUWxFgjwGc+qusR80
        X/Lt5WMB+y8dPONY8p0qxWDIRpYme6+puUy9gUswgkjXw2bMLTHwqD1QT3mXXzTquOFTEKGHqMTGG
        esRtN4Qvg==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1vbu-0006Fq-TX; Mon, 17 Sep 2018 15:38:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] swiotlb: refactor swiotlb_map_page
Date:   Mon, 17 Sep 2018 17:38:24 +0200
Message-Id: <20180917153826.28052-8-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180917153826.28052-1-hch@lst.de>
References: <20180917153826.28052-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the somewhat useless map_single function, and replace it with a
swiotlb_bounce_page handler that handles everything related to actually
bouncing a page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 77 +++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 15755d7a5242..4d7a4d85d71e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -543,26 +543,6 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	return tlb_addr;
 }
 
-/*
- * Allocates bounce buffer and returns its physical address.
- */
-static phys_addr_t
-map_single(struct device *hwdev, phys_addr_t phys, size_t size,
-	   enum dma_data_direction dir, unsigned long attrs)
-{
-	dma_addr_t start_dma_addr;
-
-	if (swiotlb_force == SWIOTLB_NO_FORCE) {
-		dev_warn_ratelimited(hwdev, "Cannot do DMA to address %pa\n",
-				     &phys);
-		return SWIOTLB_MAP_ERROR;
-	}
-
-	start_dma_addr = __phys_to_dma(hwdev, io_tlb_start);
-	return swiotlb_tbl_map_single(hwdev, start_dma_addr, phys, size,
-				      dir, attrs);
-}
-
 /*
  * tlb_addr is the physical address of the bounce buffer to unmap.
  */
@@ -714,6 +694,34 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 	return true;
 }
 
+static dma_addr_t swiotlb_bounce_page(struct device *dev, phys_addr_t *phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	dma_addr_t dma_addr;
+
+	if (unlikely(swiotlb_force == SWIOTLB_NO_FORCE)) {
+		dev_warn_ratelimited(dev,
+			"Cannot do DMA to address %pa\n", phys);
+		return DIRECT_MAPPING_ERROR;
+	}
+
+	/* Oh well, have to allocate and map a bounce buffer. */
+	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
+			*phys, size, dir, attrs);
+	if (*phys == SWIOTLB_MAP_ERROR)
+		return DIRECT_MAPPING_ERROR;
+
+	/* Ensure that the address returned is DMA'ble */
+	dma_addr = __phys_to_dma(dev, *phys);
+	if (unlikely(!dma_capable(dev, dma_addr, size))) {
+		swiotlb_tbl_unmap_single(dev, *phys, size, dir,
+			attrs | DMA_ATTR_SKIP_CPU_SYNC);
+		return DIRECT_MAPPING_ERROR;
+	}
+
+	return dma_addr;
+}
+
 /*
  * Map a single buffer of the indicated size for DMA in streaming mode.  The
  * physical address to use is returned.
@@ -726,8 +734,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 			    enum dma_data_direction dir,
 			    unsigned long attrs)
 {
-	phys_addr_t map, phys = page_to_phys(page) + offset;
-	dma_addr_t dev_addr = phys_to_dma(dev, phys);
+	phys_addr_t phys = page_to_phys(page) + offset;
+	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
 	BUG_ON(dir == DMA_NONE);
 	/*
@@ -735,26 +743,13 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 	 * we can safely return the device addr and not worry about bounce
 	 * buffering it.
 	 */
-	if (dma_capable(dev, dev_addr, size) && swiotlb_force != SWIOTLB_FORCE)
-		return dev_addr;
-
-	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
-
-	/* Oh well, have to allocate and map a bounce buffer. */
-	map = map_single(dev, phys, size, dir, attrs);
-	if (map == SWIOTLB_MAP_ERROR)
-		return DIRECT_MAPPING_ERROR;
-
-	dev_addr = __phys_to_dma(dev, map);
-
-	/* Ensure that the address returned is DMA'ble */
-	if (dma_capable(dev, dev_addr, size))
-		return dev_addr;
-
-	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
-	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
+	if (!dma_capable(dev, dma_addr, size) ||
+	    swiotlb_force == SWIOTLB_FORCE) {
+		trace_swiotlb_bounced(dev, dma_addr, size, swiotlb_force);
+		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
+	}
 
-	return DIRECT_MAPPING_ERROR;
+	return dma_addr;
 }
 
 /*
-- 
2.18.0

