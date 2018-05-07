Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeEGM3Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:29:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751937AbeEGM3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:29:15 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/3] f2fs: fix to initialize i_current_depth according to inode type
Date: Mon, 7 May 2018 20:28:52 +0800
Message-ID: <20180507122854.91506-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i_current_depth is used only for directory inode, but its space is
shared with i_gc_failures field used for regular inode, in order to
avoid affecting i_gc_failures' value, this patch fixes to initialize
the union's fields according to inode type.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- rebase code.
 fs/f2fs/inode.c | 12 +++++++++---
 fs/f2fs/namei.c |  3 +++
 fs/f2fs/super.c |  1 -
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 7f2fe4574c48..3a74a1cf3264 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -232,8 +232,10 @@ static int do_read_inode(struct inode *inode)
 	inode->i_ctime.tv_nsec = le32_to_cpu(ri->i_ctime_nsec);
 	inode->i_mtime.tv_nsec = le32_to_cpu(ri->i_mtime_nsec);
 	inode->i_generation = le32_to_cpu(ri->i_generation);
-
-	fi->i_current_depth = le32_to_cpu(ri->i_current_depth);
+	if (S_ISDIR(inode->i_mode))
+		fi->i_current_depth = le32_to_cpu(ri->i_current_depth);
+	else if (S_ISREG(inode->i_mode))
+		fi->i_gc_failures = le16_to_cpu(ri->i_gc_failures);
 	fi->i_xattr_nid = le32_to_cpu(ri->i_xattr_nid);
 	fi->i_flags = le32_to_cpu(ri->i_flags);
 	fi->flags = 0;
@@ -422,7 +424,11 @@ void update_inode(struct inode *inode, struct page *node_page)
 	ri->i_atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
 	ri->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
 	ri->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
-	ri->i_current_depth = cpu_to_le32(F2FS_I(inode)->i_current_depth);
+	if (S_ISDIR(inode->i_mode))
+		ri->i_current_depth =
+			cpu_to_le32(F2FS_I(inode)->i_current_depth);
+	else if (S_ISREG(inode->i_mode))
+		ri->i_gc_failures = cpu_to_le16(F2FS_I(inode)->i_gc_failures);
 	ri->i_xattr_nid = cpu_to_le32(F2FS_I(inode)->i_xattr_nid);
 	ri->i_flags = cpu_to_le32(F2FS_I(inode)->i_flags);
 	ri->i_pino = cpu_to_le32(F2FS_I(inode)->i_pino);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index fef6e3ab2135..bcfc4219b29e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -54,6 +54,9 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 			F2FS_I(inode)->i_crtime = current_time(inode);
 	inode->i_generation = sbi->s_next_generation++;
 
+	if (S_ISDIR(inode->i_mode))
+		F2FS_I(inode)->i_current_depth = 1;
+
 	err = insert_inode_locked(inode);
 	if (err) {
 		err = -EINVAL;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 294be9e92aee..55ccc2eaaa2e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -826,7 +826,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 	/* Initialize f2fs-specific inode info */
 	atomic_set(&fi->dirty_pages, 0);
-	fi->i_current_depth = 1;
 	init_rwsem(&fi->i_sem);
 	INIT_LIST_HEAD(&fi->dirty_list);
 	INIT_LIST_HEAD(&fi->gdirty_list);
-- 
2.17.0.391.g1f1cddd558b5
