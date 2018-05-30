Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbeE3PL0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753836AbeE3PLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:11:21 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/2] f2fs: fix to correct return value of f2fs_trim_fs
Date: Wed, 30 May 2018 23:10:40 +0800
Message-Id: <20180530151041.24726-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

We should account trimmed block number from __wait_all_discard_cmd
in __issue_discard_cmd_range, otherwise trimmed blocks returned
by f2fs_trim_fs will be wrong, this patch fixes it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix to add missing return value in __wait_all_discard_cmd.
 fs/f2fs/segment.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4b24a68f4dc7..66983acaad16 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1319,21 +1319,21 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 	return trimmed;
 }
 
-static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
+static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 						struct discard_policy *dpolicy)
 {
 	struct discard_policy dp;
+	unsigned int discard_blks;
 
-	if (dpolicy) {
-		__wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
-		return;
-	}
+	if (dpolicy)
+		return __wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
 
 	/* wait all */
 	__init_discard_policy(sbi, &dp, DPOLICY_FSTRIM, 1);
-	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
+	discard_blks = __wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
 	__init_discard_policy(sbi, &dp, DPOLICY_UMOUNT, 1);
-	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
+	discard_blks += __wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
+	return 0;
 }
 
 /* This should be covered by global mutex, &sit_i->sentry_lock */
@@ -2365,7 +2365,7 @@ bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
 	return has_candidate;
 }
 
-static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
+static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 					struct discard_policy *dpolicy,
 					unsigned int start, unsigned int end)
 {
@@ -2375,6 +2375,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	struct discard_cmd *dc;
 	struct blk_plug plug;
 	int issued;
+	unsigned int trimmed = 0;
 
 next:
 	issued = 0;
@@ -2410,7 +2411,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
-			__wait_all_discard_cmd(sbi, NULL);
+			trimmed += __wait_all_discard_cmd(sbi, NULL);
 			congestion_wait(BLK_RW_ASYNC, HZ/50);
 			goto next;
 		}
@@ -2424,6 +2425,8 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 	blk_finish_plug(&plug);
 	mutex_unlock(&dcc->cmd_lock);
+
+	return trimmed;
 }
 
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
@@ -2434,7 +2437,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	block_t start_block, end_block;
 	struct cp_control cpc;
 	struct discard_policy dpolicy;
-	unsigned long long trimmed = 0;
+	unsigned long long trimmed;
 	int err = 0;
 
 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
@@ -2472,8 +2475,9 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	end_block = START_BLOCK(sbi, end_segno + 1);
 
 	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
-	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
-	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
+	trimmed = __issue_discard_cmd_range(sbi, &dpolicy,
+					start_block, end_block);
+	trimmed += __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
 	range->len = F2FS_BLK_TO_BYTES(trimmed);
 out:
-- 
2.16.2.17.g38e79b1fd
