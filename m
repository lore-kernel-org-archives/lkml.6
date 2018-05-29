Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966911AbeE2Uu7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966770AbeE2Uu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:50:56 -0400
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: issue discard commands proactively in high fs utilization
Date: Tue, 29 May 2018 13:50:48 -0700
Message-Id: <20180529205048.39694-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the high utilization like over 80%, we don't expect huge # of large discard
commands, but do many small pending discards which affects FTL GCs a lot.
Let's issue them in that case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  3 +-
 fs/f2fs/segment.c | 71 ++++++++++++++++++++++++++---------------------
 2 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e852ac9472c6..27231fe8a6b2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -186,6 +186,7 @@ enum {
 #define DEF_MAX_DISCARD_LEN		512	/* Max. 2MB per discard */
 #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
 #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
+#define DEF_DISCARD_URGENT_UTIL		80	/* do more discard over 80% */
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 
@@ -2777,8 +2778,6 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
 void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
 void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
 bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
-void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
-						unsigned int granularity);
 void drop_discard_cmd(struct f2fs_sb_info *sbi);
 void stop_discard_thread(struct f2fs_sb_info *sbi);
 bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6e40e536dae0..8c1f7a6bf178 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -915,6 +915,38 @@ static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
 #endif
 }
 
+static void __init_discard_policy(struct f2fs_sb_info *sbi,
+				struct discard_policy *dpolicy,
+				int discard_type, unsigned int granularity)
+{
+	/* common policy */
+	dpolicy->type = discard_type;
+	dpolicy->sync = true;
+	dpolicy->granularity = granularity;
+
+	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
+	dpolicy->io_aware_gran = MAX_PLIST_NUM;
+
+	if (discard_type == DPOLICY_BG) {
+		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
+		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
+		dpolicy->io_aware = true;
+		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
+			dpolicy->granularity = 1;
+			dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
+		}
+	} else if (discard_type == DPOLICY_FORCE) {
+		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
+		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
+		dpolicy->io_aware = false;
+	} else if (discard_type == DPOLICY_FSTRIM) {
+		dpolicy->io_aware = false;
+	} else if (discard_type == DPOLICY_UMOUNT) {
+		dpolicy->io_aware = false;
+	}
+}
+
+
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
 static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 						struct discard_policy *dpolicy,
@@ -1278,9 +1310,9 @@ static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 	}
 
 	/* wait all */
-	init_discard_policy(&dp, DPOLICY_FSTRIM, 1);
+	__init_discard_policy(sbi, &dp, DPOLICY_FSTRIM, 1);
 	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
-	init_discard_policy(&dp, DPOLICY_UMOUNT, 1);
+	__init_discard_policy(sbi, &dp, DPOLICY_UMOUNT, 1);
 	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
 }
 
@@ -1326,7 +1358,8 @@ bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 	struct discard_policy dpolicy;
 	bool dropped;
 
-	init_discard_policy(&dpolicy, DPOLICY_UMOUNT, dcc->discard_granularity);
+	__init_discard_policy(sbi, &dpolicy, DPOLICY_UMOUNT,
+					dcc->discard_granularity);
 	__issue_discard_cmd(sbi, &dpolicy);
 	dropped = __drop_discard_cmd(sbi);
 
@@ -1347,7 +1380,7 @@ static int issue_discard_thread(void *data)
 	set_freezable();
 
 	do {
-		init_discard_policy(&dpolicy, DPOLICY_BG,
+		__init_discard_policy(sbi, &dpolicy, DPOLICY_BG,
 					dcc->discard_granularity);
 
 		wait_event_interruptible_timeout(*q,
@@ -1365,7 +1398,7 @@ static int issue_discard_thread(void *data)
 			dcc->discard_wake = 0;
 
 		if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
-			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
+			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
 
 		sb_start_intwrite(sbi->sb);
 
@@ -1658,32 +1691,6 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	wake_up_discard_thread(sbi, false);
 }
 
-void init_discard_policy(struct discard_policy *dpolicy,
-				int discard_type, unsigned int granularity)
-{
-	/* common policy */
-	dpolicy->type = discard_type;
-	dpolicy->sync = true;
-	dpolicy->granularity = granularity;
-
-	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
-	dpolicy->io_aware_gran = MAX_PLIST_NUM;
-
-	if (discard_type == DPOLICY_BG) {
-		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
-		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
-		dpolicy->io_aware = true;
-	} else if (discard_type == DPOLICY_FORCE) {
-		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
-		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
-		dpolicy->io_aware = false;
-	} else if (discard_type == DPOLICY_FSTRIM) {
-		dpolicy->io_aware = false;
-	} else if (discard_type == DPOLICY_UMOUNT) {
-		dpolicy->io_aware = false;
-	}
-}
-
 static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 {
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
@@ -2442,7 +2449,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	start_block = START_BLOCK(sbi, start_segno);
 	end_block = START_BLOCK(sbi, min(cur_segno, end_segno) + 1);
 
-	init_discard_policy(&dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
+	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
 	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
 	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
-- 
2.17.0.441.gb46fe60e1d-goog
