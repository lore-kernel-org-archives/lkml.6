Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AE8C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A17321783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548719264;
	bh=5wr3OjB2Bvgymvp8BY/evJIrtugqR+HZMfiCwFQhYkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uB2JqrZWXJeFODGUWJgU6MAQ5fHOyJxspiubxNDb6VMJPfMJ/bBJ9HpqqHsfIj0ZZ
	 txDK6zFjkxk840bFurao8pKO/jbVla8v36I45wDNh8Xsqlr9oeplKsWS9y40HgG8xc
	 iPHps4kkz7ucRSNVjlWSAYrGltfVFegEOKcH3AFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfA1Xrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:47:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbfA1Xrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:47:39 -0500
Received: from localhost (203-69-98-252.HINET-IP.hinet.net [203.69.98.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EB952171F;
        Mon, 28 Jan 2019 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548719258;
        bh=5wr3OjB2Bvgymvp8BY/evJIrtugqR+HZMfiCwFQhYkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QaXW7/wRAJblOhdwTFeisJAhHGH1m4IolJ2BOlLICKEo+4dpvHLVCzBCPZMNotmEL
         FlaQuztJbyC+2QNOG68LOiyIslcQYl74/fQIbzJQmPCy9JYqTybcgHQ/mRtjhNX3QB
         gq/tJ2UVFO9nqZ5RqDNkZOfpqmYVn4GCw4qpKzBs=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 7/7] f2fs: sync filesystem after roll-forward recovery
Date:   Tue, 29 Jan 2019 07:47:17 +0800
Message-Id: <20190128234717.77225-7-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
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
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  5 +++--
 fs/f2fs/node.c       |  4 +++-
 fs/f2fs/super.c      | 44 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 622dca707752..03fea4efd64b 100644
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
index 7694cb350734..384d1c248857 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1458,9 +1458,16 @@ static int f2fs_enable_quotas(struct super_block *sb);
 
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
@@ -1468,18 +1475,24 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
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
@@ -1488,7 +1501,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	sbi->unusable_block_count = 0;
 	mutex_unlock(&sbi->gc_mutex);
-	return 0;
+restore_flag:
+	sbi->sb->s_flags = s_flags;	/* Restore MS_RDONLY status */
+	return err;
 }
 
 static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
@@ -3369,7 +3384,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = f2fs_disable_checkpoint(sbi);
 		if (err)
-			goto free_meta;
+			goto sync_free_meta;
 	} else if (is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)) {
 		f2fs_enable_checkpoint(sbi);
 	}
@@ -3382,7 +3397,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		/* After POR, we can run background GC thread.*/
 		err = f2fs_start_gc_thread(sbi);
 		if (err)
-			goto free_meta;
+			goto sync_free_meta;
 	}
 	kvfree(options);
 
@@ -3405,6 +3420,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	clear_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
 	return 0;
 
+sync_free_meta:
+	/* safe to flush all the data */
+	sync_filesystem(sbi->sb);
+	retry = false;
+
 free_meta:
 #ifdef CONFIG_QUOTA
 	f2fs_truncate_quota_inode_pages(sb);
@@ -3418,6 +3438,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * falls into an infinite loop in f2fs_sync_meta_pages().
 	 */
 	truncate_inode_pages_final(META_MAPPING(sbi));
+	/* evict some inodes being cached by GC */
+	evict_inodes(sb);
 	f2fs_unregister_sysfs(sbi);
 free_root_inode:
 	dput(sb->s_root);
-- 
2.19.0.605.g01d371f741-goog

