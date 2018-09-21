Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60615ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F7921566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F7921566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391193AbeIUWYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:24:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390575AbeIUWYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A59C3002C8E;
        Fri, 21 Sep 2018 16:34:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 785EA7FFF5;
        Fri, 21 Sep 2018 16:34:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 32/34] afs: Add fs_context support [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:34:27 +0100
Message-ID: <153754766768.17872.1303834616810317427.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 21 Sep 2018 16:34:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fs_context support to the AFS filesystem, converting the parameter
parsing to store options there.

This will form the basis for namespace propagation over mountpoints within
the AFS model, thereby allowing AFS to be used in containers more easily.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h |    8 -
 fs/afs/super.c    |  503 +++++++++++++++++++++++++++++++----------------------
 fs/afs/volume.c   |    4 
 3 files changed, 297 insertions(+), 218 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 871a228d7f37..22d428052500 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -35,15 +35,15 @@
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
@@ -1056,7 +1056,7 @@ static inline struct afs_volume *__afs_get_volume(struct afs_volume *volume)
 	return volume;
 }
 
-extern struct afs_volume *afs_create_volume(struct afs_mount_params *);
+extern struct afs_volume *afs_create_volume(struct afs_fs_context *);
 extern void afs_activate_volume(struct afs_volume *);
 extern void afs_deactivate_volume(struct afs_volume *);
 extern void afs_put_volume(struct afs_cell *, struct afs_volume *);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index b85f5e993539..8d969fd4af40 100644
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
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
 #include <linux/statfs.h>
 #include <linux/sched.h>
 #include <linux/nsproxy.h>
@@ -30,22 +30,22 @@
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
+static const struct fs_parameter_description afs_fs_parameters;
 
 struct file_system_type afs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "afs",
-	.mount		= afs_mount,
-	.kill_sb	= afs_kill_super,
-	.fs_flags	= 0,
+	.owner			= THIS_MODULE,
+	.name			= "afs",
+	.init_fs_context	= afs_init_fs_context,
+	.parameters		= &afs_fs_parameters,
+	.kill_sb		= afs_kill_super,
+	.fs_flags		= 0,
 };
 MODULE_ALIAS_FS("afs");
 
