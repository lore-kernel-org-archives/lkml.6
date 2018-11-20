Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14E1C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D906F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D906F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeKUAKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:10:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56867 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbeKUAJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:09:53 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0850D469E5C4C;
        Tue, 20 Nov 2018 21:40:40 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 20 Nov 2018 21:40:35 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>
CC:     <robin.murphy@arm.com>, <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <ganapatrao.kulkarni@cavium.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2] iommu/dma: Use NUMA aware memory allocations in __iommu_dma_alloc_pages()
Date:   Tue, 20 Nov 2018 21:42:00 +0800
Message-ID: <1542721320-233109-1-git-send-email-john.garry@huawei.com>
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

Change function __iommu_dma_alloc_pages() to allocate memory/pages
for DMA from respective device NUMA node.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
[JPG:  Modifed to use kvzalloc() and fixed indentation]
Signed-off-by: John Garry <john.garry@huawei.com>
---
Difference v1->v2:
- Add Ganapatrao's tag and change author

This patch was originally posted by Ganapatrao in [1].

However, after initial review, it was never reposted (due to lack of
cycles, I think). In addition, the functionality in its sibling patches
were merged through patches, as mentioned in [2]; this also refers to a
discussion on device local allocations vs CPU local allocations for DMA
pool, and which is better [3].

However, as mentioned in [3], dma_alloc_coherent() uses the locality
information from the device - as in direct DMA - so this patch is just
applying this same policy.

[1] https://lore.kernel.org/patchwork/patch/833004/
[2] https://lkml.org/lkml/2018/8/22/391
[3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html


diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b0475..ada00bc 100644
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
+	pages = kvzalloc_node(count * sizeof(*pages), GFP_KERNEL, nid);
 	if (!pages)
 		return NULL;
 
@@ -483,8 +480,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
 			unsigned int order = __fls(order_mask);
 
 			order_size = 1U << order;
-			page = alloc_pages((order_mask - order_size) ?
-					   gfp | __GFP_NORETRY : gfp, order);
+			page = alloc_pages_node(nid,
+						(order_mask - order_size) ?
+						gfp | __GFP_NORETRY : gfp,
+						order);
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

