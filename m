Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E54C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B2C217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548201760;
	bh=9jFY1FOOu2PmQUONlzapd2mhdLt0P/sf+j7CzeZl0rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Txmqvf+BM6KeJXY3BLhGS9rOqp+Y1K7UmcPebYfHkVUtqa13n1dMwfqFJ5ylXvMIM
	 wAfxUH8dzmr3/Zxb5XsPxysxgf5KdCaFI5PbZSwV25dRDb6mu3EpkCRjOk1O+aNZA8
	 dw8n6P+w7LcuZtsRs2KjYgJvMwsoEj9jMbYtzmBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfAWACi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfAWACc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:02:32 -0500
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A71A217D4;
        Wed, 23 Jan 2019 00:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548201751;
        bh=9jFY1FOOu2PmQUONlzapd2mhdLt0P/sf+j7CzeZl0rU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnL1Mn4QEPcbpSJPmMBTnyywH1UhXi4Mk3xzD4TSu2wdWi8IAz8xLgyIho88tOTy+
         YbsL1M7+zKjR2shHeiauIjlxQ74WPpAcTsWIriZf4PU4+xkusBG1Dsp/REYvMKA1gq
         dFhXjD6Voz4/7+N8J+AW+Gmy1cu0fS5b0uHkWyQg=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: sync filesystem after roll-forward recovery
Date:   Tue, 22 Jan 2019 16:02:29 -0800
Message-Id: <20190123000229.45236-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20190123000229.45236-1-jaegeuk@kernel.org>
References: <20190123000229.45236-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some works after roll-forward recovery can get an error which will release
all the data structures. Let's flush them in order to make it clean.

One possible corruption came from:

[   90.400500] list_del corruption. prev->next should be ffffffed1f566208, but was (null)
[   90.675349] Call trace:
[   90.677869]  __list_del_entry_valid+0x94/0xb4
[   90.682351]  remove_dirty_inode+0xac/0x114
[   90.686563]  __f2fs_write_data_pages+0x6a8/0x6c8
[   90.691302]  f2fs_write_data_pages+0x40/0x4c
[   90.695695]  do_writepages+0x80/0xf0
[   90.699372]  __writeback_single_inode+0xdc/0x4ac
[   90.704113]  writeback_sb_inodes+0x280/0x440
[   90.708501]  wb_writeback+0x1b8/0x3d0
[   90.712267]  wb_workfn+0x1a8/0x4d4
[   90.715765]  process_one_work+0x1c0/0x3d4
[   90.719883]  worker_thread+0x224/0x344
[   90.723739]  kthread+0x120/0x130
[   90.727055]  ret_from_fork+0x10/0x18

Reported-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  5 +++--
 fs/f2fs/node.c       |  4 +++-
 fs/f2fs/super.c      | 42 +++++++++++++++++++++++++++++++-----------
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f955cd3e0677..ccccf0ce2f06 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -306,8 +306,9 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 		goto skip_write;
 
 	/* collect a number of dirty meta pages and write together */
-	if (wbc->for_kupdate ||
-		get_pages(sbi, F2FS_DIRTY_META) < nr_pages_to_skip(sbi, META))
+	if (wbc->sync_mode != WB_SYNC_ALL &&
+			get_pages(sbi, F2FS_DIRTY_META) <
+					nr_pages_to_skip(sbi, META))
 		goto skip_write;
 
 	/* if locked failed, cp will flush dirty pages instead */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4f450e573312..f6ff84e29749 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1920,7 +1920,9 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	f2fs_balance_fs_bg(sbi);
 
 	/* collect a number of dirty node pages and write together */
-	if (get_pages(sbi, F2FS_DIRTY_NODES) < nr_pages_to_skip(sbi, NODE))
+	if (wbc->sync_mode != WB_SYNC_ALL &&
+			get_pages(sbi, F2FS_DIRTY_NODES) <
+					nr_pages_to_skip(sbi, NODE))
 		goto skip_write;
 
 	if (wbc->sync_mode == WB_SYNC_ALL)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7998ff5418f2..2af0db2b738e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1456,9 +1456,16 @@ static int f2fs_enable_quotas(struct super_block *sb);
 
 static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 {
+	unsigned int s_flags = sbi->sb->s_flags;
 	struct cp_control cpc;
-	int err;
+	int err = 0;
+	int ret;
 
+	if (s_flags & SB_RDONLY) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+				"checkpoint=disable on readonly fs");
+		return -EINVAL;
+	}
 	sbi->sb->s_flags |= SB_ACTIVE;
 
 	f2fs_update_time(sbi, DISABLE_TIME);
@@ -1466,18 +1473,24 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
 		mutex_lock(&sbi->gc_mutex);
 		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
-		if (err == -ENODATA)
+		if (err == -ENODATA) {
+			err = 0;
 			break;
+		}
 		if (err && err != -EAGAIN)
-			return err;
+			break;
 	}
 
-	err = sync_filesystem(sbi->sb);
-	if (err)
-		return err;
+	ret = sync_filesystem(sbi->sb);
+	if (ret || err) {
+		err = ret ? ret: err;
+		goto restore_flag;
+	}
 
-	if (f2fs_disable_cp_again(sbi))
-		return -EAGAIN;
+	if (f2fs_disable_cp_again(sbi)) {
+		err = -EAGAIN;
+		goto restore_flag;
+	}
 
 	mutex_lock(&sbi->gc_mutex);
 	cpc.reason = CP_PAUSE;
@@ -1486,7 +1499,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	sbi->unusable_block_count = 0;
 	mutex_unlock(&sbi->gc_mutex);
-	return 0;
+restore_flag:
+	sbi->sb->s_flags = s_flags;	/* Restore MS_RDONLY status */
+	return err;
 }
 
 static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
@@ -3356,7 +3371,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = f2fs_disable_checkpoint(sbi);
 		if (err)
-			goto free_meta;
+			goto sync_free_meta;
 	} else if (is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)) {
 		f2fs_enable_checkpoint(sbi);
 	}
@@ -3369,7 +3384,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		/* After POR, we can run background GC thread.*/
 		err = f2fs_start_gc_thread(sbi);
 		if (err)
-			goto free_meta;
+			goto sync_free_meta;
 	}
 	kvfree(options);
 
@@ -3391,6 +3406,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
 
+sync_free_meta:
+	/* safe to flush all the data */
+	sync_filesystem(sbi->sb);
+	retry = false;
+
 free_meta:
 #ifdef CONFIG_QUOTA
 	f2fs_truncate_quota_inode_pages(sb);
-- 
2.19.0.605.g01d371f741-goog

