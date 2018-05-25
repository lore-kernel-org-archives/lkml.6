Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971882AbeEYAIM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:08:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965178AbeEYAIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:08:07 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 25/32] afs: Add fs_context support [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:08:05 +0100
Message-ID: <152720688593.9073.6282893137674299880.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fs_context support to the AFS filesystem, converting the parameter
parsing to store options there.

This will form the basis for namespace propagation over mountpoints within
the AFS model, thereby allowing AFS to be used in containers more easily.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h |    8 -
 fs/afs/super.c    |  444 ++++++++++++++++++++++++++++++-----------------------
 fs/afs/volume.c   |    4 
 3 files changed, 256 insertions(+), 200 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e6cef5702ae2..eb6e75e00181 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -34,15 +34,15 @@
 struct pagevec;
 struct afs_call;
 
-struct afs_mount_params {
+struct afs_fs_context {
 	bool			rwpath;		/* T if the parent should be considered R/W */
 	bool			force;		/* T to force cell type */
 	bool			autocell;	/* T if set auto mount operation */
 	bool			dyn_root;	/* T if dynamic root */
+	bool			no_cell;	/* T if the source is "none" (for dynroot) */
 	afs_voltype_t		type;		/* type of volume requested */
-	int			volnamesz;	/* size of volume name */
+	unsigned int		volnamesz;	/* size of volume name */
 	const char		*volname;	/* name of volume to mount */
-	struct net		*net_ns;	/* Network namespace in effect */
 	struct afs_net		*net;		/* the AFS net namespace stuff */
 	struct afs_cell		*cell;		/* cell in which to find volume */
 	struct afs_volume	*volume;	/* volume record */
@@ -1012,7 +1012,7 @@ static inline struct afs_volume *__afs_get_volume(struct afs_volume *volume)
 	return volume;
 }
 
-extern struct afs_volume *afs_create_volume(struct afs_mount_params *);
+extern struct afs_volume *afs_create_volume(struct afs_fs_context *);
 extern void afs_activate_volume(struct afs_volume *);
 extern void afs_deactivate_volume(struct afs_volume *);
 extern void afs_put_volume(struct afs_cell *, struct afs_volume *);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index a562b90ad660..f0494f36d548 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -1,6 +1,6 @@
 /* AFS superblock handling
  *
- * Copyright (c) 2002, 2007 Red Hat, Inc. All rights reserved.
+ * Copyright (c) 2002, 2007, 2018 Red Hat, Inc. All rights reserved.
  *
  * This software may be freely redistributed under the terms of the
  * GNU General Public License.
@@ -30,22 +30,20 @@
 #include "internal.h"
 
 static void afs_i_init_once(void *foo);
-static struct dentry *afs_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name,
-				void *data, size_t data_size);
 static void afs_kill_super(struct super_block *sb);
 static struct inode *afs_alloc_inode(struct super_block *sb);
 static void afs_destroy_inode(struct inode *inode);
 static int afs_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int afs_show_devname(struct seq_file *m, struct dentry *root);
 static int afs_show_options(struct seq_file *m, struct dentry *root);
+static int afs_init_fs_context(struct fs_context *fc, struct dentry *reference);
 
 struct file_system_type afs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "afs",
-	.mount		= afs_mount,
-	.kill_sb	= afs_kill_super,
-	.fs_flags	= 0,
+	.owner			= THIS_MODULE,
+	.name			= "afs",
+	.init_fs_context	= afs_init_fs_context,
+	.kill_sb		= afs_kill_super,
+	.fs_flags		= 0,
 };
 MODULE_ALIAS_FS("afs");
 
@@ -191,61 +189,53 @@ static int afs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 /*
- * parse the mount options
- * - this function has been shamelessly adapted from the ext3 fs which
- *   shamelessly adapted it from the msdos fs
+ * Parse an single mount option.
  */
-static int afs_parse_options(struct afs_mount_params *params,
-			     char *options, const char **devname)
+static int afs_parse_option(struct fs_context *fc, char *opt, size_t len)
 {
+	struct afs_fs_context *ctx = fc->fs_private;
 	struct afs_cell *cell;
 	substring_t args[MAX_OPT_ARGS];
-	char *p;
-	int token;
-
-	_enter("%s", options);
-
-	options[PAGE_SIZE - 1] = 0;
-
-	while ((p = strsep(&options, ","))) {
-		if (!*p)
-			continue;
-
-		token = match_token(p, afs_options_list, args);
-		switch (token) {
-		case afs_opt_cell:
-			rcu_read_lock();
-			cell = afs_lookup_cell_rcu(params->net,
-						   args[0].from,
-						   args[0].to - args[0].from);
-			rcu_read_unlock();
-			if (IS_ERR(cell))
-				return PTR_ERR(cell);
-			afs_put_cell(params->net, params->cell);
-			params->cell = cell;
-			break;
-
-		case afs_opt_rwpath:
-			params->rwpath = true;
-			break;
-
-		case afs_opt_vol:
-			*devname = args[0].from;
-			break;
-
-		case afs_opt_autocell:
-			params->autocell = true;
-			break;
-
-		case afs_opt_dyn:
-			params->dyn_root = true;
-			break;
-
-		default:
-			printk(KERN_ERR "kAFS:"
-			       " Unknown or invalid mount option: '%s'\n", p);
+	int token, size;
+
+	_enter("%s", opt);
+
+	token = match_token(opt, afs_options_list, args);
+	switch (token) {
+	case afs_opt_cell:
+		size = args[0].to - args[0].from;
+		if (size <= 0)
 			return -EINVAL;
-		}
+		if (size > AFS_MAXCELLNAME)
+			return -ENAMETOOLONG;
+
+		rcu_read_lock();
+		cell = afs_lookup_cell_rcu(ctx->net, args[0].from, size);
+		rcu_read_unlock();
+		if (IS_ERR(cell))
+			return PTR_ERR(cell);
+		afs_put_cell(ctx->net, ctx->cell);
+		ctx->cell = cell;
+		break;
+
+	case afs_opt_rwpath:
+		ctx->rwpath = true;
+		break;
+
+	case afs_opt_vol:
+		return -EINVAL; /* Not required for automount */
+
+	case afs_opt_autocell:
+		ctx->autocell = true;
+		break;
+
+	case afs_opt_dyn:
+		ctx->dyn_root = true;
+		break;
+
+	default:
+		printk(KERN_ERR "kAFS: Unknown or invalid mount option: '%s'\n", opt);
+		return -EINVAL;
 	}
 
 	_leave(" = 0");
@@ -253,9 +243,10 @@ static int afs_parse_options(struct afs_mount_params *params,
 }
 
 /*
- * parse a device name to get cell name, volume name, volume type and R/W
- * selector
- * - this can be one of the following:
+ * Parse the source name to get cell name, volume name, volume type and R/W
+ * selector.
+ *
+ * This can be one of the following:
  *	"%[cell:]volume[.]"		R/W volume
  *	"#[cell:]volume[.]"		R/O or R/W volume (rwpath=0),
  *					 or R/W (rwpath=1) volume
@@ -264,9 +255,9 @@ static int afs_parse_options(struct afs_mount_params *params,
  *	"%[cell:]volume.backup"		Backup volume
  *	"#[cell:]volume.backup"		Backup volume
  */
-static int afs_parse_device_name(struct afs_mount_params *params,
-				 const char *name)
+static int afs_parse_source(struct fs_context *fc, char *name)
 {
+	struct afs_fs_context *ctx = fc->fs_private;
 	struct afs_cell *cell;
 	const char *cellname, *suffix;
 	int cellnamesz;
@@ -279,69 +270,116 @@ static int afs_parse_device_name(struct afs_mount_params *params,
 	}
 
 	if ((name[0] != '%' && name[0] != '#') || !name[1]) {
+		/* To use dynroot, we don't want to have to provide a source */
+		if (strcmp(name, "none") == 0) {
+			ctx->no_cell = true;
+			return 0;
+		}
 		printk(KERN_ERR "kAFS: unparsable volume name\n");
 		return -EINVAL;
 	}
 
 	/* determine the type of volume we're looking for */
-	params->type = AFSVL_ROVOL;
-	params->force = false;
-	if (params->rwpath || name[0] == '%') {
-		params->type = AFSVL_RWVOL;
-		params->force = true;
+	ctx->type = AFSVL_ROVOL;
+	ctx->force = false;
+	if (ctx->rwpath || name[0] == '%') {
+		ctx->type = AFSVL_RWVOL;
+		ctx->force = true;
 	}
 	name++;
 
 	/* split the cell name out if there is one */
-	params->volname = strchr(name, ':');
-	if (params->volname) {
+	ctx->volname = strchr(name, ':');
+	if (ctx->volname) {
 		cellname = name;
-		cellnamesz = params->volname - name;
-		params->volname++;
+		cellnamesz = ctx->volname - name;
+		ctx->volname++;
 	} else {
-		params->volname = name;
+		ctx->volname = name;
 		cellname = NULL;
 		cellnamesz = 0;
 	}
 
 	/* the volume type is further affected by a possible suffix */
-	suffix = strrchr(params->volname, '.');
+	suffix = strrchr(ctx->volname, '.');
 	if (suffix) {
 		if (strcmp(suffix, ".readonly") == 0) {
-			params->type = AFSVL_ROVOL;
-			params->force = true;
+			ctx->type = AFSVL_ROVOL;
+			ctx->force = true;
 		} else if (strcmp(suffix, ".backup") == 0) {
-			params->type = AFSVL_BACKVOL;
-			params->force = true;
+			ctx->type = AFSVL_BACKVOL;
+			ctx->force = true;
 		} else if (suffix[1] == 0) {
 		} else {
 			suffix = NULL;
 		}
 	}
 
-	params->volnamesz = suffix ?
-		suffix - params->volname : strlen(params->volname);
+	ctx->volnamesz = suffix ?
+		suffix - ctx->volname : strlen(ctx->volname);
 
 	_debug("cell %*.*s [%p]",
-	       cellnamesz, cellnamesz, cellname ?: "", params->cell);
+	       cellnamesz, cellnamesz, cellname ?: "", ctx->cell);
 
 	/* lookup the cell record */
-	if (cellname || !params->cell) {
-		cell = afs_lookup_cell(params->net, cellname, cellnamesz,
+	if (cellname) {
+		cell = afs_lookup_cell(ctx->net, cellname, cellnamesz,
 				       NULL, false);
 		if (IS_ERR(cell)) {
-			printk(KERN_ERR "kAFS: unable to lookup cell '%*.*s'\n",
+			pr_err("kAFS: unable to lookup cell '%*.*s'\n",
 			       cellnamesz, cellnamesz, cellname ?: "");
 			return PTR_ERR(cell);
 		}
-		afs_put_cell(params->net, params->cell);
-		params->cell = cell;
+		afs_put_cell(ctx->net, ctx->cell);
+		ctx->cell = cell;
 	}
 
 	_debug("CELL:%s [%p] VOLUME:%*.*s SUFFIX:%s TYPE:%d%s",
-	       params->cell->name, params->cell,
-	       params->volnamesz, params->volnamesz, params->volname,
-	       suffix ?: "-", params->type, params->force ? " FORCE" : "");
+	       ctx->cell->name, ctx->cell,
+	       ctx->volnamesz, ctx->volnamesz, ctx->volname,
+	       suffix ?: "-", ctx->type, ctx->force ? " FORCE" : "");
+
+	return 0;
+}
+
+/*
+ * Validate the options, get the cell key and look up the volume.
+ */
+static int afs_validate_fc(struct fs_context *fc)
+{
+	struct afs_fs_context *ctx = fc->fs_private;
+	struct afs_volume *volume;
+	struct key *key;
+
+	if (!ctx->dyn_root) {
+		if (ctx->no_cell) {
+			pr_warn("kAFS: Can only specify source 'none' with -o dyn\n");
+			return -EINVAL;
+		}
+
+		if (!ctx->cell) {
+			pr_warn("kAFS: No cell specified\n");
+			return -EDESTADDRREQ;
+		}
+
+		/* We try to do the mount securely. */
+		key = afs_request_key(ctx->cell);
+		if (IS_ERR(key))
+			return PTR_ERR(key);
+
+		ctx->key = key;
+
+		if (ctx->volume) {
+			afs_put_volume(ctx->cell, ctx->volume);
+			ctx->volume = NULL;
+		}
+
+		volume = afs_create_volume(ctx);
+		if (IS_ERR(volume))
+			return PTR_ERR(volume);
+
+		ctx->volume = volume;
+	}
 
 	return 0;
 }
@@ -349,34 +387,30 @@ static int afs_parse_device_name(struct afs_mount_params *params,
 /*
  * check a superblock to see if it's the one we're looking for
  */
-static int afs_test_super(struct super_block *sb, void *data)
+static int afs_test_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct afs_super_info *as1 = data;
+	struct afs_fs_context *ctx = fc->fs_private;
 	struct afs_super_info *as = AFS_FS_S(sb);
 
-	return (as->net_ns == as1->net_ns &&
+	return (as->net_ns == fc->net_ns &&
 		as->volume &&
-		as->volume->vid == as1->volume->vid);
+		as->volume->vid == ctx->volume->vid);
 }
 
-static int afs_dynroot_test_super(struct super_block *sb, void *data)
+static int afs_dynroot_test_super(struct super_block *sb, struct fs_context *fc)
 {
 	return false;
 }
 
-static int afs_set_super(struct super_block *sb, void *data)
+static int afs_set_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct afs_super_info *as = data;
-
-	sb->s_fs_info = as;
 	return set_anon_super(sb, NULL);
 }
 
 /*
  * fill in the superblock
  */
-static int afs_fill_super(struct super_block *sb,
-			  struct afs_mount_params *params)
+static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 {
 	struct afs_super_info *as = AFS_FS_S(sb);
 	struct afs_fid fid;
@@ -407,13 +441,13 @@ static int afs_fill_super(struct super_block *sb,
 		fid.vid		= as->volume->vid;
 		fid.vnode	= 1;
 		fid.unique	= 1;
-		inode = afs_iget(sb, params->key, &fid, NULL, NULL, NULL);
+		inode = afs_iget(sb, ctx->key, &fid, NULL, NULL, NULL);
 	}
 
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (params->autocell || params->dyn_root)
+	if (ctx->autocell || as->dyn_root)
 		set_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(inode)->flags);
 
 	ret = -ENOMEM;
@@ -421,7 +455,7 @@ static int afs_fill_super(struct super_block *sb,
 	if (!sb->s_root)
 		goto error;
 
-	if (params->dyn_root)
+	if (as->dyn_root)
 		sb->s_d_op = &afs_dynroot_dentry_operations;
 	else
 		sb->s_d_op = &afs_fs_dentry_operations;
@@ -434,17 +468,20 @@ static int afs_fill_super(struct super_block *sb,
 	return ret;
 }
 
-static struct afs_super_info *afs_alloc_sbi(struct afs_mount_params *params)
+static struct afs_super_info *afs_alloc_sbi(struct fs_context *fc)
 {
+	struct afs_fs_context *ctx = fc->fs_private;
 	struct afs_super_info *as;
 
 	as = kzalloc(sizeof(struct afs_super_info), GFP_KERNEL);
 	if (as) {
-		as->net_ns = get_net(params->net_ns);
-		if (params->dyn_root)
+		as->net_ns = get_net(fc->net_ns);
+		if (ctx->dyn_root) {
 			as->dyn_root = true;
-		else
-			as->cell = afs_get_cell(params->cell);
+		} else {
+			as->cell = afs_get_cell(ctx->cell);
+			as->volume = __afs_get_volume(ctx->volume);
+		}
 	}
 	return as;
 }
@@ -459,129 +496,148 @@ static void afs_destroy_sbi(struct afs_super_info *as)
 	}
 }
 
+static void afs_kill_super(struct super_block *sb)
+{
+	struct afs_super_info *as = AFS_FS_S(sb);
+	struct afs_net *net = afs_net(as->net_ns);
+
+	/* Clear the callback interests (which will do ilookup5) before
+	 * deactivating the superblock.
+	 */
+	if (as->volume)
+		afs_clear_callback_interests(net, as->volume->servers);
+	kill_anon_super(sb);
+	if (as->volume)
+		afs_deactivate_volume(as->volume);
+	afs_destroy_sbi(as);
+}
+
 /*
- * get an AFS superblock
+ * Get an AFS superblock and root directory.
  */
-static struct dentry *afs_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name,
-				void *options, size_t data_size)
+static int afs_get_tree(struct fs_context *fc)
 {
-	struct afs_mount_params params;
+	struct afs_fs_context *ctx = fc->fs_private;
 	struct super_block *sb;
-	struct afs_volume *candidate;
-	struct key *key;
 	struct afs_super_info *as;
 	int ret;
 
-	_enter(",,%s,%p", dev_name, options);
-
-	memset(&params, 0, sizeof(params));
-
-	ret = -EINVAL;
-	if (current->nsproxy->net_ns != &init_net)
-		goto error;
-	params.net_ns = current->nsproxy->net_ns;
-	params.net = afs_net(params.net_ns);
-	
-	/* parse the options and device name */
-	if (options) {
-		ret = afs_parse_options(&params, options, &dev_name);
-		if (ret < 0)
-			goto error;
-	}
-
-	if (!params.dyn_root) {
-		ret = afs_parse_device_name(&params, dev_name);
-		if (ret < 0)
-			goto error;
-
-		/* try and do the mount securely */
-		key = afs_request_key(params.cell);
-		if (IS_ERR(key)) {
-			_leave(" = %ld [key]", PTR_ERR(key));
-			ret = PTR_ERR(key);
-			goto error;
-		}
-		params.key = key;
-	}
+	_enter("%s", fc->source);
 
 	/* allocate a superblock info record */
 	ret = -ENOMEM;
-	as = afs_alloc_sbi(&params);
+	as = afs_alloc_sbi(fc);
 	if (!as)
-		goto error_key;
-
-	if (!params.dyn_root) {
-		/* Assume we're going to need a volume record; at the very
-		 * least we can use it to update the volume record if we have
-		 * one already.  This checks that the volume exists within the
-		 * cell.
-		 */
-		candidate = afs_create_volume(&params);
-		if (IS_ERR(candidate)) {
-			ret = PTR_ERR(candidate);
-			goto error_as;
-		}
-
-		as->volume = candidate;
-	}
+		goto error;
+	fc->s_fs_info = as;
 
 	/* allocate a deviceless superblock */
-	sb = sget(fs_type,
-		  as->dyn_root ? afs_dynroot_test_super : afs_test_super,
-		  afs_set_super, flags, as);
+	sb = sget_fc(fc,
+		     as->dyn_root ? afs_dynroot_test_super : afs_test_super,
+		     afs_set_super);
 	if (IS_ERR(sb)) {
 		ret = PTR_ERR(sb);
-		goto error_as;
+		goto error;
 	}
 
 	if (!sb->s_root) {
 		/* initial superblock/root creation */
 		_debug("create");
-		ret = afs_fill_super(sb, &params);
+		ret = afs_fill_super(sb, ctx);
 		if (ret < 0)
 			goto error_sb;
-		as = NULL;
 		sb->s_flags |= SB_ACTIVE;
 	} else {
 		_debug("reuse");
 		ASSERTCMP(sb->s_flags, &, SB_ACTIVE);
-		afs_destroy_sbi(as);
-		as = NULL;
 	}
 
-	afs_put_cell(params.net, params.cell);
-	key_put(params.key);
+	fc->root = dget(sb->s_root);
+	fc->drop_sb = true;
 	_leave(" = 0 [%p]", sb);
-	return dget(sb->s_root);
+	return 0;
 
 error_sb:
 	deactivate_locked_super(sb);
-	goto error_key;
-error_as:
-	afs_destroy_sbi(as);
-error_key:
-	key_put(params.key);
 error:
-	afs_put_cell(params.net, params.cell);
 	_leave(" = %d", ret);
-	return ERR_PTR(ret);
+	return ret;
 }
 
-static void afs_kill_super(struct super_block *sb)
+static void afs_free_fc(struct fs_context *fc)
 {
-	struct afs_super_info *as = AFS_FS_S(sb);
+	struct afs_fs_context *ctx = fc->fs_private;
 
-	/* Clear the callback interests (which will do ilookup5) before
-	 * deactivating the superblock.
-	 */
-	if (as->volume)
-		afs_clear_callback_interests(afs_net(as->net_ns),
-					     as->volume->servers);
-	kill_anon_super(sb);
-	if (as->volume)
-		afs_deactivate_volume(as->volume);
-	afs_destroy_sbi(as);
+	afs_destroy_sbi(fc->s_fs_info);
+	afs_put_volume(ctx->cell, ctx->volume);
+	afs_put_cell(ctx->net, ctx->cell);
+	key_put(ctx->key);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations afs_context_ops = {
+	.free		= afs_free_fc,
+	.parse_source	= afs_parse_source,
+	.parse_option	= afs_parse_option,
+	.validate	= afs_validate_fc,
+	.get_tree	= afs_get_tree,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int afs_init_fs_context(struct fs_context *fc, struct dentry *reference)
+{
+	struct afs_fs_context *ctx;
+	struct afs_super_info *src_as;
+	struct afs_cell *cell;
+
+	if (current->nsproxy->net_ns != &init_net)
+		return -EINVAL;
+
+	ctx = kzalloc(sizeof(struct afs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->type = AFSVL_ROVOL;
+
+	switch (fc->purpose) {
+	case FS_CONTEXT_FOR_USER_MOUNT:
+	case FS_CONTEXT_FOR_KERNEL_MOUNT:
+		ctx->net = afs_net(fc->net_ns);
+
+		/* Default to the workstation cell. */
+		rcu_read_lock();
+		cell = afs_lookup_cell_rcu(ctx->net, NULL, 0);
+		rcu_read_unlock();
+		if (IS_ERR(cell))
+			cell = NULL;
+		ctx->cell = cell;
+		break;
+
+	case FS_CONTEXT_FOR_SUBMOUNT:
+		if (!reference)
+			return -EINVAL;
+
+		src_as = AFS_FS_S(reference->d_sb);
+		ASSERT(src_as);
+
+		ctx->net = afs_net(fc->net_ns);
+		if (src_as->cell)
+			ctx->cell = afs_get_cell(src_as->cell);
+		if (src_as->volume && src_as->volume->type == AFSVL_RWVOL) {
+			ctx->type = AFSVL_RWVOL;
+			ctx->force = true;
+		}
+		break;
+
+	case FS_CONTEXT_FOR_RECONFIGURE:
+		break;
+	}
+
+	fc->fs_private = ctx;
+	fc->ops = &afs_context_ops;
+	return 0;
 }
 
 /*
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 3037bd01f617..7adcddf02e66 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -21,7 +21,7 @@ static const char *const afs_voltypes[] = { "R/W", "R/O", "BAK" };
 /*
  * Allocate a volume record and load it up from a vldb record.
  */
-static struct afs_volume *afs_alloc_volume(struct afs_mount_params *params,
+static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 					   struct afs_vldb_entry *vldb,
 					   unsigned long type_mask)
 {
@@ -149,7 +149,7 @@ static struct afs_vldb_entry *afs_vl_lookup_vldb(struct afs_cell *cell,
  * - Rule 3: If parent volume is R/W, then only mount R/W volume unless
  *           explicitly told otherwise
  */
-struct afs_volume *afs_create_volume(struct afs_mount_params *params)
+struct afs_volume *afs_create_volume(struct afs_fs_context *params)
 {
 	struct afs_vldb_entry *vldb;
 	struct afs_volume *volume;
