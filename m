Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9ZWPJO/PGlu1EAAAmS7hNA
	; Fri, 08 Jun 2018 18:51:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 58382607E7; Fri,  8 Jun 2018 18:51:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 93292607DC;
	Fri,  8 Jun 2018 18:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93292607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeFHSvp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:51:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53814 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeFHSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSq-0006O5-DH; Fri, 08 Jun 2018 18:50:20 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] introduce FMODE_CREATED and switch to it
Date: Fri,  8 Jun 2018 19:50:15 +0100
Message-Id: <20180608185019.24472-9-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Parallel to FILE_CREATED, goes into ->f_mode instead of *opened.
NFS is a bit of a wart here - it doesn't have file at the point
where FILE_CREATED used to be set, so we need to propagate it
there (for now).  IMA is another one (here and everywhere)...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/lustre/lustre/llite/namei.c |  2 +-
 fs/9p/vfs_inode.c                           |  2 +-
 fs/9p/vfs_inode_dotl.c                      |  2 +-
 fs/ceph/file.c                              |  2 +-
 fs/cifs/dir.c                               |  2 +-
 fs/fuse/dir.c                               |  2 +-
 fs/gfs2/inode.c                             |  2 +-
 fs/namei.c                                  | 15 ++++++++-------
 fs/nfs/dir.c                                |  5 ++++-
 fs/nfs/nfs4proc.c                           |  2 +-
 include/linux/fs.h                          |  1 +
 11 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
index b47bda601ead..72376af0d4b5 100644
--- a/drivers/staging/lustre/lustre/llite/namei.c
+++ b/drivers/staging/lustre/lustre/llite/namei.c
@@ -735,7 +735,7 @@ static int ll_atomic_open(struct inode *dir, struct dentry *dentry,
 				goto out_release;
 			}
 
-			*opened |= FILE_CREATED;
+			file->f_mode |= FMODE_CREATED;
 		}
 		if (d_really_is_positive(dentry) &&
 		    it_disposition(it, DISP_OPEN_OPEN)) {
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index d719d7fe92ce..6d6af0109cf2 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -930,7 +930,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		v9fs_cache_inode_set_cookie(d_inode(dentry), file);
 
-	*opened |= FILE_CREATED;
+	file->f_mode |= FMODE_CREATED;
 out:
 	dput(res);
 	return err;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 0b79872848c1..c6939b7cb18c 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -358,7 +358,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	file->private_data = ofid;
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		v9fs_cache_inode_set_cookie(inode, file);
-	*opened |= FILE_CREATED;
+	file->f_mode |= FMODE_CREATED;
 out:
 	v9fs_put_acl(dacl, pacl);
 	dput(res);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 4f2aa53c4ff6..37ab240d4cdf 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -472,7 +472,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		dout("atomic_open finish_open on dn %p\n", dn);
 		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
 			ceph_init_inode_acls(d_inode(dentry), &acls);
-			*opened |= FILE_CREATED;
+			file->f_mode |= FMODE_CREATED;
 		}
 		err = finish_open(file, dentry, ceph_open);
 	}
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index ca8fc209af6d..88a8178f90bb 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -539,7 +539,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	}
 
 	if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
-		*opened |= FILE_CREATED;
+		file->f_mode |= FMODE_CREATED;
 
 	rc = finish_open(file, direntry, generic_file_open);
 	if (rc) {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ae40501d39c9..31b432a0e70b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -508,7 +508,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 		goto no_open;
 
 	/* Only creates */
-	*opened |= FILE_CREATED;
+	file->f_mode |= FMODE_CREATED;
 
 	if (fc->no_create)
 		goto mknod;
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 198e07d5ecdd..146ef177982e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -767,7 +767,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	mark_inode_dirty(inode);
 	d_instantiate(dentry, inode);
 	if (file) {
-		*opened |= FILE_CREATED;
+		file->f_mode |= FMODE_CREATED;
 		error = finish_open(file, dentry, gfs2_open_common);
 	}
 	gfs2_glock_dq_uninit(ghs);
diff --git a/fs/namei.c b/fs/namei.c
index ef21c904f147..592d62a9f549 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3027,7 +3027,7 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 		 * permission here.
 		 */
 		int acc_mode = op->acc_mode;
-		if (*opened & FILE_CREATED) {
+		if (file->f_mode & FMODE_CREATED) {
 			WARN_ON(!(open_flag & O_CREAT));
 			fsnotify_create(dir, dentry);
 			acc_mode = 0;
@@ -3043,7 +3043,7 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 				dput(dentry);
 				dentry = file->f_path.dentry;
 			}
-			if (*opened & FILE_CREATED)
+			if (file->f_mode & FMODE_CREATED)
 				fsnotify_create(dir, dentry);
 			if (unlikely(d_is_negative(dentry))) {
 				error = -ENOENT;
@@ -3092,7 +3092,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return -ENOENT;
 
-	*opened &= ~FILE_CREATED;
+	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
@@ -3177,7 +3177,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
-		*opened |= FILE_CREATED;
+		file->f_mode |= FMODE_CREATED;
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 		if (!dir_inode->i_op->create) {
 			error = -EACCES;
@@ -3284,7 +3284,7 @@ static int do_last(struct nameidata *nd,
 		if (error)
 			goto out;
 
-		if ((*opened & FILE_CREATED) ||
+		if ((file->f_mode & FMODE_CREATED) ||
 		    !S_ISREG(file_inode(file)->i_mode))
 			will_truncate = false;
 
@@ -3292,7 +3292,7 @@ static int do_last(struct nameidata *nd,
 		goto opened;
 	}
 
-	if (*opened & FILE_CREATED) {
+	if (file->f_mode & FMODE_CREATED) {
 		/* Don't check for write permission, don't truncate */
 		open_flag &= ~O_TRUNC;
 		will_truncate = false;
@@ -3366,7 +3366,8 @@ static int do_last(struct nameidata *nd,
 	if (error)
 		goto out;
 opened:
-	error = ima_file_check(file, op->acc_mode, *opened);
+	error = ima_file_check(file, op->acc_mode,
+				file->f_mode & FMODE_CREATED ? FILE_CREATED : 0);
 	if (!error && will_truncate)
 		error = handle_truncate(file);
 out:
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 43dc1c66873d..bc4a045493f5 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1444,6 +1444,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	unsigned int lookup_flags = 0;
 	bool switched = false;
+	int created = 0;
 	int err;
 
 	/* Expect a negative dentry */
@@ -1504,7 +1505,9 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		goto out;
 
 	trace_nfs_atomic_open_enter(dir, ctx, open_flags);
-	inode = NFS_PROTO(dir)->open_context(dir, ctx, open_flags, &attr, opened);
+	inode = NFS_PROTO(dir)->open_context(dir, ctx, open_flags, &attr, &created);
+	if (created)
+		file->f_mode |= FMODE_CREATED;
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b71757e85066..0504439d1600 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2934,7 +2934,7 @@ static int _nfs4_do_open(struct inode *dir,
 		}
 	}
 	if (opened && opendata->file_created)
-		*opened |= FILE_CREATED;
+		*opened = 1;
 
 	if (pnfs_use_threshold(ctx_th, opendata->f_attr.mdsthreshold, server)) {
 		*ctx_th = opendata->f_attr.mdsthreshold;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a7c090c2b6b9..6dafc39987fa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -148,6 +148,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_CAN_WRITE         ((__force fmode_t)0x40000)
 
 #define FMODE_OPENED		((__force fmode_t)0x80000)
+#define FMODE_CREATED		((__force fmode_t)0x100000)
 
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
-- 
2.11.0
