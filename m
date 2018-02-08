Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeBHQQ7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:16:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbeBHQQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:16:56 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 7/7] afs: Support the AFS dynamic root
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 16:16:49 +0000
Message-ID: <151810660949.20070.7564505641363848605.stgit@warthog.procyon.org.uk>
In-Reply-To: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
References: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the AFS dynamic root which is a pseudo-volume that doesn't connect
to any server resource, but rather is just a root directory that
dynamically creates mountpoint directories where the name of such a
directory is the name of the cell.

Such a mount can be created thus:

	mount -t afs none /afs -o dyn

Dynamic root superblocks aren't shared except by bind mounts and
propagation.  Cell root volumes can then be mounted by referring to them by
name, e.g.:

	ls /afs/grand.central.org/
	ls /afs/.grand.central.org/

The kernel will upcall to consult the DNS if the address wasn't supplied
directly.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/afs.txt |   17 +++++
 fs/afs/dir.c                      |  122 ++++++++++++++++++++++++++++++----
 fs/afs/inode.c                    |   48 ++++++++-----
 fs/afs/internal.h                 |   12 ++-
 fs/afs/mntpt.c                    |   20 +++---
 fs/afs/super.c                    |  132 +++++++++++++++++++++++++------------
 net/dns_resolver/dns_query.c      |   22 +++---
 7 files changed, 276 insertions(+), 97 deletions(-)

diff --git a/Documentation/filesystems/afs.txt b/Documentation/filesystems/afs.txt
index ba99b5ac4fd8..c5254f6d234d 100644
--- a/Documentation/filesystems/afs.txt
+++ b/Documentation/filesystems/afs.txt
@@ -7,6 +7,7 @@ Contents:
  - Overview.
  - Usage.
  - Mountpoints.
+ - Dynamic root.
  - Proc filesystem.
  - The cell database.
  - Security.
@@ -127,6 +128,22 @@ mounted on /afs in one go by doing:
 	umount /afs
 
 
+============
+DYNAMIC ROOT
+============
+
+A mount option is available to create a serverless mount that is only usable
+for dynamic lookup.  Creating such a mount can be done by, for example:
+
+	mount -t afs none /afs -o dyn
+
+This creates a mount that just has an empty directory at the root.  Attempting
+to look up a name in this directory will cause a mountpoint to be created that
+looks up a cell of the same name, for example:
+
+	ls /afs/grand.central.org/
+
+
 ===============
 PROC FILESYSTEM
 ===============
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 23c7f395d718..ba2b458b36d1 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -17,10 +17,13 @@
 #include <linux/pagemap.h>
 #include <linux/ctype.h>
 #include <linux/sched.h>
+#include <linux/dns_resolver.h>
 #include "internal.h"
 
 static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags);
+static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentry,
+					 unsigned int flags);
 static int afs_dir_open(struct inode *inode, struct file *file);
 static int afs_readdir(struct file *file, struct dir_context *ctx);
 static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
@@ -64,6 +67,17 @@ const struct inode_operations afs_dir_inode_operations = {
 	.listxattr	= afs_listxattr,
 };
 
