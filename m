Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933584AbeEWPPg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:15:36 -0400
Received: from m50-134.163.com ([123.125.50.134]:52018 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933419AbeEWPPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:15:31 -0400
From: Huaisheng Ye <yehs2007@163.com>
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: mhocko@suse.com, willy@infradead.org, hch@lst.de, vbabka@suse.cz,
        mgorman@techsingularity.net, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
        hehy1@lenovo.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>,
        zhongjiang <zhongjiang@huawei.com>, Minchan Kim <minchan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v3 6/9] mm/vmpressure: update usage of zone modifiers
Date: Wed, 23 May 2018 22:57:51 +0800
Message-Id: <1527087474-93986-7-git-send-email-yehs2007@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527087474-93986-1-git-send-email-yehs2007@163.com>
References: <1527087474-93986-1-git-send-email-yehs2007@163.com>
X-CM-TRANSID: DtGowAAXEWSIgQVbCQ9NAA--.108S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7trykKryDJrW8Aw4xZw1fZwb_yoW8Xr15pr
        9rCr4xWr95ur13ta4rAa1xGa4Ikw1rCF45GFnrAry7Aas0gr98Wr1akFy8WryDCFWYyrn5
        Xr47Aws5ArZ0qa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b2cTdUUUUU=
X-Originating-IP: [103.244.59.4]
X-CM-SenderInfo: p1hk2jqqqxqiywtou0bp/1tbizRdPT1c7BDy5cQABsH
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MOVABLE to replace (__GFP_HIGHMEM | __GFP_MOVABLE).

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.

__GFP_ZONE_MOVABLE contains encoded ZONE_MOVABLE and __GFP_MOVABLE flag.

With GFP_ZONE_TABLE, __GFP_HIGHMEM ORing __GFP_MOVABLE means gfp_zone
should return ZONE_MOVABLE. In order to keep that compatible with
GFP_ZONE_TABLE, replace (__GFP_HIGHMEM | __GFP_MOVABLE) with
__GFP_ZONE_MOVABLE.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: zhongjiang <zhongjiang@huawei.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 mm/vmpressure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 85350ce..30a40e2 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -256,7 +256,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 	 * Indirect reclaim (kswapd) sets sc->gfp_mask to GFP_KERNEL, so
 	 * we account it too.
 	 */
-	if (!(gfp & (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_IO | __GFP_FS)))
+	if (!(gfp & (__GFP_ZONE_MOVABLE | __GFP_IO | __GFP_FS)))
 		return;
 
 	/*
-- 
1.8.3.1