@@ -64,22 +64,40 @@ static const struct super_operations afs_super_ops = {
 static struct kmem_cache *afs_inode_cachep;
 static atomic_t afs_count_active_inodes;
 
-enum {
-	afs_no_opt,
-	afs_opt_cell,
-	afs_opt_dyn,
-	afs_opt_rwpath,
-	afs_opt_vol,
-	afs_opt_autocell,
+enum afs_param {
+	Opt_autocell,
+	Opt_cell,
+	Opt_dyn,
+	Opt_rwpath,
+	Opt_source,
+	Opt_vol,
+	nr__afs_params
 };
 
-static const match_table_t afs_options_list = {
-	{ afs_opt_cell,		"cell=%s"	},
-	{ afs_opt_dyn,		"dyn"		},
-	{ afs_opt_rwpath,	"rwpath"	},
-	{ afs_opt_vol,		"vol=%s"	},
-	{ afs_opt_autocell,	"autocell"	},
-	{ afs_no_opt,		NULL		},
+static const struct fs_parameter_spec afs_param_specs[nr__afs_params] = {
+	[Opt_autocell]	= { fs_param_is_flag },
+	[Opt_cell]	= { fs_param_is_string },
+	[Opt_dyn]	= { fs_param_is_flag },
+	[Opt_rwpath]	= { fs_param_is_flag },
+	[Opt_source]	= { fs_param_is_string },
+	[Opt_vol]	= { fs_param_is_string },
+};
+
+static const char *const afs_param_keys[nr__afs_params] = {
+	[Opt_autocell]	= "autocell",
+	[Opt_cell]	= "cell",
+	[Opt_dyn]	= "dyn",
+	[Opt_rwpath]	= "rwpath",
+	[Opt_source]	= "source",
+	[Opt_vol]	= "vol",
+};
+
+static const struct fs_parameter_description afs_fs_parameters = {
+	.name		= "kAFS",
+	.nr_params	= nr__afs_params,
+	.source_param	= Opt_source,
+	.keys		= afs_param_keys,
+	.specs		= afs_param_specs,
 };
 
 /*
@@ -191,71 +209,10 @@ static int afs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 /*
- * parse the mount options
- * - this function has been shamelessly adapted from the ext3 fs which
- *   shamelessly adapted it from the msdos fs
- */
-static int afs_parse_options(struct afs_mount_params *params,
-			     char *options, const char **devname)
-{
-	struct afs_cell *cell;
-	substring_t args[MAX_OPT_ARGS];
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
-			return -EINVAL;
-		}
-	}
-
-	_leave(" = 0");
-	return 0;
-}
-
-/*
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
@@ -264,11 +221,11 @@ static int afs_parse_options(struct afs_mount_params *params,
  *	"%[cell:]volume.backup"		Backup volume
  *	"#[cell:]volume.backup"		Backup volume
  */
-static int afs_parse_device_name(struct afs_mount_params *params,
-				 const char *name)
+static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
 {
+	struct afs_fs_context *ctx = fc->fs_private;
 	struct afs_cell *cell;
-	const char *cellname, *suffix;
+	const char *cellname, *suffix, *name = param->string;
 	int cellnamesz;
 
 	_enter(",%s", name);
@@ -279,69 +236,174 @@ static int afs_parse_device_name(struct afs_mount_params *params,
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
+	fc->source = param->string;
+	param->string = NULL;
+	return 0;
+}
+
+/*
+ * Parse a single mount parameter.
+ */
+static int afs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	struct afs_fs_context *ctx = fc->fs_private;
+	struct afs_cell *cell;
+	int opt;
+
+	opt = fs_parse(fc, &afs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_cell:
+		if (param->size <= 0)
+			return -EINVAL;
+		if (param->size > AFS_MAXCELLNAME)
+			return -ENAMETOOLONG;
+
+		rcu_read_lock();
+		cell = afs_lookup_cell_rcu(ctx->net, param->string, param->size);
+		rcu_read_unlock();
+		if (IS_ERR(cell))
+			return PTR_ERR(cell);
+		afs_put_cell(ctx->net, ctx->cell);
+		ctx->cell = cell;
+		break;
+
+	case Opt_source:
+		return afs_parse_source(fc, param);
+
+	case Opt_autocell:
+		ctx->autocell = true;
+		break;
+
+	case Opt_dyn:
+		ctx->dyn_root = true;
+		break;
+
+	case Opt_rwpath:
+		ctx->rwpath = true;
+		break;
+
+	case Opt_vol:
+		return invalf(fc, "'vol' param is obsolete");
+
+	default:
+		return -EINVAL;
+	}
+
+	_leave(" = 0");
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
@@ -349,39 +411,34 @@ static int afs_parse_device_name(struct afs_mount_params *params,
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
-		as->volume->vid == as1->volume->vid &&
+		as->volume->vid == ctx->volume->vid &&
 		!as->dyn_root);
 }
 
-static int afs_dynroot_test_super(struct super_block *sb, void *data)
+static int afs_dynroot_test_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct afs_super_info *as1 = data;
 	struct afs_super_info *as = AFS_FS_S(sb);
 
-	return (as->net_ns == as1->net_ns &&
+	return (as->net_ns == fc->net_ns &&
 		as->dyn_root);
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
@@ -412,13 +469,13 @@ static int afs_fill_super(struct super_block *sb,
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
@@ -443,17 +500,20 @@ static int afs_fill_super(struct super_block *sb,
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
@@ -475,7 +535,7 @@ static void afs_kill_super(struct super_block *sb)
 
 	if (as->dyn_root)
 		afs_dynroot_depopulate(sb);
-	
+
 	/* Clear the callback interests (which will do ilookup5) before
 	 * deactivating the superblock.
 	 */
@@ -488,112 +548,131 @@ static void afs_kill_super(struct super_block *sb)
 }
 
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
+	_enter("");
 
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
+}
+
+static void afs_free_fc(struct fs_context *fc)
+{
+	struct afs_fs_context *ctx = fc->fs_private;
+
+	afs_destroy_sbi(fc->s_fs_info);
+	afs_put_volume(ctx->cell, ctx->volume);
+	afs_put_cell(ctx->net, ctx->cell);
+	key_put(ctx->key);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations afs_context_ops = {
+	.free		= afs_free_fc,
+	.parse_param	= afs_parse_param,
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
+		if (!reference) {
+			kfree(ctx);
+			return -EINVAL;
+		}
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
+	default:
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

