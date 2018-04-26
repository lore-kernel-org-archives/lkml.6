Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbeDZJGo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:06:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753951AbeDZJGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:06:25 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] Revert "f2fs: add ovp valid_blocks check for bg gc victim to fg_gc"
Date: Thu, 26 Apr 2018 17:05:51 +0800
Message-ID: <20180426090551.92364-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
In-Reply-To: <20180426090551.92364-1-yuchao0@huawei.com>
References: <20180426090551.92364-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For extreme case:
10 section, op = 10%, no_fggc_threshold = 90%
All section usage: 85% 85% 85% 85% 90% 90% 95% 95% 95% 95%

During foreground GC, if we skip select dirty section whose usage
is larger than no_fggc_threshold, we can only recycle 80% invalid
space from four 85% usage sections and two 90% usage sections,
result in encountering out-of-space issue.

This reverts commit e93b9865251a0503d83fd570e7d5a7c8bc351715 to
fix this issue, besides, we keep the logic that we scan all dirty
section when searching a victim, so that GC can select victim with
least valid blocks.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  3 ---
 fs/f2fs/gc.c      | 16 ----------------
 fs/f2fs/segment.h |  9 ---------
 3 files changed, 28 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 64e3677998d8..9f8b327272df 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1192,9 +1192,6 @@ struct f2fs_sb_info {
 	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
 	unsigned int cur_victim_sec;		/* current victim section num */
 
-	/* threshold for converting bg victims for fg */
-	u64 fggc_threshold;
-
 	/* threshold for gc trials on pinned files */
 	u64 gc_pin_file_threshold;
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3134dd781252..62eba4a71123 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -263,10 +263,6 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
 	for_each_set_bit(secno, dirty_i->victim_secmap, MAIN_SECS(sbi)) {
 		if (sec_usage_check(sbi, secno))
 			continue;
-
-		if (no_fggc_candidate(sbi, secno))
-			continue;
-
 		clear_bit(secno, dirty_i->victim_secmap);
 		return GET_SEG_FROM_SEC(sbi, secno);
 	}
@@ -406,9 +402,6 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			goto next;
 		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
 			goto next;
-		if (gc_type == FG_GC && p.alloc_mode == LFS &&
-					no_fggc_candidate(sbi, secno))
-			goto next;
 
 		cost = get_gc_cost(sbi, segno, &p);
 
@@ -1152,17 +1145,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 
 void build_gc_manager(struct f2fs_sb_info *sbi)
 {
-	u64 main_count, resv_count, ovp_count;
-
 	DIRTY_I(sbi)->v_ops = &default_v_ops;
 
-	/* threshold of # of valid blocks in a section for victims of FG_GC */
-	main_count = SM_I(sbi)->main_segments << sbi->log_blocks_per_seg;
-	resv_count = SM_I(sbi)->reserved_segments << sbi->log_blocks_per_seg;
-	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
-
-	sbi->fggc_threshold = div64_u64((main_count - ovp_count) *
-				BLKS_PER_SEC(sbi), (main_count - resv_count));
 	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
 
 	/* give warm/cold data area from slower device */
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7702b054689c..c385daabcb67 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -774,15 +774,6 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 				- (base + 1) + type;
 }
 
-static inline bool no_fggc_candidate(struct f2fs_sb_info *sbi,
-						unsigned int secno)
-{
-	if (get_valid_blocks(sbi, GET_SEG_FROM_SEC(sbi, secno), true) >
-						sbi->fggc_threshold)
-		return true;
-	return false;
-}
-
 static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
 {
 	if (IS_CURSEC(sbi, secno) || (sbi->cur_victim_sec == secno))
-- 
2.15.0.55.gc2ece9dc4de6
