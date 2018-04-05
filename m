Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbeDEUbB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:31:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752641AbeDEUa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:58 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/20] afs: Split the dynroot stuff out and give it its own
 ops tables
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:30:56 +0100
Message-ID: <152296025629.31027.1722324212194911193.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the AFS dynamic root stuff out of the main directory handling file
and into its own file as they share little in common.

The dynamic root code also gets its own dentry and inode ops tables.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/Makefile   |    1 
 fs/afs/dir.c      |  187 ----------------------------------------------
 fs/afs/dynroot.c  |  216 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/internal.h |   12 ++-
 fs/afs/super.c    |   11 ++-
 5 files changed, 235 insertions(+), 192 deletions(-)
 create mode 100644 fs/afs/dynroot.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index 45b7fc405fa6..6a055423c192 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -12,6 +12,7 @@ kafs-objs := \
 	cell.o \
 	cmservice.o \
 	dir.o \
+	dynroot.o \
 	file.o \
 	flock.o \
 	fsclient.o \
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 3c7fcd6ad9b7..8f2df235b07f 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -10,25 +10,19 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/ctype.h>
 #include <linux/sched.h>
-#include <linux/dns_resolver.h>
 #include "internal.h"
 
 static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags);
-static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentry,
-					 unsigned int flags);
 static int afs_dir_open(struct inode *inode, struct file *file);
 static int afs_readdir(struct file *file, struct dir_context *ctx);
 static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
 static int afs_d_delete(const struct dentry *dentry);
-static void afs_d_release(struct dentry *dentry);
 static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
 				  loff_t fpos, u64 ino, unsigned dtype);
 static int afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
@@ -69,17 +63,6 @@ const struct inode_operations afs_dir_inode_operations = {
 	.listxattr	= afs_listxattr,
 };
 
-const struct file_operations afs_dynroot_file_operations = {
-	.open		= dcache_dir_open,
-	.release	= dcache_dir_close,
-	.iterate_shared	= dcache_readdir,
-	.llseek		= dcache_dir_lseek,
-};
-
-const struct inode_operations afs_dynroot_inode_operations = {
-	.lookup		= afs_dynroot_lookup,
-};
-
 const struct dentry_operations afs_fs_dentry_operations = {
 	.d_revalidate	= afs_d_revalidate,
 	.d_delete	= afs_d_delete,
@@ -702,71 +685,6 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	return inode;
 }
 
-/*
- * Probe to see if a cell may exist.  This prevents positive dentries from
- * being created unnecessarily.
- */
-static int afs_probe_cell_name(struct dentry *dentry)
-{
-	struct afs_cell *cell;
-	const char *name = dentry->d_name.name;
-	size_t len = dentry->d_name.len;
-	int ret;
-
-	/* Names prefixed with a dot are R/W mounts. */
-	if (name[0] == '.') {
-		if (len == 1)
-			return -EINVAL;
-		name++;
-		len--;
-	}
-
-	cell = afs_lookup_cell_rcu(afs_d2net(dentry), name, len);
-	if (!IS_ERR(cell)) {
-		afs_put_cell(afs_d2net(dentry), cell);
-		return 0;
-	}
-
-	ret = dns_query("afsdb", name, len, "ipv4", NULL, NULL);
-	if (ret == -ENODATA)
-		ret = -EDESTADDRREQ;
-	return ret;
-}
-
-/*
- * Try to auto mount the mountpoint with pseudo directory, if the autocell
- * operation is setted.
- */
-static struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
-{
-	struct afs_vnode *vnode = AFS_FS_I(dir);
-	struct inode *inode;
-	int ret = -ENOENT;
-
-	_enter("%p{%pd}, {%x:%u}",
-	       dentry, dentry, vnode->fid.vid, vnode->fid.vnode);
-
-	if (!test_bit(AFS_VNODE_AUTOCELL, &vnode->flags))
-		goto out;
-
-	ret = afs_probe_cell_name(dentry);
-	if (ret < 0)
-		goto out;
-
-	inode = afs_iget_pseudo_dir(dir->i_sb, false);
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
-		goto out;
-	}
-
-	_leave("= %p", inode);
-	return inode;
-
-out:
-	_leave("= %d", ret);
-	return ERR_PTR(ret);
-}
-
 /*
  * Look up an entry in a directory with @sys substitution.
  */
