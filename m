Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161696AbeEYANB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:13:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S971813AbeEYAGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:06:31 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/32] VFS: Implement a filesystem superblock
 creation/configuration context [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:06:29 +0100
Message-ID: <152720678933.9073.11201500538963619904.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a filesystem context concept to be used during superblock
creation for mount and superblock reconfiguration for remount.

The mounting procedure then becomes:

 (1) Allocate new fs_context context.

 (2) Configure the context.

 (3) Create superblock.

 (4) Mount the superblock any number of times.

 (5) Destroy the context.

Rather than calling fs_type->mount(), an fs_context struct is created and
fs_type->init_fs_context() is called to set it up.
fs_type->fs_context_size says how much space should be allocated for the
config context.  The fs_context struct is placed at the beginning and any
extra space is for the filesystem's use.

A set of operations has to be set by ->init_fs_context() to provide
freeing, duplication, option parsing, binary data parsing, validation,
mounting and superblock filling.

Legacy filesystems are supported by the provision of a set of legacy
fs_context operations that build up a list of mount options and then invoke
fs_type->mount() from within the fs_context ->get_tree() operation.  This
allows all filesystems to be accessed using fs_context.

It should be noted that, whilst this patch adds a lot of lines of code,
there is quite a bit of duplication with existing code that can be
eliminated should all filesystems be converted over.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/Makefile                |    3 
 fs/fs_context.c            |  599 ++++++++++++++++++++++++++++++++++++++++++++
 fs/internal.h              |    3 
 fs/libfs.c                 |   17 +
 fs/namespace.c             |  350 +++++++++++++++++---------
 fs/super.c                 |  311 ++++++++++++++++++++++-
 include/linux/fs.h         |   13 +
 include/linux/fs_context.h |   45 +++
 include/linux/mount.h      |    3 
 9 files changed, 1201 insertions(+), 143 deletions(-)
 create mode 100644 fs/fs_context.c

diff --git a/fs/Makefile b/fs/Makefile
index c9375fd2c8c4..6f2dae3c32da 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -12,7 +12,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
-		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o
+		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
+		fs_context.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
diff --git a/fs/fs_context.c b/fs/fs_context.c
new file mode 100644
index 000000000000..bef68a12ddb5
--- /dev/null
+++ b/fs/fs_context.c
@@ -0,0 +1,599 @@
+/* Provide a way to create a superblock configuration context within the kernel
+ * that allows a superblock to be set up prior to mounting.
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/fs_context.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/nsproxy.h>
+#include <linux/slab.h>
+#include <linux/magic.h>
+#include <linux/security.h>
+#include <linux/parser.h>
+#include <linux/mnt_namespace.h>
+#include <linux/pid_namespace.h>
+#include <linux/user_namespace.h>
+#include <net/net_namespace.h>
+#include "mount.h"
+
+enum legacy_fs_param {
+	LEGACY_FS_UNSET_PARAMS,
+	LEGACY_FS_NO_PARAMS,
+	LEGACY_FS_MONOLITHIC_PARAMS,
+	LEGACY_FS_INDIVIDUAL_PARAMS,
+	LEGACY_FS_MAGIC_PARAMS,
+};
+
+struct legacy_fs_context {
+	struct fs_context	fc;
+	char			*legacy_data;	/* Data page for legacy filesystems */
+	char			*secdata;
+	size_t			data_size;
+	enum legacy_fs_param	param_type;
+};
+
+static const struct fs_context_operations legacy_fs_context_ops;
+
+static const match_table_t common_set_sb_flag = {
+	{ SB_DIRSYNC,		"dirsync" },
+	{ SB_LAZYTIME,		"lazytime" },
+	{ SB_MANDLOCK,		"mand" },
+	{ SB_POSIXACL,		"posixacl" },
+	{ SB_RDONLY,		"ro" },
+	{ SB_SYNCHRONOUS,	"sync" },
+	{ },
+};
+
+static const match_table_t common_clear_sb_flag = {
+	{ SB_LAZYTIME,		"nolazytime" },
+	{ SB_MANDLOCK,		"nomand" },
+	{ SB_RDONLY,		"rw" },
+	{ SB_SILENT,		"silent" },
+	{ SB_SYNCHRONOUS,	"async" },
+	{ },
+};
+
+static const match_table_t forbidden_sb_flag = {
+	{ 0,	"bind" },
+	{ 0,	"move" },
+	{ 0,	"private" },
+	{ 0,	"remount" },
+	{ 0,	"shared" },
+	{ 0,	"slave" },
+	{ 0,	"unbindable" },
+	{ 0,	"rec" },
+	{ 0,	"noatime" },
+	{ 0,	"relatime" },
+	{ 0,	"norelatime" },
+	{ 0,	"strictatime" },
+	{ 0,	"nostrictatime" },
+	{ 0,	"nodiratime" },
+	{ 0,	"dev" },
+	{ 0,	"nodev" },
+	{ 0,	"exec" },
+	{ 0,	"noexec" },
+	{ 0,	"suid" },
+	{ 0,	"nosuid" },
+	{ },
+};
+
+/*
+ * Check for a common mount option that manipulates s_flags.
+ */
+static int vfs_parse_sb_flag_option(struct fs_context *fc, char *data)
+{
+	substring_t args[MAX_OPT_ARGS];
+	unsigned int token;
+
+	token = match_token(data, common_set_sb_flag, args);
+	if (token) {
+		fc->sb_flags |= token;
+		return 1;
+	}
+
+	token = match_token(data, common_clear_sb_flag, args);
+	if (token) {
+		fc->sb_flags &= ~token;
+		return 1;
+	}
+
+	token = match_token(data, forbidden_sb_flag, args);
+	if (token)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * vfs_parse_fs_option - Add a single mount option to a superblock config
+ * @fc: The filesystem context to modify
+ * @opt: The option to apply.
+ * @len: The length of the option.
+ *
+ * A single mount option in string form is applied to the filesystem context
+ * being set up.  Certain standard options (for example "ro") are translated
+ * into flag bits without going to the filesystem.  The active security module
+ * is allowed to observe and poach options.  Any other options are passed over
+ * to the filesystem to parse.
+ *
+ * This may be called multiple times for a context.
+ *
+ * Returns 0 on success and a negative error code on failure.  In the event of
+ * failure, supplementary error information may have been set.
+ */
+int vfs_parse_fs_option(struct fs_context *fc, char *opt, size_t len)
+{
+	int ret;
+
+	ret = vfs_parse_sb_flag_option(fc, opt);
+	if (ret < 0)
+		return ret;
+	if (ret == 1)
+		return 0;
+
+	ret = security_fs_context_parse_option(fc, opt, len);
+	if (ret < 0)
+		return ret;
+	if (ret == 1)
+		return 0;
+
+	if (fc->ops->parse_option)
+		return fc->ops->parse_option(fc, opt, len);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(vfs_parse_fs_option);
+
+/**
+ * vfs_set_fs_source - Set the source/device name in a filesystem context
+ * @fc: The filesystem context to alter
+ * @source: The name of the source
+ * @slen: Length of @source string
+ */
+int vfs_set_fs_source(struct fs_context *fc, const char *source, size_t slen)
+{
+	char *src;
+	int ret;
+
+	if (fc->source)
+		return -EINVAL;
+	src = kmemdup_nul(source, slen, GFP_KERNEL);
+	if (!src)
+		return -ENOMEM;
+
+	ret = security_fs_context_parse_source(fc, src);
+	if (ret < 0)
+		goto error;
+
+	if (fc->ops->parse_source) {
+		ret = fc->ops->parse_source(fc, src);
+		if (ret < 0)
+			goto error;
+	}
+
+	fc->source = src;
+	return 0;
+
+error:
+	kfree(src);
+	return ret;
+}
+EXPORT_SYMBOL(vfs_set_fs_source);
+
+/**
+ * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
+ * @ctx: The superblock configuration to fill in.
+ * @data: The data to parse
+ * @data_size: The amount of data
+ *
+ * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
+ * called from the ->monolithic_mount_data() fs_context operation.
+ *
+ * Returns 0 on success or the error returned by the ->parse_option() fs_context
+ * operation on failure.
+ */
+int generic_parse_monolithic(struct fs_context *fc, void *data, size_t data_size)
+{
+	char *options = data, *opt;
+	int ret;
+
+	if (!options)
+		return 0;
+
+	while ((opt = strsep(&options, ",")) != NULL) {
+		if (*opt) {
+			ret = vfs_parse_fs_option(fc, opt, strlen(opt));
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(generic_parse_monolithic);
+
+/**
+ * vfs_new_fs_context - Create a filesystem context.
+ * @fs_type: The filesystem type.
+ * @reference: The dentry from which this one derives (or NULL)
+ * @sb_flags: Filesystem/superblock flags (SB_*)
+ * @purpose: The purpose that this configuration shall be used for.
+ *
+ * Open a filesystem and create a mount context.  The mount context is
+ * initialised with the supplied flags and, if a submount/automount from
+ * another superblock (referred to by @reference) is supplied, may have
+ * parameters such as namespaces copied across from that superblock.
+ */
+struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
+				      struct dentry *reference,
+				      unsigned int sb_flags,
+				      enum fs_context_purpose purpose)
+{
+	struct fs_context *fc;
+	int ret;
+
+	fc = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
+	if (!fc)
+		return ERR_PTR(-ENOMEM);
+
+	fc->purpose	= purpose;
+	fc->sb_flags	= sb_flags;
+	fc->fs_type	= get_filesystem(fs_type);
+	fc->cred	= get_current_cred();
+
+	switch (purpose) {
+	case FS_CONTEXT_FOR_KERNEL_MOUNT:
+		fc->sb_flags |= SB_KERNMOUNT;
+		/* Fallthrough */
+	case FS_CONTEXT_FOR_USER_MOUNT:
+		fc->user_ns = get_user_ns(fc->cred->user_ns);
+		fc->net_ns = get_net(current->nsproxy->net_ns);
+		break;
+	case FS_CONTEXT_FOR_SUBMOUNT:
+		fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
+		fc->net_ns = get_net(current->nsproxy->net_ns);
+		break;
+	case FS_CONTEXT_FOR_RECONFIGURE:
+		/* We don't pin any namespaces as the superblock's
+		 * subscriptions cannot be changed at this point.
+		 */
+		fc->root = dget(reference);
+		break;
+	}
+
+
+	/* TODO: Make all filesystems support this unconditionally */
+	if (fc->fs_type->init_fs_context) {
+		ret = fc->fs_type->init_fs_context(fc, reference);
+		if (ret < 0)
+			goto err_fc;
+	} else {
+		fc->ops = &legacy_fs_context_ops;
+	}
+
+	/* Do the security check last because ->init_fs_context may change the
+	 * namespace subscriptions.
+	 */
+	ret = security_fs_context_alloc(fc, reference);
+	if (ret < 0)
+		goto err_fc;
+
+	return fc;
+
+err_fc:
+	put_fs_context(fc);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(vfs_new_fs_context);
+
+/**
+ * vfs_sb_reconfig - Create a filesystem context for remount/reconfiguration
+ * @mountpoint: The mountpoint to open
+ * @sb_flags: Filesystem/superblock flags (SB_*)
+ *
+ * Open a mounted filesystem and create a filesystem context such that a
+ * remount can be effected.
+ */
+struct fs_context *vfs_sb_reconfig(struct path *mountpoint,
+				   unsigned int sb_flags)
+{
+	struct fs_context *fc;
+
+	fc = vfs_new_fs_context(mountpoint->dentry->d_sb->s_type,
+				mountpoint->dentry,
+				sb_flags, FS_CONTEXT_FOR_RECONFIGURE);
+	if (IS_ERR(fc))
+		return fc;
+
+	return fc;
+}
+
+/**
+ * vfs_dup_fc_config: Duplicate a filesytem context.
+ * @src_fc: The context to copy.
+ */
+struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
+{
+	struct fs_context *fc;
+	int ret;
+
+	if (!src_fc->ops->dup)
+		return ERR_PTR(-ENOTSUPP);
+
+	fc = kmemdup(src_fc, sizeof(struct legacy_fs_context), GFP_KERNEL);
+	if (!fc)
+		return ERR_PTR(-ENOMEM);
+
+	fc->fs_private	= NULL;
+	fc->source	= NULL;
+	fc->security	= NULL;
+	get_filesystem(fc->fs_type);
+	get_net(fc->net_ns);
+	get_user_ns(fc->user_ns);
+	get_cred(fc->cred);
+
+	/* Can't call put until we've called ->dup */
+	ret = fc->ops->dup(fc, src_fc);
+	if (ret < 0)
+		goto err_fc;
+
+	ret = security_fs_context_dup(fc, src_fc);
+	if (ret < 0)
+		goto err_fc;
+	return fc;
+
+err_fc:
+	put_fs_context(fc);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(vfs_dup_fs_context);
+
+/**
+ * put_fs_context - Dispose of a superblock configuration context.
+ * @fc: The context to dispose of.
+ */
+void put_fs_context(struct fs_context *fc)
+{
+	struct super_block *sb;
+
+	if (fc->root) {
+		sb = fc->root->d_sb;
+		dput(fc->root);
+		fc->root = NULL;
+		if (fc->drop_sb) {
+			deactivate_super(sb);
+			fc->drop_sb = false;
+		}
+	}
+
+	if (fc->ops && fc->ops->free)
+		fc->ops->free(fc);
+
+	security_fs_context_free(fc);
+	if (fc->net_ns)
+		put_net(fc->net_ns);
+	put_user_ns(fc->user_ns);
+	if (fc->cred)
+		put_cred(fc->cred);
+	kfree(fc->subtype);
+	put_filesystem(fc->fs_type);
+	kfree(fc->source);
+	kfree(fc);
+}
+EXPORT_SYMBOL(put_fs_context);
+
+/*
+ * Free the config for a filesystem that doesn't support fs_context.
+ */
+static void legacy_fs_context_free(struct fs_context *fc)
+{
+	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+
+	free_secdata(ctx->secdata);
+	switch (ctx->param_type) {
+	case LEGACY_FS_UNSET_PARAMS:
+	case LEGACY_FS_NO_PARAMS:
+		break;
+	case LEGACY_FS_MAGIC_PARAMS:
+		break; /* ctx->data is a weird pointer */
+	default:
+		kfree(ctx->legacy_data);
+		break;
+	}
+}
+
+/*
+ * Duplicate a legacy config.
+ */
+static int legacy_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
+{
+	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+	struct legacy_fs_context *src_ctx = container_of(src_fc, struct legacy_fs_context, fc);
+
+	switch (ctx->param_type) {
+	case LEGACY_FS_MONOLITHIC_PARAMS:
+	case LEGACY_FS_INDIVIDUAL_PARAMS:
+		ctx->legacy_data = kmemdup(src_ctx->legacy_data,
+					   src_ctx->data_size, GFP_KERNEL);
+		if (!ctx->legacy_data)
+			return -ENOMEM;
+		/* Fall through */
+	default:
+		break;
+	}
+	return 0;
+}
+
+/*
+ * Add an option to a legacy config.  We build up a comma-separated list of
+ * options.
+ */
+static int legacy_parse_option(struct fs_context *fc, char *opt, size_t len)
+{
+	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+	unsigned int size = ctx->data_size;
+
+	if (ctx->param_type != LEGACY_FS_UNSET_PARAMS &&
+	    ctx->param_type != LEGACY_FS_INDIVIDUAL_PARAMS) {
+		pr_warn("VFS: Can't mix monolithic and individual options\n");
+		return -EINVAL;
+	}
+
+	if (len > PAGE_SIZE - 2 - size)
+		return -EINVAL;
+	if (memchr(opt, ',', len) != NULL)
+		return -EINVAL;
+	if (!ctx->legacy_data) {
+		ctx->legacy_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!ctx->legacy_data)
+			return -ENOMEM;
+	}
+
+	ctx->legacy_data[size++] = ',';
+	memcpy(ctx->legacy_data + size, opt, len);
+	size += len;
+	ctx->legacy_data[size] = '\0';
+	ctx->data_size = size;
+	ctx->param_type = LEGACY_FS_INDIVIDUAL_PARAMS;
+	return 0;
+}
+
+/*
+ * Add monolithic mount data.
+ */
+static int legacy_parse_monolithic(struct fs_context *fc, void *data, size_t data_size)
+{
+	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+
+	if (ctx->param_type != LEGACY_FS_UNSET_PARAMS) {
+		pr_warn("VFS: Can't mix monolithic and individual options\n");
+		return -EINVAL;
+	}
+
+	if (!data) {
+		ctx->param_type = LEGACY_FS_NO_PARAMS;
+		return 0;
+	}
+
+	ctx->data_size = data_size;
+	if (data_size > 0) {
+		ctx->legacy_data = kmemdup(data, data_size, GFP_KERNEL);
+		if (!ctx->legacy_data)
+			return -ENOMEM;
+		ctx->param_type = LEGACY_FS_MONOLITHIC_PARAMS;
+	} else {
+		/* Some filesystems pass weird pointers through that we don't
+		 * want to copy.  They can indicate this by setting data_size
+		 * to 0.
+		 */
+		ctx->legacy_data = data;
+		ctx->param_type = LEGACY_FS_MAGIC_PARAMS;
+	}
+
+	return 0;
+}
+
+/*
+ * Use the legacy mount validation step to strip out and process security
+ * config options.
+ */
+static int legacy_validate(struct fs_context *fc)
+{
+	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+
+	switch (ctx->param_type) {
+	case LEGACY_FS_UNSET_PARAMS:
+		ctx->param_type = LEGACY_FS_NO_PARAMS;
+		/* Fall through */
+	case LEGACY_FS_NO_PARAMS:
+	case LEGACY_FS_MAGIC_PARAMS:
+		return 0;
+	default:
+		break;
+	}
+
+	if (ctx->fc.fs_type->fs_flags & FS_BINARY_MOUNTDATA)
+		return 0;
+
+	ctx->secdata = alloc_secdata();
+	if (!ctx->secdata)
+		return -ENOMEM;
+
+	return security_sb_copy_data(ctx->legacy_data, ctx->data_size,
+				     ctx->secdata);
+}
+
+/*
+ * Determine the superblock subtype.
+ */
+static int legacy_set_subtype(struct fs_context *fc)
+{
+	const char *subtype = strchr(fc->fs_type->name, '.');
+
+	if (subtype) {
+		subtype++;
+		if (!subtype[0])
+			return -EINVAL;
+	} else {
+		subtype = "";
+	}
+
+	fc->subtype = kstrdup(subtype, GFP_KERNEL);
+	if (!fc->subtype)
+		return -ENOMEM;
+	return 0;
+}
+
+/*
+ * Get a mountable root with the legacy mount command.
+ */
+static int legacy_get_tree(struct fs_context *fc)
+{
+	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
+	struct super_block *sb;
+	struct dentry *root;
+	int ret;
+
+	root = ctx->fc.fs_type->mount(ctx->fc.fs_type, ctx->fc.sb_flags,
+				      ctx->fc.source, ctx->legacy_data,
+				      ctx->data_size);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	sb = root->d_sb;
+	BUG_ON(!sb);
+
+	if ((ctx->fc.fs_type->fs_flags & FS_HAS_SUBTYPE) &&
+	    !fc->subtype) {
+		ret = legacy_set_subtype(fc);
+		if (ret < 0)
+			goto err_sb;
+	}
+
+	ctx->fc.root = root;
+	ctx->fc.drop_sb = true;
+	return 0;
+
+err_sb:
+	dput(root);
+	deactivate_locked_super(sb);
+	return ret;
+}
+
+static const struct fs_context_operations legacy_fs_context_ops = {
+	.free			= legacy_fs_context_free,
+	.dup			= legacy_fs_context_dup,
+	.parse_option		= legacy_parse_option,
+	.parse_monolithic	= legacy_parse_monolithic,
+	.validate		= legacy_validate,
+	.get_tree		= legacy_get_tree,
+};
diff --git a/fs/internal.h b/fs/internal.h
index 1afa522c5f30..91a990234488 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -98,7 +98,8 @@ extern struct file *get_empty_filp(void);
 /*
  * super.c
  */
-extern int do_remount_sb(struct super_block *, int, void *, size_t, int);
+extern int do_remount_sb(struct super_block *, int, void *, size_t, int,
+			 struct fs_context *);
 extern bool trylock_super(struct super_block *sb);
 extern struct dentry *mount_fs(struct file_system_type *,
 			       int, const char *, void *, size_t);
diff --git a/fs/libfs.c b/fs/libfs.c
index 9f1f4884b7cc..823f0510e43d 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/vfs.h>
 #include <linux/quotaops.h>
 #include <linux/mutex.h>
@@ -574,13 +575,27 @@ static DEFINE_SPINLOCK(pin_fs_lock);
 
 int simple_pin_fs(struct file_system_type *type, struct vfsmount **mount, int *count)
 {
+	struct fs_context *fc;
 	struct vfsmount *mnt = NULL;
+	int ret;
+
 	spin_lock(&pin_fs_lock);
 	if (unlikely(!*mount)) {
 		spin_unlock(&pin_fs_lock);
-		mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL, 0);
+
+		fc = vfs_new_fs_context(type, NULL, 0, FS_CONTEXT_FOR_KERNEL_MOUNT);
+		if (IS_ERR(fc))
+			return PTR_ERR(fc);
+
+		ret = vfs_get_tree(fc);
+		if (ret < 0)
+			return ret;
+
+		mnt = vfs_create_mount(fc, 0);
+		put_fs_context(fc);
 		if (IS_ERR(mnt))
 			return PTR_ERR(mnt);
+
 		spin_lock(&pin_fs_lock);
 		if (!*mount)
 			*mount = mnt;
diff --git a/fs/namespace.c b/fs/namespace.c
index a6ab1137f8d2..14be35d02050 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -25,8 +25,10 @@
 #include <linux/magic.h>
 #include <linux/bootmem.h>
 #include <linux/task_work.h>
+#include <linux/file.h>
 #include <linux/sched/task.h>
 #include <uapi/linux/mount.h>
+#include <linux/fs_context.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -1019,56 +1021,6 @@ static struct mount *skip_mnt_tree(struct mount *p)
 	return p;
 }
 
-struct vfsmount *
-vfs_kern_mount(struct file_system_type *type, int flags, const char *name,
-	       void *data, size_t data_size)
-{
-	struct mount *mnt;
-	struct dentry *root;
-
-	if (!type)
-		return ERR_PTR(-ENODEV);
-
-	mnt = alloc_vfsmnt(name);
-	if (!mnt)
-		return ERR_PTR(-ENOMEM);
-
-	if (flags & SB_KERNMOUNT)
-		mnt->mnt.mnt_flags = MNT_INTERNAL;
-
-	root = mount_fs(type, flags, name, data, data_size);
-	if (IS_ERR(root)) {
-		mnt_free_id(mnt);
-		free_vfsmnt(mnt);
-		return ERR_CAST(root);
-	}
-
-	mnt->mnt.mnt_root = root;
-	mnt->mnt.mnt_sb = root->d_sb;
-	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
-	mnt->mnt_parent = mnt;
-	lock_mount_hash();
-	list_add_tail(&mnt->mnt_instance, &root->d_sb->s_mounts);
-	unlock_mount_hash();
-	return &mnt->mnt;
-}
-EXPORT_SYMBOL_GPL(vfs_kern_mount);
-
-struct vfsmount *
-vfs_submount(const struct dentry *mountpoint, struct file_system_type *type,
-	     const char *name, void *data, size_t data_size)
-{
-	/* Until it is worked out how to pass the user namespace
-	 * through from the parent mount to the submount don't support
-	 * unprivileged mounts with submounts.
-	 */
-	if (mountpoint->d_sb->s_user_ns != &init_user_ns)
-		return ERR_PTR(-EPERM);
-
-	return vfs_kern_mount(type, SB_SUBMOUNT, name, data, data_size);
-}
-EXPORT_SYMBOL_GPL(vfs_submount);
-
 static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 					int flag)
 {
@@ -1596,7 +1548,7 @@ static int do_umount(struct mount *mnt, int flags)
 			return -EPERM;
 		down_write(&sb->s_umount);
 		if (!sb_rdonly(sb))
-			retval = do_remount_sb(sb, SB_RDONLY, NULL, 0, 0);
+			retval = do_remount_sb(sb, SB_RDONLY, NULL, 0, 0, NULL);
 		up_write(&sb->s_umount);
 		return retval;
 	}
@@ -2283,6 +2235,20 @@ static int change_mount_flags(struct vfsmount *mnt, int ms_flags)
 	return error;
 }
 
+/*
+ * Parse the monolithic page of mount data given to sys_mount().
+ */
+static int parse_monolithic_mount_data(struct fs_context *fc, void *data, size_t data_size)
+{
+	int (*monolithic_mount_data)(struct fs_context *, void *, size_t);
+
+	monolithic_mount_data = fc->ops->parse_monolithic;
+	if (!monolithic_mount_data)
+		monolithic_mount_data = generic_parse_monolithic;
+
+	return monolithic_mount_data(fc, data, data_size);
+}
+
 /*
  * change filesystem flags. dir should be a physical root of filesystem.
  * If you've mounted a non-root directory somewhere and want to do remount
@@ -2291,9 +2257,11 @@ static int change_mount_flags(struct vfsmount *mnt, int ms_flags)
 static int do_remount(struct path *path, int ms_flags, int sb_flags,
 		      int mnt_flags, void *data, size_t data_size)
 {
+	struct fs_context *fc = NULL;
 	int err;
 	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
+	struct file_system_type *type = sb->s_type;
 
 	if (!check_mnt(mnt))
 		return -EINVAL;
@@ -2328,9 +2296,29 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 		return -EPERM;
 	}
 
-	err = security_sb_remount(sb, data, data_size);
-	if (err)
-		return err;
+	if (type->init_fs_context) {
+		fc = vfs_sb_reconfig(path, sb_flags);
+		if (IS_ERR(fc))
+			return PTR_ERR(fc);
+
+		err = parse_monolithic_mount_data(fc, data, data_size);
+		if (err < 0)
+			goto err_fc;
+
+		if (fc->ops->validate) {
+			err = fc->ops->validate(fc);
+			if (err < 0)
+				goto err_fc;
+		}
+
+		err = security_fs_context_validate(fc);
+		if (err)
+			return err;
+	} else {
+		err = security_sb_remount(sb, data, data_size);
+		if (err)
+			return err;
+	}
 
 	down_write(&sb->s_umount);
 	if (ms_flags & MS_BIND)
@@ -2338,7 +2326,7 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	else if (!capable(CAP_SYS_ADMIN))
 		err = -EPERM;
 	else
-		err = do_remount_sb(sb, sb_flags, data, data_size, 0);
+		err = do_remount_sb(sb, sb_flags, data, data_size, 0, fc);
 	if (!err) {
 		lock_mount_hash();
 		mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
@@ -2347,6 +2335,9 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 		unlock_mount_hash();
 	}
 	up_write(&sb->s_umount);
+err_fc:
+	if (fc)
+		put_fs_context(fc);
 	return err;
 }
 
@@ -2430,29 +2421,6 @@ static int do_move_mount(struct path *path, const char *old_name)
 	return err;
 }
 
-static struct vfsmount *fs_set_subtype(struct vfsmount *mnt, const char *fstype)
-{
-	int err;
-	const char *subtype = strchr(fstype, '.');
-	if (subtype) {
-		subtype++;
-		err = -EINVAL;
-		if (!subtype[0])
-			goto err;
-	} else
-		subtype = "";
-
-	mnt->mnt_sb->s_subtype = kstrdup(subtype, GFP_KERNEL);
-	err = -ENOMEM;
-	if (!mnt->mnt_sb->s_subtype)
-		goto err;
-	return mnt;
-
- err:
-	mntput(mnt);
-	return ERR_PTR(err);
-}
-
 /*
  * add a mount into a namespace's mount tree
  */
@@ -2497,44 +2465,88 @@ static int do_add_mount(struct mount *newmnt, struct path *path, int mnt_flags)
 	return err;
 }
 
-static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags);
+static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags);
+
+/*
+ * Create a new mount using a superblock configuration and request it
+ * be added to the namespace tree.
+ */
+static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
+			   unsigned int mnt_flags)
+{
+	struct vfsmount *mnt;
+	int ret;
+
+	ret = security_sb_mountpoint(fc, mountpoint,
+				     mnt_flags & ~MNT_INTERNAL_FLAGS);
+	if (ret < 0)
+		return ret;
+
+	if (mount_too_revealing(fc->root->d_sb, &mnt_flags)) {
+		pr_warn("VFS: Mount too revealing\n");
+		return -EPERM;
+	}
+
+	mnt = vfs_create_mount(fc, mnt_flags);
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
+	ret = do_add_mount(real_mount(mnt), mountpoint, mnt_flags);
+	if (ret < 0)
+		goto err_mnt;
+	return ret;
+
+err_mnt:
+	mntput(mnt);
+	return ret;
+}
 
 /*
  * create a new mount for userspace and request it to be added into the
  * namespace's tree
  */
