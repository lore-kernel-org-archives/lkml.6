Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A0BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E6721A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa3ebTZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E6721A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbeHFRA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732258AbeHFRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:00:27 -0400
Received: from localhost.localdomain (unknown [49.77.238.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FBEE21A50;
        Mon,  6 Aug 2018 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533567059;
        bh=tWZ30dLVLFW3xwdtyBoNC3Z8nL23NfSyNYeE0AWgzf0=;
        h=From:To:Cc:Subject:Date:From;
        b=sa3ebTZfP0zIfZhFCDiQqbbpF3o/XCIbMyV4rMYwUE74JkHaTAbdEUPMIReXrZ/S1
         qUgOtwzLubFYZayv6qrXu4ug9FZEWnlyZo0aG7Q53OlqXQRE7//Mn3GYVy4bSuicsX
         H6DrnG7218a+Snu3K4jIqvxFELQRvQvfcijWIk0I=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v5] f2fs: split discard command in prior to block layer
Date:   Mon,  6 Aug 2018 22:43:50 +0800
Message-Id: <20180806144350.22625-1-chao@kernel.org>
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
v5:
- fix to add missing parenthese.
 fs/f2fs/f2fs.h    |  23 +++----
 fs/f2fs/segment.c | 148 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 127 insertions(+), 44 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ca23fbc8da30..a83ea4416e03 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -178,7 +178,6 @@ enum {
 
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
-#define DEF_MAX_DISCARD_LEN		512	/* Max. 2MB per discard */
 #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
 #define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
 #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
@@ -250,9 +249,10 @@ struct discard_entry {
 					(MAX_PLIST_NUM - 1) : (blk_num - 1))
 
 enum {
-	D_PREP,
-	D_SUBMIT,
-	D_DONE,
+	D_PREP,			/* initial */
+	D_PARTIAL,		/* partially submitted */
+	D_SUBMIT,		/* all submitted */
+	D_DONE,			/* finished */
 };
 
 struct discard_info {
@@ -277,7 +277,10 @@ struct discard_cmd {
 	struct block_device *bdev;	/* bdev */
 	unsigned short ref;		/* reference count */
 	unsigned char state;		/* state */
+	unsigned char issuing;		/* issuing discard */
 	int error;			/* bio error */
+	spinlock_t lock;		/* for state/bio_ref updating */
+	unsigned short bio_ref;		/* bio reference count */
 };
 
 enum {
@@ -710,22 +713,22 @@ static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
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
index 96f225b1596e..f93c37309bff 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -843,9 +843,12 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 	dc->len = len;
 	dc->ref = 0;
 	dc->state = D_PREP;
+	dc->issuing = 0;
 	dc->error = 0;
 	init_completion(&dc->wait);
 	list_add_tail(&dc->list, pend_list);
+	spin_lock_init(&dc->lock);
+	dc->bio_ref = 0;
 	atomic_inc(&dcc->discard_cmd_cnt);
 	dcc->undiscard_blks += len;
 
@@ -872,7 +875,7 @@ static void __detach_discard_cmd(struct discard_cmd_control *dcc,
 							struct discard_cmd *dc)
 {
 	if (dc->state == D_DONE)
-		atomic_dec(&dcc->issing_discard);
+		atomic_sub(dc->issuing, &dcc->issing_discard);
 
 	list_del(&dc->list);
 	rb_erase(&dc->rb_node, &dcc->root);
@@ -887,9 +890,17 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 							struct discard_cmd *dc)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	unsigned long flags;
 
 	trace_f2fs_remove_discard(dc->bdev, dc->start, dc->len);
 
+	spin_lock_irqsave(&dc->lock, flags);
+	if (dc->bio_ref) {
+		spin_unlock_irqrestore(&dc->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&dc->lock, flags);
+
 	f2fs_bug_on(sbi, dc->ref);
 
 	if (dc->error == -EOPNOTSUPP)
@@ -905,10 +916,17 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 static void f2fs_submit_discard_endio(struct bio *bio)
 {
 	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
+	unsigned long flags;
 
 	dc->error = blk_status_to_errno(bio->bi_status);
-	dc->state = D_DONE;
-	complete_all(&dc->wait);
+
+	spin_lock_irqsave(&dc->lock, flags);
+	dc->bio_ref--;
+	if (!dc->bio_ref && dc->state == D_SUBMIT) {
+		dc->state = D_DONE;
+		complete_all(&dc->wait);
+	}
+	spin_unlock_irqrestore(&dc->lock, flags);
 	bio_put(bio);
 }
 
@@ -976,17 +994,25 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
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
+	int err = 0;
 
 	if (dc->state != D_PREP)
 		return;
@@ -994,30 +1020,81 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
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
+	dc->len = 0;
+
+	while (total_len && *issued < dpolicy->max_requests && !err) {
+		struct bio *bio = NULL;
+		unsigned long flags;
+		bool last = true;
+
+		if (len > max_discard_blocks) {
+			len = max_discard_blocks;
+			last = false;
+		}
+
+		(*issued)++;
+		if (*issued == dpolicy->max_requests)
+			last = true;
+
+		dc->len += len;
+
+		err = __blkdev_issue_discard(bdev,
+					SECTOR_FROM_BLOCK(start),
+					SECTOR_FROM_BLOCK(len),
+					GFP_NOFS, 0, &bio);
+		if (!err && bio) {
+			/*
+			 * should keep before submission to avoid D_DONE
+			 * right away
+			 */
+			spin_lock_irqsave(&dc->lock, flags);
+			if (last)
+				dc->state = D_SUBMIT;
+			else
+				dc->state = D_PARTIAL;
+			dc->bio_ref++;
+			spin_unlock_irqrestore(&dc->lock, flags);
+
+			atomic_inc(&dcc->issing_discard);
+			dc->issuing++;
+			list_move_tail(&dc->list, wait_list);
+
+			/* sanity check on discard range */
+			__check_sit_bitmap(sbi, start, start + len);
+
 			bio->bi_private = dc;
 			bio->bi_end_io = f2fs_submit_discard_endio;
 			bio->bi_opf |= flag;
 			submit_bio(bio);
-			list_move_tail(&dc->list, wait_list);
-			__check_sit_bitmap(sbi, dc->start, dc->start + dc->len);
+
+			atomic_inc(&dcc->issued_discard);
 
 			f2fs_update_iostat(sbi, FS_DISCARD, 1);
+		} else {
+			spin_lock_irqsave(&dc->lock, flags);
+			if (dc->state == D_PARTIAL)
+				dc->state = D_SUBMIT;
+			spin_unlock_irqrestore(&dc->lock, flags);
+
+			__remove_discard_cmd(sbi, dc);
+			err = -EIO;
 		}
-	} else {
-		__remove_discard_cmd(sbi, dc);
+
+		lstart += len;
+		start += len;
+		total_len -= len;
+		len = total_len;
 	}
+
+	if (len)
+		__update_discard_tree_range(sbi, bdev, lstart, start, len);
 }
 
 static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
@@ -1098,10 +1175,11 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
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
@@ -1141,7 +1219,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 
 		if (prev_dc && prev_dc->state == D_PREP &&
 			prev_dc->bdev == bdev &&
-			__is_discard_back_mergeable(&di, &prev_dc->di)) {
+			__is_discard_back_mergeable(&di, &prev_dc->di,
+							max_discard_blocks)) {
 			prev_dc->di.len += di.len;
 			dcc->undiscard_blks += di.len;
 			__relocate_discard_cmd(dcc, prev_dc);
@@ -1152,7 +1231,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 
 		if (next_dc && next_dc->state == D_PREP &&
 			next_dc->bdev == bdev &&
-			__is_discard_front_mergeable(&di, &next_dc->di)) {
+			__is_discard_front_mergeable(&di, &next_dc->di,
+							max_discard_blocks)) {
 			next_dc->di.lstart = di.lstart;
 			next_dc->di.len += di.len;
 			next_dc->di.start = di.start;
@@ -1175,8 +1255,6 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 		node = rb_next(&prev_dc->rb_node);
 		next_dc = rb_entry_safe(node, struct discard_cmd, rb_node);
 	}
-
-	mutex_unlock(&dcc->cmd_lock);
 }
 
 static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
@@ -1191,7 +1269,9 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 
 		blkstart -= FDEV(devi).start_blk;
 	}
+	mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);
 	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
+	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
 	return 0;
 }
 
@@ -1230,9 +1310,9 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 		}
 
 		dcc->next_pos = dc->lstart + dc->len;
-		__submit_discard_cmd(sbi, dpolicy, dc);
+		__submit_discard_cmd(sbi, dpolicy, dc, &issued);
 
-		if (++issued >= dpolicy->max_requests)
+		if (issued >= dpolicy->max_requests)
 			break;
 next:
 		node = rb_next(&dc->rb_node);
@@ -1287,9 +1367,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 				break;
 			}
 
-			__submit_discard_cmd(sbi, dpolicy, dc);
+			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
 
-			if (++issued >= dpolicy->max_requests)
+			if (issued >= dpolicy->max_requests)
 				break;
 		}
 		blk_finish_plug(&plug);
@@ -2496,9 +2576,9 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
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

