Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeEGIVj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:21:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32922 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeEGIVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:21:17 -0400
X-Google-Smtp-Source: AB8JxZqyxrRRoI0lPuIVgm4w+ZyOZmypa/xaBy3fRWQsfDYJ3xR2y7oc0N7ZGiWuOQYQlxVmgJEFng==
From: Miklos Szeredi <mszeredi@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 2/3] vfs: dedupe: rationalize args
Date: Mon,  7 May 2018 10:21:07 +0200
Message-Id: <20180507082108.28186-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507082108.28186-1-mszeredi@redhat.com>
References: <20180507082108.28186-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up f_op->dedupe_file_range() interface.

1) Use loff_t for offsets instead of u64
2) Order the arguments the same way as {copy|clone}_file_range().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/btrfs/ctree.h   | 4 ++--
 fs/btrfs/ioctl.c   | 4 ++--
 fs/ocfs2/file.c    | 6 +++---
 fs/read_write.c    | 4 ++--
 fs/xfs/xfs_file.c  | 6 +++---
 include/linux/fs.h | 2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 019a25962ac8..a8f1ab69158b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3269,8 +3269,8 @@ void btrfs_get_block_group_info(struct list_head *groups_list,
 				struct btrfs_ioctl_space_info *space);
 void update_ioctl_balance_args(struct btrfs_fs_info *fs_info, int lock,
 			       struct btrfs_ioctl_balance_args *bargs);
-s64 btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 olen,
-			    struct file *dst_file, u64 dst_loff);
+s64 btrfs_dedupe_file_range(struct file *src_file, loff_t loff,
+			    struct file *dst_file, loff_t dst_loff, u64 olen);
 
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b6a1df6bb895..10658c0a5ac9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3194,8 +3194,8 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 
 #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 
-s64 btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 olen,
-			    struct file *dst_file, u64 dst_loff)
+s64 btrfs_dedupe_file_range(struct file *src_file, loff_t loff,
+			    struct file *dst_file, loff_t dst_loff, u64 olen)
 {
 	struct inode *src = file_inode(src_file);
 	struct inode *dst = file_inode(dst_file);
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index cf3732df4c2e..00656f4b6059 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2538,10 +2538,10 @@ static int ocfs2_file_clone_range(struct file *file_in,
 }
 
 static s64 ocfs2_file_dedupe_range(struct file *src_file,
-				   u64 loff,
-				   u64 len,
+				   loff_t loff,
 				   struct file *dst_file,
-				   u64 dst_loff)
+				   loff_t dst_loff,
+				   u64 len)
 {
 	int error;
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 6a79c7ec2bb2..0cdef381d9d9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -2046,8 +2046,8 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 			info->status = -EINVAL;
 		} else {
 			deduped = dst_file->f_op->dedupe_file_range(file, off,
-							len, dst_file,
-							info->dest_offset);
+							dst_file,
+							info->dest_offset, len);
 			if (deduped == -EBADE)
 				info->status = FILE_DEDUPE_RANGE_DIFFERS;
 			else if (deduped < 0)
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index d06dd1557d0e..e2620a00d132 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -871,10 +871,10 @@ xfs_file_clone_range(
 STATIC s64
 xfs_file_dedupe_range(
 	struct file	*src_file,
-	u64		loff,
-	u64		len,
+	loff_t		loff,
 	struct file	*dst_file,
-	u64		dst_loff)
+	loff_t		dst_loff,
+	u64		len)
 {
 	int		error;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6feb121ae48c..8007a31c4d3c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1738,7 +1738,7 @@ struct file_operations {
 			loff_t, size_t, unsigned int);
 	int (*clone_file_range)(struct file *, loff_t, struct file *, loff_t,
 			u64);
-	s64 (*dedupe_file_range)(struct file *, u64, u64, struct file *,
+	s64 (*dedupe_file_range)(struct file *, loff_t, struct file *, loff_t,
 			u64);
 } __randomize_layout;
 
-- 
2.14.3