-static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
-			int mnt_flags, const char *name,
+static int do_new_mount(struct path *mountpoint, const char *fstype,
+			int sb_flags, int mnt_flags, const char *name,
 			void *data, size_t data_size)
 {
-	struct file_system_type *type;
-	struct vfsmount *mnt;
+	struct file_system_type *fs_type;
+	struct fs_context *fc;
 	int err;
 
 	if (!fstype)
 		return -EINVAL;
 
-	type = get_fs_type(fstype);
-	if (!type)
-		return -ENODEV;
-
-	mnt = vfs_kern_mount(type, sb_flags, name, data, data_size);
-	if (!IS_ERR(mnt) && (type->fs_flags & FS_HAS_SUBTYPE) &&
-	    !mnt->mnt_sb->s_subtype)
-		mnt = fs_set_subtype(mnt, fstype);
+	err = -ENODEV;
+	fs_type = get_fs_type(fstype);
+	if (!fs_type)
+		goto out;
 
-	put_filesystem(type);
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
+	fc = vfs_new_fs_context(fs_type, NULL, sb_flags,
+				FS_CONTEXT_FOR_USER_MOUNT);
+	put_filesystem(fs_type);
+	if (IS_ERR(fc)) {
+		err = PTR_ERR(fc);
+		goto out;
+	}
 
-	if (mount_too_revealing(mnt, &mnt_flags)) {
-		mntput(mnt);
-		return -EPERM;
+	if (name) {
+		err = vfs_set_fs_source(fc, name, strlen(name));
+		if (err < 0)
+			goto out_fc;
 	}
 
-	err = do_add_mount(real_mount(mnt), path, mnt_flags);
-	if (err)
-		mntput(mnt);
+	err = parse_monolithic_mount_data(fc, data, data_size);
+	if (err < 0)
+		goto out_fc;
+
+	err = vfs_get_tree(fc);
+	if (err < 0)
+		goto out_fc;
+
+	err = do_new_mount_fc(fc, mountpoint, mnt_flags);
+out_fc:
+	put_fs_context(fc);
+out:
 	return err;
 }
 
@@ -3082,6 +3094,117 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	return ksys_mount(dev_name, dir_name, type, flags, data);
 }
 