@@ -923,105 +841,6 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	return NULL;
 }
 
-/*
- * Look up @cell in a dynroot directory.  This is a substitution for the
- * local cell name for the net namespace.
- */
-static struct dentry *afs_lookup_atcell(struct dentry *dentry)
-{
-	struct afs_cell *cell;
-	struct afs_net *net = afs_d2net(dentry);
-	struct dentry *parent, *ret;
-	unsigned int seq = 0;
-	char *name;
-	int len;
-
-	if (!net->ws_cell)
-		return ERR_PTR(-ENOENT);
-
-	parent = dget_parent(dentry);
-
-	ret = ERR_PTR(-ENOMEM);
-	name = kmalloc(AFS_MAXCELLNAME + 1, GFP_KERNEL);
-	if (!name)
-		goto out_p;
-
-	rcu_read_lock();
-	do {
-		read_seqbegin_or_lock(&net->cells_lock, &seq);
-		cell = rcu_dereference_raw(net->ws_cell);
-		if (cell) {
-			len = cell->name_len;
-			memcpy(name, cell->name, len + 1);
-		}
-	} while (need_seqretry(&net->cells_lock, seq));
-	done_seqretry(&net->cells_lock, seq);
-	rcu_read_unlock();
-
-	ret = ERR_PTR(-ENOENT);
-	if (!cell)
-		goto out_n;
-
-	ret = lookup_one_len(name, parent, len);
-	if (IS_ERR(ret) || d_is_positive(ret))
-		goto out_n;
-
-	/* We don't want to d_add() the @cell dentry here as we don't want to
-	 * the cached dentry to hide changes to the local cell name.
-	 */
-	dput(ret);
-	ret = NULL;
-
-out_n:
-	kfree(name);
-out_p:
-	dput(parent);
-	return ret;
-}
-
-/*
- * Look up an entry in a dynroot directory.
- */
-static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentry,
-					 unsigned int flags)
-{
-	struct afs_vnode *vnode;
-	struct inode *inode;
-	int ret;
-
-	vnode = AFS_FS_I(dir);
-
-	_enter("%pd", dentry);
-
-	ASSERTCMP(d_inode(dentry), ==, NULL);
-
-	if (dentry->d_name.len >= AFSNAMEMAX) {
-		_leave(" = -ENAMETOOLONG");
-		return ERR_PTR(-ENAMETOOLONG);
-	}
-
-	if (dentry->d_name.len == 5 &&
-	    memcmp(dentry->d_name.name, "@cell", 5) == 0)
-		return afs_lookup_atcell(dentry);
-
-	inode = afs_try_auto_mntpt(dentry, dir);
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
-		if (ret == -ENOENT) {
-			d_add(dentry, NULL);
-			_leave(" = NULL [negative]");
-			return NULL;
-		}
-		_leave(" = %d [do]", ret);
-		return ERR_PTR(ret);
-	}
-
-	d_add(dentry, inode);
-	_leave(" = 0 { ino=%lu v=%u }",
-	       d_inode(dentry)->i_ino, d_inode(dentry)->i_generation);
-	return NULL;
-}
-
 /*
  * check that a dentry lookup hit has found a valid entry
  * - NOTE! the hit can be a negative hit too, so we can't assume we have an
@@ -1029,7 +848,6 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
  */
 static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
-	struct afs_super_info *as = dentry->d_sb->s_fs_info;
 	struct afs_vnode *vnode, *dir;
 	struct afs_fid uninitialized_var(fid);
 	struct dentry *parent;
