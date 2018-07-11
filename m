Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FB5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6F9208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6F9208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732837AbeGKC0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:26:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45600 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732422AbeGKCYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lc-0003JT-8Q; Wed, 11 Jul 2018 02:22:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 20/42] getting rid of 'opened' argument of ->atomic_open() - step 1
Date:   Wed, 11 Jul 2018 03:21:44 +0100
Message-Id: <20180711022206.12571-20-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

'opened' argument of finish_open() is unused.  Kill it.

Signed-off-by Al Viro <viro@zeniv.linux.org.uk>
---
 fs/9p/vfs_inode.c      | 2 +-
 fs/9p/vfs_inode_dotl.c | 2 +-
 fs/ceph/file.c         | 2 +-
 fs/cifs/dir.c          | 2 +-
 fs/fuse/dir.c          | 2 +-
 fs/gfs2/inode.c        | 6 +++---
 fs/namei.c             | 2 +-
 fs/nfs/dir.c           | 2 +-
 fs/open.c              | 3 +--
 include/linux/fs.h     | 3 +--
 10 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 566929792480..7b6ff3275d9c 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -917,7 +917,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		v9inode->writeback_fid = (void *) inode_fid;
 	}
 	mutex_unlock(&v9inode->v_mutex);
-	err = finish_open(file, dentry, generic_file_open, opened);
+	err = finish_open(file, dentry, generic_file_open);
 	if (err)
 		goto error;
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ee65db5c7eb0..c6939b7cb18c 100644
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
index 38a63fff7903..38b28cb2fac1 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -509,7 +509,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			ceph_init_inode_acls(d_inode(dentry), &acls);
 			file->f_mode |= FMODE_CREATED;
 		}
-		err = finish_open(file, dentry, ceph_open, opened);
+		err = finish_open(file, dentry, ceph_open);
 	}
 out_req:
 	if (!req->r_err && req->r_target_inode)
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 21d7e393900e..891bfd62e67a 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -541,7 +541,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
 		file->f_mode |= FMODE_CREATED;
 
-	rc = finish_open(file, direntry, generic_file_open, opened);
+	rc = finish_open(file, direntry, generic_file_open);
 	if (rc) {
 		if (server->ops->close)
 			server->ops->close(xid, tcon, &fid);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d4bdcf51e6cb..a5b1f5ff8cb7 100644
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
index 4aba00a6004b..59f695e96d63 100644
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
 		file->f_mode |= FMODE_CREATED;
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
diff --git a/fs/namei.c b/fs/namei.c
index 3abb91e23718..cc412d0620a3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3475,7 +3475,7 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	if (error)
 		goto out2;
 	file->f_path.mnt = path.mnt;
-	error = finish_open(file, child, NULL, opened);
+	error = finish_open(file, child, NULL);
 out2:
 	mnt_drop_write(path.mnt);
 out:
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0ac50983fc4e..22176a3818d5 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1439,7 +1439,7 @@ static int nfs_finish_open(struct nfs_open_context *ctx,
 {
 	int err;
 
-	err = finish_open(file, dentry, do_open, opened);
+	err = finish_open(file, dentry, do_open);
 	if (err)
 		goto out;
 	if (S_ISREG(file->f_path.dentry->d_inode->i_mode))
diff --git a/fs/open.c b/fs/open.c
index e8ae46a740b6..a46ba6647562 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -846,8 +846,7 @@ static int do_dentry_open(struct file *f,
  * Returns zero on success or -errno if the open failed.
  */
 int finish_open(struct file *file, struct dentry *dentry,
-		int (*open)(struct inode *, struct file *),
-		int *opened)
+		int (*open)(struct inode *, struct file *))
 {
 	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ca668c7e48a7..70be3e4c26ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2441,8 +2441,7 @@ enum {
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

