Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936433AbeE2PMY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:12:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32909 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935637AbeE2OoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:05 -0400
X-Google-Smtp-Source: AB8JxZpK+qaFTivMpgOm/2kcHbdct471nz7CeKcTVhdXsIyU+t9HbzfcLPm1YQCDTZ9bA7pbJ8zDJA==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/39] ovl: add ovl_mmap()
Date: Tue, 29 May 2018 16:43:19 +0200
Message-Id: <20180529144339.16538-20-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement stacked mmap.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7b47dce4b072..4057bbf2e141 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -255,6 +255,33 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	return ret;
 }
 
+static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct fd real;
+	const struct cred *old_cred;
+	int ret;
+
+	ret = ovl_real_fdget(file, &real);
+	if (ret)
+		return ret;
+
+	/* transfer ref: */
+	fput(vma->vm_file);
+	vma->vm_file = get_file(real.file);
+	fdput(real);
+
+	if (!vma->vm_file->f_op->mmap)
+		return -ENODEV;
+
+	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = call_mmap(vma->vm_file, vma);
+	revert_creds(old_cred);
+
+	ovl_file_accessed(file);
+
+	return ret;
+}
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
@@ -262,4 +289,5 @@ const struct file_operations ovl_file_operations = {
 	.read_iter	= ovl_read_iter,
 	.write_iter	= ovl_write_iter,
 	.fsync		= ovl_fsync,
+	.mmap		= ovl_mmap,
 };
-- 
2.14.3
