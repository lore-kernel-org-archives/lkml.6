Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967866AbeEXPhk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:37:40 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25420 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966698AbeEXPhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:37:39 -0400
From: Huaisheng Ye <yehs2007@zoho.com>
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
Date: Thu, 24 May 2018 23:20:53 +0800
Message-Id: <20180524152053.1248-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
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
