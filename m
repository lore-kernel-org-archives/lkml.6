Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32379C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5A122520
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5A122520
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbeKVB1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:27:37 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51809 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728298AbeKVB1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:27:37 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 57188107FEE0;
        Wed, 21 Nov 2018 22:52:47 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Wed, 21 Nov 2018 22:52:38 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>
CC:     <robin.murphy@arm.com>, <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <ganapatrao.kulkarni@cavium.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3] iommu/dma: Use NUMA aware memory allocations in __iommu_dma_alloc_pages()
Date:   Wed, 21 Nov 2018 22:54:10 +0800
Message-ID: <1542812051-178935-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
respective device NUMA node. The ternary operator which would be for
alloc_pages_node() is tidied along with this.

We also include a change to use kvzalloc() for kzalloc()/vzalloc()
combination.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
[JPG: Added kvzalloc(), drop pages ** being device local, tidied ternary operator]
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b0475..4afb1a8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -449,20 +449,17 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 	kvfree(pages);
 }
 
-static struct page **__iommu_dma_alloc_pages(unsigned int count,
-		unsigned long order_mask, gfp_t gfp)
+static struct page **__iommu_dma_alloc_pages(struct device *dev,
+		unsigned int count, unsigned long order_mask, gfp_t gfp)
 {
 	struct page **pages;
-	unsigned int i = 0, array_size = count * sizeof(*pages);
+	unsigned int i = 0, nid = dev_to_node(dev);
 
 	order_mask &= (2U << MAX_ORDER) - 1;
 	if (!order_mask)
 		return NULL;
 
-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, GFP_KERNEL);
-	else
-		pages = vzalloc(array_size);
+	pages = kvzalloc(count * sizeof(*pages), GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
@@ -481,10 +478,12 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
 		for (order_mask &= (2U << __fls(count)) - 1;
 		     order_mask; order_mask &= ~order_size) {
 			unsigned int order = __fls(order_mask);
+			gfp_t alloc_flags = gfp;
 
 			order_size = 1U << order;
-			page = alloc_pages((order_mask - order_size) ?
-					   gfp | __GFP_NORETRY : gfp, order);
+			if (order_mask > order_size)
+				alloc_flags |= __GFP_NORETRY;
+			page = alloc_pages_node(nid, alloc_flags, order);
 			if (!page)
 				continue;
 			if (!order)
@@ -569,7 +568,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 		alloc_sizes = min_size;
 
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
+	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
+					gfp);
 	if (!pages)
 		return NULL;
 
-- 
1.9.1

