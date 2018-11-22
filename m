Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62722C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238F320820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mWdRNJNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238F320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437364AbeKWAoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:44:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbeKWAoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LMcFiN9J9xZ4Q9tzI9kfXgD5SiGjnTEgdGwtE7ssLsU=; b=mWdRNJNC5A0Y0Eqn4408jgjNS0
        0c0MPqZ7+mFYpoElF/IuRwoHo4ArHLX5/HsTTBGH365XGxIOnyUx6Ryo4e6g60EA697LaBb6eFu+a
        d3QHROYIZQer0L9ecbDo7AACWf3VKFgY3VxVVDQ3se2M/ySzN8UAYpJjFq9nB+Vu8fAbPvbbSAN7q
        HF2DmQbgaPnc4F9zbkLscqcJ8vahH+/l5hOnb9WsQeUrpxAk5lDzy8FqUl9vazekAHwSqud44qk0i
        Gl3DHElgehNZMV8ImUNQ1aKDZdiveAxJs5V/Dw8bHl/4kul3l45u8xbf0UqAv89WVCj4Qi6F5w4f9
        DBNoqMGA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpai-0000PJ-Ew; Thu, 22 Nov 2018 14:04:25 +0000
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
Subject: [PATCH 20/24] iommu/intel: small map_page cleanup
Date:   Thu, 22 Nov 2018 15:03:16 +0100
Message-Id: <20181122140320.24080-21-hch@lst.de>
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

Pass the page + offset to the low-level __iommu_map_single helper
(which gets renamed to fit the new calling conventions) as both
callers have the page at hand.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel-iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f3ccf025108b..3b8a7acac7a1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3597,9 +3597,11 @@ static int iommu_no_mapping(struct device *dev)
 	return 0;
 }
 
-static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
-				     size_t size, int dir, u64 dma_mask)
+static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
+				   unsigned long offset, size_t size, int dir,
+				   u64 dma_mask)
 {
+	phys_addr_t paddr = page_to_phys(page) + offset;
 	struct dmar_domain *domain;
 	phys_addr_t start_paddr;
 	unsigned long iova_pfn;
@@ -3661,8 +3663,7 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	return __intel_map_single(dev, page_to_phys(page) + offset, size,
-				  dir, *dev->dma_mask);
+	return __intel_map_page(dev, page, offset, size, dir, *dev->dma_mask);
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
@@ -3753,9 +3754,8 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	memset(page_address(page), 0, size);
 
-	*dma_handle = __intel_map_single(dev, page_to_phys(page), size,
-					 DMA_BIDIRECTIONAL,
-					 dev->coherent_dma_mask);
+	*dma_handle = __intel_map_page(dev, page, 0, size, DMA_BIDIRECTIONAL,
+				       dev->coherent_dma_mask);
 	if (*dma_handle)
 		return page_address(page);
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-- 
2.19.1

