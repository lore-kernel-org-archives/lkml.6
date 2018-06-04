Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeFDPWY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752143AbeFDPWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:22:23 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 2/2] f2fs: fix to update mtime correctly
Date: Mon,  4 Jun 2018 23:20:17 +0800
Message-Id: <20180604152017.15015-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

If we change system time to the past, get_mtime() will return a
overflowed time, and SIT_I(sbi)->max_mtime will be udpated
incorrectly, this patch fixes the two issues.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix to correct return value of get_mtime().
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/segment.c    |  7 ++++---
 fs/f2fs/segment.h    | 17 ++++++++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 76e1856e4666..c7ffa1e0e021 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1223,7 +1223,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * modify checkpoint
 	 * version number is already updated
 	 */
-	ckpt->elapsed_time = cpu_to_le64(get_mtime(sbi));
+	ckpt->elapsed_time = cpu_to_le64(get_mtime(sbi, true));
 	ckpt->free_segment_count = cpu_to_le32(free_segments(sbi));
 	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
 		ckpt->cur_node_segno[i] =
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 66983acaad16..c1bd31da772d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1822,8 +1822,9 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 				(new_vblocks > sbi->blocks_per_seg)));
 
 	se->valid_blocks = new_vblocks;
-	se->mtime = get_mtime(sbi);
-	SIT_I(sbi)->max_mtime = se->mtime;
+	se->mtime = get_mtime(sbi, false);
+	if (se->mtime > SIT_I(sbi)->max_mtime)
+		SIT_I(sbi)->max_mtime = se->mtime;
 
 	/* Update valid block bitmap */
 	if (del > 0) {
@@ -3879,7 +3880,7 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
 		if (sit_i->min_mtime > mtime)
 			sit_i->min_mtime = mtime;
 	}
-	sit_i->max_mtime = get_mtime(sbi);
+	sit_i->max_mtime = get_mtime(sbi, false);
 	up_write(&sit_i->sentry_lock);
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index c574131ac7e1..f18fc82fbe99 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -745,12 +745,23 @@ static inline void set_to_next_sit(struct sit_info *sit_i, unsigned int start)
 #endif
 }
 
-static inline unsigned long long get_mtime(struct f2fs_sb_info *sbi)
+static inline unsigned long long get_mtime(struct f2fs_sb_info *sbi,
+						bool base_time)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	time64_t now = ktime_get_real_seconds();
+	time64_t diff, now = ktime_get_real_seconds();
 
-	return sit_i->elapsed_time + now - sit_i->mounted_time;
+	if (now >= sit_i->mounted_time)
+		return sit_i->elapsed_time + now - sit_i->mounted_time;
+
+	/* system time is set to the past */
+	if (!base_time) {
+		diff = sit_i->mounted_time - now;
+		if (sit_i->elapsed_time >= diff)
+			return sit_i->elapsed_time - diff;
+		return 0;
+	}
+	return sit_i->elapsed_time;
 }
 
 static inline void set_summary(struct f2fs_summary *sum, nid_t nid,
-- 
2.16.2.17.g38e79b1fd
