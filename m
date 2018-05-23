Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933503AbeEWPRo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:17:44 -0400
Received: from m50-134.163.com ([123.125.50.134]:35233 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933385AbeEWPRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:17:39 -0400
From: Huaisheng Ye <yehs2007@163.com>
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: mhocko@suse.com, willy@infradead.org, hch@lst.de, vbabka@suse.cz,
        mgorman@techsingularity.net, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
        hehy1@lenovo.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v3 2/9] include/linux/dma-mapping: update usage of zone modifiers
Date: Wed, 23 May 2018 22:57:47 +0800
Message-Id: <1527087474-93986-3-git-send-email-yehs2007@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527087474-93986-1-git-send-email-yehs2007@163.com>
References: <1527087474-93986-1-git-send-email-yehs2007@163.com>
X-CM-TRANSID: DtGowAAXEWSIgQVbCQ9NAA--.108S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7JryrAr1fZFyUJrykXFyDAwb_yoW8JF48pF
        n7uw1fWrZ3Cr1ay348Cw47G3WI9w4kCryDCFyaqa4kCr15tFyqqrsIkFyj93srZayxuF4r
        WrsrCrW5CFW5Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bIwZcUUUUU=
X-Originating-IP: [103.244.59.4]
X-CM-SenderInfo: p1hk2jqqqxqiywtou0bp/1tbiPRZPT1SIWxQupQABsy
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32).

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated with
each others by OR.

Use GFP_NORMAL() to clear bottom 3 bits of GFP bitmaks.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f8ab1c0..8fe524d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -519,7 +519,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 		return cpu_addr;
 
 	/* let the implementation decide on the zone to allocate from: */
-	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
+	flag = GFP_NORMAL(flag);
 
 	if (!arch_dma_alloc_attrs(&dev, &flag))
 		return NULL;
-- 
1.8.3.1
