Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeFEQH3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:07:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752198AbeFEQH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:07:26 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/5] afs: Display manually added cells in dynamic root mount
From: David Howells <dhowells@redhat.com>
To: viro@ZenIV.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Jun 2018 17:07:24 +0100
Message-ID: <152821484419.16494.12571848033105958373.stgit@warthog.procyon.org.uk>
In-Reply-To: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
References: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alter the dynroot mount so that cells created by manipulation of
/proc/fs/afs/cells and /proc/fs/afs/rootcell and by specification of a root
cell as a module parameter will cause directories for those cells to be
created in the dynamic root superblock for the network namespace[*].

To this end:

 (1) Only one dynamic root superblock is now created per network namespace
     and this is shared between all attempts to mount it.  This makes it
     easier to find the superblock to modify.

 (2) When a dynamic root superblock is created, the list of cells is walked
     and directories created for each cell already defined.

 (3) When a new cell is added, if a dynamic root superblock exists, a
     directory is created for it.

 (4) When a cell is destroyed, the directory is removed.

 (5) These directories are created by calling lookup_one_len() on the root
     dir which automatically creates them if they don't exist.

[*] Inasmuch as network namespaces are currently supported here.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c         |   12 +++--
 fs/afs/dynroot.c      |  124 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/internal.h     |    7 ++-
 fs/afs/main.c         |    2 -
 fs/afs/super.c        |   19 ++++++--
 fs/namei.c            |   29 +++++++++++
 include/linux/namei.h |    1 
 7 files changed, 183 insertions(+), 11 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index bb92b54d2a4a..f3d0bef16d78 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -15,6 +15,7 @@
 #include <linux/dns_resolver.h>
 #include <linux/sched.h>
 #include <linux/inet.h>
+#include <linux/namei.h>
 #include <keys/rxrpc-type.h>
 #include "internal.h"
 
@@ -531,9 +532,11 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
 	ret = afs_proc_cell_setup(cell);
 	if (ret < 0)
 		return ret;
-	spin_lock(&net->proc_cells_lock);
+
+	mutex_lock(&net->proc_cells_lock);
 	list_add_tail(&cell->proc_link, &net->proc_cells);
-	spin_unlock(&net->proc_cells_lock);
+	afs_dynroot_mkdir(net, cell);
+	mutex_unlock(&net->proc_cells_lock);
 	return 0;
 }
 
@@ -546,9 +549,10 @@ static void afs_deactivate_cell(struct afs_net *net, struct afs_cell *cell)
 
 	afs_proc_cell_remove(cell);
 
-	spin_lock(&net->proc_cells_lock);
+	mutex_lock(&net->proc_cells_lock);
 	list_del_init(&cell->proc_link);
-	spin_unlock(&net->proc_cells_lock);
+	afs_dynroot_rmdir(net, cell);
+	mutex_unlock(&net->proc_cells_lock);
 
 #ifdef CONFIG_AFS_FSCACHE
 	fscache_relinquish_cookie(cell->cache, NULL, false);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 7425f416ed73..174e843f0633 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -1,4 +1,4 @@
