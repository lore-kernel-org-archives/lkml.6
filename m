Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8A9C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EBE20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EBE20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeJXTFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:05:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbeJXTFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:05:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8B7C864DF7A58;
        Wed, 24 Oct 2018 18:37:38 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 24 Oct 2018 18:37:32 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: support subsectional garbage collection
Date:   Wed, 24 Oct 2018 18:37:27 +0800
Message-ID: <20181024103728.9870-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20181024103728.9870-1-yuchao0@huawei.com>
References: <20181024103728.9870-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Section is minimal garbage collection unit of f2fs, in zoned block
device, or ancient block mapping flash device, in order to improve
GC efficiency, we can align GC unit to lower device erase unit,
normally, it consists of multiple of segments.

Once background or foreground GC triggers, it brings a large number
of IOs, which will impact user IO, and also occupy cpu/memory resource
intensively.

So, to reduce impact of GC on large size section, this patch supports
subsectional GC, in one cycle of GC, it only migrate partial segment{s}
in victim section. Currently, by default, we use sbi->segs_per_sec as
migration granularity.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/gc.c    | 43 ++++++++++++++++++++++++++++++++++++-------
 fs/f2fs/super.c |  3 +++
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e57e7874d162..b9cec3f2184c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1266,6 +1266,7 @@ struct f2fs_sb_info {
 	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
 	unsigned int cur_victim_sec;		/* current victim section num */
 	unsigned int gc_mode;			/* current GC state */
+	unsigned int next_victim_seg[2];	/* next segment in victim section */
 	/* for skip statistic */
 	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
 	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
@@ -1275,6 +1276,8 @@ struct f2fs_sb_info {
 
 	/* maximum # of trials to find a victim segment for SSR and GC */
 	unsigned int max_victim_search;
+	/* migration granularity of garbage collection, unit: segment */
+	unsigned int migration_granularity;
 
 	/*
 	 * for stat information.
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 34b9d56f5f9e..d5d8c433178b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -333,6 +333,22 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	if (p.max_search == 0)
 		goto out;
 
+	if (__is_large_section(sbi) && p.alloc_mode == LFS) {
+		if (sbi->next_victim_seg[BG_GC] != NULL_SEGNO) {
+			p.min_segno = sbi->next_victim_seg[BG_GC];
+			*result = p.min_segno;
+			sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
+			goto got_result;
+		}
+		if (gc_type == FG_GC &&
+				sbi->next_victim_seg[FG_GC] != NULL_SEGNO) {
+			p.min_segno = sbi->next_victim_seg[FG_GC];
+			*result = p.min_segno;
+			sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
+			goto got_result;
+		}
+	}
+
 	last_victim = sm->last_victim[p.gc_mode];
 	if (p.alloc_mode == LFS && gc_type == FG_GC) {
 		p.min_segno = check_bg_victims(sbi);
@@ -395,6 +411,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	}
 	if (p.min_segno != NULL_SEGNO) {
 got_it:
+		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
+got_result:
 		if (p.alloc_mode == LFS) {
 			secno = GET_SEC_FROM_SEG(sbi, p.min_segno);
 			if (gc_type == FG_GC)
@@ -402,7 +420,6 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			else
 				set_bit(secno, dirty_i->victim_secmap);
 		}
-		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
 
 		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
 				sbi->cur_victim_sec,
@@ -1093,15 +1110,18 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	struct blk_plug plug;
 	unsigned int segno = start_segno;
 	unsigned int end_segno = start_segno + sbi->segs_per_sec;
-	int seg_freed = 0;
+	int seg_freed = 0, migrated = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
 	int submitted = 0;
 
+	if (__is_large_section(sbi))
+		end_segno = rounddown(end_segno, sbi->segs_per_sec);
+
 	/* readahead multi ssa blocks those have contiguous address */
 	if (__is_large_section(sbi))
 		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
-					sbi->segs_per_sec, META_SSA, true);
+					end_segno - segno, META_SSA, true);
 
 	/* reference all summary page */
 	while (segno < end_segno) {
@@ -1130,18 +1150,23 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					GET_SUM_BLOCK(sbi, segno));
 		f2fs_put_page(sum_page, 0);
 
-		if (get_valid_blocks(sbi, segno, false) == 0 ||
-				!PageUptodate(sum_page) ||
-				unlikely(f2fs_cp_error(sbi)))
+		if (get_valid_blocks(sbi, segno, false) == 0)
 			goto next;
 
+		if (__is_large_section(sbi) &&
+				migrated >= sbi->migration_granularity)
+			goto skip;
+
+		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
+			goto skip;
+
 		sum = page_address(sum_page);
 		if (type != GET_SUM_TYPE((&sum->footer))) {
 			f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent segment (%u) "
 				"type [%d, %d] in SSA and SIT",
 				segno, type, GET_SUM_TYPE((&sum->footer)));
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			goto next;
+			goto skip;
 		}
 
 		/*
@@ -1163,7 +1188,11 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		if (gc_type == FG_GC &&
 				get_valid_blocks(sbi, segno, false) == 0)
 			seg_freed++;
+		migrated++;
 next:
+		if (__is_large_section(sbi) && segno + 1 < end_segno)
+			sbi->next_victim_seg[gc_type] = segno + 1;
+skip:
 		f2fs_put_page(sum_page, 0);
 	}
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5b297f3b55e4..c85e3a17aaa0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2692,7 +2692,10 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->node_ino_num = le32_to_cpu(raw_super->node_ino);
 	sbi->meta_ino_num = le32_to_cpu(raw_super->meta_ino);
 	sbi->cur_victim_sec = NULL_SECNO;
+	sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
+	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
+	sbi->migration_granularity = sbi->segs_per_sec;
 
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
-- 
2.18.0.rc1

