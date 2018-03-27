Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeC0Guu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:50:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38988 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeC0Gur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:50:47 -0400
X-Google-Smtp-Source: AG47ELuXEQqw5SutEqvaFMCBCUTk/guiK6ZcdNMDuxB23XI44gY1eXZoNYayCFVNyA2Ifccijdo6XA==
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 1/4] zram: correct flag name of ZRAM_ACCESS
Date: Tue, 27 Mar 2018 15:50:30 +0900
Message-Id: <20180327065033.181819-2-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180327065033.181819-1-minchan@kernel.org>
References: <20180327065033.181819-1-minchan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZRAM_ACCESS is used for locking a slot of zram so correct the name.
It is also not a common flag to indicate status of the block so
move the declare position on top of the flag.
Lastly, let's move the function to the top of source code to be able to
use it easily without forward declaration.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 20 ++++++++++----------
 drivers/block/zram/zram_drv.h |  6 +++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0f3fadd71230..18dadeab775b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -52,6 +52,16 @@ static size_t huge_class_size;
 
 static void zram_free_page(struct zram *zram, size_t index);
 
+static void zram_slot_lock(struct zram *zram, u32 index)
+{
+	bit_spin_lock(ZRAM_LOCK, &zram->table[index].value);
+}
+
+static void zram_slot_unlock(struct zram *zram, u32 index)
+{
+	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].value);
+}
+
 static inline bool init_done(struct zram *zram)
 {
 	return zram->disksize;
@@ -753,16 +763,6 @@ static DEVICE_ATTR_RO(io_stat);
 static DEVICE_ATTR_RO(mm_stat);
 static DEVICE_ATTR_RO(debug_stat);
 
-static void zram_slot_lock(struct zram *zram, u32 index)
-{
-	bit_spin_lock(ZRAM_ACCESS, &zram->table[index].value);
-}
-
-static void zram_slot_unlock(struct zram *zram, u32 index)
-{
-	bit_spin_unlock(ZRAM_ACCESS, &zram->table[index].value);
-}
-
 static void zram_meta_free(struct zram *zram, u64 disksize)
 {
 	size_t num_pages = disksize >> PAGE_SHIFT;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index d71c8000a964..e540462fec6c 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -44,9 +44,9 @@
 
 /* Flags for zram pages (table[page_no].value) */
 enum zram_pageflags {
-	/* Page consists the same element */
-	ZRAM_SAME = ZRAM_FLAG_SHIFT,
-	ZRAM_ACCESS,	/* page is now accessed */
+	/* zram slot is locked */
+	ZRAM_LOCK = ZRAM_FLAG_SHIFT,
+	ZRAM_SAME,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
 
 	__NR_ZRAM_PAGEFLAGS,
-- 
2.17.0.rc0.231.g781580f067-goog
