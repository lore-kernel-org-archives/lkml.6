Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72291C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBC52089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBC52089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeGIE6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:58:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38090 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754412AbeGIEyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBm-0003fG-Ve; Mon, 09 Jul 2018 04:54:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 12/27] Preparation to killing ->atomic_open() 'opened' argument.
Date:   Mon,  9 Jul 2018 05:54:02 +0100
Message-Id: <20180709045417.13988-12-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

__gfs2_lookup(), gfs2_create_inode(), nfs_finish_open() and fuse_create_open()
don't need 'opened' anymore.  Get rid of that argument in those.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/dir.c   |  4 ++--
 fs/gfs2/inode.c | 19 +++++++++----------
 fs/nfs/dir.c    |  5 ++---
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a5b1f5ff8cb7..b8d7e9d423c8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -399,7 +399,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
  */
 static int fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned flags,
-			    umode_t mode, int *opened)
+			    umode_t mode)
 {
 	int err;
 	struct inode *inode;
@@ -513,7 +513,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, opened);
+	err = fuse_create_open(dir, entry, file, flags, mode);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 59f695e96d63..15e2a8a3b917 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -580,7 +580,7 @@ static int gfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
 static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 			     struct file *file,
 			     umode_t mode, dev_t dev, const char *symname,
-			     unsigned int size, int excl, int *opened)
+			     unsigned int size, int excl)
 {
 	const struct qstr *name = &dentry->d_name;
 	struct posix_acl *default_acl, *acl;
@@ -822,7 +822,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 static int gfs2_create(struct inode *dir, struct dentry *dentry,
 		       umode_t mode, bool excl)
 {
-	return gfs2_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0, excl, NULL);
+	return gfs2_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0, excl);
 }
 
 /**
@@ -830,14 +830,13 @@ static int gfs2_create(struct inode *dir, struct dentry *dentry,
  * @dir: The directory inode
  * @dentry: The dentry of the new inode
  * @file: File to be opened
- * @opened: atomic_open flags
  *
  *
  * Returns: errno
  */
 
 static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
-				    struct file *file, int *opened)
+				    struct file *file)
 {
 	struct inode *inode;
 	struct dentry *d;
@@ -879,7 +878,7 @@ static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
 static struct dentry *gfs2_lookup(struct inode *dir, struct dentry *dentry,
 				  unsigned flags)
 {
-	return __gfs2_lookup(dir, dentry, NULL, NULL);
+	return __gfs2_lookup(dir, dentry, NULL);
 }
 
 /**
@@ -1189,7 +1188,7 @@ static int gfs2_symlink(struct inode *dir, struct dentry *dentry,
 	if (size >= gfs2_max_stuffed_size(GFS2_I(dir)))
 		return -ENAMETOOLONG;
 
-	return gfs2_create_inode(dir, dentry, NULL, S_IFLNK | S_IRWXUGO, 0, symname, size, 0, NULL);
+	return gfs2_create_inode(dir, dentry, NULL, S_IFLNK | S_IRWXUGO, 0, symname, size, 0);
 }
 
 /**
@@ -1204,7 +1203,7 @@ static int gfs2_symlink(struct inode *dir, struct dentry *dentry,
 static int gfs2_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	unsigned dsize = gfs2_max_stuffed_size(GFS2_I(dir));
-	return gfs2_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, NULL, dsize, 0, NULL);
+	return gfs2_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, NULL, dsize, 0);
 }
 
 /**
@@ -1219,7 +1218,7 @@ static int gfs2_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 static int gfs2_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
 		      dev_t dev)
 {
-	return gfs2_create_inode(dir, dentry, NULL, mode, dev, NULL, 0, 0, NULL);
+	return gfs2_create_inode(dir, dentry, NULL, mode, dev, NULL, 0, 0);
 }
 
 /**
@@ -1244,7 +1243,7 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (!d_in_lookup(dentry))
 		goto skip_lookup;
 
-	d = __gfs2_lookup(dir, dentry, file, opened);
+	d = __gfs2_lookup(dir, dentry, file);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 	if (d != NULL)
@@ -1262,7 +1261,7 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (!(flags & O_CREAT))
 		return -ENOENT;
 
-	return gfs2_create_inode(dir, dentry, file, S_IFREG | mode, 0, NULL, 0, excl, opened);
+	return gfs2_create_inode(dir, dentry, file, S_IFREG | mode, 0, NULL, 0, excl);
 }
 
 /*
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 22176a3818d5..71ae3cc3e53a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1434,8 +1434,7 @@ static int do_open(struct inode *inode, struct file *filp)
 
 static int nfs_finish_open(struct nfs_open_context *ctx,
 			   struct dentry *dentry,
-			   struct file *file, unsigned open_flags,
-			   int *opened)
+			   struct file *file, unsigned open_flags)
 {
 	int err;
 
@@ -1549,7 +1548,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 
-	err = nfs_finish_open(ctx, ctx->dentry, file, open_flags, opened);
+	err = nfs_finish_open(ctx, ctx->dentry, file, open_flags);
 	trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 	put_nfs_open_context(ctx);
 out:
-- 
2.11.0