-/* dir.c: AFS dynamic root handling
+/* AFS dynamic root handling
  *
  * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
@@ -207,3 +207,125 @@ const struct dentry_operations afs_dynroot_dentry_operations = {
 	.d_release	= afs_d_release,
 	.d_automount	= afs_d_automount,
 };
+
+/*
+ * Create a manually added cell mount directory.
+ * - The caller must hold net->proc_cells_lock
+ */
+int afs_dynroot_mkdir(struct afs_net *net, struct afs_cell *cell)
+{
+	struct super_block *sb = net->dynroot_sb;
+	struct dentry *root, *subdir;
+	int ret;
+
+	if (!sb || atomic_read(&sb->s_active) == 0)
+		return 0;
+
+	/* Let the ->lookup op do the creation */
+	root = sb->s_root;
+	inode_lock(root->d_inode);
+	subdir = lookup_one_len(cell->name, root, cell->name_len);
+	if (IS_ERR(subdir)) {
+		ret = PTR_ERR(subdir);
+		goto unlock;
+	}
+
+	/* Note that we're retaining an extra ref on the dentry */
+	subdir->d_fsdata = (void *)1UL;
+	ret = 0;
+unlock:
+	inode_unlock(root->d_inode);
+	return ret;
+}
+
+/*
+ * Remove a manually added cell mount directory.
+ * - The caller must hold net->proc_cells_lock
+ */
+void afs_dynroot_rmdir(struct afs_net *net, struct afs_cell *cell)
+{
+	struct super_block *sb = net->dynroot_sb;
+	struct dentry *root, *subdir;
+
+	if (!sb || atomic_read(&sb->s_active) == 0)
+		return;
+
+	root = sb->s_root;
+	inode_lock(root->d_inode);
+
+	/* Don't want to trigger a lookup call, which will re-add the cell */
+	subdir = try_lookup_one_len(cell->name, root, cell->name_len);
+	if (IS_ERR_OR_NULL(subdir)) {
+		_debug("lookup %ld", PTR_ERR(subdir));
+		goto no_dentry;
+	}
+
+	_debug("rmdir %pd %u", subdir, d_count(subdir));
+
+	if (subdir->d_fsdata) {
+		_debug("unpin %u", d_count(subdir));
+		subdir->d_fsdata = NULL;
+		dput(subdir);
+	}
+	dput(subdir);
+no_dentry:
+	inode_unlock(root->d_inode);
+	_leave("");
+}
+
+/*
+ * Populate a newly created dynamic root with cell names.
+ */
+int afs_dynroot_populate(struct super_block *sb)
+{
+	struct afs_cell *cell;
+	struct afs_net *net = afs_sb2net(sb);
+	int ret;
+
+	if (mutex_lock_interruptible(&net->proc_cells_lock) < 0)
+		return -ERESTARTSYS;
+
+	net->dynroot_sb = sb;
+	list_for_each_entry(cell, &net->proc_cells, proc_link) {
+		ret = afs_dynroot_mkdir(net, cell);
+		if (ret < 0)
+			goto error;
+	}
+
+	ret = 0;
+out:
+	mutex_unlock(&net->proc_cells_lock);
+	return ret;
+
+error:
+	net->dynroot_sb = NULL;
+	goto out;
+}
+
+/*
+ * When a dynamic root that's in the process of being destroyed, depopulate it
+ * of pinned directories.
+ */
+void afs_dynroot_depopulate(struct super_block *sb)
+{
+	struct afs_net *net = afs_sb2net(sb);
+	struct dentry *root = sb->s_root, *subdir, *tmp;
+
+	/* Prevent more subdirs from being created */
+	mutex_lock(&net->proc_cells_lock);
+	if (net->dynroot_sb == sb)
+		net->dynroot_sb = NULL;
+	mutex_unlock(&net->proc_cells_lock);
+
+	inode_lock(root->d_inode);
+
+	/* Remove all the pins for dirs created for manually added cells */
+	list_for_each_entry_safe(subdir, tmp, &root->d_subdirs, d_child) {
+		if (subdir->d_fsdata) {
+			subdir->d_fsdata = NULL;
+			dput(subdir);
+		}
+	}
+
+	inode_unlock(root->d_inode);
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index bc3d8c87a938..ab6bdf456f1a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -239,7 +239,7 @@ struct afs_net {
 	atomic_t		cells_outstanding;
 	seqlock_t		cells_lock;
 
-	spinlock_t		proc_cells_lock;
+	struct mutex		proc_cells_lock;
 	struct list_head	proc_cells;
 
 	/* Known servers.  Theoretically each fileserver can only be in one
@@ -263,6 +263,7 @@ struct afs_net {
 	struct mutex		lock_manager_mutex;
 
 	/* Misc */
+	struct super_block	*dynroot_sb;	/* Dynamic root mount superblock */
 	struct proc_dir_entry	*proc_afs;	/* /proc/net/afs directory */
 	struct afs_sysnames	*sysnames;
 	rwlock_t		sysnames_lock;
@@ -721,6 +722,10 @@ extern const struct inode_operations afs_dynroot_inode_operations;
 extern const struct dentry_operations afs_dynroot_dentry_operations;
 
 extern struct inode *afs_try_auto_mntpt(struct dentry *, struct inode *);
+extern int afs_dynroot_mkdir(struct afs_net *, struct afs_cell *);
+extern void afs_dynroot_rmdir(struct afs_net *, struct afs_cell *);
+extern int afs_dynroot_populate(struct super_block *);
+extern void afs_dynroot_depopulate(struct super_block *);
 
 /*
  * file.c
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 7d2c1354e2ca..e84fe822a960 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -86,7 +86,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 	INIT_WORK(&net->cells_manager, afs_manage_cells);
 	timer_setup(&net->cells_timer, afs_cells_timer, 0);
 
-	spin_lock_init(&net->proc_cells_lock);
+	mutex_init(&net->proc_cells_lock);
 	INIT_LIST_HEAD(&net->proc_cells);
 
 	seqlock_init(&net->fs_lock);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 67135c2c3c9a..d524e4e6f290 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -365,12 +365,16 @@ static int afs_test_super(struct super_block *sb, struct fs_context *fc)
 
 	return (as->net_ns == fc->net_ns &&
 		as->volume &&
-		as->volume->vid == ctx->volume->vid);
+		as->volume->vid == ctx->volume->vid &&
+		!as->dyn_root);
 }
 
 static int afs_dynroot_test_super(struct super_block *sb, struct fs_context *fc)
 {
-	return false;
+	struct afs_super_info *as = AFS_FS_S(sb);
+
+	return (as->net_ns == fc->net_ns &&
+		as->dyn_root);
 }
 
 static int afs_set_super(struct super_block *sb, struct fs_context *fc)
@@ -426,10 +430,14 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	if (!sb->s_root)
 		goto error;
 
-	if (as->dyn_root)
+	if (as->dyn_root) {
 		sb->s_d_op = &afs_dynroot_dentry_operations;
-	else
+		ret = afs_dynroot_populate(sb);
+		if (ret < 0)
+			goto error;
+	} else {
 		sb->s_d_op = &afs_fs_dentry_operations;
+	}
 
 	_leave(" = 0");
 	return 0;
@@ -472,6 +480,9 @@ static void afs_kill_super(struct super_block *sb)
 	struct afs_super_info *as = AFS_FS_S(sb);
 	struct afs_net *net = afs_net(as->net_ns);
 
+	if (as->dyn_root)
+		afs_dynroot_depopulate(sb);
+	
 	/* Clear the callback interests (which will do ilookup5) before
 	 * deactivating the superblock.
 	 */
diff --git a/fs/namei.c b/fs/namei.c
index a59968de1636..2794a3b265ee 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2461,6 +2461,35 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
 	return inode_permission(base->d_inode, MAY_EXEC);
 }
 
+/**
+ * try_lookup_one_len - filesystem helper to lookup single pathname component
+ * @name:	pathname component to lookup
+ * @base:	base directory to lookup from
+ * @len:	maximum length @len should be interpreted to
+ *
+ * Look up a dentry by name in the dcache, returning NULL if it does not
+ * currently exist.  The function does not try to create a dentry.
+ *
+ * Note that this routine is purely a helper for filesystem usage and should
+ * not be called by generic code.
+ *
+ * The caller must hold base->i_mutex.
+ */
+struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int len)
+{
+	struct qstr this;
+	int err;
+
+	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
+
+	err = lookup_one_len_common(name, base, len, &this);
+	if (err)
+		return ERR_PTR(err);
+
+	return lookup_dcache(&this, base, 0);
+}
+EXPORT_SYMBOL(try_lookup_one_len);
+
 /**
  * lookup_one_len - filesystem helper to lookup single pathname component
  * @name:	pathname component to lookup
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a982bb7cd480..a78606e8e3df 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -81,6 +81,7 @@ extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
 extern int kern_path_mountpoint(int, const char *, struct path *, unsigned int);
 
+extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
 
