Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964854AbeE2O6e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:58:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39398 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936531AbeE2OqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:23 -0400
X-Google-Smtp-Source: ADUXVKK7yOXRFaZumHQMDzHMe7EBhSDvMpUiIoTwAcZQyoefcLLF1FYbT3IKu/RzIMPb2UWyWIhEeA==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/28] ovl: Add helper ovl_already_copied_up()
Date: Tue, 29 May 2018 16:45:50 +0200
Message-Id: <20180529144612.16675-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Goyal <vgoyal@redhat.com>

There are couple of places where we need to know if file is already copied
up (in lockless manner).  Right now its open coded and there are only two
conditions to check.  Soon this patch series will introduce another
condition to check and Amir wants to introduce one more.  So introduce a
helper instead to check this so that code is easier to read.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c   | 20 ++------------------
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/util.c      | 26 +++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 38cfd1acc196..6247617fea0b 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -761,21 +761,7 @@ int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		struct dentry *next;
 		struct dentry *parent = NULL;
 
-		/*
-		 * Check if copy-up has happened as well as for upper alias (in
-		 * case of hard links) is there.
-		 *
-		 * Both checks are lockless:
-		 *  - false negatives: will recheck under oi->lock
-		 *  - false positives:
-		 *    + ovl_dentry_upper() uses memory barriers to ensure the
-		 *      upper dentry is up-to-date
-		 *    + ovl_dentry_has_upper_alias() relies on locking of
-		 *      upper parent i_rwsem to prevent reordering copy-up
-		 *      with rename.
-		 */
-		if (ovl_dentry_upper(dentry) &&
-		    (ovl_dentry_has_upper_alias(dentry) || disconnected))
+		if (ovl_already_copied_up(dentry))
 			break;
 
 		next = dget(dentry);
@@ -803,9 +789,7 @@ int ovl_copy_up_flags(struct dentry *dentry, int flags)
 static bool ovl_open_need_copy_up(struct dentry *dentry, int flags)
 {
 	/* Copy up of disconnected dentry does not set upper alias */
-	if (ovl_dentry_upper(dentry) &&
-	    (ovl_dentry_has_upper_alias(dentry) ||
-	     (dentry->d_flags & DCACHE_DISCONNECTED)))
+	if (ovl_already_copied_up(dentry))
 		return false;
 
 	if (special_file(d_inode(dentry)->i_mode))
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 9172d3d5d870..2a9c5a80ae48 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -238,6 +238,7 @@ bool ovl_is_whiteout(struct dentry *dentry);
 struct file *ovl_path_open(struct path *path, int flags);
 int ovl_copy_up_start(struct dentry *dentry);
 void ovl_copy_up_end(struct dentry *dentry);
+bool ovl_already_copied_up(struct dentry *dentry);
 bool ovl_check_origin_xattr(struct dentry *dentry);
 bool ovl_check_dir_xattr(struct dentry *dentry, const char *name);
 int ovl_check_setxattr(struct dentry *dentry, struct dentry *upperdentry,
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 25d202b47326..43235294e77b 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -377,13 +377,37 @@ struct file *ovl_path_open(struct path *path, int flags)
 	return dentry_open(path, flags | O_NOATIME, current_cred());
 }
 
+bool ovl_already_copied_up(struct dentry *dentry)
+{
+	bool disconnected = dentry->d_flags & DCACHE_DISCONNECTED;
+
+	/*
+	 * Check if copy-up has happened as well as for upper alias (in
+	 * case of hard links) is there.
+	 *
+	 * Both checks are lockless:
+	 *  - false negatives: will recheck under oi->lock
+	 *  - false positives:
+	 *    + ovl_dentry_upper() uses memory barriers to ensure the
+	 *      upper dentry is up-to-date
+	 *    + ovl_dentry_has_upper_alias() relies on locking of
+	 *      upper parent i_rwsem to prevent reordering copy-up
+	 *      with rename.
+	 */
+	if (ovl_dentry_upper(dentry) &&
+	    (ovl_dentry_has_upper_alias(dentry) || disconnected))
+		return true;
+
+	return false;
+}
+
 int ovl_copy_up_start(struct dentry *dentry)
 {
 	struct ovl_inode *oi = OVL_I(d_inode(dentry));
 	int err;
 
 	err = mutex_lock_interruptible(&oi->lock);
-	if (!err && ovl_dentry_has_upper_alias(dentry)) {
+	if (!err && ovl_already_copied_up(dentry)) {
 		err = 1; /* Already copied up */
 		mutex_unlock(&oi->lock);
 	}
-- 
2.14.3
