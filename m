Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933163AbeDICZs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 22:25:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933134AbeDICZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 22:25:45 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: don't split checkpoint in fstrim
Date: Mon, 9 Apr 2018 10:25:23 +0800
Message-ID: <20180409022523.79671-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, we issue discard asynchronously in separated thread instead of in
checkpoint, after that, we won't encounter long latency in checkpoint
due to huge number of synchronous discard command handling, so, we don't
need to split checkpoint to do trim in batch, merge it and obsolete
related sysfs entry.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: correct end boundary.
 Documentation/ABI/testing/sysfs-fs-f2fs |  1 +
 fs/f2fs/f2fs.h                          |  5 -----
 fs/f2fs/segment.c                       | 37 ++++++++++-----------------------
 fs/f2fs/sysfs.c                         |  3 +++
 4 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 540553c933b6..372b88f4e706 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -101,6 +101,7 @@ Date:		February 2015
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
 		 Controls the trimming rate in batch mode.
+		 <deprecated>
 
 What:		/sys/fs/f2fs/<disk>/cp_interval
 Date:		October 2015
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0aaf70955c77..f414f7ab8ddb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -178,11 +178,6 @@ enum {
 #define	CP_DISCARD	0x00000010
 #define CP_TRIMMED	0x00000020
 
-#define DEF_BATCHED_TRIM_SECTIONS	2048
-#define BATCHED_TRIM_SEGMENTS(sbi)	\
-		(GET_SEG_FROM_SEC(sbi, SM_I(sbi)->trim_sections))
-#define BATCHED_TRIM_BLOCKS(sbi)	\
-		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
 #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2aff7834d821..16c10dea8aad 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2424,7 +2424,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 {
 	__u64 start = F2FS_BYTES_TO_BLK(range->start);
 	__u64 end = start + F2FS_BYTES_TO_BLK(range->len) - 1;
-	unsigned int start_segno, end_segno, cur_segno;
+	unsigned int start_segno, end_segno;
 	block_t start_block, end_block;
 	struct cp_control cpc;
 	struct discard_policy dpolicy;
@@ -2450,33 +2450,20 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 
 	cpc.reason = CP_DISCARD;
 	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
+	cpc.trim_start = start_segno;
+	cpc.trim_end = end_segno;
 
-	/* do checkpoint to issue discard commands safely */
-	for (cur_segno = start_segno; cur_segno <= end_segno;
-					cur_segno = cpc.trim_end + 1) {
-		cpc.trim_start = cur_segno;
-
-		if (sbi->discard_blks == 0)
-			break;
-		else if (sbi->discard_blks < BATCHED_TRIM_BLOCKS(sbi))
-			cpc.trim_end = end_segno;
-		else
-			cpc.trim_end = min_t(unsigned int,
-				rounddown(cur_segno +
-				BATCHED_TRIM_SEGMENTS(sbi),
-				sbi->segs_per_sec) - 1, end_segno);
-
-		mutex_lock(&sbi->gc_mutex);
-		err = write_checkpoint(sbi, &cpc);
-		mutex_unlock(&sbi->gc_mutex);
-		if (err)
-			break;
+	if (sbi->discard_blks == 0)
+		goto out;
 
-		schedule();
-	}
+	mutex_lock(&sbi->gc_mutex);
+	err = write_checkpoint(sbi, &cpc);
+	mutex_unlock(&sbi->gc_mutex);
+	if (err)
+		goto out;
 
 	start_block = START_BLOCK(sbi, start_segno);
-	end_block = START_BLOCK(sbi, min(cur_segno, end_segno) + 1);
+	end_block = START_BLOCK(sbi, end_segno + 1);
 
 	init_discard_policy(&dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
 	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
@@ -3869,8 +3856,6 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->min_hot_blocks = DEF_MIN_HOT_BLOCKS;
 	sm_info->min_ssr_sections = reserved_sections(sbi);
 
-	sm_info->trim_sections = DEF_BATCHED_TRIM_SECTIONS;
-
 	INIT_LIST_HEAD(&sm_info->sit_entry_set);
 
 	init_rwsem(&sm_info->curseg_lock);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index ab54990d057d..2130d9b031a2 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -251,6 +251,9 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "trim_sections"))
+		return -EINVAL;
+
 	*ui = t;
 
 	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
-- 
2.15.0.55.gc2ece9dc4de6
