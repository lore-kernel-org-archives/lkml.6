Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4914EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EFB21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0ENEA4CT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EFB21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeHXT6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbeHXT6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:58:51 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27DB42156B;
        Fri, 24 Aug 2018 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535127809;
        bh=1sSk+Kwr4bkln3nxOljgWzmay0UcOoVVThgSzjHSlBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ENEA4CT60ctysne0vUoP/BFNtvUuJreQacHOLP4V2gz6iCTvQFU0OcGaRRE53vPK
         sifsws/dMisQiOFGdiSa0DuUXpkryD6xJwRf79ipuz8SxcaMjNnvQLor4ynakLcrED
         l0FB0CDeY0tPlPaT8OAe7q1HZkkb+MgQG71Nk9q4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [RFC PATCH 03/10] fs-verity: implement FS_IOC_ENABLE_VERITY ioctl
Date:   Fri, 24 Aug 2018 09:16:35 -0700
Message-Id: <20180824161642.1144-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824161642.1144-1-ebiggers@kernel.org>
References: <20180824161642.1144-1-ebiggers@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a function for filesystems to call to implement the
FS_IOC_ENABLE_VERITY ioctl.  This ioctl performs various validations
(e.g., checking that the file isn't open for writing), then calls back
into the filesystem to set the verity bit on the inode.

This ioctl is used to mark a file as being fs-verity protected, after
userspace has appended the Merkle tree and other metadata to the file.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/Makefile       |   2 +-
 fs/verity/ioctl.c        | 121 +++++++++++++++++++++++++++++++++++++++
 include/linux/fsverity.h |  11 ++++
 3 files changed, 133 insertions(+), 1 deletion(-)
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
index 0000000000000..993f2afdcc734
--- /dev/null
+++ b/fs/verity/ioctl.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fs/verity/ioctl.c: fs-verity ioctls
+ *
+ * Copyright (C) 2018 Google LLC
+ *
+ * Originally written by Jaegeuk Kim and Michael Halcrow;
+ * heavily rewritten by Eric Biggers.
+ */
+
+#include "fsverity_private.h"
+
+#include <linux/capability.h>
+#include <linux/mm.h>
+#include <linux/mount.h>
+#include <linux/uaccess.h>
+
+/**
+ * fsverity_ioctl_enable - enable fs-verity on a file
+ *
+ * Set the verity bit on a file.  Userspace must have already appended verity
+ * metadata to the file.
+ *
+ * Enabling fs-verity makes the file contents immutable, and the filesystem
+ * doesn't allow disabling it (other than by replacing the file).
+ *
+ * To avoid races with the file contents being modified, no processes must have
+ * the file open for writing.  This includes the caller!
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int fsverity_ioctl_enable(struct file *filp, const void __user *arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct fsverity_info *vi;
+	int err;
+
+	/*
+	 * In principle we need only check 'inode_owner_or_capable(inode)',
+	 * which would allow non-root users to enable fs-verity on their own
+	 * files.  But to be conservative, for now restrict this to root-only.
+	 */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
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
+	/* Set the verity bit */
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
index 56341f10aa965..c710b6b5fb4a6 100644
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
@@ -35,6 +38,14 @@ extern void fsverity_enqueue_verify_work(struct work_struct *work);
 
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
2.18.0

