Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id j70PACzQGlsaEgAAmS7hNA
	; Fri, 08 Jun 2018 18:53:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 233D2607DC; Fri,  8 Jun 2018 18:53:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5E9996074D;
	Fri,  8 Jun 2018 18:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E9996074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeFHSw5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:52:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53794 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeFHSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSp-0006Nb-Q6; Fri, 08 Jun 2018 18:50:19 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] get rid of 'opened' argument of finish_open()
Date: Fri,  8 Jun 2018 19:50:10 +0100
Message-Id: <20180608185019.24472-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

We only deal with opened & FILE_OPENED in it and it's parallel to
file->f_mode & FMODE_OPENED.  So let the callers deal with the latter
instead.  Most of the call chains go through fs/namei.c:atomic_open()
and do not look at FILE_OPENED between the return from finish_open()
and return to atomic_open(), which reduces the size of patch nicely -
we propagate to *opened in atomic_open() and that leaves us with
do_tmpfile() (where we do the same) and gfs2_atomic_open() (where we
check ->f_mode instead of *opened).

Signed-off-by Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/lustre/lustre/llite/namei.c |  2 +-
 fs/9p/vfs_inode.c                           |  2 +-
 fs/9p/vfs_inode_dotl.c                      |  2 +-
 fs/ceph/file.c                              |  2 +-
 fs/cifs/dir.c                               |  2 +-
 fs/fuse/dir.c                               |  2 +-
 fs/gfs2/inode.c                             |  8 ++++----
 fs/namei.c                                  |  6 +++++-
 fs/nfs/dir.c                                |  2 +-
 fs/open.c                                   | 14 ++++----------
 include/linux/fs.h                          |  3 +--
 11 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
index 6c9ec462eb41..b47bda601ead 100644
--- a/drivers/staging/lustre/lustre/llite/namei.c
+++ b/drivers/staging/lustre/lustre/llite/namei.c
@@ -748,7 +748,7 @@ static int ll_atomic_open(struct inode *dir, struct dentry *dentry,
 				rc = finish_no_open(file, de);
 			} else {
 				file->private_data = it;
-				rc = finish_open(file, dentry, NULL, opened);
+				rc = finish_open(file, dentry, NULL);
 				/* We dget in ll_splice_alias. finish_open takes
 				 * care of dget for fd open.
 				 */
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 9ee534159cc6..d719d7fe92ce 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -922,7 +922,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		v9inode->writeback_fid = (void *) inode_fid;
 	}
 	mutex_unlock(&v9inode->v_mutex);
-	err = finish_open(file, dentry, generic_file_open, opened);
+	err = finish_open(file, dentry, generic_file_open);
 	if (err)
 		goto error;
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 7f6ae21a27b3..0b79872848c1 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -352,7 +352,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	}
 	mutex_unlock(&v9inode->v_mutex);
 	/* Since we are opening a file, assign the open fid to the file */
-	err = finish_open(file, dentry, generic_file_open, opened);
+	err = finish_open(file, dentry, generic_file_open);
 	if (err)
 		goto err_clunk_old_fid;
 	file->private_data = ofid;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f85040d73e3d..4f2aa53c4ff6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -474,7 +474,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			ceph_init_inode_acls(d_inode(dentry), &acls);
 			*opened |= FILE_CREATED;
 		}
-		err = finish_open(file, dentry, ceph_open, opened);
+		err = finish_open(file, dentry, ceph_open);
 	}
 out_req:
 	if (!req->r_err && req->r_target_inode)
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 81ba6e0d88d8..ca8fc209af6d 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -541,7 +541,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
 		*opened |= FILE_CREATED;
 