@@ -1041,9 +859,6 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	if (as->dyn_root)
-		return 1;
-
 	if (d_really_is_positive(dentry)) {
 		vnode = AFS_FS_I(d_inode(dentry));
 		_enter("{v={%x:%u} n=%pd fl=%lx},",
@@ -1201,7 +1016,7 @@ static int afs_d_delete(const struct dentry *dentry)
 /*
  * handle dentry release
  */
-static void afs_d_release(struct dentry *dentry)
+void afs_d_release(struct dentry *dentry)
 {
 	_enter("%pd", dentry);
 }
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
new file mode 100644
index 000000000000..b70380e5d0e3
--- /dev/null
+++ b/fs/afs/dynroot.c
@@ -0,0 +1,216 @@
+/* dir.c: AFS dynamic root handling
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/dns_resolver.h>
+#include "internal.h"
+
+const struct file_operations afs_dynroot_file_operations = {
+	.open		= dcache_dir_open,
+	.release	= dcache_dir_close,
+	.iterate_shared	= dcache_readdir,
+	.llseek		= dcache_dir_lseek,
+};
+
+/*
+ * Probe to see if a cell may exist.  This prevents positive dentries from
+ * being created unnecessarily.
+ */
+static int afs_probe_cell_name(struct dentry *dentry)
+{
+	struct afs_cell *cell;
+	const char *name = dentry->d_name.name;
+	size_t len = dentry->d_name.len;
+	int ret;
+
+	/* Names prefixed with a dot are R/W mounts. */
+	if (name[0] == '.') {
+		if (len == 1)
+			return -EINVAL;
+		name++;
+		len--;
+	}
+
+	cell = afs_lookup_cell_rcu(afs_d2net(dentry), name, len);
+	if (!IS_ERR(cell)) {
+		afs_put_cell(afs_d2net(dentry), cell);
+		return 0;
+	}
+
+	ret = dns_query("afsdb", name, len, "ipv4", NULL, NULL);
+	if (ret == -ENODATA)
+		ret = -EDESTADDRREQ;
+	return ret;
+}
+
+/*
+ * Try to auto mount the mountpoint with pseudo directory, if the autocell
+ * operation is setted.
+ */
+struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
+{
+	struct afs_vnode *vnode = AFS_FS_I(dir);
+	struct inode *inode;
+	int ret = -ENOENT;
+
+	_enter("%p{%pd}, {%x:%u}",
+	       dentry, dentry, vnode->fid.vid, vnode->fid.vnode);
+
+	if (!test_bit(AFS_VNODE_AUTOCELL, &vnode->flags))
+		goto out;
+
+	ret = afs_probe_cell_name(dentry);
+	if (ret < 0)
+		goto out;
+
+	inode = afs_iget_pseudo_dir(dir->i_sb, false);
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
+		goto out;
+	}
+
+	_leave("= %p", inode);
+	return inode;
+
+out:
+	_leave("= %d", ret);
+	return ERR_PTR(ret);
+}
+
+/*
+ * Look up @cell in a dynroot directory.  This is a substitution for the
+ * local cell name for the net namespace.
+ */
+static struct dentry *afs_lookup_atcell(struct dentry *dentry)
+{
+	struct afs_cell *cell;
+	struct afs_net *net = afs_d2net(dentry);
+	struct dentry *parent, *ret;
+	unsigned int seq = 0;
+	char *name;
+	int len;
+
+	if (!net->ws_cell)
+		return ERR_PTR(-ENOENT);
+
+	parent = dget_parent(dentry);
+
+	ret = ERR_PTR(-ENOMEM);
+	name = kmalloc(AFS_MAXCELLNAME + 1, GFP_KERNEL);
+	if (!name)
+		goto out_p;
+
+	rcu_read_lock();
+	do {
+		read_seqbegin_or_lock(&net->cells_lock, &seq);
+		cell = rcu_dereference_raw(net->ws_cell);
+		if (cell) {
+			len = cell->name_len;
+			memcpy(name, cell->name, len + 1);
+		}
+	} while (need_seqretry(&net->cells_lock, seq));
+	done_seqretry(&net->cells_lock, seq);
+	rcu_read_unlock();
+
+	ret = ERR_PTR(-ENOENT);
+	if (!cell)
+		goto out_n;
+
+	ret = lookup_one_len(name, parent, len);
+	if (IS_ERR(ret) || d_is_positive(ret))
+		goto out_n;
+
+	/* We don't want to d_add() the @cell dentry here as we don't want to
+	 * the cached dentry to hide changes to the local cell name.
+	 */
+	dput(ret);
+	ret = NULL;
+
+out_n:
+	kfree(name);
+out_p:
+	dput(parent);
+	return ret;
+}
+
+/*
+ * Look up an entry in a dynroot directory.
+ */
+static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentry,
+					 unsigned int flags)
+{
+	struct afs_vnode *vnode;
+	struct inode *inode;
+	int ret;
+
+	vnode = AFS_FS_I(dir);
+
+	_enter("%pd", dentry);
+
+	ASSERTCMP(d_inode(dentry), ==, NULL);
+
+	if (dentry->d_name.len >= AFSNAMEMAX) {
+		_leave(" = -ENAMETOOLONG");
+		return ERR_PTR(-ENAMETOOLONG);
+	}
+
+	if (dentry->d_name.len == 5 &&
+	    memcmp(dentry->d_name.name, "@cell", 5) == 0)
+		return afs_lookup_atcell(dentry);
+
+	inode = afs_try_auto_mntpt(dentry, dir);
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
+		if (ret == -ENOENT) {
+			d_add(dentry, NULL);
+			_leave(" = NULL [negative]");
+			return NULL;
+		}
+		_leave(" = %d [do]", ret);
+		return ERR_PTR(ret);
+	}
+
+	d_add(dentry, inode);
+	_leave(" = 0 { ino=%lu v=%u }",
+	       d_inode(dentry)->i_ino, d_inode(dentry)->i_generation);
+	return NULL;
+}
+
+const struct inode_operations afs_dynroot_inode_operations = {
+	.lookup		= afs_dynroot_lookup,
+};
+
+/*
+ * Dirs in the dynamic root don't need revalidation.
+ */
+static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	return 1;
+}
+
+/*
+ * Allow the VFS to enquire as to whether a dentry should be unhashed (mustn't
+ * sleep)
+ * - called from dput() when d_count is going to 0.
+ * - return 1 to request dentry be unhashed, 0 otherwise
+ */
+static int afs_dynroot_d_delete(const struct dentry *dentry)
+{
+	return d_really_is_positive(dentry);
+}
+
+const struct dentry_operations afs_dynroot_dentry_operations = {
+	.d_revalidate	= afs_dynroot_d_revalidate,
+	.d_delete	= afs_dynroot_d_delete,
+	.d_release	= afs_d_release,
+	.d_automount	= afs_d_automount,
+};
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 967acc096f3d..3bad5b8e38dc 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -669,11 +669,19 @@ extern bool afs_cm_incoming_call(struct afs_call *);
  */
 extern const struct file_operations afs_dir_file_operations;
 extern const struct inode_operations afs_dir_inode_operations;