+/**
+ * vfs_create_mount - Create a mount for a configured superblock
+ * @fc: The configuration context with the superblock attached
+ * @mnt_flags: The mount flags to apply
+ *
+ * Create a mount to an already configured superblock.  If necessary, the
+ * caller should invoke vfs_get_tree() before calling this.
+ *
+ * Note that this does not attach the mount to anything.
+ */
+struct vfsmount *vfs_create_mount(struct fs_context *fc, unsigned int mnt_flags)
+{
+	struct mount *mnt;
+
+	if (!fc->root)
+		return ERR_PTR(-EINVAL);
+
+	mnt = alloc_vfsmnt(fc->source ?: "none");
+	if (!mnt)
+		return ERR_PTR(-ENOMEM);
+
+	if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
+		/* It's a longterm mount, don't release mnt until we unmount
+		 * before file sys is unregistered
+		 */
+		mnt_flags |= MNT_INTERNAL;
+
+	atomic_inc(&fc->root->d_sb->s_active);
+	mnt->mnt.mnt_flags	= mnt_flags;
+	mnt->mnt.mnt_sb		= fc->root->d_sb;
+	mnt->mnt.mnt_root	= dget(fc->root);
+	mnt->mnt_mountpoint	= mnt->mnt.mnt_root;
+	mnt->mnt_parent		= mnt;
+
+	lock_mount_hash();
+	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
+	unlock_mount_hash();
+	return &mnt->mnt;
+}
+EXPORT_SYMBOL(vfs_create_mount);
+
+struct vfsmount *vfs_kern_mount(struct file_system_type *type,
+				int sb_flags, const char *devname,
+				void *data, size_t data_size)
+{
+	struct fs_context *fc;
+	struct vfsmount *mnt;
+	int ret;
+
+	if (!type)
+		return ERR_PTR(-EINVAL);
+
+	fc = vfs_new_fs_context(type, NULL, sb_flags,
+				sb_flags & SB_KERNMOUNT ?
+				FS_CONTEXT_FOR_KERNEL_MOUNT :
+				FS_CONTEXT_FOR_USER_MOUNT);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	if (devname) {
+		ret = vfs_set_fs_source(fc, devname, strlen(devname));
+		if (ret < 0)
+			goto err_fc;
+	}
+
+	ret = parse_monolithic_mount_data(fc, data, data_size);
+	if (ret < 0)
+		goto err_fc;
+
+	ret = vfs_get_tree(fc);
+	if (ret < 0)
+		goto err_fc;
+
+	mnt = vfs_create_mount(fc, 0);
+out:
+	put_fs_context(fc);
+	return mnt;
+err_fc:
+	mnt = ERR_PTR(ret);
+	goto out;
+}
+EXPORT_SYMBOL_GPL(vfs_kern_mount);
+
+struct vfsmount *
+vfs_submount(const struct dentry *mountpoint, struct file_system_type *type,
+	     const char *name, void *data, size_t data_size)
+{
+	/* Until it is worked out how to pass the user namespace
+	 * through from the parent mount to the submount don't support
+	 * unprivileged mounts with submounts.
+	 */
+	if (mountpoint->d_sb->s_user_ns != &init_user_ns)
+		return ERR_PTR(-EPERM);
+
+	return vfs_kern_mount(type, MS_SUBMOUNT, name, data, data_size);
+}
+EXPORT_SYMBOL_GPL(vfs_submount);
+
+struct vfsmount *kern_mount(struct file_system_type *type)
+{
+	return vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(kern_mount);
+
+struct vfsmount *kern_mount_data(struct file_system_type *type,
+				 void *data, size_t data_size)
+{
+	return vfs_kern_mount(type, SB_KERNMOUNT, type->name, data, data_size);
+}
+EXPORT_SYMBOL_GPL(kern_mount_data);
+
 /*
  * Return true if path is reachable from root
  *
@@ -3302,22 +3425,6 @@ void put_mnt_ns(struct mnt_namespace *ns)
 	free_mnt_ns(ns);
 }
 
-struct vfsmount *kern_mount_data(struct file_system_type *type,
-				 void *data, size_t data_size)
-{
-	struct vfsmount *mnt;
-	mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, data, data_size);
-	if (!IS_ERR(mnt)) {
-		/*
-		 * it is a longterm mount, don't release mnt until
-		 * we unmount before file sys is unregistered
-		*/
-		real_mount(mnt)->mnt_ns = MNT_NS_INTERNAL;
-	}
-	return mnt;
-}
-EXPORT_SYMBOL_GPL(kern_mount_data);
-
 void kern_unmount(struct vfsmount *mnt)
 {
 	/* release long term mount so mount point can be released */
@@ -3358,7 +3465,8 @@ bool current_chrooted(void)
 	return chrooted;
 }
 
