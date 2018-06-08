Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ER7YOJfPGlsoBAAAmS7hNA
	; Fri, 08 Jun 2018 18:51:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D7EA9607E7; Fri,  8 Jun 2018 18:51:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 09159601D2;
	Fri,  8 Jun 2018 18:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09159601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeFHSu4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:50:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53826 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbeFHSuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSq-0006ON-OB; Fri, 08 Jun 2018 18:50:20 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] get rid of 'opened' argument of ->atomic_open()
Date: Fri,  8 Jun 2018 19:50:18 +0100
Message-Id: <20180608185019.24472-12-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

not used anymore

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/lustre/lustre/llite/namei.c | 7 +++----
 fs/9p/vfs_inode.c                           | 3 +--
 fs/9p/vfs_inode_dotl.c                      | 3 +--
 fs/bad_inode.c                              | 2 +-
 fs/ceph/file.c                              | 3 +--
 fs/ceph/super.h                             | 3 +--
 fs/cifs/cifsfs.h                            | 3 +--
 fs/cifs/dir.c                               | 3 +--
 fs/fuse/dir.c                               | 2 +-
 fs/gfs2/inode.c                             | 3 +--
 fs/namei.c                                  | 3 +--
 fs/nfs/dir.c                                | 2 +-
 fs/nfs/nfs4_fs.h                            | 2 +-
 include/linux/fs.h                          | 2 +-
 14 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
index 72376af0d4b5..6de32ef466b1 100644
--- a/drivers/staging/lustre/lustre/llite/namei.c
+++ b/drivers/staging/lustre/lustre/llite/namei.c
@@ -678,15 +678,14 @@ static struct dentry *ll_lookup_nd(struct inode *parent, struct dentry *dentry,
  */
 static int ll_atomic_open(struct inode *dir, struct dentry *dentry,
 			  struct file *file, unsigned int open_flags,
-			  umode_t mode, int *opened)
+			  umode_t mode)
 {
 	struct lookup_intent *it;
 	struct dentry *de;
 	int rc = 0;
 
-	CDEBUG(D_VFSTRACE, "VFS Op:name=%pd, dir=" DFID "(%p),file %p,open_flags %x,mode %x opened %d\n",
-	       dentry, PFID(ll_inode2fid(dir)), dir, file, open_flags, mode,
-	       *opened);
+	CDEBUG(D_VFSTRACE, "VFS Op:name=%pd, dir=" DFID "(%p),file %p,open_flags %x,mode %x\n",
+	       dentry, PFID(ll_inode2fid(dir)), dir, file, open_flags, mode);
 
 	/* Only negative dentries enter here */
 	LASSERT(!d_inode(dentry));
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 6d6af0109cf2..228bc15311d8 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -864,8 +864,7 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 
 static int
 v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
-		     struct file *file, unsigned flags, umode_t mode,
-		     int *opened)
+		     struct file *file, unsigned flags, umode_t mode)
 {
 	int err;
 	u32 perm;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c6939b7cb18c..4823e1c46999 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -241,8 +241,7 @@ v9fs_vfs_create_dotl(struct inode *dir, struct dentry *dentry, umode_t omode,
 
 static int
 v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
-			  struct file *file, unsigned flags, umode_t omode,
-			  int *opened)
+			  struct file *file, unsigned flags, umode_t omode)
 {
 	int err = 0;
 	kgid_t gid;
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 213b51dbbb60..60f839611c48 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -134,7 +134,7 @@ static int bad_inode_update_time(struct inode *inode, struct timespec *time,
 
 static int bad_inode_atomic_open(struct inode *inode, struct dentry *dentry,
 				 struct file *file, unsigned int open_flag,
-				 umode_t create_mode, int *opened)
+				 umode_t create_mode)
 {
 	return -EIO;
 }
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 37ab240d4cdf..8ad1602ea97f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -394,8 +394,7 @@ int ceph_open(struct inode *inode, struct file *file)
  * file or symlink, return 1 so the VFS can retry.
  */
 int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
-		     struct file *file, unsigned flags, umode_t mode,
-		     int *opened)
+		     struct file *file, unsigned flags, umode_t mode)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a7077a0c989f..971328b99ede 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1025,8 +1025,7 @@ extern const struct file_operations ceph_file_fops;
 extern int ceph_renew_caps(struct inode *inode);
 extern int ceph_open(struct inode *inode, struct file *file);
 extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
