Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933704AbeEWPQB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:16:01 -0400
Received: from m50-134.163.com ([123.125.50.134]:55334 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933674AbeEWPPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:15:53 -0400
From: Huaisheng Ye <yehs2007@163.com>
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: mhocko@suse.com, willy@infradead.org, hch@lst.de, vbabka@suse.cz,
        mgorman@techsingularity.net, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
        hehy1@lenovo.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>,
        Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v3 5/9] drivers/block/zram/zram_drv: update usage of zone modifiers
Date: Wed, 23 May 2018 22:57:50 +0800
Message-Id: <1527087474-93986-6-git-send-email-yehs2007@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527087474-93986-1-git-send-email-yehs2007@163.com>
References: <1527087474-93986-1-git-send-email-yehs2007@163.com>
X-CM-TRANSID: DtGowAAXEWSIgQVbCQ9NAA--.108S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7trykKryDJrW8Aw4xZw1fZwb_yoW8Ww1Dpr
        yUCr4I9ryDZF1aqFyrJw4IqFyfKw1kC343K347A34Uu3s5Jr98ZF12kFy8WFyDZrWSkF9a
        qrsrA3yrAF1qqrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b2cTdUUUUU=
X-Originating-IP: [103.244.59.4]
X-CM-SenderInfo: p1hk2jqqqxqiywtou0bp/1tbizRdPT1c7BDy5cQAAsG
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
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 drivers/block/zram/zram_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0f3fadd..1bb5ca8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1004,14 +1004,12 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				__GFP_KSWAPD_RECLAIM |
 				__GFP_NOWARN |
-				__GFP_HIGHMEM |
-				__GFP_MOVABLE);
+				__GFP_ZONE_MOVABLE);
 	if (!handle) {
 		zcomp_stream_put(zram->comp);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
-				GFP_NOIO | __GFP_HIGHMEM |
-				__GFP_MOVABLE);
+				GFP_NOIO | __GFP_ZONE_MOVABLE);
 		if (handle)
 			goto compress_again;
 		return -ENOMEM;
-- 
1.8.3.1
