Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EBEC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A259C21888
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix7Ajgwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A259C21888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeHERM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 13:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeHERM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 13:12:26 -0400
Received: from localhost.localdomain (unknown [49.77.238.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A2F21885;
        Sun,  5 Aug 2018 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533481652;
        bh=3q++5G+y5bLET89V6yA9Lx717pLoOe5B6XqdWwQWvPk=;
        h=From:To:Cc:Subject:Date:From;
        b=ix7Ajgwa1t6P1P5uKv9PLQrCtWBXZPJUfPRkGmzuMZEZpVMy4FwHvD6aSU06Mk3oR
         OoWpQWPH9oAeFf/EGpTwhpTKEnbCf5vlGeYNdl5ShU0MabVKJKLznMQG6p2pCy5gJy
         Dfz3IUZcXdx1oeVeDpZefEiWgCj5caCuPN4wqD5w=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: split discard command in prior to block layer
Date:   Sun,  5 Aug 2018 23:06:36 +0800
Message-Id: <20180805150636.9523-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Some devices has small max_{hw,}discard_sectors, so that in
__blkdev_issue_discard(), one big size discard bio can be split
into multiple small size discard bios, result in heavy load in IO
scheduler and device, which can hang other sync IO for long time.

Now, f2fs is trying to control discard commands more elaboratively,
in order to make less conflict in between discard IO and user IO
to enhance application's performance, so in this patch, we will
split discard bio in f2fs in prior to in block layer to reduce
issuing multiple discard bios in a short time.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- attach multi bios to one discard command entry.
 fs/f2fs/f2fs.h    |  14 +++----
 fs/f2fs/segment.c | 103 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 78 insertions(+), 39 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1212bc4c3dbd..7f8e650c02e0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -178,7 +178,6 @@ enum {
 
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
-#define DEF_MAX_DISCARD_LEN		512	/* Max. 2MB per discard */
 #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
 #define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
 #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
@@ -278,6 +277,7 @@ struct discard_cmd {
 	unsigned short ref;		/* reference count */
 	unsigned char state;		/* state */
 	int error;			/* bio error */
+	atomic_t bio_ref;		/* bio reference count */
 };
 
 enum {
@@ -710,22 +710,22 @@ static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
 }
 
 static inline bool __is_discard_mergeable(struct discard_info *back,
-						struct discard_info *front)
+			struct discard_info *front, unsigned int max_len)
 {
 	return (back->lstart + back->len == front->lstart) &&
-		(back->len + front->len < DEF_MAX_DISCARD_LEN);
+		(back->len + front->len <= max_len);
 }
 
 static inline bool __is_discard_back_mergeable(struct discard_info *cur,
-						struct discard_info *back)
+			struct discard_info *back, unsigned int max_len)
 {
-	return __is_discard_mergeable(back, cur);
+	return __is_discard_mergeable(back, cur, max_len);
 }
 
 static inline bool __is_discard_front_mergeable(struct discard_info *cur,
-						struct discard_info *front)
+			struct discard_info *front, unsigned int max_len)
 {
-	return __is_discard_mergeable(cur, front);
+	return __is_discard_mergeable(cur, front, max_len);
 }
 
 static inline bool __is_extent_mergeable(struct extent_info *back,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 15b3b095fd58..b00ff6fa2807 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -845,6 +845,7 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 	dc->error = 0;
 	init_completion(&dc->wait);
 	list_add_tail(&dc->list, pend_list);
+	atomic_set(&dc->bio_ref, 0);
 	atomic_inc(&dcc->discard_cmd_cnt);
 	dcc->undiscard_blks += len;
 
@@ -906,8 +907,10 @@ static void f2fs_submit_discard_endio(struct bio *bio)
 	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
 
 	dc->error = blk_status_to_errno(bio->bi_status);
-	dc->state = D_DONE;
-	complete_all(&dc->wait);
+	if (atomic_dec_and_test(&dc->bio_ref)) {
+		dc->state = D_DONE;
+		complete_all(&dc->wait);
+	}
 	bio_put(bio);
 }
 
@@ -975,17 +978,24 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	}
 }
 
-
+static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
+				struct block_device *bdev, block_t lstart,
+				block_t start, block_t len);
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
 static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 						struct discard_policy *dpolicy,