-static bool mnt_already_visible(struct mnt_namespace *ns, struct vfsmount *new,
+static bool mnt_already_visible(struct mnt_namespace *ns,
+				const struct super_block *sb,
 				int *new_mnt_flags)
 {
 	int new_flags = *new_mnt_flags;
@@ -3370,7 +3478,7 @@ static bool mnt_already_visible(struct mnt_namespace *ns, struct vfsmount *new,
 		struct mount *child;
 		int mnt_flags;
 
-		if (mnt->mnt.mnt_sb->s_type != new->mnt_sb->s_type)
+		if (mnt->mnt.mnt_sb->s_type != sb->s_type)
 			continue;
 
 		/* This mount is not fully visible if it's root directory
@@ -3421,7 +3529,7 @@ static bool mnt_already_visible(struct mnt_namespace *ns, struct vfsmount *new,
 	return visible;
 }
 
-static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags)
+static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags)
 {
 	const unsigned long required_iflags = SB_I_NOEXEC | SB_I_NODEV;
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
@@ -3431,7 +3539,7 @@ static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags)
 		return false;
 
 	/* Can this filesystem be too revealing? */
-	s_iflags = mnt->mnt_sb->s_iflags;
+	s_iflags = sb->s_iflags;
 	if (!(s_iflags & SB_I_USERNS_VISIBLE))
 		return false;
 
@@ -3441,7 +3549,7 @@ static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags)
 		return true;
 	}
 
-	return !mnt_already_visible(ns, mnt, new_mnt_flags);
+	return !mnt_already_visible(ns, sb, new_mnt_flags);
 }
 
 bool mnt_may_suid(struct vfsmount *mnt)
