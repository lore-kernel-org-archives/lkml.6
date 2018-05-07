Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeEGIV2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:21:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53440 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeEGIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:21:16 -0400
X-Google-Smtp-Source: AB8JxZrkALPPA6fOFNUW578SwTjvGqScD9m9Gk6mW/8swsEJmlTuFUFkYoq7puD92GEt3OYvFf/XGQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 1/3] vfs: dedpue: return s64
Date: Mon,  7 May 2018 10:21:06 +0200
Message-Id: <20180507082108.28186-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507082108.28186-1-mszeredi@redhat.com>
References: <20180507082108.28186-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f_op->dedupe_file_range() gets a u64 length to dedup and returns an ssize_t
actual length deduped.  This breaks badly on 32bit archs since the returned
length will be truncated and possibly overflow into the sign bit (xfs and
ocfs2 are affected, btrfs limits actual length to 16MiB).

Returning s64 should be good, since clone_verify_area() makes sure that the
supplied length doesn't overflow.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/btrfs/ctree.h   |  4 ++--
 fs/btrfs/ioctl.c   |  6 +++---
 fs/ocfs2/file.c    | 10 +++++-----
 fs/read_write.c    |  2 +-
 fs/xfs/xfs_file.c  |  2 +-
 include/linux/fs.h |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2771cc56a622..019a25962ac8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3269,8 +3269,8 @@ void btrfs_get_block_group_info(struct list_head *groups_list,
 				struct btrfs_ioctl_space_info *space);
 void update_ioctl_balance_args(struct btrfs_fs_info *fs_info, int lock,
 			       struct btrfs_ioctl_balance_args *bargs);
-ssize_t btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 olen,
-			   struct file *dst_file, u64 dst_loff);
+s64 btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 olen,
+			    struct file *dst_file, u64 dst_loff);
 
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 632e26d6f7ce..b6a1df6bb895 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3194,13 +3194,13 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 
 #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 
-ssize_t btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 olen,
-				struct file *dst_file, u64 dst_loff)
+s64 btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 olen,
+			    struct file *dst_file, u64 dst_loff)
 {
 	struct inode *src = file_inode(src_file);
 	struct inode *dst = file_inode(dst_file);
 	u64 bs = BTRFS_I(src)->root->fs_info->sb->s_blocksize;
-	ssize_t res;
+	int res;
 
 	if (olen > BTRFS_MAX_DEDUPE_LEN)
 		olen = BTRFS_MAX_DEDUPE_LEN;
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 6ee94bc23f5b..cf3732df4c2e 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2537,11 +2537,11 @@ static int ocfs2_file_clone_range(struct file *file_in,
 					 len, false);
 }
 
-static ssize_t ocfs2_file_dedupe_range(struct file *src_file,
-				       u64 loff,
-				       u64 len,
-				       struct file *dst_file,
-				       u64 dst_loff)
+static s64 ocfs2_file_dedupe_range(struct file *src_file,
+				   u64 loff,
+				   u64 len,
+				   struct file *dst_file,
+				   u64 dst_loff)
 {
 	int error;
 
diff --git a/fs/read_write.c b/fs/read_write.c
index c4eabbfc90df..6a79c7ec2bb2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1976,7 +1976,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	u16 count = same->dest_count;
 	struct file *dst_file;
 	loff_t dst_off;
-	ssize_t deduped;
+	s64 deduped;
 
 	if (!(file->f_mode & FMODE_READ))
 		return -EINVAL;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 299aee4b7b0b..d06dd1557d0e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -868,7 +868,7 @@ xfs_file_clone_range(
 				     len, false);
 }
 
-STATIC ssize_t
+STATIC s64
 xfs_file_dedupe_range(
 	struct file	*src_file,
 	u64		loff,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 760d8da1b6c7..6feb121ae48c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1738,7 +1738,7 @@ struct file_operations {
 			loff_t, size_t, unsigned int);
 	int (*clone_file_range)(struct file *, loff_t, struct file *, loff_t,
 			u64);
-	ssize_t (*dedupe_file_range)(struct file *, u64, u64, struct file *,
+	s64 (*dedupe_file_range)(struct file *, u64, u64, struct file *,
 			u64);
 } __randomize_layout;
 
-- 
2.14.3
