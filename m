Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1FFC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF0A20840
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAPcJtF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF0A20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeKBH7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbeKBH7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:59:17 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFBAE2084C;
        Thu,  1 Nov 2018 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541112857;
        bh=b3QHRP8YQqlEGz0tStooS8qoUx6+xZnHbUaWpaBLfuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAPcJtF3Hzy88pY/EPlY6QG8e40f21qSv7o1jvok3nWI9vAt/Rj8d+2k+a+B0CsgH
         rlUcL0W5z23YgF2OikvUnIkvArKLODb54l4L+LK6kWfSkF5j+sbWfIaBMEZYWjywtq
         Gy/Jwi5EajAGtsDvBxJbL7/S9lmiIpY7qL7QtFS4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH v2 05/12] fs-verity: implement FS_IOC_ENABLE_VERITY ioctl
Date:   Thu,  1 Nov 2018 15:52:23 -0700
Message-Id: <20181101225230.88058-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181101225230.88058-1-ebiggers@kernel.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a function for filesystems to call to implement the
FS_IOC_ENABLE_VERITY ioctl.  This ioctl enables fs-verity on a file,
after userspace has appended verity metadata to it.

This ioctl is documented in Documentation/filesystem/fsverity.rst;
see there for more information.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/Makefile       |   2 +-
 fs/verity/ioctl.c        | 117 +++++++++++++++++++++++++++++++++++++++
 include/linux/fsverity.h |  11 ++++
 3 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 fs/verity/ioctl.c

diff --git a/fs/verity/Makefile b/fs/verity/Makefile
index a6c7cefb61ab7..6450925e3a8b7 100644
--- a/fs/verity/Makefile
+++ b/fs/verity/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_FS_VERITY)	+= fsverity.o
 
-fsverity-y := hash_algs.o setup.o verify.o
+fsverity-y := hash_algs.o ioctl.o setup.o verify.o
diff --git a/fs/verity/ioctl.c b/fs/verity/ioctl.c
new file mode 100644
index 0000000000000..c5f0022cb3bef
--- /dev/null
+++ b/fs/verity/ioctl.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fs/verity/ioctl.c: fs-verity ioctls
+ *
+ * Copyright 2018 Google LLC
+ *
+ * Originally written by Jaegeuk Kim and Michael Halcrow;
+ * heavily rewritten by Eric Biggers.
+ */
+
+#include "fsverity_private.h"
+
+#include <linux/mm.h>
+#include <linux/mount.h>
+#include <linux/uaccess.h>
+
+/**
+ * fsverity_ioctl_enable - enable fs-verity on a file
+ *
+ * Enable fs-verity on a file.  Verity metadata must have already been appended
+ * to the file.  See Documentation/filesystems/fsverity.rst, section
+ * 'FS_IOC_ENABLE_VERITY' for details.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int fsverity_ioctl_enable(struct file *filp, const void __user *arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct fsverity_info *vi;
+	int err;
+
+	err = inode_permission(inode, MAY_WRITE);
+	if (err)
+		return err;
+
+	if (IS_APPEND(inode))
+		return -EPERM;
+
+	if (arg) /* argument is reserved */
+		return -EINVAL;
+
+	if (S_ISDIR(inode->i_mode))
+		return -EISDIR;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	err = mnt_want_write_file(filp);
+	if (err)
+		goto out;
+
+	/*
+	 * Temporarily lock out writers via writable file descriptors or
+	 * truncate().  This should stabilize the contents of the file as well
+	 * as its size.  Note that at the end of this ioctl we will unlock
+	 * writers, but at that point the verity bit will be set (if the ioctl
+	 * succeeded), preventing future writers.
+	 */
+	err = deny_write_access(filp);
+	if (err) /* -ETXTBSY */
+		goto out_drop_write;
+
+	/*
+	 * fsync so that the verity bit can't be persisted to disk prior to the
+	 * data, causing verification errors after a crash.
+	 */
+	err = vfs_fsync(filp, 1);
+	if (err)
+		goto out_allow_write;
+
+	/* Serialize concurrent use of this ioctl on the same inode */
+	inode_lock(inode);
+
+	if (get_fsverity_info(inode)) { /* fs-verity already enabled? */
+		err = -EEXIST;
+		goto out_unlock;
+	}
+
+	/* Validate the verity metadata */
+	vi = create_fsverity_info(inode, true);
+	if (IS_ERR(vi)) {
+		err = PTR_ERR(vi);
+		if (err == -EINVAL) /* distinguish "invalid metadata" case */
+			err = -EBADMSG;
+		goto out_unlock;
+	}
+
+	/*
+	 * Ask the filesystem to mark the file as a verity file, e.g. by setting
+	 * the verity bit in the inode.
+	 */
+	err = inode->i_sb->s_vop->set_verity(inode, vi->data_i_size);
+	if (err)
+		goto out_free_vi;
+
+	/* Invalidate all cached pages, forcing re-verification */
+	truncate_inode_pages(inode->i_mapping, 0);
+
+	/*
+	 * Set ->i_verity_info, unless another task managed to do it already
+	 * between ->set_verity() and here.
+	 */
+	if (set_fsverity_info(inode, vi))
+		vi = NULL;
+	err = 0;
+out_free_vi:
+	free_fsverity_info(vi);
+out_unlock:
+	inode_unlock(inode);
+out_allow_write:
+	allow_write_access(filp);
+out_drop_write:
+	mnt_drop_write_file(filp);
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(fsverity_ioctl_enable);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 15478fe7d55aa..5de50b52ccc70 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -21,6 +21,9 @@ struct fsverity_operations {
 
 #if __FS_HAS_VERITY
 
+/* ioctl.c */
+extern int fsverity_ioctl_enable(struct file *filp, const void __user *arg);
+
 /* setup.c */
 extern int fsverity_file_open(struct inode *inode, struct file *filp);
 extern int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
@@ -40,6 +43,14 @@ static inline bool fsverity_check_hole(struct inode *inode, struct page *page)
 
 #else /* !__FS_HAS_VERITY */
 
+/* ioctl.c */
+
+static inline int fsverity_ioctl_enable(struct file *filp,
+					const void __user *arg)
+{
+	return -EOPNOTSUPP;
+}
+
 /* setup.c */
 
 static inline int fsverity_file_open(struct inode *inode, struct file *filp)
-- 
2.19.1.568.g152ad8e336-goog