+const struct file_operations afs_dynroot_file_operations = {
+	.open		= dcache_dir_open,
+	.release	= dcache_dir_close,
+	.iterate_shared	= dcache_readdir,
+	.llseek		= dcache_dir_lseek,
+};
+
+const struct inode_operations afs_dynroot_inode_operations = {
+	.lookup		= afs_dynroot_lookup,
+};
+
 const struct dentry_operations afs_fs_dentry_operations = {
 	.d_revalidate	= afs_d_revalidate,
 	.d_delete	= afs_d_delete,
@@ -468,25 +482,58 @@ static int afs_do_lookup(struct inode *dir, struct dentry *dentry,
 }
 
 /*
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
  * Try to auto mount the mountpoint with pseudo directory, if the autocell
  * operation is setted.
  */
-static struct inode *afs_try_auto_mntpt(
-	int ret, struct dentry *dentry, struct inode *dir, struct key *key,
-	struct afs_fid *fid)
+static struct inode *afs_try_auto_mntpt(struct dentry *dentry,
+					struct inode *dir, struct afs_fid *fid)
 {
-	const char *devname = dentry->d_name.name;
 	struct afs_vnode *vnode = AFS_FS_I(dir);
 	struct inode *inode;
+	int ret = -ENOENT;
 
-	_enter("%d, %p{%pd}, {%x:%u}, %p",
-	       ret, dentry, dentry, vnode->fid.vid, vnode->fid.vnode, key);
+	_enter("%p{%pd}, {%x:%u}",
+	       dentry, dentry, vnode->fid.vid, vnode->fid.vnode);
+
+	if (!test_bit(AFS_VNODE_AUTOCELL, &vnode->flags))
+		goto out;
 
-	if (ret != -ENOENT ||
-	    !test_bit(AFS_VNODE_AUTOCELL, &vnode->flags))
+	ret = afs_probe_cell_name(dentry);
+	if (ret < 0)
 		goto out;
 
-	inode = afs_iget_autocell(dir, devname, strlen(devname), key);
+	inode = afs_iget_pseudo_dir(dir->i_sb, false);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto out;
@@ -545,13 +592,16 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 
 	ret = afs_do_lookup(dir, dentry, &fid, key);
 	if (ret < 0) {
-		inode = afs_try_auto_mntpt(ret, dentry, dir, key, &fid);
-		if (!IS_ERR(inode)) {
-			key_put(key);
-			goto success;
+		if (ret == -ENOENT) {
+			inode = afs_try_auto_mntpt(dentry, dir, &fid);
+			if (!IS_ERR(inode)) {
+				key_put(key);
+				goto success;
+			}
+
+			ret = PTR_ERR(inode);
 		}
 
-		ret = PTR_ERR(inode);
 		key_put(key);
 		if (ret == -ENOENT) {
 			d_add(dentry, NULL);
@@ -583,12 +633,53 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 }
 
 /*
+ * Look up an entry in a dynroot directory.
+ */
+static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentry,
+					 unsigned int flags)
+{
+	struct afs_vnode *vnode;
+	struct afs_fid fid;
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
+	inode = afs_try_auto_mntpt(dentry, dir, &fid);
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
+/*
  * check that a dentry lookup hit has found a valid entry
  * - NOTE! the hit can be a negative hit too, so we can't assume we have an
  *   inode
  */
 static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
+	struct afs_super_info *as = dentry->d_sb->s_fs_info;
 	struct afs_vnode *vnode, *dir;
 	struct afs_fid uninitialized_var(fid);
 	struct dentry *parent;
@@ -600,6 +691,9 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
+	if (as->dyn_root)
+		return 1;
+
 	if (d_really_is_positive(dentry)) {
 		vnode = AFS_FS_I(d_inode(dentry));
 		_enter("{v={%x:%u} n=%pd fl=%lx},",
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index c7f17c44c7ce..6b39d0255b72 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -147,7 +147,7 @@ int afs_iget5_test(struct inode *inode, void *opaque)
  *
  * These pseudo inodes don't match anything.
  */
-static int afs_iget5_autocell_test(struct inode *inode, void *opaque)
+static int afs_iget5_pseudo_dir_test(struct inode *inode, void *opaque)
 {
 	return 0;
 }
@@ -169,31 +169,34 @@ static int afs_iget5_set(struct inode *inode, void *opaque)
 }
 
 /*
- * inode retrieval for autocell
+ * Create an inode for a dynamic root directory or an autocell dynamic
+ * automount dir.
  */
-struct inode *afs_iget_autocell(struct inode *dir, const char *dev_name,
-				int namesz, struct key *key)
+struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 {
 	struct afs_iget_data data;
 	struct afs_super_info *as;
 	struct afs_vnode *vnode;
-	struct super_block *sb;
 	struct inode *inode;
 	static atomic_t afs_autocell_ino;
 
-	_enter("{%x:%u},%*.*s,",
-	       AFS_FS_I(dir)->fid.vid, AFS_FS_I(dir)->fid.vnode,
-	       namesz, namesz, dev_name ?: "");
+	_enter("");
 
-	sb = dir->i_sb;
 	as = sb->s_fs_info;
-	data.volume = as->volume;
-	data.fid.vid = as->volume->vid;
-	data.fid.unique = 0;
-	data.fid.vnode = 0;
+	if (as->volume) {
+		data.volume = as->volume;
+		data.fid.vid = as->volume->vid;
+	}
+	if (root) {
+		data.fid.vnode = 1;
+		data.fid.unique = 1;
+	} else {
+		data.fid.vnode = atomic_inc_return(&afs_autocell_ino);
+		data.fid.unique = 0;
+	}
 
-	inode = iget5_locked(sb, atomic_inc_return(&afs_autocell_ino),
-			     afs_iget5_autocell_test, afs_iget5_set,
+	inode = iget5_locked(sb, data.fid.vnode,
+			     afs_iget5_pseudo_dir_test, afs_iget5_set,
 			     &data);
 	if (!inode) {
 		_leave(" = -ENOMEM");
@@ -211,7 +214,12 @@ struct inode *afs_iget_autocell(struct inode *dir, const char *dev_name,
 
 	inode->i_size		= 0;
 	inode->i_mode		= S_IFDIR | S_IRUGO | S_IXUGO;
-	inode->i_op		= &afs_autocell_inode_operations;
+	if (root) {
+		inode->i_op	= &afs_dynroot_inode_operations;
+		inode->i_fop	= &afs_dynroot_file_operations;
+	} else {
+		inode->i_op	= &afs_autocell_inode_operations;
+	}
 	set_nlink(inode, 2);
 	inode->i_uid		= GLOBAL_ROOT_UID;
 	inode->i_gid		= GLOBAL_ROOT_GID;
@@ -223,8 +231,12 @@ struct inode *afs_iget_autocell(struct inode *dir, const char *dev_name,
 	inode->i_generation	= 0;
 
 	set_bit(AFS_VNODE_PSEUDODIR, &vnode->flags);
-	set_bit(AFS_VNODE_MOUNTPOINT, &vnode->flags);
-	inode->i_flags |= S_AUTOMOUNT | S_NOATIME;
+	if (!root) {
+		set_bit(AFS_VNODE_MOUNTPOINT, &vnode->flags);
+		inode->i_flags |= S_AUTOMOUNT;
+	}
+
+	inode->i_flags |= S_NOATIME;
 	unlock_new_inode(inode);
 	_leave(" = %p", inode);
 	return inode;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 804d1f905622..f38d6a561a84 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -36,6 +36,7 @@ struct afs_mount_params {
 	bool			rwpath;		/* T if the parent should be considered R/W */
 	bool			force;		/* T to force cell type */
 	bool			autocell;	/* T if set auto mount operation */
+	bool			dyn_root;	/* T if dynamic root */
 	afs_voltype_t		type;		/* type of volume requested */
 	int			volnamesz;	/* size of volume name */
 	const char		*volname;	/* name of volume to mount */
@@ -186,6 +187,7 @@ struct afs_super_info {
 	struct afs_net		*net;		/* Network namespace */
 	struct afs_cell		*cell;		/* The cell in which the volume resides */
 	struct afs_volume	*volume;	/* volume record */
+	bool			dyn_root;	/* True if dynamic root */
 };
 
 static inline struct afs_super_info *AFS_FS_S(struct super_block *sb)
@@ -634,10 +636,13 @@ extern bool afs_cm_incoming_call(struct afs_call *);
 /*
  * dir.c
  */
-extern bool afs_dir_check_page(struct inode *, struct page *);
+extern const struct file_operations afs_dir_file_operations;
 extern const struct inode_operations afs_dir_inode_operations;
+extern const struct file_operations afs_dynroot_file_operations;
+extern const struct inode_operations afs_dynroot_inode_operations;
 extern const struct dentry_operations afs_fs_dentry_operations;
-extern const struct file_operations afs_dir_file_operations;
+
+extern bool afs_dir_check_page(struct inode *, struct page *);
 
 /*
  * file.c
@@ -695,8 +700,7 @@ extern int afs_fs_get_capabilities(struct afs_net *, struct afs_server *,
  */
 extern int afs_fetch_status(struct afs_vnode *, struct key *);
 extern int afs_iget5_test(struct inode *, void *);
-extern struct inode *afs_iget_autocell(struct inode *, const char *, int,
-				       struct key *);
+extern struct inode *afs_iget_pseudo_dir(struct super_block *, bool);
 extern struct inode *afs_iget(struct super_block *, struct key *,
 			      struct afs_fid *, struct afs_file_status *,
 			      struct afs_callback *,
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 690fea9d84c3..99fd13500a97 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -72,7 +72,7 @@ static int afs_mntpt_open(struct inode *inode, struct file *file)
  */
 static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
 {
-	struct afs_super_info *super;
+	struct afs_super_info *as;
 	struct vfsmount *mnt;
 	struct afs_vnode *vnode;
 	struct page *page;
@@ -104,13 +104,13 @@ static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
 			goto error_no_page;
 
 		if (mntpt->d_name.name[0] == '.') {
-			devname[0] = '#';
-			memcpy(devname + 1, mntpt->d_name.name, size - 1);
+			devname[0] = '%';
+			memcpy(devname + 1, mntpt->d_name.name + 1, size - 1);
 			memcpy(devname + size, afs_root_cell,
 			       sizeof(afs_root_cell));
 			rwpath = true;
 		} else {
-			devname[0] = '%';
+			devname[0] = '#';
 			memcpy(devname + 1, mntpt->d_name.name, size);
 			memcpy(devname + size + 1, afs_root_cell,
 			       sizeof(afs_root_cell));
@@ -142,11 +142,13 @@ static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
 	}
 
 	/* work out what options we want */
-	super = AFS_FS_S(mntpt->d_sb);
-	memcpy(options, "cell=", 5);
-	strcpy(options + 5, super->volume->cell->name);
-	if (super->volume->type == AFSVL_RWVOL || rwpath)
-		strcat(options, ",rwpath");
+	as = AFS_FS_S(mntpt->d_sb);
+	if (as->cell) {
+		memcpy(options, "cell=", 5);
+		strcpy(options + 5, as->cell->name);
+		if ((as->volume && as->volume->type == AFSVL_RWVOL) || rwpath)
+			strcat(options, ",rwpath");
+	}
 
 	/* try and do the mount */
 	_debug("--- attempting mount %s -o %s ---", devname, options);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 1037dd41a622..3623c952b6ff 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -64,6 +64,7 @@ static atomic_t afs_count_active_inodes;
 enum {
 	afs_no_opt,
 	afs_opt_cell,
+	afs_opt_dyn,
 	afs_opt_rwpath,
 	afs_opt_vol,
 	afs_opt_autocell,
@@ -71,6 +72,7 @@ enum {
 
 static const match_table_t afs_options_list = {
 	{ afs_opt_cell,		"cell=%s"	},
+	{ afs_opt_dyn,		"dyn"		},
 	{ afs_opt_rwpath,	"rwpath"	},
 	{ afs_opt_vol,		"vol=%s"	},
 	{ afs_opt_autocell,	"autocell"	},
@@ -148,6 +150,11 @@ static int afs_show_devname(struct seq_file *m, struct dentry *root)
 	const char *suf = "";
 	char pref = '%';
 
+	if (as->dyn_root) {
+		seq_puts(m, "none");
+		return 0;
+	}
+	
 	switch (volume->type) {
 	case AFSVL_RWVOL:
 		break;
@@ -171,8 +178,12 @@ static int afs_show_devname(struct seq_file *m, struct dentry *root)
  */
 static int afs_show_options(struct seq_file *m, struct dentry *root)
 {
+	struct afs_super_info *as = AFS_FS_S(root->d_sb);
+
+	if (as->dyn_root)
+		seq_puts(m, ",dyn");
 	if (test_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(d_inode(root))->flags))
-		seq_puts(m, "autocell");
+		seq_puts(m, ",autocell");
 	return 0;
 }
 
@@ -212,7 +223,7 @@ static int afs_parse_options(struct afs_mount_params *params,
 			break;
 
 		case afs_opt_rwpath:
-			params->rwpath = 1;
+			params->rwpath = true;
 			break;
 
 		case afs_opt_vol:
@@ -220,7 +231,11 @@ static int afs_parse_options(struct afs_mount_params *params,
 			break;
 
 		case afs_opt_autocell:
-			params->autocell = 1;
+			params->autocell = true;
+			break;
+
+		case afs_opt_dyn:
+			params->dyn_root = true;
 			break;
 
 		default:
@@ -254,7 +269,7 @@ static int afs_parse_device_name(struct afs_mount_params *params,
 	int cellnamesz;
 
 	_enter(",%s", name);
-
+	
 	if (!name) {
 		printk(KERN_ERR "kAFS: no volume name specified\n");
 		return -EINVAL;
@@ -336,7 +351,14 @@ static int afs_test_super(struct super_block *sb, void *data)
 	struct afs_super_info *as1 = data;
 	struct afs_super_info *as = AFS_FS_S(sb);
 
-	return as->net == as1->net && as->volume->vid == as1->volume->vid;
+	return (as->net == as1->net &&
+		as->volume &&
+		as->volume->vid == as1->volume->vid);
+}
+
+static int afs_dynroot_test_super(struct super_block *sb, void *data)
+{
+	return false;
 }
 
 static int afs_set_super(struct super_block *sb, void *data)
@@ -365,24 +387,30 @@ static int afs_fill_super(struct super_block *sb,
 	sb->s_blocksize_bits	= PAGE_SHIFT;
 	sb->s_magic		= AFS_FS_MAGIC;
 	sb->s_op		= &afs_super_ops;
-	sb->s_xattr		= afs_xattr_handlers;
+	if (!as->dyn_root)
+		sb->s_xattr	= afs_xattr_handlers;
 	ret = super_setup_bdi(sb);
 	if (ret)
 		return ret;
 	sb->s_bdi->ra_pages	= VM_MAX_READAHEAD * 1024 / PAGE_SIZE;
-	sprintf(sb->s_id, "%u", as->volume->vid);
-
-	afs_activate_volume(as->volume);
 
 	/* allocate the root inode and dentry */
-	fid.vid		= as->volume->vid;
-	fid.vnode	= 1;
-	fid.unique	= 1;
-	inode = afs_iget(sb, params->key, &fid, NULL, NULL, NULL);
+	if (as->dyn_root) {
+		inode = afs_iget_pseudo_dir(sb, true);
+		sb->s_flags	|= SB_RDONLY;
+	} else {
+		sprintf(sb->s_id, "%u", as->volume->vid);
+		afs_activate_volume(as->volume);
+		fid.vid		= as->volume->vid;
+		fid.vnode	= 1;
+		fid.unique	= 1;
+		inode = afs_iget(sb, params->key, &fid, NULL, NULL, NULL);
+	}
+
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (params->autocell)
+	if (params->autocell || params->dyn_root)
 		set_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(inode)->flags);
 
 	ret = -ENOMEM;
@@ -407,7 +435,10 @@ static struct afs_super_info *afs_alloc_sbi(struct afs_mount_params *params)
 	as = kzalloc(sizeof(struct afs_super_info), GFP_KERNEL);
 	if (as) {
 		as->net = afs_get_net(params->net);
-		as->cell = afs_get_cell(params->cell);
+		if (params->dyn_root)
+			as->dyn_root = true;
+		else
+			as->cell = afs_get_cell(params->cell);
 	}
 	return as;
 }
@@ -451,18 +482,20 @@ static struct dentry *afs_mount(struct file_system_type *fs_type,
 			goto error;
 	}
 
-	ret = afs_parse_device_name(&params, dev_name);
-	if (ret < 0)
-		goto error;
+	if (!params.dyn_root) {
+		ret = afs_parse_device_name(&params, dev_name);
+		if (ret < 0)
+			goto error;
 
-	/* try and do the mount securely */
-	key = afs_request_key(params.cell);
-	if (IS_ERR(key)) {
-		_leave(" = %ld [key]", PTR_ERR(key));
-		ret = PTR_ERR(key);
-		goto error;
+		/* try and do the mount securely */
+		key = afs_request_key(params.cell);
+		if (IS_ERR(key)) {
+			_leave(" = %ld [key]", PTR_ERR(key));
+			ret = PTR_ERR(key);
+			goto error;
+		}
+		params.key = key;
 	}
-	params.key = key;
 
 	/* allocate a superblock info record */
 	ret = -ENOMEM;
@@ -470,20 +503,25 @@ static struct dentry *afs_mount(struct file_system_type *fs_type,
 	if (!as)
 		goto error_key;
 
-	/* Assume we're going to need a volume record; at the very least we can
-	 * use it to update the volume record if we have one already.  This
-	 * checks that the volume exists within the cell.
-	 */
-	candidate = afs_create_volume(&params);
-	if (IS_ERR(candidate)) {
-		ret = PTR_ERR(candidate);
-		goto error_as;
-	}
+	if (!params.dyn_root) {
+		/* Assume we're going to need a volume record; at the very
+		 * least we can use it to update the volume record if we have
+		 * one already.  This checks that the volume exists within the
+		 * cell.
+		 */
+		candidate = afs_create_volume(&params);
+		if (IS_ERR(candidate)) {
+			ret = PTR_ERR(candidate);
+			goto error_as;
+		}
 
-	as->volume = candidate;
+		as->volume = candidate;
+	}
 
 	/* allocate a deviceless superblock */
-	sb = sget(fs_type, afs_test_super, afs_set_super, flags, as);
+	sb = sget(fs_type,
+		  as->dyn_root ? afs_dynroot_test_super : afs_test_super,
+		  afs_set_super, flags, as);
 	if (IS_ERR(sb)) {
 		ret = PTR_ERR(sb);
 		goto error_as;
@@ -529,9 +567,11 @@ static void afs_kill_super(struct super_block *sb)
 	/* Clear the callback interests (which will do ilookup5) before
 	 * deactivating the superblock.
 	 */
-	afs_clear_callback_interests(as->net, as->volume->servers);
+	if (as->volume)
+		afs_clear_callback_interests(as->net, as->volume->servers);
 	kill_anon_super(sb);
-	afs_deactivate_volume(as->volume);
+	if (as->volume)
+		afs_deactivate_volume(as->volume);
 	afs_destroy_sbi(as);
 }
 
@@ -619,12 +659,24 @@ static void afs_destroy_inode(struct inode *inode)
  */
 static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct afs_super_info *as = AFS_FS_S(dentry->d_sb);
 	struct afs_fs_cursor fc;
 	struct afs_volume_status vs;
 	struct afs_vnode *vnode = AFS_FS_I(d_inode(dentry));
 	struct key *key;
 	int ret;
 
+	buf->f_type	= dentry->d_sb->s_magic;
+	buf->f_bsize	= AFS_BLOCK_SIZE;
+	buf->f_namelen	= AFSNAMEMAX - 1;
+
+	if (as->dyn_root) {
+		buf->f_blocks	= 1;
+		buf->f_bavail	= 0;
+		buf->f_bfree	= 0;
+		return 0;
+	}
+	
 	key = afs_request_key(vnode->volume->cell);
 	if (IS_ERR(key))
 		return PTR_ERR(key);
@@ -645,10 +697,6 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	key_put(key);
 
 	if (ret == 0) {
-		buf->f_type	= dentry->d_sb->s_magic;
-		buf->f_bsize	= AFS_BLOCK_SIZE;
-		buf->f_namelen	= AFSNAMEMAX - 1;
-
 		if (vs.max_quota == 0)
 			buf->f_blocks = vs.part_max_blocks;
 		else
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index af781010753b..49da67034f29 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -52,11 +52,11 @@
  * @name: Name to look up
  * @namelen: Length of name
  * @options: Request options (or NULL if no options)
- * @_result: Where to place the returned data.
+ * @_result: Where to place the returned data (or NULL)
  * @_expiry: Where to store the result expiry time (or NULL)
  *
- * The data will be returned in the pointer at *result, and the caller is
- * responsible for freeing it.
+ * The data will be returned in the pointer at *result, if provided, and the
+ * caller is responsible for freeing it.
  *
  * The description should be of the form "[<query_type>:]<domain_name>", and
  * the options need to be appropriate for the query type requested.  If no
@@ -81,7 +81,7 @@ int dns_query(const char *type, const char *name, size_t namelen,
 	kenter("%s,%*.*s,%zu,%s",
 	       type, (int)namelen, (int)namelen, name, namelen, options);
 
-	if (!name || namelen == 0 || !_result)
+	if (!name || namelen == 0)
 		return -EINVAL;
 
 	/* construct the query key description as "[<type>:]<name>" */
@@ -146,13 +146,15 @@ int dns_query(const char *type, const char *name, size_t namelen,
 	upayload = user_key_payload_locked(rkey);
 	len = upayload->datalen;
 
-	ret = -ENOMEM;
-	*_result = kmalloc(len + 1, GFP_KERNEL);
-	if (!*_result)
-		goto put;
+	if (_result) {
+		ret = -ENOMEM;
+		*_result = kmalloc(len + 1, GFP_KERNEL);
+		if (!*_result)
+			goto put;
 
-	memcpy(*_result, upayload->data, len);
-	(*_result)[len] = '\0';
+		memcpy(*_result, upayload->data, len);
+		(*_result)[len] = '\0';
+	}
 
 	if (_expiry)
 		*_expiry = rkey->expiry;
