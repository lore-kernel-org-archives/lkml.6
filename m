Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE04C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADEC20936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADEC20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbeGKC0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:26:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45586 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732389AbeGKCYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lb-0003JE-VD; Wed, 11 Jul 2018 02:22:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 18/42] introduce FMODE_CREATED and switch to it
Date:   Wed, 11 Jul 2018 03:21:42 +0100
Message-Id: <20180711022206.12571-18-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Parallel to FILE_CREATED, goes into ->f_mode instead of *opened.
NFS is a bit of a wart here - it doesn't have file at the point
where FILE_CREATED used to be set, so we need to propagate it
there (for now).  IMA is another one (here and everywhere)...

Note that this needs do_dentry_open() to leave old bits in ->f_mode
alone - we want it to preserve FMODE_CREATED if it had been already
set (no other bit can be there).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/9p/vfs_inode.c      |  2 +-
 fs/9p/vfs_inode_dotl.c |  2 +-
 fs/ceph/file.c         |  2 +-
 fs/cifs/dir.c          |  2 +-
 fs/fuse/dir.c          |  2 +-
 fs/gfs2/inode.c        |  2 +-
 fs/namei.c             | 15 ++++++++-------
 fs/nfs/dir.c           |  5 ++++-
 fs/nfs/nfs4proc.c      |  2 +-
 fs/open.c              |  2 +-
 include/linux/fs.h     |  1 +
 11 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 42e102e2e74a..566929792480 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -925,7 +925,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		v9fs_cache_inode_set_cookie(d_inode(dentry), file);
 
-	*opened |= FILE_CREATED;
+	file->f_mode |= FMODE_CREATED;
 out:
 	dput(res);
 	return err;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 7f6ae21a27b3..ee65db5c7eb0 100644
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
index ad0bed99b1d5..38a63fff7903 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -507,7 +507,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		dout("atomic_open finish_open on dn %p\n", dn);
 		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
 			ceph_init_inode_acls(d_inode(dentry), &acls);
-			*opened |= FILE_CREATED;
+			file->f_mode |= FMODE_CREATED;
 		}
 		err = finish_open(file, dentry, ceph_open, opened);
 	}
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index ddae52bd1993..21d7e393900e 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -539,7 +539,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	}
 
 	if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
-		*opened |= FILE_CREATED;
+		file->f_mode |= FMODE_CREATED;
 
 	rc = finish_open(file, direntry, generic_file_open, opened);
 	if (rc) {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 56231b31f806..d4bdcf51e6cb 100644
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
index 67c588edf8d8..4aba00a6004b 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -767,7 +767,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	mark_inode_dirty(inode);
 	d_instantiate(dentry, inode);
 	if (file) {
-		*opened |= FILE_CREATED;
+		file->f_mode |= FMODE_CREATED;
 		error = finish_open(file, dentry, gfs2_open_common, opened);
 	}
 	gfs2_glock_dq_uninit(ghs);
diff --git a/fs/namei.c b/fs/namei.c
index ad8d53c3243c..33f92918e051 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3061,7 +3061,7 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 		 * permission here.
 		 */
 		int acc_mode = op->acc_mode;
-		if (*opened & FILE_CREATED) {
+		if (file->f_mode & FMODE_CREATED) {
 			WARN_ON(!(open_flag & O_CREAT));
 			fsnotify_create(dir, dentry);
 			acc_mode = 0;
@@ -3077,7 +3077,7 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 				dput(dentry);
 				dentry = file->f_path.dentry;
 			}
-			if (*opened & FILE_CREATED)
+			if (file->f_mode & FMODE_CREATED)
 				fsnotify_create(dir, dentry);
 			if (unlikely(d_is_negative(dentry))) {
 				error = -ENOENT;
@@ -3126,7 +3126,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return -ENOENT;
 
-	*opened &= ~FILE_CREATED;
+	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
@@ -3211,7 +3211,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
-		*opened |= FILE_CREATED;
+		file->f_mode |= FMODE_CREATED;
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 		if (!dir_inode->i_op->create) {
 			error = -EACCES;
@@ -3318,7 +3318,7 @@ static int do_last(struct nameidata *nd,
 		if (error)
 			goto out;
 
-		if ((*opened & FILE_CREATED) ||
+		if ((file->f_mode & FMODE_CREATED) ||
 		    !S_ISREG(file_inode(file)->i_mode))
 			will_truncate = false;
 
@@ -3326,7 +3326,7 @@ static int do_last(struct nameidata *nd,
 		goto opened;
 	}
 
-	if (*opened & FILE_CREATED) {
+	if (file->f_mode & FMODE_CREATED) {
 		/* Don't check for write permission, don't truncate */
 		open_flag &= ~O_TRUNC;
 		will_truncate = false;
@@ -3400,7 +3400,8 @@ static int do_last(struct nameidata *nd,
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
index 7a9c14426855..0ac50983fc4e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1461,6 +1461,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	unsigned int lookup_flags = 0;
 	bool switched = false;
+	int created = 0;
 	int err;
 
 	/* Expect a negative dentry */
@@ -1521,7 +1522,9 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
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
index ed45090e4df6..2c4df0ffbca1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2951,7 +2951,7 @@ static int _nfs4_do_open(struct inode *dir,
 		}
 	}
 	if (opened && opendata->file_created)
-		*opened |= FILE_CREATED;
+		*opened = 1;
 
 	if (pnfs_use_threshold(ctx_th, opendata->f_attr.mdsthreshold, server)) {
 		*ctx_th = opendata->f_attr.mdsthreshold;
diff --git a/fs/open.c b/fs/open.c
index 1f379656feab..e8ae46a740b6 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -731,7 +731,7 @@ static int do_dentry_open(struct file *f,
 	static const struct file_operations empty_fops = {};
 	int error;
 
-	f->f_mode = OPEN_FMODE(f->f_flags) | FMODE_LSEEK |
+	f->f_mode |= OPEN_FMODE(f->f_flags) | FMODE_LSEEK |
 				FMODE_PREAD | FMODE_PWRITE;
 
 	path_get(&f->f_path);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 05f34726e29c..ca668c7e48a7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -149,6 +149,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_CAN_WRITE         ((__force fmode_t)0x40000)
 
 #define FMODE_OPENED		((__force fmode_t)0x80000)
+#define FMODE_CREATED		((__force fmode_t)0x100000)
 
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
-- 
2.11.0

