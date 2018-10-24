Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7B5C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D1D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D1D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJXTFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:05:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbeJXTFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:05:15 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85BD48E77371B;
        Wed, 24 Oct 2018 18:37:38 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 24 Oct 2018 18:37:32 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: introduce __is_large_section() for cleanup
Date:   Wed, 24 Oct 2018 18:37:26 +0800
Message-ID: <20181024103728.9870-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a wrapper __is_large_section() to clean up codes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c   |  2 +-
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/gc.c      |  4 ++--
 fs/f2fs/segment.c | 16 ++++++++--------
 fs/f2fs/segment.h |  2 +-
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 139b4d5c83d5..e327eefdbc02 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -197,7 +197,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->base_mem += 2 * SIT_VBLOCK_MAP_SIZE * MAIN_SEGS(sbi);
 	si->base_mem += SIT_VBLOCK_MAP_SIZE * MAIN_SEGS(sbi);
 	si->base_mem += SIT_VBLOCK_MAP_SIZE;
-	if (sbi->segs_per_sec > 1)
+	if (__is_large_section(sbi))
 		si->base_mem += MAIN_SECS(sbi) * sizeof(struct sec_entry);
 	si->base_mem += __bitmap_size(sbi, SIT_BITMAP);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b60ab0b78be5..e57e7874d162 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2767,6 +2767,8 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 	spin_unlock(&sbi->iostat_lock);
 }
 
+#define __is_large_section(sbi)		((sbi)->segs_per_sec > 1)
+
 #define __is_meta_io(fio) (PAGE_TYPE_OF_BIO(fio->type) == META &&	\
 				(!is_read_io(fio->op) || fio->is_meta))
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82f144052fce..a114eacc0d7e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2560,7 +2560,7 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 		return -EFAULT;
 
 	if (sbi->s_ndevs <= 1 || sbi->s_ndevs - 1 <= range.dev_num ||
-			sbi->segs_per_sec != 1) {
+			__is_large_section(sbi)) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"Can't flush %u in %d for segs_per_sec %u != 1\n",
 				range.dev_num, sbi->s_ndevs,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a07241fb8537..34b9d56f5f9e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1099,7 +1099,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	int submitted = 0;
 
 	/* readahead multi ssa blocks those have contiguous address */
-	if (sbi->segs_per_sec > 1)
+	if (__is_large_section(sbi))
 		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
 					sbi->segs_per_sec, META_SSA, true);
 
@@ -1307,7 +1307,7 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
 
 	/* give warm/cold data area from slower device */
-	if (sbi->s_ndevs && sbi->segs_per_sec == 1)
+	if (sbi->s_ndevs && !__is_large_section(sbi))
 		SIT_I(sbi)->last_victim[ALLOC_NEXT] =
 				GET_SEGNO(sbi, FDEV(0).end_blk) + 1;
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 63b109679281..b0e6331a5d95 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1884,7 +1884,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 	unsigned int start = 0, end = -1;
 	unsigned int secno, start_segno;
 	bool force = (cpc->reason & CP_DISCARD);
-	bool need_align = test_opt(sbi, LFS) && sbi->segs_per_sec > 1;
+	bool need_align = test_opt(sbi, LFS) && __is_large_section(sbi);
 
 	mutex_lock(&dirty_i->seglist_lock);
 
@@ -1916,7 +1916,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					(end - 1) <= cpc->trim_end)
 				continue;
 
-		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
+		if (!test_opt(sbi, LFS) || !__is_large_section(sbi)) {
 			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
 				(end - start) << sbi->log_blocks_per_seg);
 			continue;
@@ -2148,7 +2148,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 	/* update total number of valid blocks to be written in ckpt area */
 	SIT_I(sbi)->written_valid_blocks += del;
 
-	if (sbi->segs_per_sec > 1)
+	if (__is_large_section(sbi))
 		get_sec_entry(sbi, segno)->valid_blocks += del;
 }
 
@@ -2414,7 +2414,7 @@ static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
 static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 {
 	/* if segs_per_sec is large than 1, we need to keep original policy. */
-	if (sbi->segs_per_sec != 1)
+	if (__is_large_section(sbi))
 		return CURSEG_I(sbi, type)->segno;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
@@ -2724,7 +2724,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	struct discard_policy dpolicy;
 	unsigned long long trimmed = 0;
 	int err = 0;
-	bool need_align = test_opt(sbi, LFS) && sbi->segs_per_sec > 1;
+	bool need_align = test_opt(sbi, LFS) && __is_large_section(sbi);
 
 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
@@ -3885,7 +3885,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	if (!sit_i->tmp_map)
 		return -ENOMEM;
 
-	if (sbi->segs_per_sec > 1) {
+	if (__is_large_section(sbi)) {
 		sit_i->sec_entries =
 			f2fs_kvzalloc(sbi, array_size(sizeof(struct sec_entry),
 						      MAIN_SECS(sbi)),
@@ -4040,7 +4040,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 					se->valid_blocks;
 			}
 
-			if (sbi->segs_per_sec > 1)
+			if (__is_large_section(sbi))
 				get_sec_entry(sbi, start)->valid_blocks +=
 							se->valid_blocks;
 		}
@@ -4084,7 +4084,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 			sbi->discard_blks -= se->valid_blocks;
 		}
 
-		if (sbi->segs_per_sec > 1) {
+		if (__is_large_section(sbi)) {
 			get_sec_entry(sbi, start)->valid_blocks +=
 							se->valid_blocks;
 			get_sec_entry(sbi, start)->valid_blocks -=
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index ab3465faddf1..a77f76f528b6 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -333,7 +333,7 @@ static inline unsigned int get_valid_blocks(struct f2fs_sb_info *sbi,
 	 * In order to get # of valid blocks in a section instantly from many
 	 * segments, f2fs manages two counting structures separately.
 	 */
-	if (use_section && sbi->segs_per_sec > 1)
+	if (use_section && __is_large_section(sbi))
 		return get_sec_entry(sbi, segno)->valid_blocks;
 	else
 		return get_seg_entry(sbi, segno)->valid_blocks;
-- 
2.18.0.rc1