-						struct discard_cmd *dc)
+						struct discard_cmd *dc,
+						unsigned int *issued)
 {
+	struct block_device *bdev = dc->bdev;
+	struct request_queue *q = bdev_get_queue(bdev);
+	unsigned int max_discard_blocks =
+			SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
 					&(dcc->fstrim_list) : &(dcc->wait_list);
-	struct bio *bio = NULL;
 	int flag = dpolicy->sync ? REQ_SYNC : 0;
+	block_t lstart, start, len, total_len;
 
 	if (dc->state != D_PREP)
 		return;
@@ -993,30 +1003,56 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		return;
 
-	trace_f2fs_issue_discard(dc->bdev, dc->start, dc->len);
-
-	dc->error = __blkdev_issue_discard(dc->bdev,
-				SECTOR_FROM_BLOCK(dc->start),
-				SECTOR_FROM_BLOCK(dc->len),
-				GFP_NOFS, 0, &bio);
-	if (!dc->error) {
-		/* should keep before submission to avoid D_DONE right away */
-		dc->state = D_SUBMIT;
-		atomic_inc(&dcc->issued_discard);
-		atomic_inc(&dcc->issing_discard);
-		if (bio) {
+	trace_f2fs_issue_discard(bdev, dc->start, dc->len);
+
+	lstart = dc->lstart;
+	start = dc->start;
+	len = dc->len;
+	total_len = len;
+
+	while (total_len && *issued < dpolicy->max_requests) {
+		struct bio *bio = NULL;
+
+		if (len > max_discard_blocks)
+			len = max_discard_blocks;
+
+		dc->error = __blkdev_issue_discard(bdev,
+					SECTOR_FROM_BLOCK(start),
+					SECTOR_FROM_BLOCK(len),
+					GFP_NOFS, 0, &bio);
+		if (!dc->error && bio) {
+			/*
+			 * should keep before submission to avoid D_DONE
+			 * right away
+			 */
+			dc->state = D_SUBMIT;
+			atomic_inc(&dc->bio_ref);
+
+			/* sanity check on discard range */
+			__check_sit_bitmap(sbi, start, start + len);
+
 			bio->bi_private = dc;
 			bio->bi_end_io = f2fs_submit_discard_endio;
 			bio->bi_opf |= flag;
 			submit_bio(bio);
 			list_move_tail(&dc->list, wait_list);
-			__check_sit_bitmap(sbi, dc->start, dc->start + dc->len);
+
+			atomic_inc(&dcc->issued_discard);
+			atomic_inc(&dcc->issing_discard);
 
 			f2fs_update_iostat(sbi, FS_DISCARD, 1);
+		} else {
+			return __remove_discard_cmd(sbi, dc);
 		}
-	} else {
-		__remove_discard_cmd(sbi, dc);
+		lstart += len;
+		start += len;
+		total_len -= len;
+		len = total_len;
+		(*issued)++;
 	}
+
+	if (len)
+		__update_discard_tree_range(sbi, bdev, lstart, start, len);
 }
 
 static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
@@ -1097,10 +1133,11 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 	struct discard_cmd *dc;
 	struct discard_info di = {0};
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
+	struct request_queue *q = bdev_get_queue(bdev);
+	unsigned int max_discard_blocks =
+			SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
 	block_t end = lstart + len;
 
-	mutex_lock(&dcc->cmd_lock);
-
 	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
 					NULL, lstart,
 					(struct rb_entry **)&prev_dc,
@@ -1140,7 +1177,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 
 		if (prev_dc && prev_dc->state == D_PREP &&
 			prev_dc->bdev == bdev &&
-			__is_discard_back_mergeable(&di, &prev_dc->di)) {
+			__is_discard_back_mergeable(&di, &prev_dc->di,
+							max_discard_blocks)) {
 			prev_dc->di.len += di.len;
 			dcc->undiscard_blks += di.len;
 			__relocate_discard_cmd(dcc, prev_dc);
@@ -1151,7 +1189,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 
 		if (next_dc && next_dc->state == D_PREP &&
 			next_dc->bdev == bdev &&
-			__is_discard_front_mergeable(&di, &next_dc->di)) {
+			__is_discard_front_mergeable(&di, &next_dc->di,
+							max_discard_blocks)) {
 			next_dc->di.lstart = di.lstart;
 			next_dc->di.len += di.len;
 			next_dc->di.start = di.start;
@@ -1174,8 +1213,6 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 		node = rb_next(&prev_dc->rb_node);
 		next_dc = rb_entry_safe(node, struct discard_cmd, rb_node);
 	}
-
-	mutex_unlock(&dcc->cmd_lock);
 }
 
 static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
@@ -1190,7 +1227,9 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 
 		blkstart -= FDEV(devi).start_blk;
 	}
+	mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);
 	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
+	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
 	return 0;
 }
 
@@ -1229,9 +1268,9 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 		}
 
 		dcc->next_pos = dc->lstart + dc->len;
-		__submit_discard_cmd(sbi, dpolicy, dc);
+		__submit_discard_cmd(sbi, dpolicy, dc, &issued);
 
-		if (++issued >= dpolicy->max_requests)
+		if (issued >= dpolicy->max_requests)
 			break;
 next:
 		node = rb_next(&dc->rb_node);
@@ -1286,9 +1325,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 				break;
 			}
 
-			__submit_discard_cmd(sbi, dpolicy, dc);
+			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
 
-			if (++issued >= dpolicy->max_requests)
+			if (issued >= dpolicy->max_requests)
 				break;
 		}
 		blk_finish_plug(&plug);
@@ -2495,9 +2534,9 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			goto skip;
 		}
 
-		__submit_discard_cmd(sbi, dpolicy, dc);
+		__submit_discard_cmd(sbi, dpolicy, dc, &issued);
 
-		if (++issued >= dpolicy->max_requests) {
+		if (issued >= dpolicy->max_requests) {
 			start = dc->lstart + dc->len;
 
 			blk_finish_plug(&plug);
-- 
2.18.0

