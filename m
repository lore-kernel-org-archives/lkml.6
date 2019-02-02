Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FCC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FDA20869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfBBJdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:33:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfBBJdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:33:33 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8E5E872899CCFB8C6034;
        Sat,  2 Feb 2019 17:33:30 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Sat, 2 Feb 2019 17:33:20 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs: fix potential data inconsistence of checkpoint
Date:   Sat, 2 Feb 2019 17:33:01 +0800
Message-ID: <20190202093301.64677-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we changed lock from cp_rwsem to node_change, it solved
the deadlock issue which was caused by below race condition:

Thread A			Thread B
- f2fs_setattr
 - f2fs_lock_op  -- read_lock
 - dquot_transfer
  - __dquot_transfer
   - dquot_acquire
    - commit_dqblk
     - f2fs_quota_write
      - f2fs_write_begin
       - f2fs_write_failed
				- write_checkpoint
				 - block_operations
				  - f2fs_lock_all  -- write_lock
        - f2fs_truncate_blocks
         - f2fs_lock_op  -- read_lock

But it breaks the sematics of cp_rwsem, in other callers like:
- f2fs_file_write_iter -> f2fs_write_begin -> f2fs_write_failed
- f2fs_direct_IO -> f2fs_write_failed

We allow to truncate dnode w/o cp_rwsem held, result in incorrect sit
bitmap update, which can cause further data corruption.

So this patch reverts previous fix implementation, and try to fix
deadlock by skipping calling f2fs_truncate_blocks() in f2fs_write_failed()
only for quota file, and keep the preallocated data/node in the tail of
quota file, we can expecte that the preallocated space can be used to
store quota info latter soon.

Fixes: af033b2aa8a8 ("f2fs: guarantee journalled quota data by checkpoint")
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c   |  3 ++-
 fs/f2fs/f2fs.h   |  3 +--
 fs/f2fs/file.c   | 14 ++++++--------
 fs/f2fs/inline.c |  4 ++--
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 77068acc8001..18ebafa2f83e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2404,7 +2404,8 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 		down_write(&F2FS_I(inode)->i_mmap_sem);
 
 		truncate_pagecache(inode, i_size);
-		f2fs_truncate_blocks(inode, i_size, true, true);
+		if (!IS_NOQUOTA(inode))
+			f2fs_truncate_blocks(inode, i_size, true);
 
 		up_write(&F2FS_I(inode)->i_mmap_sem);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5ccf55eaa514..b0eb8174a13d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2825,8 +2825,7 @@ static inline bool is_valid_data_blkaddr(struct f2fs_sb_info *sbi,
  */
 int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
 void f2fs_truncate_data_blocks(struct dnode_of_data *dn);
-int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock,
-							bool buf_write);
+int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate(struct inode *inode);
 int f2fs_getattr(const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int flags);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fe6f92fbba38..b8f5d1208619 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -589,8 +589,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 	return 0;
 }
 
-int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock,
-							bool buf_write)
+int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
@@ -598,7 +597,6 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock,
 	int count = 0, err = 0;
 	struct page *ipage;
 	bool truncate_page = false;
-	int flag = buf_write ? F2FS_GET_BLOCK_PRE_AIO : F2FS_GET_BLOCK_PRE_DIO;
 
 	trace_f2fs_truncate_blocks_enter(inode, from);
 
@@ -608,7 +606,7 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock,
 		goto free_partial;
 
 	if (lock)
-		__do_map_lock(sbi, flag, true);
+		f2fs_lock_op(sbi);
 
 	ipage = f2fs_get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(ipage)) {
@@ -646,7 +644,7 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock,
 	err = f2fs_truncate_inode_blocks(inode, free_from);
 out:
 	if (lock)
-		__do_map_lock(sbi, flag, false);
+		f2fs_unlock_op(sbi);
 free_partial:
 	/* lastly zero out the first data page */
 	if (!err)
@@ -681,7 +679,7 @@ int f2fs_truncate(struct inode *inode)
 			return err;
 	}
 
-	err = f2fs_truncate_blocks(inode, i_size_read(inode), true, false);
+	err = f2fs_truncate_blocks(inode, i_size_read(inode), true);
 	if (err)
 		return err;
 
@@ -1262,7 +1260,7 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	new_size = i_size_read(inode) - len;
 	truncate_pagecache(inode, new_size);
 
-	ret = f2fs_truncate_blocks(inode, new_size, true, false);
+	ret = f2fs_truncate_blocks(inode, new_size, true);
 	up_write(&F2FS_I(inode)->i_mmap_sem);
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
@@ -1447,7 +1445,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_balance_fs(sbi, true);
 
 	down_write(&F2FS_I(inode)->i_mmap_sem);
-	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true, false);
+	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true);
 	up_write(&F2FS_I(inode)->i_mmap_sem);
 	if (ret)
 		return ret;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d636cbcf68f2..a1381d05956b 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -298,7 +298,7 @@ bool f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 		clear_inode_flag(inode, FI_INLINE_DATA);
 		f2fs_put_page(ipage, 1);
 	} else if (ri && (ri->i_inline & F2FS_INLINE_DATA)) {
-		if (f2fs_truncate_blocks(inode, 0, false, false))
+		if (f2fs_truncate_blocks(inode, 0, false))
 			return false;
 		goto process_inline;
 	}
@@ -470,7 +470,7 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 	return 0;
 punch_dentry_pages:
 	truncate_inode_pages(&dir->i_data, 0);
-	f2fs_truncate_blocks(dir, 0, false, false);
+	f2fs_truncate_blocks(dir, 0, false);
 	f2fs_remove_dirty_inode(dir);
 	return err;
 }
-- 
2.18.0.rc1

