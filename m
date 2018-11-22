Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF60C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B374820820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iXTjDfc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B374820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437414AbeKWAoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:44:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbeKWAoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WHPez5RhxTIcMvprH5ITOwWzwL8816DB5aR/L+bV10Y=; b=iXTjDfc+EGineHV5XPn0jZsdxs
        ie3idgdj7spU8QlqDiAk6DynhstM8EQMF+TPY4B4YaAVzC7YyDlEjb1m8/YrMveX0TkheUGSpd0u6
        Yf7KqakIbaaL8oUCA83YGK8XhWdqxsRtIqJfjfcW7Y9a510QCTyNzBfFvNLlak0nQdw6wTnX+1CZa
        PDxWZXy11waRlC/+nPE++0QMshU77c3LPWHxfh8Ay4WmTEk9PBeDfjg8s0uN7ZXIAXZjkVy78SqnC
        R9yZUeHunEpedADHhWGUnv+Db+LL3z/TiV0uQT/9WvN+tYw+w0dFS2LTh0UsV4CHPijhAQb3yW+YO
        vpGZPstw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpaq-0000Sa-MZ; Thu, 22 Nov 2018 14:04:33 +0000
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
Subject: [PATCH 23/24] xen-swiotlb: remove the mapping_error dma_map_ops method
Date:   Thu, 22 Nov 2018 15:03:19 +0100
Message-Id: <20181122140320.24080-24-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2a7f545bd0b5..6dc969d5ea2f 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -53,8 +53,6 @@
  * API.
  */
 
-#define XEN_SWIOTLB_ERROR_CODE	(~(dma_addr_t)0x0)
-
 static char *xen_io_tlb_start, *xen_io_tlb_end;
 static unsigned long xen_io_tlb_nslabs;
 /*
@@ -406,7 +404,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
 				     attrs);
 	if (map == SWIOTLB_MAP_ERROR)
-		return XEN_SWIOTLB_ERROR_CODE;
+		return DMA_MAPPING_ERROR;
 
 	dev_addr = xen_phys_to_bus(map);
 	xen_dma_map_page(dev, pfn_to_page(map >> PAGE_SHIFT),
@@ -421,7 +419,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
 	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
 
-	return XEN_SWIOTLB_ERROR_CODE;
+	return DMA_MAPPING_ERROR;
 }
 
 /*
@@ -700,11 +698,6 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
 }
 
-static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == XEN_SWIOTLB_ERROR_CODE;
-}
-
 const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.alloc = xen_swiotlb_alloc_coherent,
 	.free = xen_swiotlb_free_coherent,
@@ -719,5 +712,4 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.dma_supported = xen_swiotlb_dma_supported,
 	.mmap = xen_swiotlb_dma_mmap,
 	.get_sgtable = xen_swiotlb_get_sgtable,
-	.mapping_error	= xen_swiotlb_mapping_error,
 };
-- 
2.19.1

