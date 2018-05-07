Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeEGIVi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:21:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39834 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752023AbeEGIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:21:18 -0400
X-Google-Smtp-Source: AB8JxZqrKqtUcsuo63zKkxz5LCNue3l6liHQ404hqTnr0WOjniTA8RoHO6KH5SIpmayBbWL0lPQUlg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 3/3] vfs: dedupe: extract helper for a single dedup
Date: Mon,  7 May 2018 10:21:08 +0200
Message-Id: <20180507082108.28186-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507082108.28186-1-mszeredi@redhat.com>
References: <20180507082108.28186-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract vfs_dedupe_file_range_one() helper to deal with a single dedup
request.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/read_write.c | 89 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0cdef381d9d9..023df230e2a0 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1964,6 +1964,44 @@ int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 }
 EXPORT_SYMBOL(vfs_dedupe_file_range_compare);
 
+static s64 vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
+				     struct file *dst_file, loff_t dst_pos,
+				     u64 len)
+{
+	s64 ret;
+
+	ret = mnt_want_write_file(dst_file);
+	if (ret)
+		return ret;
+
+	ret = clone_verify_area(dst_file, dst_pos, len, true);
+	if (ret < 0)
+		goto out_drop_write;
+
+	ret = -EINVAL;
+	if (!(capable(CAP_SYS_ADMIN) || (dst_file->f_mode & FMODE_WRITE)))
+		goto out_drop_write;
+
+	ret = -EXDEV;
+	if (src_file->f_path.mnt != dst_file->f_path.mnt)
+		goto out_drop_write;
+
+	ret = -EISDIR;
+	if (S_ISDIR(file_inode(dst_file)->i_mode))
+		goto out_drop_write;
+
+	ret = -EINVAL;
+	if (!dst_file->f_op->dedupe_file_range)
+		goto out_drop_write;
+
+	ret = dst_file->f_op->dedupe_file_range(src_file, src_pos,
+						dst_file, dst_pos, len);
+out_drop_write:
+	mnt_drop_write_file(dst_file);
+
+	return ret;
+}
+
 int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 {
 	struct file_dedupe_range_info *info;
@@ -1972,10 +2010,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	u64 len;
 	int i;
 	int ret;
-	bool is_admin = capable(CAP_SYS_ADMIN);
 	u16 count = same->dest_count;
-	struct file *dst_file;
-	loff_t dst_off;
 	s64 deduped;
 
 	if (!(file->f_mode & FMODE_READ))
@@ -2010,54 +2045,28 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	}
 
 	for (i = 0, info = same->info; i < count; i++, info++) {
-		struct inode *dst;
 		struct fd dst_fd = fdget(info->dest_fd);
+		struct file *dst_file = dst_fd.file;
 
-		dst_file = dst_fd.file;
 		if (!dst_file) {
 			info->status = -EBADF;
 			goto next_loop;
 		}
-		dst = file_inode(dst_file);
-
-		ret = mnt_want_write_file(dst_file);
-		if (ret) {
-			info->status = ret;
-			goto next_loop;
-		}
-
-		dst_off = info->dest_offset;
-		ret = clone_verify_area(dst_file, dst_off, len, true);
-		if (ret < 0) {
-			info->status = ret;
-			goto next_file;
-		}
-		ret = 0;
 
 		if (info->reserved) {
 			info->status = -EINVAL;
-		} else if (!(is_admin || (dst_file->f_mode & FMODE_WRITE))) {
-			info->status = -EINVAL;
-		} else if (file->f_path.mnt != dst_file->f_path.mnt) {
-			info->status = -EXDEV;
-		} else if (S_ISDIR(dst->i_mode)) {
-			info->status = -EISDIR;
-		} else if (dst_file->f_op->dedupe_file_range == NULL) {
-			info->status = -EINVAL;
-		} else {
-			deduped = dst_file->f_op->dedupe_file_range(file, off,
-							dst_file,
-							info->dest_offset, len);
-			if (deduped == -EBADE)
-				info->status = FILE_DEDUPE_RANGE_DIFFERS;
-			else if (deduped < 0)
-				info->status = deduped;
-			else
-				info->bytes_deduped += deduped;
+			goto next_loop;
 		}
 
-next_file:
-		mnt_drop_write_file(dst_file);
+		deduped = vfs_dedupe_file_range_one(file, off, dst_file,
+						    info->dest_offset, len);
+		if (deduped == -EBADE)
+			info->status = FILE_DEDUPE_RANGE_DIFFERS;
+		else if (deduped < 0)
+			info->status = deduped;
+		else
+			info->bytes_deduped += deduped;
+
 next_loop:
 		fdput(dst_fd);
 
-- 
2.14.3