diff --git a/fs/super.c b/fs/super.c
index c9d208b7999e..b9d386d728c6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <uapi/linux/mount.h>
+#include <linux/fs_context.h>
 #include "internal.h"
 
 static int thaw_super_locked(struct super_block *sb);
@@ -184,16 +185,13 @@ static void destroy_unused_super(struct super_block *s)
 }
 
 /**
- *	alloc_super	-	create new superblock
- *	@type:	filesystem type superblock should belong to
- *	@flags: the mount flags
- *	@user_ns: User namespace for the super_block
+ *	alloc_super - Create new superblock
+ *	@fc: The filesystem configuration context
  *
  *	Allocates and initializes a new &struct super_block.  alloc_super()
  *	returns a pointer new superblock or %NULL if allocation had failed.
  */
-static struct super_block *alloc_super(struct file_system_type *type, int flags,
-				       struct user_namespace *user_ns)
+static struct super_block *alloc_super(struct fs_context *fc)
 {
 	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
 	static const struct super_operations default_op;
@@ -203,9 +201,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 		return NULL;
 
 	INIT_LIST_HEAD(&s->s_mounts);
-	s->s_user_ns = get_user_ns(user_ns);
+	s->s_user_ns = get_user_ns(fc->user_ns);
 	init_rwsem(&s->s_umount);
-	lockdep_set_class(&s->s_umount, &type->s_umount_key);
+	lockdep_set_class(&s->s_umount, &fc->fs_type->s_umount_key);
 	/*
 	 * sget() can have s_umount recursion.
 	 *
@@ -229,12 +227,12 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	for (i = 0; i < SB_FREEZE_LEVELS; i++) {
 		if (__percpu_init_rwsem(&s->s_writers.rw_sem[i],
 					sb_writers_name[i],
-					&type->s_writers_key[i]))
+					&fc->fs_type->s_writers_key[i]))
 			goto fail;
 	}
 	init_waitqueue_head(&s->s_writers.wait_unfrozen);
 	s->s_bdi = &noop_backing_dev_info;
-	s->s_flags = flags;
+	s->s_flags = fc->sb_flags;
 	if (s->s_user_ns != &init_user_ns)
 		s->s_iflags |= SB_I_NODEV;
 	INIT_HLIST_NODE(&s->s_instances);
@@ -252,7 +250,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
-	lockdep_set_class(&s->s_vfs_rename_mutex, &type->s_vfs_rename_key);
+	lockdep_set_class(&s->s_vfs_rename_mutex, &fc->fs_type->s_vfs_rename_key);
 	init_rwsem(&s->s_dquot.dqio_sem);
 	s->s_maxbytes = MAX_NON_LFS;
 	s->s_op = &default_op;
@@ -472,6 +470,97 @@ void generic_shutdown_super(struct super_block *sb)
 
 EXPORT_SYMBOL(generic_shutdown_super);
 
+/**
+ * sget_fc - Find or create a superblock
+ * @fc:	Filesystem context.
+ * @test: Comparison callback
+ * @set: Setup callback
+ *
+ * Find or create a superblock using the parameters stored in the filesystem
+ * context and the two callback functions.
+ *
+ * If an extant superblock is matched, then that will be returned with an
+ * elevated reference count that the caller must transfer or discard.
+ *
+ * If no match is made, a new superblock will be allocated and basic
+ * initialisation will be performed (s_type, s_fs_info and s_id will be set and
+ * the set() callback will be invoked), the superblock will be published and it
+ * will be returned in a partially constructed state with SB_BORN and SB_ACTIVE
+ * as yet unset.
+ */
+struct super_block *sget_fc(struct fs_context *fc,
+			    int (*test)(struct super_block *, struct fs_context *),
+			    int (*set)(struct super_block *, struct fs_context *))
+{
+	struct super_block *s = NULL;
+	struct super_block *old;
+	int err;
+
+	if (!(fc->sb_flags & SB_KERNMOUNT) &&
+	    fc->purpose != FS_CONTEXT_FOR_SUBMOUNT) {
+		/* Don't allow mounting unless the caller has CAP_SYS_ADMIN
+		 * over the namespace.
+		 */
+		if (!(fc->fs_type->fs_flags & FS_USERNS_MOUNT) &&
+		    !capable(CAP_SYS_ADMIN))
+			return ERR_PTR(-EPERM);
+		else if (!ns_capable(fc->user_ns, CAP_SYS_ADMIN))
+			return ERR_PTR(-EPERM);
+	}
+
+retry:
+	spin_lock(&sb_lock);
+	if (test) {
+		hlist_for_each_entry(old, &fc->fs_type->fs_supers, s_instances) {
+			if (!test(old, fc))
+				continue;
+			if (fc->user_ns != old->s_user_ns) {
+				spin_unlock(&sb_lock);
+				if (s) {
+					up_write(&s->s_umount);
+					destroy_unused_super(s);
+				}
+				return ERR_PTR(-EBUSY);
+			}
+			if (!grab_super(old))
+				goto retry;
+			if (s) {
+				up_write(&s->s_umount);
+				destroy_unused_super(s);
+				s = NULL;
+			}
+			return old;
+		}
+	}
+	if (!s) {
+		spin_unlock(&sb_lock);
+		s = alloc_super(fc);
+		if (!s)
+			return ERR_PTR(-ENOMEM);
+		goto retry;
+	}
+
+	s->s_fs_info = fc->s_fs_info;
+	err = set(s, fc);
+	if (err) {
+		s->s_fs_info = NULL;
+		spin_unlock(&sb_lock);
+		up_write(&s->s_umount);
+		destroy_unused_super(s);
+		return ERR_PTR(err);
+	}
+	fc->s_fs_info = NULL;
+	s->s_type = fc->fs_type;
+	strlcpy(s->s_id, s->s_type->name, sizeof(s->s_id));
+	list_add_tail(&s->s_list, &super_blocks);
+	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
+	spin_unlock(&sb_lock);
+	get_filesystem(s->s_type);
+	register_shrinker(&s->s_shrink);
+	return s;
+}
+EXPORT_SYMBOL(sget_fc);
+
 /**
  *	sget_userns -	find or create a superblock
  *	@type:	filesystem type superblock should belong to
@@ -514,7 +603,14 @@ struct super_block *sget_userns(struct file_system_type *type,
 	}
 	if (!s) {
 		spin_unlock(&sb_lock);
-		s = alloc_super(type, (flags & ~SB_SUBMOUNT), user_ns);
+		{
+			struct fs_context fc = {
+				.fs_type	= type,
+				.sb_flags	= flags & ~SB_SUBMOUNT,
+				.user_ns	= user_ns,
+			};
+			s = alloc_super(&fc);
+		}
 		if (!s)
 			return ERR_PTR(-ENOMEM);
 		goto retry;
@@ -838,11 +934,13 @@ struct super_block *user_get_super(dev_t dev)
  *	@data:	the rest of options
  *	@data_size: The size of the data
  *      @force: whether or not to force the change
+ *	@fc:	the superblock config for filesystems that support it
+ *		(NULL if called from emergency or umount)
  *
  *	Alters the mount options of a mounted file system.
  */
 int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
-		  size_t data_size, int force)
+		  size_t data_size, int force, struct fs_context *fc)
 {
 	int retval;
 	int remount_ro;
@@ -884,8 +982,17 @@ int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
 		}
 	}
 