-	rc = finish_open(file, direntry, generic_file_open, opened);
+	rc = finish_open(file, direntry, generic_file_open);
 	if (rc) {
 		if (server->ops->close)
 			server->ops->close(xid, tcon, &fid);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 24967382a7b1..18952cd38772 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -469,7 +469,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	d_instantiate(entry, inode);
 	fuse_change_entry_timeout(entry, &outentry);
 	fuse_invalidate_attr(dir);
-	err = finish_open(file, entry, generic_file_open, opened);
+	err = finish_open(file, entry, generic_file_open);
 	if (err) {
 		fuse_sync_release(ff, flags);
 	} else {
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8700eb815638..7bb236b99598 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -626,7 +626,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		error = 0;
 		if (file) {
 			if (S_ISREG(inode->i_mode))
-				error = finish_open(file, dentry, gfs2_open_common, opened);
+				error = finish_open(file, dentry, gfs2_open_common);
 			else
 				error = finish_no_open(file, NULL);
 		}
@@ -768,7 +768,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	d_instantiate(dentry, inode);
 	if (file) {
 		*opened |= FILE_CREATED;
-		error = finish_open(file, dentry, gfs2_open_common, opened);
+		error = finish_open(file, dentry, gfs2_open_common);
 	}
 	gfs2_glock_dq_uninit(ghs);
 	gfs2_glock_dq_uninit(ghs + 1);
@@ -866,7 +866,7 @@ static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
 		return d;
 	}
 	if (file && S_ISREG(inode->i_mode))
-		error = finish_open(file, dentry, gfs2_open_common, opened);
+		error = finish_open(file, dentry, gfs2_open_common);
 
 	gfs2_glock_dq_uninit(&gh);
 	if (error) {
@@ -1250,7 +1250,7 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (d != NULL)
 		dentry = d;
 	if (d_really_is_positive(dentry)) {
-		if (!(*opened & FILE_OPENED))
+		if (!(file->f_mode & FMODE_OPENED))
 			return finish_no_open(file, d);
 		dput(d);
 		return 0;
diff --git a/fs/namei.c b/fs/namei.c
index 4eb916996345..b34ead1b8790 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3027,6 +3027,8 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 		 * permission here.
 		 */
 		int acc_mode = op->acc_mode;
+		if (file->f_mode & FMODE_OPENED)
+			*opened |= FILE_OPENED;
 		if (*opened & FILE_CREATED) {
 			WARN_ON(!(open_flag & O_CREAT));
 			fsnotify_create(dir, dentry);
@@ -3446,9 +3448,11 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	if (error)
 		goto out2;
 	file->f_path.mnt = path.mnt;
-	error = finish_open(file, child, NULL, opened);
+	error = finish_open(file, child, NULL);
 	if (error)
 		goto out2;
+	if (file->f_mode & FMODE_OPENED)
+		*opened |= FILE_OPENED;
 	error = open_check_o_direct(file);
 	if (error)
 		fput(file);
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 73f8b43d988c..5b8f1d32d6b8 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1423,7 +1423,7 @@ static int nfs_finish_open(struct nfs_open_context *ctx,
 {
 	int err;
 
-	err = finish_open(file, dentry, do_open, opened);
+	err = finish_open(file, dentry, do_open);
 	if (err)
 		goto out;
 	if (S_ISREG(file->f_path.dentry->d_inode->i_mode))
diff --git a/fs/open.c b/fs/open.c
index b3b1dbf0227d..83e489d43526 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -742,7 +742,7 @@ static int do_dentry_open(struct file *f,
 	static const struct file_operations empty_fops = {};
 	int error;
 
-	f->f_mode = OPEN_FMODE(f->f_flags) | FMODE_LSEEK |
+	f->f_mode |= OPEN_FMODE(f->f_flags) | FMODE_LSEEK |
 				FMODE_PREAD | FMODE_PWRITE;
 
 	path_get(&f->f_path);
@@ -848,19 +848,13 @@ static int do_dentry_open(struct file *f,
  * Returns zero on success or -errno if the open failed.
  */
 int finish_open(struct file *file, struct dentry *dentry,
-		int (*open)(struct inode *, struct file *),
-		int *opened)
+		int (*open)(struct inode *, struct file *))
 {
-	int error;
-	BUG_ON(*opened & FILE_OPENED); /* once it's opened, it's opened */
+	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 
 	file->f_path.dentry = dentry;
-	error = do_dentry_open(file, d_backing_inode(dentry), open,
+	return do_dentry_open(file, d_backing_inode(dentry), open,
 			       current_cred());
-	if (!error)
-		*opened |= FILE_OPENED;
-
-	return error;
 }
 EXPORT_SYMBOL(finish_open);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 105f071d4732..a7c090c2b6b9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2417,8 +2417,7 @@ enum {
 	FILE_OPENED = 2
 };
 extern int finish_open(struct file *file, struct dentry *dentry,
-			int (*open)(struct inode *, struct file *),
-			int *opened);
+			int (*open)(struct inode *, struct file *));
 extern int finish_no_open(struct file *file, struct dentry *dentry);
 
 /* fs/ioctl.c */
-- 
2.11.0
