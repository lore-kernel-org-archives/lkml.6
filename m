Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeDLPUU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:20:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55565 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbeDLPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:08:50 -0400
X-Google-Smtp-Source: AIpwx4/PCFeHUSkYEkEBIlqthpoN8vG3e/CTuUPoBKxDgqIdS3tmQCnWzo3SBYV0NCJnWdeg4dsbNw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/35] ovl: readd fallocate
Date: Thu, 12 Apr 2018 17:08:06 +0200
Message-Id: <20180412150826.20988-16-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement stacked fallocate.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index f1cc2fdc62c1..05e3e2f80b89 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -268,6 +268,29 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 	return ret;
 }
 
+long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+{
+	struct inode *inode = file_inode(file);
+	struct fd real;
+	const struct cred *old_cred;
+	int ret;
+
+	ret = ovl_real_file(file, &real);
+	if (ret)
+		return ret;
+
+	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = vfs_fallocate(real.file, mode, offset, len);
+	revert_creds(old_cred);
+
+	/* Update size */
+	ovl_copyattr(ovl_inode_real(inode), inode);
+
+	fdput(real);
+
+	return ret;
+}
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
@@ -276,4 +299,5 @@ const struct file_operations ovl_file_operations = {
 	.write_iter	= ovl_write_iter,
 	.fsync		= ovl_fsync,
 	.mmap		= ovl_mmap,
+	.fallocate	= ovl_fallocate,
 };
-- 
2.14.3
