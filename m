Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12493C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EC62089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EC62089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeGIE5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:57:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38106 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754421AbeGIEyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBn-0003ff-EZ; Mon, 09 Jul 2018 04:54:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 16/27] new wrapper: alloc_file_pseudo()
Date:   Mon,  9 Jul 2018 05:54:06 +0100
Message-Id: <20180709045417.13988-16-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

takes inode, vfsmount, name, mode and file_operations and either
returns a new struct file (in which case inode reference we held
is consumed) or returns ERR_PTR(), in which case no refcounts are
altered.

converted aio_private_file() and sock_alloc_file() to it

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c             | 27 ++++++---------------------
 fs/file_table.c      | 27 +++++++++++++++++++++++++++
 include/linux/file.h |  3 +++
 net/socket.c         | 27 ++++-----------------------
 4 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 4d63e8e4d1b5..c5244c68f90e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -215,9 +215,7 @@ static const struct address_space_operations aio_ctx_aops;
 
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
-	struct qstr this = QSTR_INIT("[aio]", 5);
 	struct file *file;
-	struct path path;
 	struct inode *inode = alloc_anon_inode(aio_mnt->mnt_sb);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
@@ -226,32 +224,19 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 	inode->i_mapping->private_data = ctx;
 	inode->i_size = PAGE_SIZE * nr_pages;
 
-	path.dentry = d_alloc_pseudo(aio_mnt->mnt_sb, &this);
-	if (!path.dentry) {
+	file = alloc_file_pseudo(inode, aio_mnt, "[aio]",
+				FMODE_READ | FMODE_WRITE, &aio_ring_fops);
+	if (IS_ERR(file))
 		iput(inode);
-		return ERR_PTR(-ENOMEM);
-	}
-	path.mnt = mntget(aio_mnt);
-
-	d_instantiate(path.dentry, inode);
-	file = alloc_file(&path, FMODE_READ | FMODE_WRITE | FMODE_OPENED,
-			  &aio_ring_fops);
-	if (IS_ERR(file)) {
-		path_put(&path);
-		return file;
-	}
-
-	file->f_flags = O_RDWR;
+	else
+		file->f_flags = O_RDWR;
 	return file;
 }
 
 static struct dentry *aio_mount(struct file_system_type *fs_type,
 				int flags, const char *dev_name, void *data)
 {
-	static const struct dentry_operations ops = {
-		.d_dname	= simple_dname,
-	};
-	struct dentry *root = mount_pseudo(fs_type, "aio:", NULL, &ops,
+	struct dentry *root = mount_pseudo(fs_type, "aio:", NULL, NULL,
 					   AIO_RING_MAGIC);
 
 	if (!IS_ERR(root))
diff --git a/fs/file_table.c b/fs/file_table.c
index 7ec0b3e5f05d..d78bc97f926f 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -182,6 +182,33 @@ struct file *alloc_file(const struct path *path, fmode_t mode,
 }
 EXPORT_SYMBOL(alloc_file);
 
+struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
+				const char *name, fmode_t mode,
+				const struct file_operations *fops)
+{
+	static const struct dentry_operations anon_ops = {
+		.d_dname = simple_dname
+	};
+	struct qstr this = QSTR_INIT(name, strlen(name));
+	struct path path;
+	struct file *file;
+
+	path.dentry = d_alloc_pseudo(mnt->mnt_sb, &this);
+	if (!path.dentry)
+		return ERR_PTR(-ENOMEM);
+	if (!mnt->mnt_sb->s_d_op)
+		d_set_d_op(path.dentry, &anon_ops);
+	path.mnt = mntget(mnt);
+	d_instantiate(path.dentry, inode);
+	file = alloc_file(&path, mode | FMODE_OPENED, fops);
+	if (IS_ERR(file)) {
+		ihold(inode);
+		path_put(&path);
+	}
+	return file;
+}
+EXPORT_SYMBOL(alloc_file_pseudo);
+
 /* the real guts of fput() - releasing the last reference to file
  */
 static void __fput(struct file *file)
diff --git a/include/linux/file.h b/include/linux/file.h
index 279720db984a..37a4d2c166de 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -17,9 +17,12 @@ extern void fput(struct file *);
 struct file_operations;
 struct vfsmount;
 struct dentry;
+struct inode;
 struct path;
 extern struct file *alloc_file(const struct path *, fmode_t mode,
 	const struct file_operations *fop);
+extern struct file *alloc_file_pseudo(struct inode *, struct vfsmount *,
+	const char *, fmode_t, const struct file_operations *);
 
 static inline void fput_light(struct file *file, int fput_needed)
 {
diff --git a/net/socket.c b/net/socket.c
index eff9db5fd99f..81cf9906cae5 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -391,33 +391,14 @@ static struct file_system_type sock_fs_type = {
 
 struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname)
 {
-	struct qstr name = { .name = "" };
-	struct path path;
 	struct file *file;
 
-	if (dname) {
-		name.name = dname;
-		name.len = strlen(name.name);
-	} else if (sock->sk) {
-		name.name = sock->sk->sk_prot_creator->name;
-		name.len = strlen(name.name);
-	}
-	path.dentry = d_alloc_pseudo(sock_mnt->mnt_sb, &name);
-	if (unlikely(!path.dentry)) {
-		sock_release(sock);
-		return ERR_PTR(-ENOMEM);
-	}
-	path.mnt = mntget(sock_mnt);
-
-	d_instantiate(path.dentry, SOCK_INODE(sock));
+	if (!dname)
+		dname = sock->sk ? sock->sk->sk_prot_creator->name : "";
 
-	file = alloc_file(&path, FMODE_READ | FMODE_WRITE | FMODE_OPENED,
-		  &socket_file_ops);
+	file = alloc_file_pseudo(SOCK_INODE(sock), sock_mnt, dname,
+				FMODE_READ | FMODE_WRITE, &socket_file_ops);
 	if (IS_ERR(file)) {
-		/* drop dentry, keep inode for a bit */
-		ihold(d_inode(path.dentry));
-		path_put(&path);
-		/* ... and now kill it properly */
 		sock_release(sock);
 		return file;
 	}
-- 
2.11.0

