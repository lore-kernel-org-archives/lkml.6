Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeEGIrd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:47:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33521 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeEGIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:31 -0400
X-Google-Smtp-Source: AB8JxZqKTVNokt3N/W23kVecJD0L64mZ0EAaBKbzhWyESydBrqFtNxDr9BNUniX6knSRh050E6WDrw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/35] ovl: add ovl_fsync()
Date: Mon,  7 May 2018 10:37:47 +0200
Message-Id: <20180507083807.28792-16-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement stacked fsync().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index a7af56861aa5..419aa3f9967b 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -233,10 +233,30 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fd real;
+	const struct cred *old_cred;
+	int ret;
+
+	ret = ovl_real_fdget(file, &real);
+	if (ret)
+		return ret;
+
+	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = vfs_fsync_range(real.file, start, end, datasync);
+	revert_creds(old_cred);
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
 	.read_iter	= ovl_read_iter,
 	.write_iter	= ovl_write_iter,
+	.fsync		= ovl_fsync,
 };
-- 
2.14.3