-	if (sb->s_op->remount_fs) {
-		retval = sb->s_op->remount_fs(sb, &sb_flags, data, data_size);
+	if (sb->s_op->reconfigure ||
+	    sb->s_op->remount_fs) {
+		if (sb->s_op->reconfigure) {
+			retval = sb->s_op->reconfigure(sb, fc);
+			sb_flags = fc->sb_flags;
+			if (retval == 0)
+				security_sb_reconfigure(fc);
+		} else {
+			retval = sb->s_op->remount_fs(sb, &sb_flags,
+						      data, data_size);
+		}
 		if (retval) {
 			if (!force)
 				goto cancel_readonly;
@@ -924,7 +1031,7 @@ static void do_emergency_remount_callback(struct super_block *sb)
 		/*
 		 * What lock protects sb->s_flags??
 		 */
-		do_remount_sb(sb, SB_RDONLY, NULL, 0, 1);
+		do_remount_sb(sb, SB_RDONLY, NULL, 0, 1, NULL);
 	}
 	up_write(&sb->s_umount);
 }
@@ -1106,6 +1213,89 @@ struct dentry *mount_ns(struct file_system_type *fs_type,
 
 EXPORT_SYMBOL(mount_ns);
 
+static int set_anon_super_fc(struct super_block *sb, struct fs_context *fc)
+{
+	return set_anon_super(sb, NULL);
+}
+
+static int test_keyed_super(struct super_block *sb, struct fs_context *fc)
+{
+	return sb->s_fs_info == fc->s_fs_info;
+}
+
+static int test_single_super(struct super_block *s, struct fs_context *fc)
+{
+	return 1;
+}
+
+/**
+ * vfs_get_super - Get a superblock with a search key set in s_fs_info.
+ * @fc: The filesystem context holding the parameters
+ * @keying: How to distinguish superblocks
+ * @fill_super: Helper to initialise a new superblock
+ *
+ * Search for a superblock and create a new one if not found.  The search
+ * criterion is controlled by @keying.  If the search fails, a new superblock
+ * is created and @fill_super() is called to initialise it.
+ *
+ * @keying can take one of a number of values:
+ *
+ * (1) vfs_get_single_super - Only one superblock of this type may exist on the
+ *     system.  This is typically used for special system filesystems.
+ *
+ * (2) vfs_get_keyed_super - Multiple superblocks may exist, but they must have
+ *     distinct keys (where the key is in s_fs_info).  Searching for the same
+ *     key again will turn up the superblock for that key.
+ *
+ * (3) vfs_get_independent_super - Multiple superblocks may exist and are
+ *     unkeyed.  Each call will get a new superblock.
+ *
+ * A permissions check is made by sget_fc() unless we're getting a superblock
+ * for a kernel-internal mount or a submount.
+ */
+int vfs_get_super(struct fs_context *fc,
+		  enum vfs_get_super_keying keying,
+		  int (*fill_super)(struct super_block *sb,
+				    struct fs_context *fc))
+{
+	int (*test)(struct super_block *, struct fs_context *);
+	struct super_block *sb;
+
+	switch (keying) {
+	case vfs_get_single_super:
+		test = test_single_super;
+		break;
+	case vfs_get_keyed_super:
+		test = test_keyed_super;
+		break;
+	case vfs_get_independent_super:
+		test = NULL;
+		break;
+	default:
+		BUG();
+	}
+
+	sb = sget_fc(fc, test, set_anon_super_fc);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	if (!sb->s_root) {
+		int err = fill_super(sb, fc);
+		if (err) {
+			deactivate_locked_super(sb);
+			return err;
+		}
+
+		sb->s_flags |= SB_ACTIVE;
+	}
+
+	BUG_ON(fc->root);
+	fc->root = dget(sb->s_root);
+	fc->drop_sb = true;
+	return 0;
+}
+EXPORT_SYMBOL(vfs_get_super);
+
 #ifdef CONFIG_BLOCK
 static int set_bdev_super(struct super_block *s, void *data)
 {
@@ -1254,7 +1444,7 @@ struct dentry *mount_single(struct file_system_type *fs_type,
 		}
 		s->s_flags |= SB_ACTIVE;
 	} else {
-		do_remount_sb(s, flags, data, data_size, 0);
+		do_remount_sb(s, flags, data, data_size, 0, NULL);
 	}
 	return dget(s->s_root);
 }
@@ -1601,3 +1791,90 @@ int thaw_super(struct super_block *sb)
 	return thaw_super_locked(sb);
 }
 EXPORT_SYMBOL(thaw_super);
