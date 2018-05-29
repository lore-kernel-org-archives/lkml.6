Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936533AbeE2PLl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:11:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36027 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935657AbeE2OoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:06 -0400
X-Google-Smtp-Source: ADUXVKIH9tpYZOjJYoOmunUkjsjhdM0R7y2NluoF9HwtbxeBqfy/l3lMUkCnqVR6NTArvseuIApNDg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/39] ovl: add ovl_fallocate()
Date: Tue, 29 May 2018 16:43:20 +0200
Message-Id: <20180529144339.16538-21-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement stacked fallocate.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4057bbf2e141..069599d53511 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -282,6 +282,29 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 	return ret;
 }
 
+static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+{
+	struct inode *inode = file_inode(file);
+	struct fd real;
+	const struct cred *old_cred;
+	int ret;
+
+	ret = ovl_real_fdget(file, &real);
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
@@ -290,4 +313,5 @@ const struct file_operations ovl_file_operations = {
 	.write_iter	= ovl_write_iter,
 	.fsync		= ovl_fsync,
 	.mmap		= ovl_mmap,
+	.fallocate	= ovl_fallocate,
 };
-- 
2.14.3
