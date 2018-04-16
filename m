Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeDPDba (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 23:31:30 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42934 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbeDPDb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 23:31:27 -0400
X-Google-Smtp-Source: AIpwx4/Z3EN3vrTLTIB2qmvVu6LoIRdc9uzfU+n+AsfT4WtlhuVwjgfmz7C58JdoUWOGUcEXLbAQsQ==
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 3/4] zram: record accessed second
Date: Mon, 16 Apr 2018 12:31:09 +0900
Message-Id: <20180416033110.32361-4-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180416033110.32361-1-minchan@kernel.org>
References: <20180416033110.32361-1-minchan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zRam as swap is useful for small memory device. However, swap means
those pages on zram are mostly cold pages due to VM's LRU algorithm.
Especially, once init data for application are touched for launching,
they tend to be not accessed any more and finally swapped out.
zRAM can store such cold pages as compressed form but it's pointless
to keep in memory. Better idea is app developers free them directly
rather than remaining them on heap.

This patch records last access time of each block of zram so that
With upcoming zram memory tracking, it could help userspace developers
to reduce memory footprint.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 16 ++++++++++++++++
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 777fb3339f59..7fc10e2ad734 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -107,6 +107,16 @@ static inline void zram_set_element(struct zram *zram, u32 index,
 	zram->table[index].element = element;
 }
 
+static void zram_accessed(struct zram *zram, u32 index)
+{
+	zram->table[index].ac_time = sched_clock();
+}
+
+static void zram_reset_access(struct zram *zram, u32 index)
+{
+	zram->table[index].ac_time = 0;
+}
+
 static unsigned long zram_get_element(struct zram *zram, u32 index)
 {
 	return zram->table[index].element;
@@ -806,6 +816,8 @@ static void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
 
+	zram_reset_access(zram, index);
+
 	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
 		zram_clear_flag(zram, index, ZRAM_HUGE);
 		atomic64_dec(&zram->stats.huge_pages);
@@ -1177,6 +1189,10 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
 
 	generic_end_io_acct(q, rw_acct, &zram->disk->part0, start_time);
 
+	zram_slot_lock(zram, index);
+	zram_accessed(zram, index);
+	zram_slot_unlock(zram, index);
+
 	if (unlikely(ret < 0)) {
 		if (!is_write)
 			atomic64_inc(&zram->stats.failed_reads);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index ff0547bdb586..1075218e88b2 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -61,6 +61,7 @@ struct zram_table_entry {
 		unsigned long element;
 	};
 	unsigned long value;
+	u64 ac_time;
 };
 
 struct zram_stats {
-- 
2.17.0.484.g0c8726318c-goog