+
+/**
+ * vfs_get_tree - Get the mountable root
+ * @fc: The superblock configuration context.
+ *
+ * The filesystem is invoked to get or create a superblock which can then later
+ * be used for mounting.  The filesystem places a pointer to the root to be
+ * used for mounting in @fc->root.
+ */
+int vfs_get_tree(struct fs_context *fc)
+{
+	struct super_block *sb;
+	int ret;
+
+	if (fc->fs_type->fs_flags & FS_REQUIRES_DEV && !fc->source)
+		return -ENOENT;
+
+	if (fc->root)
+		return -EBUSY;
+
+	if (fc->ops->validate) {
+		ret = fc->ops->validate(fc);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = security_fs_context_validate(fc);
+	if (ret < 0)
+		return ret;
+
+	/* Get the mountable root in fc->root, with a ref on the root and a ref
+	 * on the superblock.
+	 */
+	ret = fc->ops->get_tree(fc);
+	if (ret < 0)
+		return ret;
+
+	if (!fc->root) {
+		pr_err("Filesystem %s get_tree() didn't set fc->root\n",
+		       fc->fs_type->name);
+		/* We don't know what the locking state of the superblock is -
+		 * if there is a superblock.
+		 */
+		BUG();
+	}
+
+	sb = fc->root->d_sb;
+	WARN_ON(!sb->s_bdi);
+
+	ret = security_sb_get_tree(fc);
+	if (ret < 0)
+		goto err_sb;
+
+	ret = -ENOMEM;
+	if (fc->subtype && !sb->s_subtype) {
+		sb->s_subtype = kstrdup(fc->subtype, GFP_KERNEL);
+		if (!sb->s_subtype)
+			goto err_sb;
+	}
+
+	/* Write barrier is for super_cache_count(). We place it before setting
+	 * SB_BORN as the data dependency between the two functions is the
+	 * superblock structure contents that we just set up, not the SB_BORN
+	 * flag.
+	 */
+	smp_wmb();
+	sb->s_flags |= SB_BORN;
+
+	/* Filesystems should never set s_maxbytes larger than MAX_LFS_FILESIZE
+	 * but s_maxbytes was an unsigned long long for many releases.  Throw
+	 * this warning for a little while to try and catch filesystems that
+	 * violate this rule.
+	 */
+	WARN(sb->s_maxbytes < 0,
+	     "%s set sb->s_maxbytes to negative value (%lld)\n",
+	     fc->fs_type->name, sb->s_maxbytes);
+
+	up_write(&sb->s_umount);
+	return 0;
+
+err_sb:
+	dput(fc->root);
+	fc->root = NULL;
+	deactivate_locked_super(sb);
+	return ret;
+}
+EXPORT_SYMBOL(vfs_get_tree);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7bb71b8e3df..19bbed58829d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -60,6 +60,7 @@ struct workqueue_struct;
 struct iov_iter;
 struct fscrypt_info;
 struct fscrypt_operations;
+struct fs_context;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -718,6 +719,11 @@ static inline void inode_unlock(struct inode *inode)
 	up_write(&inode->i_rwsem);
 }
 
