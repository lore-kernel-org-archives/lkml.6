Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEC0C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286B12152A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286B12152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeHHEcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:32:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbeHHEcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:32:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EABAF55AA2B62;
        Wed,  8 Aug 2018 10:15:11 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 10:15:07 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix use-after-free of dicard command entry
Date:   Wed, 8 Aug 2018 10:14:55 +0800
Message-ID: <20180808021455.109291-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Dan Carpenter reported:

The patch 20ee4382322c: "f2fs: issue small discard by LBA order" from
Jul 8, 2018, leads to the following Smatch warning:

	fs/f2fs/segment.c:1277 __issue_discard_cmd_orderly()
	warn: 'dc' was already freed.

See also:
fs/f2fs/segment.c:2550 __issue_discard_cmd_range() warn: 'dc' was already freed.

In order to fix this issue, let's get error from __submit_discard_cmd(),
and release current discard command after we referenced next one.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 79 +++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index be1bf38400ca..8826ea683804 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -998,7 +998,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 				struct block_device *bdev, block_t lstart,
 				block_t start, block_t len);
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
-static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
+static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 						struct discard_policy *dpolicy,
 						struct discard_cmd *dc,
 						unsigned int *issued)
@@ -1015,10 +1015,10 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	int err = 0;
 
 	if (dc->state != D_PREP)
-		return;
+		return 0;
 
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
-		return;
+		return 0;
 
 	trace_f2fs_issue_discard(bdev, dc->start, dc->len);
 
@@ -1057,43 +1057,44 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 					SECTOR_FROM_BLOCK(len),
 					GFP_NOFS, 0, &bio);
 submit:
-		if (!err && bio) {
-			/*
-			 * should keep before submission to avoid D_DONE
-			 * right away
-			 */
+		if (err) {
 			spin_lock_irqsave(&dc->lock, flags);
-			if (last)
+			if (dc->state == D_PARTIAL)
 				dc->state = D_SUBMIT;
-			else
-				dc->state = D_PARTIAL;
-			dc->bio_ref++;
 			spin_unlock_irqrestore(&dc->lock, flags);
 
-			atomic_inc(&dcc->issing_discard);
-			dc->issuing++;
-			list_move_tail(&dc->list, wait_list);
+			break;
+		}
 
-			/* sanity check on discard range */
-			__check_sit_bitmap(sbi, start, start + len);
+		f2fs_bug_on(sbi, !bio);
 
-			bio->bi_private = dc;
-			bio->bi_end_io = f2fs_submit_discard_endio;
-			bio->bi_opf |= flag;
-			submit_bio(bio);
+		/*
+		 * should keep before submission to avoid D_DONE
+		 * right away
+		 */
+		spin_lock_irqsave(&dc->lock, flags);
+		if (last)
+			dc->state = D_SUBMIT;
+		else
+			dc->state = D_PARTIAL;
+		dc->bio_ref++;
+		spin_unlock_irqrestore(&dc->lock, flags);
 
-			atomic_inc(&dcc->issued_discard);
+		atomic_inc(&dcc->issing_discard);
+		dc->issuing++;
+		list_move_tail(&dc->list, wait_list);
 
-			f2fs_update_iostat(sbi, FS_DISCARD, 1);
-		} else {
-			spin_lock_irqsave(&dc->lock, flags);
-			if (dc->state == D_PARTIAL)
-				dc->state = D_SUBMIT;
-			spin_unlock_irqrestore(&dc->lock, flags);
+		/* sanity check on discard range */
+		__check_sit_bitmap(sbi, start, start + len);
 
-			__remove_discard_cmd(sbi, dc);
-			err = -EIO;
-		}
+		bio->bi_private = dc;
+		bio->bi_end_io = f2fs_submit_discard_endio;
+		bio->bi_opf |= flag;
+		submit_bio(bio);
+
+		atomic_inc(&dcc->issued_discard);
+
+		f2fs_update_iostat(sbi, FS_DISCARD, 1);
 
 		lstart += len;
 		start += len;
@@ -1101,8 +1102,9 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		len = total_len;
 	}
 
-	if (len)
+	if (!err && len)
 		__update_discard_tree_range(sbi, bdev, lstart, start, len);
+	return err;
 }
 
 static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
@@ -1308,6 +1310,7 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 
 	while (dc) {
 		struct rb_node *node;
+		int err = 0;
 
 		if (dc->state != D_PREP)
 			goto next;
@@ -1318,12 +1321,14 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 		}
 
 		dcc->next_pos = dc->lstart + dc->len;
-		__submit_discard_cmd(sbi, dpolicy, dc, &issued);
+		err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
 
 		if (issued >= dpolicy->max_requests)
 			break;
 next:
 		node = rb_next(&dc->rb_node);
+		if (err)
+			__remove_discard_cmd(sbi, dc);
 		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
 	}
 
@@ -2577,6 +2582,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 	while (dc && dc->lstart <= end) {
 		struct rb_node *node;
+		int err = 0;
 
 		if (dc->len < dpolicy->granularity)
 			goto skip;
@@ -2586,11 +2592,14 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			goto skip;
 		}
 
-		__submit_discard_cmd(sbi, dpolicy, dc, &issued);
+		err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
 
 		if (issued >= dpolicy->max_requests) {
 			start = dc->lstart + dc->len;
 
+			if (err)
+				__remove_discard_cmd(sbi, dc);
+
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
 			trimmed += __wait_all_discard_cmd(sbi, NULL);
@@ -2599,6 +2608,8 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 		}
 skip:
 		node = rb_next(&dc->rb_node);
+		if (err)
+			__remove_discard_cmd(sbi, dc);
 		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
 
 		if (fatal_signal_pending(current))
-- 
2.18.0.rc1

