Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4480C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33402088F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f4Sw+ugm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33402088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJHPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:13:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJHPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z+IydY/L4R61M/yNlfy1qHZ2mxaA9rfL2FujrLQw3zM=; b=f4Sw+ugmqWanW8muE9UBveZQqy
        yotnsehsx/0mSfv6k7StcPGJsYe11Hrj+1CnYwMIag+xXc+UPe/npqWvd0pGLxS7dizeYtGmPdRHG
        ViVIT1Gr2sVfpZHt85VCEUzkDVe/trPUw2+yzo4xCInvisUkrpjXMlclvWdyfkDV4hdLz07CWNRlA
        otvM4ieaiMMPmSbqCBtJK+Kk5HVfUX0csdvFSvcQqWlCqqLbsbKjMNQN62SfRRwMdAz/wq61q0kOb
        1xBJ2pi+N/bKLJlevzdfYPKCajCruG+36+1P4m/cAez4mmvJ574xdfYVSqitOrv4Ol6o6x6j0OHU3
        X5bRHlvg==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9QVZ-0002K7-4Y; Mon, 08 Oct 2018 08:03:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] swiotlb: refactor swiotlb_map_page
Date:   Mon,  8 Oct 2018 10:02:43 +0200
Message-Id: <20181008080246.20543-8-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008080246.20543-1-hch@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.19.0

