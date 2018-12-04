Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A73C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFDF20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K6Ud/WCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFDF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeLDQQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:16:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLDQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4TxGgdTkM3Sdh2pzUGPE0Qzu7xcPixeFZGVu2hcA30c=; b=K6Ud/WCcQSyXBvJdJvlsAzsTzr
        WYUqkUmdcpSu5gZHcNhZa4Z70RhUSKXMJVTWWzhleI9+QA7cGSRXCHNwK1uF2pEDcR5yDxptSv64G
        J60HKxwjj9LkofA9TstCU/r1BJojEqsRyTrTmzzut6V/AFvIkbTyI/Ms/Au2iAMRyaROv9sNxGXfE
        b5+Rs1zdR0e5wcv03F5rEjc3iilcdCls95TWbRSI5YuB65u2L614+96/ACeHohxm5HzIouETJsWi4
        4j20xPs7m/cjSOW7If5gd9NwoP9L6jczHUqlmj4y3z5q1tnd/XHFN+HEG1oCixz31qm29gMmE5U1t
        VgroxTow==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUDNN-0002EY-LP; Tue, 04 Dec 2018 16:16:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] swiotlb: remove SWIOTLB_MAP_ERROR
Date:   Tue,  4 Dec 2018 08:16:41 -0800
Message-Id: <20181204161645.8038-2-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204161645.8038-1-hch@lst.de>
References: <20181204161645.8038-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use DMA_MAPPING_ERROR instead, which already maps to the same
value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 4 ++--
 include/linux/swiotlb.h   | 3 ---
 kernel/dma/swiotlb.c      | 4 ++--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 6dc969d5ea2f..833e80b46eb2 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -403,7 +403,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 
 	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
 				     attrs);
-	if (map == SWIOTLB_MAP_ERROR)
+	if (map == DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
 	dev_addr = xen_phys_to_bus(map);
@@ -572,7 +572,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 								 sg_phys(sg),
 								 sg->length,
 								 dir, attrs);
-			if (map == SWIOTLB_MAP_ERROR) {
+			if (map == DMA_MAPPING_ERROR) {
 				dev_warn(hwdev, "swiotlb buffer is full\n");
 				/* Don't panic here, we expect map_sg users
 				   to do proper error handling. */
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index a387b59640a4..14aec0b70dd9 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -46,9 +46,6 @@ enum dma_sync_target {
 	SYNC_FOR_DEVICE = 1,
 };
 
-/* define the last possible byte of physical address space as a mapping error */
-#define SWIOTLB_MAP_ERROR (~(phys_addr_t)0x0)
-
 extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 					  dma_addr_t tbl_dma_addr,
 					  phys_addr_t phys, size_t size,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ff1ce81bb623..19ba8e473d71 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -526,7 +526,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
-	return SWIOTLB_MAP_ERROR;
+	return DMA_MAPPING_ERROR;
 found:
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 
@@ -637,7 +637,7 @@ static dma_addr_t swiotlb_bounce_page(struct device *dev, phys_addr_t *phys,
 	/* Oh well, have to allocate and map a bounce buffer. */
 	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
 			*phys, size, dir, attrs);
-	if (*phys == SWIOTLB_MAP_ERROR)
+	if (*phys == DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
 	/* Ensure that the address returned is DMA'ble */
-- 
2.19.1