+static inline int inode_lock_killable(struct inode *inode)
+{
+	return down_write_killable(&inode->i_rwsem);
+}
+
 static inline void inode_lock_shared(struct inode *inode)
 {
 	down_read(&inode->i_rwsem);
@@ -1828,6 +1834,7 @@ struct super_operations {
 	int (*unfreeze_fs) (struct super_block *);
 	int (*statfs) (struct dentry *, struct kstatfs *);
 	int (*remount_fs) (struct super_block *, int *, char *, size_t);
+	int (*reconfigure) (struct super_block *, struct fs_context *);
 	void (*umount_begin) (struct super_block *);
 
 	int (*show_options)(struct seq_file *, struct dentry *);
@@ -2074,6 +2081,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+	int (*init_fs_context)(struct fs_context *, struct dentry *);
 	struct dentry *(*mount) (struct file_system_type *, int,
 				 const char *, void *, size_t);
 	void (*kill_sb) (struct super_block *);
@@ -2132,6 +2140,9 @@ void deactivate_locked_super(struct super_block *sb);
 int set_anon_super(struct super_block *s, void *data);
 int get_anon_bdev(dev_t *);
 void free_anon_bdev(dev_t);
+struct super_block *sget_fc(struct fs_context *fc,
+			    int (*test)(struct super_block *, struct fs_context *),
+			    int (*set)(struct super_block *, struct fs_context *));
 struct super_block *sget_userns(struct file_system_type *type,
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),
@@ -2174,8 +2185,8 @@ mount_pseudo(struct file_system_type *fs_type, char *name,
 
 extern int register_filesystem(struct file_system_type *);
 extern int unregister_filesystem(struct file_system_type *);
+extern struct vfsmount *kern_mount(struct file_system_type *);
 extern struct vfsmount *kern_mount_data(struct file_system_type *, void *, size_t);
-#define kern_mount(type) kern_mount_data(type, NULL, 0)
 extern void kern_unmount(struct vfsmount *mnt);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 04783814632c..368fe5bb1efd 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -25,6 +25,7 @@ struct pid_namespace;
 struct super_block;
 struct user_namespace;
 struct vfsmount;
+struct path;
 
 enum fs_context_purpose {
 	FS_CONTEXT_FOR_USER_MOUNT,	/* New superblock for user-specified mount */
@@ -33,6 +34,19 @@ enum fs_context_purpose {
 	FS_CONTEXT_FOR_RECONFIGURE,	/* Superblock reconfiguration (remount) */
 };
 
+/*
+ * Userspace usage phase for fsopen/fspick.
+ */
+enum fs_context_phase {
+	FS_CONTEXT_CREATE_PARAMS,	/* Loading params for sb creation */
+	FS_CONTEXT_CREATING,		/* A superblock is being created */
+	FS_CONTEXT_AWAITING_MOUNT,	/* Superblock created, awaiting fsmount() */
+	FS_CONTEXT_AWAITING_RECONF,	/* Awaiting initialisation for reconfiguration */
+	FS_CONTEXT_RECONF_PARAMS,	/* Loading params for reconfiguration */
+	FS_CONTEXT_RECONFIGURING,	/* Reconfiguring the superblock */
+	FS_CONTEXT_FAILED,		/* Failed to correctly transition a context */
+};
+
 /*
  * Filesystem context for holding the parameters used in the creation or
  * reconfiguration of a superblock.
@@ -60,6 +74,7 @@ struct fs_context {
 	bool			drop_sb:1;	/* T if need to drop an SB reference */
 	bool			source_is_dev:1; /* T if source is local device/file */
 	enum fs_context_purpose	purpose : 8;
+	enum fs_context_phase	phase:8;	/* The phase the context is in */
 };
 
 struct fs_context_operations {
@@ -67,9 +82,37 @@ struct fs_context_operations {
 	int (*dup)(struct fs_context *fc, struct fs_context *src_fc);
 	int (*parse_source)(struct fs_context *fc, char *source);
 	int (*parse_option)(struct fs_context *fc, char *opt, size_t len);
-	int (*parse_monolithic)(struct fs_context *fc, void *data);
+	int (*parse_monolithic)(struct fs_context *fc, void *data, size_t data_size);
 	int (*validate)(struct fs_context *fc);
 	int (*get_tree)(struct fs_context *fc);
 };
 
+/*
+ * fs_context manipulation functions.
+ */
+extern struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
+					     struct dentry *reference,
+					     unsigned int ms_flags,
+					     enum fs_context_purpose purpose);
+extern struct fs_context *vfs_sb_reconfig(struct path *path, unsigned int ms_flags);
+extern struct fs_context *vfs_dup_fs_context(struct fs_context *src);
+extern int vfs_set_fs_source(struct fs_context *fc, const char *source, size_t slen);
+extern int vfs_parse_fs_option(struct fs_context *fc, char *data, size_t opt);
+extern int generic_parse_monolithic(struct fs_context *fc, void *data, size_t data_size);
+extern int vfs_get_tree(struct fs_context *fc);
+extern void put_fs_context(struct fs_context *fc);
+
+/*
+ * sget() wrapper to be called from the ->get_tree() op.
+ */
+enum vfs_get_super_keying {
+	vfs_get_single_super,	/* Only one such superblock may exist */
+	vfs_get_keyed_super,	/* Superblocks with different s_fs_info keys may exist */
+	vfs_get_independent_super, /* Multiple independent superblocks may exist */
+};
+extern int vfs_get_super(struct fs_context *fc,
+			 enum vfs_get_super_keying keying,
+			 int (*fill_super)(struct super_block *sb,
+					   struct fs_context *fc));
+
 #endif /* _LINUX_FS_CONTEXT_H */
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 8a1031a511c9..ee5af77afc06 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -21,6 +21,7 @@ struct super_block;
 struct vfsmount;
 struct dentry;
 struct mnt_namespace;
+struct fs_context;
 
 #define MNT_NOSUID	0x01
 #define MNT_NODEV	0x02
@@ -88,6 +89,8 @@ struct path;
 extern struct vfsmount *clone_private_mount(const struct path *path);
 
 struct file_system_type;
+extern struct vfsmount *vfs_create_mount(struct fs_context *fc,
+					 unsigned int mnt_flags);
 extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 				      int flags, const char *name,
 				      void *data, size_t data_size);
