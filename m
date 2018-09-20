Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC4CECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA95121531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MOXT3VTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA95121531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbeIUAiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:38:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUAiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mhVJhvauS2Qesiha69iTKDtr1MlYjTFxMhC6gJ7gxJY=; b=MOXT3VTJosDpRUwGbVx7TRh5A
        FlUMrNwDMywpJdShD/oaVQMGZiJNGdyxfQvXnjBn4nMWGmNPpMjmR67ggTUM7wblihD/vQrMOkvJJ
        FzPZLuKKeIBPZLZBDivXVsTPrtbtcs/EBtfu8DPo7F/kiTY4MzedpybT0XBEAGjEtEmI0Uec28Dyh
        DBhWNHy9OSbySqy1EXiF2OuQWzGRmbgA1LHoBBW7QCQ7TNtiod8FIeWqOQ4XXpEVqun12J4pF7INy
        RhXXzw3xBxO7bfrlzYOs7OaScu+9BYYe+LYlBTy3hs2/frBHIf6kceHUIBSUet2sWTMsFAme4Dvao
        Shkf7TtOQ==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g344W-0001li-95; Thu, 20 Sep 2018 18:53:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] dma-direct: implement complete bus_dma_mask handling
Date:   Thu, 20 Sep 2018 20:52:46 +0200
Message-Id: <20180920185247.20037-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920185247.20037-1-hch@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of rejecting devices with a too small bus_dma_mask we can handle
by taking the bus dma_mask into account for allocations and bounce
buffering decisions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h |  3 ++-
 kernel/dma/direct.c        | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index b79496d8c75b..fbca184ff5a0 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -27,7 +27,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	if (!dev->dma_mask)
 		return false;
 
-	return addr + size - 1 <= *dev->dma_mask;
+	return addr + size - 1 <=
+		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 3c404e33d946..64466b7ef67b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -43,10 +43,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 			return false;
 		}
 
-		if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
+		if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
 			dev_err(dev,
-				"%s: overflow %pad+%zu of device mask %llx\n",
-				caller, &dma_addr, size, *dev->dma_mask);
+				"%s: overflow %pad+%zu of device mask %llx bus mask %llx\n",
+				caller, &dma_addr, size,
+				*dev->dma_mask, dev->bus_dma_mask);
 		}
 		return false;
 	}
@@ -65,12 +66,18 @@ u64 dma_direct_get_required_mask(struct device *dev)
 {
 	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
 
+	if (dev->bus_dma_mask && dev->bus_dma_mask < max_dma)
+		max_dma = dev->bus_dma_mask;
+
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
 static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 		u64 *phys_mask)
 {
+	if (dev->bus_dma_mask && dev->bus_dma_mask < dma_mask)
+		dma_mask = dev->bus_dma_mask;
+
 	if (force_dma_unencrypted())
 		*phys_mask = __dma_to_phys(dev, dma_mask);
 	else
@@ -87,7 +94,7 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
 	return phys_to_dma_direct(dev, phys) + size - 1 <=
-			dev->coherent_dma_mask;
+			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_mask);
 }
 
 void *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -291,12 +298,6 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
 		return 0;
 #endif
-	/*
-	 * Upstream PCI/PCIe bridges or SoC interconnects may not carry
-	 * as many DMA address bits as the device itself supports.
-	 */
-	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
-		return 0;
 	return 1;
 }
 
-- 
2.18.0