-			    struct file *file, unsigned flags, umode_t mode,
-			    int *opened);
+			    struct file *file, unsigned flags, umode_t mode);
 extern int ceph_release(struct inode *inode, struct file *filp);
 extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 				  char *data, size_t len);
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 013ba2aed8d9..a1a09caa65a2 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -65,8 +65,7 @@ extern struct inode *cifs_root_iget(struct super_block *);
 extern int cifs_create(struct inode *, struct dentry *, umode_t,
 		       bool excl);
 extern int cifs_atomic_open(struct inode *, struct dentry *,
-			    struct file *, unsigned, umode_t,
-			    int *);
+			    struct file *, unsigned, umode_t);
 extern struct dentry *cifs_lookup(struct inode *, struct dentry *,
 				  unsigned int);
 extern int cifs_unlink(struct inode *dir, struct dentry *dentry);
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 88a8178f90bb..6d55f666113b 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -465,8 +465,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 
 int
 cifs_atomic_open(struct inode *inode, struct dentry *direntry,
-		 struct file *file, unsigned oflags, umode_t mode,
-		 int *opened)
+		 struct file *file, unsigned oflags, umode_t mode)
 {
 	int rc;
 	unsigned int xid;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 31b432a0e70b..c9e1b532f1ff 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -489,7 +489,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 static int fuse_mknod(struct inode *, struct dentry *, umode_t, dev_t);
 static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned flags,
-			    umode_t mode, int *opened)
+			    umode_t mode)
 {
 	int err;
 	struct fuse_conn *fc = get_fuse_conn(dir);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 9cb09f63d831..78df5e3da44e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1228,14 +1228,13 @@ static int gfs2_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
  * @file: The proposed new struct file
  * @flags: open flags
  * @mode: File mode
- * @opened: Flag to say whether the file has been opened or not
  *
  * Returns: error code or 0 for success
  */
 
 static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 			    struct file *file, unsigned flags,
-			    umode_t mode, int *opened)
+			    umode_t mode)
 {
 	struct dentry *d;
 	bool excl = !!(flags & O_EXCL);
diff --git a/fs/namei.c b/fs/namei.c
index ce71a69653b1..189ead589811 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3018,8 +3018,7 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 	file->f_path.dentry = DENTRY_NOT_SET;
 	file->f_path.mnt = nd->path.mnt;
 	error = dir->i_op->atomic_open(dir, dentry, file,
-				       open_to_namei_flags(open_flag),
-				       mode, opened);
+				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
 	if (!error) {
 		/*
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bc4a045493f5..d4151843f02c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1435,7 +1435,7 @@ static int nfs_finish_open(struct nfs_open_context *ctx,
 
 int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
-		    umode_t mode, int *opened)
+		    umode_t mode)
 {
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index b374f680830c..562903f5e2a3 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -233,7 +233,7 @@ extern const struct dentry_operations nfs4_dentry_operations;
 
 /* dir.c */
 int nfs_atomic_open(struct inode *, struct dentry *, struct file *,
-		    unsigned, umode_t, int *);
+		    unsigned, umode_t);
 
 /* super.c */
 extern struct file_system_type nfs4_fs_type;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6dafc39987fa..b4af9018785f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1771,7 +1771,7 @@ struct inode_operations {
 	int (*update_time)(struct inode *, struct timespec *, int);
 	int (*atomic_open)(struct inode *, struct dentry *,
 			   struct file *, unsigned open_flag,
-			   umode_t create_mode, int *opened);
+			   umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
 } ____cacheline_aligned;
-- 
2.11.0
