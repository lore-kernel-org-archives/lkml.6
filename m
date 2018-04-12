Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbeDLPVr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:21:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38287 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeDLPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:08:46 -0400
X-Google-Smtp-Source: AIpwx4/RIlkiOGUBNUVHSUFieK/OjD+/587duMNddpNF3eopwZ0K0dBG5JlPguzTU0jyC2q2Q6n41A==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/35] ovl: readd read_iter
Date: Thu, 12 Apr 2018 17:08:02 +0200
Message-Id: <20180412150826.20988-12-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement stacked reading.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 409b542ff30c..a19429c5965d 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -9,6 +9,7 @@
 #include <linux/cred.h>
 #include <linux/file.h>
 #include <linux/xattr.h>
+#include <linux/uio.h>
 #include "overlayfs.h"
 
 static struct file *ovl_open_realfile(const struct file *file)
@@ -129,8 +130,63 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 					i_size_read(realinode));
 }
 
+static void ovl_file_accessed(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	if ((file->f_flags & O_NOATIME) || !ovl_inode_upper(inode))
+		return;
+
+	ovl_copytimes(inode);
+	touch_atime(&file->f_path);
+}
+
+static rwf_t ovl_iocb_to_rwf(struct kiocb *iocb)
+{
+	int ifl = iocb->ki_flags;
+	rwf_t flags = 0;
+
+	if (ifl & IOCB_NOWAIT)
+		flags |= RWF_NOWAIT;
+	if (ifl & IOCB_HIPRI)
+		flags |= RWF_HIPRI;
+	if (ifl & IOCB_DSYNC)
+		flags |= RWF_DSYNC;
+	if (ifl & IOCB_SYNC)
+		flags |= RWF_SYNC;
+
+	return flags;
+}
+
+static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct fd real;
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	ret = ovl_real_file(file, &real);
+	if (ret)
+		return ret;
+
+	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
+			    ovl_iocb_to_rwf(iocb));
+	revert_creds(old_cred);
+
+	ovl_file_accessed(file);
+
+	fdput(real);
+
+	return ret;
+}
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
 	.llseek		= ovl_llseek,
+	.read_iter	= ovl_read_iter,
 };
-- 
2.14.3