-extern const struct file_operations afs_dynroot_file_operations;
-extern const struct inode_operations afs_dynroot_inode_operations;
 extern const struct dentry_operations afs_fs_dentry_operations;
 
 extern bool afs_dir_check_page(struct inode *, struct page *);
+extern void afs_d_release(struct dentry *);
+
+/*
+ * dynroot.c
+ */
+extern const struct file_operations afs_dynroot_file_operations;
+extern const struct inode_operations afs_dynroot_inode_operations;
+extern const struct dentry_operations afs_dynroot_dentry_operations;
+
+extern struct inode *afs_try_auto_mntpt(struct dentry *, struct inode *);
 
 /*
  * file.c
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 3623c952b6ff..65081ec3c36e 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -154,7 +154,7 @@ static int afs_show_devname(struct seq_file *m, struct dentry *root)
 		seq_puts(m, "none");
 		return 0;
 	}
-	
+
 	switch (volume->type) {
 	case AFSVL_RWVOL:
 		break;
@@ -269,7 +269,7 @@ static int afs_parse_device_name(struct afs_mount_params *params,
 	int cellnamesz;
 
 	_enter(",%s", name);
-	
+
 	if (!name) {
 		printk(KERN_ERR "kAFS: no volume name specified\n");
 		return -EINVAL;
@@ -418,7 +418,10 @@ static int afs_fill_super(struct super_block *sb,
 	if (!sb->s_root)
 		goto error;
 
-	sb->s_d_op = &afs_fs_dentry_operations;
+	if (params->dyn_root)
+		sb->s_d_op = &afs_dynroot_dentry_operations;
+	else
+		sb->s_d_op = &afs_fs_dentry_operations;
 
 	_leave(" = 0");
 	return 0;
@@ -676,7 +679,7 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		buf->f_bfree	= 0;
 		return 0;
 	}
-	
+
 	key = afs_request_key(vnode->volume->cell);
 	if (IS_ERR(key))
 		return PTR_ERR(key);
