Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbeDPJKE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:10:04 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38398 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754424AbeDPJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:10:02 -0400
X-Google-Smtp-Source: AIpwx4+EcZ9bHg8Ele4EX6QMQebXgDpR1BREgjVOOsv/C63UkRWyzM+HEMmj2I5HoCHCn7TvaGzh3w==
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v5 2/4] zram: mark incompressible page as ZRAM_HUGE
Date: Mon, 16 Apr 2018 18:09:44 +0900
Message-Id: <20180416090946.63057-3-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180416090946.63057-1-minchan@kernel.org>
References: <20180416090946.63057-1-minchan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark incompressible pages so that we could investigate who is the
owner of the incompressible pages once the page is swapped out
via using upcoming zram memory tracker feature.

With it, we could prevent such pages to be swapped out by using
mlock. Otherwise we might remove them.

This patch exposes new stat for huge pages via mm_stat.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/blockdev/zram.txt |  1 +
 drivers/block/zram/zram_drv.c   | 17 ++++++++++++++---
 drivers/block/zram/zram_drv.h   |  2 ++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index 257e65714c6a..78db38d02bc9 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -218,6 +218,7 @@ The stat file represents device's mm statistics. It consists of a single
  same_pages       the number of same element filled pages written to this disk.
                   No memory is allocated for such pages.
  pages_compacted  the number of pages freed during compaction
+ huge_pages	  the number of incompressible pages
 
 9) Deactivate:
 	swapoff /dev/zram0
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 18dadeab775b..777fb3339f59 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -729,14 +729,15 @@ static ssize_t mm_stat_show(struct device *dev,
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu\n",
+			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu\n",
 			orig_size << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.compr_data_size),
 			mem_used << PAGE_SHIFT,
 			zram->limit_pages << PAGE_SHIFT,
 			max_used << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.same_pages),
-			pool_stats.pages_compacted);
+			pool_stats.pages_compacted,
+			(u64)atomic64_read(&zram->stats.huge_pages));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -805,6 +806,11 @@ static void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
 
+	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
+		zram_clear_flag(zram, index, ZRAM_HUGE);
+		atomic64_dec(&zram->stats.huge_pages);
+	}
+
 	if (zram_wb_enabled(zram) && zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_wb_clear(zram, index);
 		atomic64_dec(&zram->stats.pages_stored);
@@ -973,6 +979,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	}
 
 	if (unlikely(comp_len >= huge_class_size)) {
+		comp_len = PAGE_SIZE;
 		if (zram_wb_enabled(zram) && allow_wb) {
 			zcomp_stream_put(zram->comp);
 			ret = write_to_bdev(zram, bvec, index, bio, &element);
@@ -984,7 +991,6 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 			allow_wb = false;
 			goto compress_again;
 		}
-		comp_len = PAGE_SIZE;
 	}
 
 	/*
@@ -1046,6 +1052,11 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	zram_slot_lock(zram, index);
 	zram_free_page(zram, index);
 
+	if (comp_len == PAGE_SIZE) {
+		zram_set_flag(zram, index, ZRAM_HUGE);
+		atomic64_inc(&zram->stats.huge_pages);
+	}
+
 	if (flags) {
 		zram_set_flag(zram, index, flags);
 		zram_set_element(zram, index, element);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 8d8959ceabd1..ff0547bdb586 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -47,6 +47,7 @@ enum zram_pageflags {
 	ZRAM_LOCK = ZRAM_FLAG_SHIFT,
 	ZRAM_SAME,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
+	ZRAM_HUGE,	/* Incompressible page */
 
 	__NR_ZRAM_PAGEFLAGS,
 };
@@ -71,6 +72,7 @@ struct zram_stats {
 	atomic64_t invalid_io;	/* non-page-aligned I/O requests */
 	atomic64_t notify_free;	/* no. of swap slot free notifications */
 	atomic64_t same_pages;		/* no. of same element filled pages */
+	atomic64_t huge_pages;		/* no. of huge pages */
 	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
 	atomic64_t writestall;		/* no. of write slow paths */
-- 
2.17.0.484.g0c8726318c-goog
