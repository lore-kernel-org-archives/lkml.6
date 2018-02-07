Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbeBGJ3q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:29:46 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34185 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753732AbeBGJ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:29:42 -0500
X-Google-Smtp-Source: AH8x226ODBzqmlE7TXz1EynJv1jlUegf/cYCw9CV7iM2mXBiIEzcSLOuwF36GV/HXjZcaTMpdAJoWg==
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH 2/2] zram: drop max_zpage_size and use zs_huge_object()
Date: Wed,  7 Feb 2018 18:29:19 +0900
Message-Id: <20180207092919.19696-3-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207092919.19696-1-sergey.senozhatsky@gmail.com>
References: <20180207092919.19696-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes ZRAM's enforced "huge object" value and uses
zsmalloc huge-class watermark instead, which makes more sense.

TEST
- I used a 1G zram device, LZO compression back-endi, original
  data set size was 444MB. Looking at zsmalloc classes stats the
  test ended up to be pretty fair.

BASE ZRAM/ZSMALLOC
=====================
zram mm_stat

498978816 191482495 199831552        0 199831552    15634        0

zsmalloc classes

 class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
...
   151  2448           0            0          1240       1240        744                3        0
   168  2720           0            0          4200       4200       2800                2        0
   190  3072           0            0         10100      10100       7575                3        0
   202  3264           0            0           380        380        304                4        0
   254  4096           0            0         10620      10620      10620                1        0

 Total                 7           46        106982     106187      48787                         0

PATCHED ZRAM/ZSMALLOC
=====================

zram mm_stat

498978816 182579184 194248704        0 194248704    15628        0

zsmalloc classes

 class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
...
   151  2448           0            0          1240       1240        744                3        0
   168  2720           0            0          4200       4200       2800                2        0
   190  3072           0            0         10100      10100       7575                3        0
   202  3264           0            0          7180       7180       5744                4        0
   254  4096           0            0          3820       3820       3820                1        0

 Total                 8           45        106959     106193      47424                         0

As we can see, we reduced the number of objects stored in class-4096,
because a huge number of objects which we previously forcibly stored
in class-4096 now stored in non-huge class-3264. This results in lower
memory consumption:
 - zsmalloc now uses 47424 physical pages, which is less than 48787
   pages zsmalloc used before.

 - objects that we store in class-3264 share zspages. That's why overall
   the number of pages that both class-4096 and class-3264 consumed went
   down from 10924 to 9564.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/block/zram/zram_drv.c |  6 +++---
 drivers/block/zram/zram_drv.h | 16 ----------------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0afa6c8c3857..3d2bc4b1423c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -965,7 +965,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		return ret;
 	}
 
-	if (unlikely(comp_len > max_zpage_size)) {
+	if (unlikely(zs_huge_object(comp_len))) {
 		if (zram_wb_enabled(zram) && allow_wb) {
 			zcomp_stream_put(zram->comp);
 			ret = write_to_bdev(zram, bvec, index, bio, &element);
@@ -1022,10 +1022,10 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
 	src = zstrm->buffer;
-	if (comp_len == PAGE_SIZE)
+	if (zs_huge_object(comp_len))
 		src = kmap_atomic(page);
 	memcpy(dst, src, comp_len);
-	if (comp_len == PAGE_SIZE)
+	if (zs_huge_object(comp_len))
 		kunmap_atomic(src);
 
 	zcomp_stream_put(zram->comp);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 31762db861e3..d71c8000a964 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -21,22 +21,6 @@
 
 #include "zcomp.h"
 
-/*-- Configurable parameters */
-
-/*
- * Pages that compress to size greater than this are stored
- * uncompressed in memory.
- */
-static const size_t max_zpage_size = PAGE_SIZE / 4 * 3;
-
-/*
- * NOTE: max_zpage_size must be less than or equal to:
- *   ZS_MAX_ALLOC_SIZE. Otherwise, zs_malloc() would
- * always return failure.
- */
-
-/*-- End of configurable params */
-
 #define SECTOR_SHIFT		9
 #define SECTORS_PER_PAGE_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
 #define SECTORS_PER_PAGE	(1 << SECTORS_PER_PAGE_SHIFT)
-- 
2.16.1
