Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C25C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67FF21565
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67FF21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbeIUWVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:21:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390681AbeIUWVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:21:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6150C05093A;
        Fri, 21 Sep 2018 16:32:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8939F7DFD9;
        Fri, 21 Sep 2018 16:32:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/34] vfs: Implement a filesystem superblock
 creation/configuration context [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:32:10 +0100
Message-ID: <153754753073.17872.8680329471324670514.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 21 Sep 2018 16:32:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a filesystem context concept to be used during superblock
creation for mount and superblock reconfiguration for remount.

The mounting procedure then becomes:

 (1) Allocate new fs_context context.

 (2) Configure the context.

 (3) Create superblock.

 (4) Query the superblock.

 (5) Create a mount for the superblock.

 (6) Destroy the context.

Rather than calling fs_type->mount(), an fs_context struct is created and
fs_type->init_fs_context() is called to set it up.  Pointers exist for the
filesystem and LSM to hang their private data off.

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

 fs/Makefile                |    2 
 fs/filesystems.c           |    4 
 fs/fs_context.c            |  658 ++++++++++++++++++++++++++++++++++++++++++++
 fs/internal.h              |   14 +
 fs/libfs.c                 |   20 +
 fs/namespace.c             |  397 ++++++++++++++++++---------
 fs/super.c                 |  401 ++++++++++++++++++++++++---
 include/linux/fs.h         |   15 +
 include/linux/fs_context.h |   30 ++
 include/linux/kernfs.h     |    2 
 include/linux/mount.h      |    3 
 11 files changed, 1379 insertions(+), 167 deletions(-)
 create mode 100644 fs/fs_context.c

diff --git a/fs/Makefile b/fs/Makefile
index 07b894227dce..9a0b8003f069 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -13,7 +13,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
-		fs_parser.o
+		fs_context.o fs_parser.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
diff --git a/fs/filesystems.c b/fs/filesystems.c
index b03f57b1105b..9135646e41ac 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/fs_parser.h>
 
 /*
  * Handling of filesystem drivers list.
@@ -73,6 +74,9 @@ int register_filesystem(struct file_system_type * fs)
 	int res = 0;
 	struct file_system_type ** p;
 
+	if (fs->parameters && !fs_validate_description(fs->parameters))
+		return -EINVAL;
+
 	BUG_ON(strchr(fs->name, '.'));
 	if (fs->next)
 		return -EBUSY;
diff --git a/fs/fs_context.c b/fs/fs_context.c
new file mode 100644
index 000000000000..328fcb764667
--- /dev/null
+++ b/fs/fs_context.c
@@ -0,0 +1,658 @@
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
+#include <linux/fs_parser.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/nsproxy.h>
+#include <linux/slab.h>
+#include <linux/magic.h>
+#include <linux/security.h>
+#include <linux/mnt_namespace.h>
+#include <linux/pid_namespace.h>
+#include <linux/user_namespace.h>
+#include <linux/bsearch.h>
+#include <net/net_namespace.h>
+#include "mount.h"
+#include "internal.h"
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
+	char			*legacy_data;	/* Data page for legacy filesystems */
+	char			*secdata;
+	size_t			data_size;
+	enum legacy_fs_param	param_type;
+};
+
+static const struct constant_table common_set_sb_flag[] = {
+	{ "dirsync",	SB_DIRSYNC },
+	{ "lazytime",	SB_LAZYTIME },
+	{ "mand",	SB_MANDLOCK },
+	{ "posixacl",	SB_POSIXACL },
+	{ "ro",		SB_RDONLY },
+	{ "sync",	SB_SYNCHRONOUS },
+};
+
+static const struct constant_table common_clear_sb_flag[] = {
+	{ "async",	SB_SYNCHRONOUS },
+	{ "nolazytime",	SB_LAZYTIME },
+	{ "nomand",	SB_MANDLOCK },
+	{ "rw",		SB_RDONLY },
+	{ "silent",	SB_SILENT },
+};
+
+static const char *const forbidden_sb_flag[] = {
+	"bind",
+	"dev",
+	"exec",
+	"move",
+	"noatime",
+	"nodev",
+	"nodiratime",
+	"noexec",
+	"norelatime",
+	"nostrictatime",
+	"nosuid",
+	"private",
+	"rec",
+	"relatime",
+	"remount",
+	"shared",
+	"slave",
+	"strictatime",
+	"suid",
+	"unbindable",
+};
+
+static int cmp_flag_name(const void *name, const void *entry)
+{
+	const char **e = (const char **)entry;
+	return strcmp(name, *e);
+}
+
+/*
+ * Check for a common mount option that manipulates s_flags.
+ */
+static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
+{
+	unsigned int token;
+
+	if (bsearch(key, forbidden_sb_flag, ARRAY_SIZE(forbidden_sb_flag),
+		    sizeof(forbidden_sb_flag[0]), cmp_flag_name))
+		return -EINVAL;
+
+	token = lookup_constant(common_set_sb_flag, key, 0);
+	if (token) {
+		fc->sb_flags |= token;
+		fc->sb_flags_mask |= token;
+		return 0;
+	}
+
+	token = lookup_constant(common_clear_sb_flag, key, 0);
+	if (token) {
+		fc->sb_flags &= ~token;
+		fc->sb_flags_mask |= token;
+		return 0;
+	}
+
+	return -ENOPARAM;
+}
+
+/**
+ * vfs_parse_fs_param - Add a single parameter to a superblock config
+ * @fc: The filesystem context to modify
+ * @param: The parameter
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
+int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	int ret;
+
+	if (!param->key)
+		return invalf(fc, "Unnamed parameter\n");
+
+	ret = vfs_parse_sb_flag(fc, param->key);
+	if (ret != -ENOPARAM)
+		return ret;
+
+	ret = security_fs_context_parse_param(fc, param);
+	if (ret != -ENOPARAM)
+		/* Param belongs to the LSM or is disallowed by the LSM; so
+		 * don't pass to the FS.
+		 */
+		return ret;
+
+	if (fc->ops->parse_param) {
+		ret = fc->ops->parse_param(fc, param);
+		if (ret != -ENOPARAM)
+			return ret;
+	}
+
+	/* If the filesystem doesn't take any arguments, we need to ignore the
+	 * source parameter if given.
+	 */
+	if (strcmp(param->key, "source") == 0)
+		return 0;
+
+	return invalf(fc, "%s: Unknown parameter '%s'",
+		      fc->fs_type->name, param->key);
+}
+EXPORT_SYMBOL(vfs_parse_fs_param);
+
+/**
+ * vfs_parse_fs_string - Convenience function to just parse a string.
+ */
+int vfs_parse_fs_string(struct fs_context *fc, const char *key,
+			const char *value, size_t v_size)
+{
+	int ret;
+
+	struct fs_parameter param = {
+		.key	= key,
+		.type	= fs_value_is_string,
+		.size	= v_size,
+	};
+
+	if (v_size > 0) {
+		param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
+		if (!param.string)
+			return -ENOMEM;
+	}
+
+	ret = vfs_parse_fs_param(fc, &param);
+	kfree(param.string);
+	return ret;
+}
+EXPORT_SYMBOL(vfs_parse_fs_string);
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
+	char *options = data, *key;
+	int ret = 0;
+
+	if (!options)
+		return 0;
+
+	while ((key = strsep(&options, ",")) != NULL) {
+		if (*key) {
+			size_t v_len = 0;
+			char *value = strchr(key, '=');
+
+			if (value) {
+				if (value == key)
+					continue;
+				*value++ = 0;
+				v_len = strlen(value);
+			}
+			ret = vfs_parse_fs_string(fc, key, value, v_len);
+			if (ret < 0)
+				break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(generic_parse_monolithic);
+
+/**
+ * vfs_new_fs_context - Create a filesystem context.
+ * @fs_type: The filesystem type.
+ * @reference: The dentry from which this one derives (or NULL)
+ * @sb_flags: Filesystem/superblock flags (SB_*)
+ * @sb_flags_mask: Applicable members of @sb_flags
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
+				      unsigned int sb_flags_mask,
+				      enum fs_context_purpose purpose)
+{
+	int (*init_fs_context)(struct fs_context *, struct dentry *);
+	struct fs_context *fc;
+	int ret = -ENOMEM;
+
+	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
+	if (!fc)
+		return ERR_PTR(-ENOMEM);
+
+	fc->purpose	= purpose;
+	fc->sb_flags	= sb_flags;
+	fc->sb_flags_mask = sb_flags_mask;
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
+	case FS_CONTEXT_FOR_ROOT_MOUNT:
+		fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
+		fc->net_ns = get_net(current->nsproxy->net_ns);
+		break;
+	case FS_CONTEXT_FOR_RECONFIGURE:
+	case FS_CONTEXT_FOR_UMOUNT:
+	case FS_CONTEXT_FOR_EMERGENCY_RO:
+		/* We don't pin any namespaces as the superblock's
+		 * subscriptions cannot be changed at this point.
+		 */
+		atomic_inc(&reference->d_sb->s_active);
+		fc->root = dget(reference);
+		break;
+	}
+
+	/* TODO: Make all filesystems support this unconditionally */
+	init_fs_context = fc->fs_type->init_fs_context;
+	if (!init_fs_context)
+		init_fs_context = legacy_init_fs_context;
+
+	ret = (*init_fs_context)(fc, reference);
+	if (ret < 0)
+		goto err_fc;
+	fc->need_free = true;
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
+ * vfs_dup_fc_config: Duplicate a filesystem context.
+ * @src_fc: The context to copy.
+ * @purpose: The purpose to set in the new mount
+ */
+struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc,
+				      enum fs_context_purpose purpose)
+{
+	struct fs_context *fc;
+	int ret;
+
+	if (!src_fc->ops->dup)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	fc = kmemdup(src_fc, sizeof(struct fs_context), GFP_KERNEL);
+	if (!fc)
+		return ERR_PTR(-ENOMEM);
+
+	fc->fs_private	= NULL;
+	fc->s_fs_info	= NULL;
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
+		deactivate_super(sb);
+	}
+
+	if (fc->need_free && fc->ops && fc->ops->free)
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
+	struct legacy_fs_context *ctx = fc->fs_private;
+
+	if (ctx) {
+		free_secdata(ctx->secdata);
+		switch (ctx->param_type) {
+		case LEGACY_FS_UNSET_PARAMS:
+		case LEGACY_FS_NO_PARAMS:
+			break;
+		case LEGACY_FS_MAGIC_PARAMS:
+			break; /* ctx->data is a weird pointer */
+		default:
+			kfree(ctx->legacy_data);
+			break;
+		}
+
+		kfree(ctx);
+	}
+}
+
+/*
+ * Duplicate a legacy config.
+ */
+static int legacy_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
+{
+	struct legacy_fs_context *ctx;
+	struct legacy_fs_context *src_ctx = src_fc->fs_private;
+
+	ctx = kmemdup(src_ctx, sizeof(*src_ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	switch (ctx->param_type) {
+	case LEGACY_FS_MONOLITHIC_PARAMS:
+	case LEGACY_FS_INDIVIDUAL_PARAMS:
+		ctx->legacy_data = kmemdup(src_ctx->legacy_data,
+					   src_ctx->data_size, GFP_KERNEL);
+		if (!ctx->legacy_data) {
+			kfree(ctx);
+			return -ENOMEM;
+		}
+		/* Fall through */
+	default:
+		break;
+	}
+
+	fc->fs_private = ctx;
+	return 0;
+}
+
+/*
+ * Add a parameter to a legacy config.  We build up a comma-separated list of
+ * options.
+ */
+static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct legacy_fs_context *ctx = fc->fs_private;
+	unsigned int size = ctx->data_size;
+	size_t len = 0;
+
+	if (strcmp(param->key, "source") == 0) {
+		if (param->type != fs_value_is_string)
+			return invalf(fc, "VFS: Legacy: Non-string source");
+		if (fc->source)
+			return invalf(fc, "VFS: Legacy: Multiple sources");
+		fc->source = param->string;
+		param->string = NULL;
+		return 0;
+	}
+
+	if ((fc->fs_type->fs_flags & FS_HAS_SUBTYPE) &&
+	    strcmp(param->key, "subtype") == 0) {
+		if (param->type != fs_value_is_string)
+			return invalf(fc, "VFS: Legacy: Non-string subtype");
+		if (fc->subtype)
+			return invalf(fc, "VFS: Legacy: Multiple subtype");
+		fc->subtype = param->string;
+		param->string= NULL;
+		return 0;
+	}
+
+	if (ctx->param_type != LEGACY_FS_UNSET_PARAMS &&
+	    ctx->param_type != LEGACY_FS_INDIVIDUAL_PARAMS)
+		return invalf(fc, "VFS: Legacy: Can't mix monolithic and individual options");
+
+	switch (param->type) {
+	case fs_value_is_string:
+		len = 1 + param->size;
+		/* Fall through */
+	case fs_value_is_flag:
+		len += strlen(param->key);
+		break;
+	default:
+		return invalf(fc, "VFS: Legacy: Parameter type for '%s' not supported",
+			      param->key);
+	}
+
+	if (len > PAGE_SIZE - 2 - size)
+		return invalf(fc, "VFS: Legacy: Cumulative options too large");
+	if (strchr(param->key, ',') ||
+	    (param->type == fs_value_is_string &&
+	     memchr(param->string, ',', param->size)))
+		return invalf(fc, "VFS: Legacy: Option '%s' contained comma",
+			      param->key);
+	if (!ctx->legacy_data) {
+		ctx->legacy_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!ctx->legacy_data)
+			return -ENOMEM;
+	}
+
+	ctx->legacy_data[size++] = ',';
+	len = strlen(param->key);
+	memcpy(ctx->legacy_data + size, param->key, len);
+	size += len;
+	if (param->type == fs_value_is_string) {
+		ctx->legacy_data[size++] = '=';
+		memcpy(ctx->legacy_data + size, param->string, param->size);
+		size += param->size;
+	}
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
+	struct legacy_fs_context *ctx = fc->fs_private;
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
+	struct legacy_fs_context *ctx = fc->fs_private;
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
+	if (fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)
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
+ * Get a mountable root with the legacy mount command.
+ */
+static int legacy_get_tree(struct fs_context *fc)
+{
+	struct legacy_fs_context *ctx = fc->fs_private;
+	struct super_block *sb;
+	struct dentry *root;
+
+	root = fc->fs_type->mount(fc->fs_type, fc->sb_flags,
+				      fc->source, ctx->legacy_data,
+				      ctx->data_size);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	sb = root->d_sb;
+	BUG_ON(!sb);
+
+	fc->root = root;
+	return 0;
+}
+
+/*
+ * Handle remount.
+ */
+static int legacy_reconfigure(struct fs_context *fc)
+{
+	struct legacy_fs_context *ctx = fc->fs_private;
+	struct super_block *sb = fc->root->d_sb;
+
+	if (!sb->s_op->remount_fs)
+		return 0;
+
+	return sb->s_op->remount_fs(sb, &fc->sb_flags,
+				    ctx ? ctx->legacy_data : NULL,
+				    ctx ? ctx->data_size : 0);
+}
+
+const struct fs_context_operations legacy_fs_context_ops = {
+	.free			= legacy_fs_context_free,
+	.dup			= legacy_fs_context_dup,
+	.parse_param		= legacy_parse_param,
+	.parse_monolithic	= legacy_parse_monolithic,
+	.validate		= legacy_validate,
+	.get_tree		= legacy_get_tree,
+	.reconfigure		= legacy_reconfigure,
+};
+
+/*
+ * Initialise a legacy context for a filesystem that doesn't support
+ * fs_context.
+ */
+int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry)
+{
+	switch (fc->purpose) {
+	default:
+		fc->fs_private = kzalloc(sizeof(struct legacy_fs_context),
+					 GFP_KERNEL);
+		if (!fc->fs_private)
+			return -ENOMEM;
+		break;
+
+	case FS_CONTEXT_FOR_UMOUNT:
+	case FS_CONTEXT_FOR_EMERGENCY_RO:
+		if (!fc->root->d_sb->s_op->remount_fs)
+			return -EOPNOTSUPP;
+		break;
+	}
+
+	fc->ops = &legacy_fs_context_ops;
+	return 0;
+}
diff --git a/fs/internal.h b/fs/internal.h
index 63b6840de8c1..fc2da60abbcd 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -51,6 +51,17 @@ int __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
  */
 extern void __init chrdev_init(void);
 
+/*
+ * fs_context.c
+ */
+extern const struct fs_context_operations legacy_fs_context_ops;
+extern int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry);
+
+/*
+ * fsopen.c
+ */
+extern void vfs_clean_context(struct fs_context *fc);
+
 /*
  * namei.c
  */
@@ -74,6 +85,7 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
  */
 extern void *copy_mount_options(const void __user *);
 extern char *copy_mount_string(const void __user *);
+extern int parse_monolithic_mount_data(struct fs_context *, void *, size_t);
 
 extern struct vfsmount *lookup_mnt(const struct path *);
 extern int finish_automount(struct vfsmount *, struct path *);
@@ -102,7 +114,7 @@ extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
 /*
  * super.c
  */
-extern int do_remount_sb(struct super_block *, int, void *, size_t, int);
+extern int reconfigure_super(struct fs_context *);
 extern bool trylock_super(struct super_block *sb);
 extern struct dentry *mount_fs(struct file_system_type *,
 			       int, const char *, void *, size_t);
diff --git a/fs/libfs.c b/fs/libfs.c
index 9f1f4884b7cc..b1744c071ab0 100644
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
@@ -574,13 +575,30 @@ static DEFINE_SPINLOCK(pin_fs_lock);
 
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
+		fc = vfs_new_fs_context(type, NULL, 0, 0,
+					FS_CONTEXT_FOR_KERNEL_MOUNT);
+		if (IS_ERR(fc))
+			return PTR_ERR(fc);
+
+		ret = vfs_get_tree(fc);
+		if (ret < 0) {
+			put_fs_context(fc);
+			return ret;
+		}
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
index 059a13e1ae09..d841ba5568d9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -28,6 +28,7 @@
 #include <linux/task_work.h>
 #include <linux/sched/task.h>
 #include <uapi/linux/mount.h>
+#include <linux/fs_context.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -941,56 +942,6 @@ static struct mount *skip_mnt_tree(struct mount *p)
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
@@ -1466,6 +1417,40 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 
 static void shrink_submounts(struct mount *mnt);
 
+static int do_umount_root(struct super_block *sb)
+{
+	int ret = 0;
+	struct fs_context fc = {
+		.purpose	= FS_CONTEXT_FOR_UMOUNT,
+		.fs_type	= sb->s_type,
+		.root		= sb->s_root,
+		.sb_flags	= SB_RDONLY,
+		.sb_flags_mask	= SB_RDONLY,
+	};
+
+	down_write(&sb->s_umount);
+	if (!sb_rdonly(sb)) {
+		int ret;
+
+		if (fc.fs_type->init_fs_context)
+			ret = fc.fs_type->init_fs_context(&fc, NULL);
+		else
+			ret = legacy_init_fs_context(&fc, NULL);
+
+		switch (ret) {
+		case 0:
+			ret = reconfigure_super(&fc);
+			fc.ops->free(&fc);
+			break;
+		case -EOPNOTSUPP:
+			ret = 0;
+			break;
+		}
+	}
+	up_write(&sb->s_umount);
+	return ret;
+}
+
 static int do_umount(struct mount *mnt, int flags)
 {
 	struct super_block *sb = mnt->mnt.mnt_sb;
@@ -1531,11 +1516,7 @@ static int do_umount(struct mount *mnt, int flags)
 		 */
 		if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 			return -EPERM;
-		down_write(&sb->s_umount);
-		if (!sb_rdonly(sb))
-			retval = do_remount_sb(sb, SB_RDONLY, NULL, 0, 0);
-		up_write(&sb->s_umount);
-		return retval;
+		return do_umount_root(sb);
 	}
 
 	namespace_lock();
@@ -2378,6 +2359,20 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 	return ret;
 }
 
+/*
+ * Parse the monolithic page of mount data given to sys_mount().
+ */
+int parse_monolithic_mount_data(struct fs_context *fc, void *data, size_t data_size)
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
@@ -2386,6 +2381,7 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 static int do_remount(struct path *path, int ms_flags, int sb_flags,
 		      int mnt_flags, void *data, size_t data_size)
 {
+	struct fs_context *fc = NULL;
 	int err;
 	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
@@ -2399,18 +2395,34 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	if (!can_change_locked_flags(mnt, mnt_flags))
 		return -EPERM;
 
-	err = security_sb_remount(sb, data, data_size);
+	fc = vfs_new_fs_context(path->dentry->d_sb->s_type,
+				path->dentry, sb_flags, MS_RMT_MASK,
+				FS_CONTEXT_FOR_RECONFIGURE);
+
+	err = parse_monolithic_mount_data(fc, data, data_size);
+	if (err < 0)
+		goto err_fc;
+
+	if (fc->ops->validate) {
+		err = fc->ops->validate(fc);
+		if (err < 0)
+			goto err_fc;
+	}
+
+	err = security_fs_context_validate(fc);
 	if (err)
-		return err;
+		goto err_fc;
 
 	down_write(&sb->s_umount);
 	err = -EPERM;
 	if (ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
-		err = do_remount_sb(sb, sb_flags, data, data_size, 0);
+		err = reconfigure_super(fc);
 		if (!err)
 			set_mount_attributes(mnt, mnt_flags);
 	}
 	up_write(&sb->s_umount);
+err_fc:
+	put_fs_context(fc);
 	return err;
 }
 
@@ -2515,29 +2527,6 @@ static int do_move_mount_old(struct path *path, const char *old_name)
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
@@ -2582,44 +2571,109 @@ static int do_add_mount(struct mount *newmnt, struct path *path, int mnt_flags)
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
+	const char *subtype = NULL;
 	int err;
 
 	if (!fstype)
 		return -EINVAL;
 
-	type = get_fs_type(fstype);
-	if (!type)
-		return -ENODEV;
+	err = -ENODEV;
+	fs_type = get_fs_type(fstype);
+	if (!fs_type)
+		goto out;
 
-	mnt = vfs_kern_mount(type, sb_flags, name, data, data_size);
-	if (!IS_ERR(mnt) && (type->fs_flags & FS_HAS_SUBTYPE) &&
-	    !mnt->mnt_sb->s_subtype)
-		mnt = fs_set_subtype(mnt, fstype);
+	if (fs_type->fs_flags & FS_HAS_SUBTYPE) {
+		subtype = strchr(fstype, '.');
+		if (subtype) {
+			subtype++;
+			if (!subtype[0]) {
+				put_filesystem(fs_type);
+				return -EINVAL;
+			}
+		} else {
+			subtype = "";
+		}
+	}
 
-	put_filesystem(type);
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
+	fc = vfs_new_fs_context(fs_type, NULL, sb_flags, sb_flags,
+				FS_CONTEXT_FOR_USER_MOUNT);
+	put_filesystem(fs_type);
+	if (IS_ERR(fc)) {
+		err = PTR_ERR(fc);
+		goto out;
+	}
 
-	if (mount_too_revealing(mnt, &mnt_flags)) {
-		mntput(mnt);
-		return -EPERM;
+	if (subtype) {
+		err = vfs_parse_fs_string(fc, "subtype",
+					  subtype, strlen(subtype));
+		if (err < 0)
+			goto out;
 	}
 
-	err = do_add_mount(real_mount(mnt), path, mnt_flags);
-	if (err)
-		mntput(mnt);
+	if (name) {
+		err = vfs_parse_fs_string(fc, "source", name, strlen(name));
+		if (err < 0)
+			goto out_fc;
+	}
+
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
 
@@ -3169,6 +3223,118 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
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
+	fc = vfs_new_fs_context(type, NULL, sb_flags, sb_flags,
+				sb_flags & SB_KERNMOUNT ?
+				FS_CONTEXT_FOR_KERNEL_MOUNT :
+				FS_CONTEXT_FOR_USER_MOUNT);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	if (devname) {
+		ret = vfs_parse_fs_string(fc, "source",
+					  devname, strlen(devname));
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
+	return vfs_kern_mount(type, SB_SUBMOUNT, name, data, data_size);
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
  * Move a mount from one place to another.
  * In combination with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be
@@ -3446,22 +3612,6 @@ void put_mnt_ns(struct mnt_namespace *ns)
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
@@ -3502,7 +3652,8 @@ bool current_chrooted(void)
 	return chrooted;
 }
 
-static bool mnt_already_visible(struct mnt_namespace *ns, struct vfsmount *new,
+static bool mnt_already_visible(struct mnt_namespace *ns,
+				const struct super_block *sb,
 				int *new_mnt_flags)
 {
 	int new_flags = *new_mnt_flags;
@@ -3514,7 +3665,7 @@ static bool mnt_already_visible(struct mnt_namespace *ns, struct vfsmount *new,
 		struct mount *child;
 		int mnt_flags;
 
-		if (mnt->mnt.mnt_sb->s_type != new->mnt_sb->s_type)
+		if (mnt->mnt.mnt_sb->s_type != sb->s_type)
 			continue;
 
 		/* This mount is not fully visible if it's root directory
@@ -3565,7 +3716,7 @@ static bool mnt_already_visible(struct mnt_namespace *ns, struct vfsmount *new,
 	return visible;
 }
 
-static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags)
+static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags)
 {
 	const unsigned long required_iflags = SB_I_NOEXEC | SB_I_NODEV;
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
@@ -3575,7 +3726,7 @@ static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags)
 		return false;
 
 	/* Can this filesystem be too revealing? */
-	s_iflags = mnt->mnt_sb->s_iflags;
+	s_iflags = sb->s_iflags;
 	if (!(s_iflags & SB_I_USERNS_VISIBLE))
 		return false;
 
@@ -3585,7 +3736,7 @@ static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags)
 		return true;
 	}
 
-	return !mnt_already_visible(ns, mnt, new_mnt_flags);
+	return !mnt_already_visible(ns, sb, new_mnt_flags);
 }
 
 bool mnt_may_suid(struct vfsmount *mnt)
diff --git a/fs/super.c b/fs/super.c
index 67f88c055967..df8c4cebd000 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <uapi/linux/mount.h>
+#include <linux/fs_context.h>
 #include "internal.h"
 
 static int thaw_super_locked(struct super_block *sb);
@@ -187,16 +188,13 @@ static void destroy_unused_super(struct super_block *s)
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
@@ -206,9 +204,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
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
@@ -232,12 +230,12 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
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
@@ -251,7 +249,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
-	lockdep_set_class(&s->s_vfs_rename_mutex, &type->s_vfs_rename_key);
+	lockdep_set_class(&s->s_vfs_rename_mutex, &fc->fs_type->s_vfs_rename_key);
 	init_rwsem(&s->s_dquot.dqio_sem);
 	s->s_maxbytes = MAX_NON_LFS;
 	s->s_op = &default_op;
@@ -475,6 +473,91 @@ void generic_shutdown_super(struct super_block *sb)
 
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
+			if (test(old, fc))
+				goto share_extant_sb;
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
+	register_shrinker_prepared(&s->s_shrink);
+	return s;
+
+share_extant_sb:
+	if (fc->user_ns != old->s_user_ns) {
+		spin_unlock(&sb_lock);
+		destroy_unused_super(s);
+		return ERR_PTR(-EBUSY);
+	}
+	if (!grab_super(old))
+		goto retry;
+	destroy_unused_super(s);
+	return old;
+}
+EXPORT_SYMBOL(sget_fc);
+
 /**
  *	sget_userns -	find or create a superblock
  *	@type:	filesystem type superblock should belong to
@@ -517,7 +600,14 @@ struct super_block *sget_userns(struct file_system_type *type,
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
@@ -835,30 +925,30 @@ struct super_block *user_get_super(dev_t dev)
 }
 
 /**
- *	do_remount_sb - asks filesystem to change mount options.
- *	@sb:	superblock in question
- *	@sb_flags: revised superblock flags
- *	@data:	the rest of options
- *	@data_size: The size of the data
- *      @force: whether or not to force the change
+ * reconfigure_super - asks filesystem to change superblock parameters
+ * @fc:	the superblock and configuration
  *
- *	Alters the mount options of a mounted file system.
+ * Alters the configuration parameters of a live superblock.
  */
-int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
-		  size_t data_size, int force)
+int reconfigure_super(struct fs_context *fc)
 {
+	struct super_block *sb = fc->root->d_sb;
 	int retval;
-	int remount_ro;
+	int remount_ro = false;
 
+	if (fc->sb_flags_mask & ~MS_RMT_MASK)
+		return -EINVAL;
 	if (sb->s_writers.frozen != SB_UNFROZEN)
 		return -EBUSY;
 
+	if (fc->sb_flags_mask & SB_RDONLY) {
 #ifdef CONFIG_BLOCK
-	if (!(sb_flags & SB_RDONLY) && bdev_read_only(sb->s_bdev))
-		return -EACCES;
+		if (!(fc->sb_flags & SB_RDONLY) && bdev_read_only(sb->s_bdev))
+			return -EACCES;
 #endif
 
-	remount_ro = (sb_flags & SB_RDONLY) && !sb_rdonly(sb);
+		remount_ro = (fc->sb_flags & SB_RDONLY) && !sb_rdonly(sb);
+	}
 
 	if (remount_ro) {
 		if (!hlist_empty(&sb->s_pins)) {
@@ -869,15 +959,16 @@ int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
 				return 0;
 			if (sb->s_writers.frozen != SB_UNFROZEN)
 				return -EBUSY;
-			remount_ro = (sb_flags & SB_RDONLY) && !sb_rdonly(sb);
+			remount_ro = !sb_rdonly(sb);
 		}
 	}
 	shrink_dcache_sb(sb);
 
-	/* If we are remounting RDONLY and current sb is read/write,
-	   make sure there are no rw files opened */
+	/* If we are reconfiguring to RDONLY and current sb is read/write,
+	 * make sure there are no files open for writing.
+	 */
 	if (remount_ro) {
-		if (force) {
+		if (fc->purpose == FS_CONTEXT_FOR_EMERGENCY_RO) {
 			sb->s_readonly_remount = 1;
 			smp_wmb();
 		} else {
@@ -887,17 +978,21 @@ int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
 		}
 	}
 
-	if (sb->s_op->remount_fs) {
-		retval = sb->s_op->remount_fs(sb, &sb_flags, data, data_size);
-		if (retval) {
-			if (!force)
+	if (fc->ops->reconfigure) {
+		retval = fc->ops->reconfigure(fc);
+		if (retval == 0) {
+			security_sb_reconfigure(fc);
+		} else {
+			if (fc->purpose != FS_CONTEXT_FOR_EMERGENCY_RO)
 				goto cancel_readonly;
 			/* If forced remount, go ahead despite any errors */
 			WARN(1, "forced remount of a %s fs returned %i\n",
 			     sb->s_type->name, retval);
 		}
 	}
-	sb->s_flags = (sb->s_flags & ~MS_RMT_MASK) | (sb_flags & MS_RMT_MASK);
+
+	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
+				 (fc->sb_flags & fc->sb_flags_mask)));
 	/* Needs to be ordered wrt mnt_is_readonly() */
 	smp_wmb();
 	sb->s_readonly_remount = 0;
@@ -921,13 +1016,29 @@ int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
 
 static void do_emergency_remount_callback(struct super_block *sb)
 {
+	struct fs_context fc = {
+		.purpose	= FS_CONTEXT_FOR_EMERGENCY_RO,
+		.fs_type	= sb->s_type,
+		.root		= sb->s_root,
+		.sb_flags	= SB_RDONLY,
+		.sb_flags_mask	= SB_RDONLY,
+	};
+
 	down_write(&sb->s_umount);
 	if (sb->s_root && sb->s_bdev && (sb->s_flags & SB_BORN) &&
 	    !sb_rdonly(sb)) {
+		int ret;
+
+		if (fc.fs_type->init_fs_context)
+			ret = fc.fs_type->init_fs_context(&fc, NULL);
+		else
+			ret = legacy_init_fs_context(&fc, NULL);
+
 		/*
 		 * What lock protects sb->s_flags??
 		 */
-		do_remount_sb(sb, SB_RDONLY, NULL, 0, 1);
+		if (ret == 0)
+			reconfigure_super(&fc);
 	}
 	up_write(&sb->s_umount);
 }
@@ -1090,6 +1201,89 @@ struct dentry *mount_ns(struct file_system_type *fs_type,
 
 EXPORT_SYMBOL(mount_ns);
 
+int set_anon_super_fc(struct super_block *sb, struct fs_context *fc)
+{
+	return set_anon_super(sb, NULL);
+}
+EXPORT_SYMBOL(set_anon_super_fc);
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
+	return 0;
+}
+EXPORT_SYMBOL(vfs_get_super);
+
 #ifdef CONFIG_BLOCK
 static int set_bdev_super(struct super_block *s, void *data)
 {
@@ -1215,6 +1409,42 @@ struct dentry *mount_nodev(struct file_system_type *fs_type,
 }
 EXPORT_SYMBOL(mount_nodev);
 
+static int reconfigure_single(struct super_block *s,
+			      int flags, void *data, size_t data_size)
+{
+	struct fs_context *fc;
+	int ret;
+
+	/* The caller really need to be passing fc down into mount_single(),
+	 * then a chunk of this can be removed.  Better yet, reconfiguration
+	 * shouldn't happen, but rather the second mount should be rejected if
+	 * the parameters are not compatible.
+	 */
+	fc = vfs_new_fs_context(s->s_type, s->s_root, flags, MS_RMT_MASK,
+				FS_CONTEXT_FOR_RECONFIGURE);
+	if (IS_ERR(fc))
+		return PTR_ERR(fc);
+
+	ret = parse_monolithic_mount_data(fc, data, data_size);
+	if (ret < 0)
+		goto out;
+
+	if (fc->ops->validate) {
+		ret = fc->ops->validate(fc);
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = security_fs_context_validate(fc);
+	if (ret)
+		goto out;
+
+	ret = reconfigure_super(fc);
+out:
+	put_fs_context(fc);
+	return ret;
+}
+
 static int compare_single(struct super_block *s, void *p)
 {
 	return 1;
@@ -1232,15 +1462,19 @@ struct dentry *mount_single(struct file_system_type *fs_type,
 		return ERR_CAST(s);
 	if (!s->s_root) {
 		error = fill_super(s, data, data_size, flags & SB_SILENT ? 1 : 0);
-		if (error) {
-			deactivate_locked_super(s);
-			return ERR_PTR(error);
-		}
+		if (error)
+			goto error;
 		s->s_flags |= SB_ACTIVE;
 	} else {
-		do_remount_sb(s, flags, data, data_size, 0);
+		error = reconfigure_single(s, flags, data, data_size);
+		if (error)
+			goto error;
 	}
 	return dget(s->s_root);
+
+error:
+	deactivate_locked_super(s);
+	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(mount_single);
 
@@ -1585,3 +1819,90 @@ int thaw_super(struct super_block *sb)
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
index 6dc32507762f..4c3c388646bc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -61,6 +61,8 @@ struct workqueue_struct;
 struct iov_iter;
 struct fscrypt_info;
 struct fscrypt_operations;
+struct fs_context;
+struct fs_parameter_description;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -746,6 +748,11 @@ static inline void inode_unlock(struct inode *inode)
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
@@ -2118,6 +2125,8 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+	int (*init_fs_context)(struct fs_context *, struct dentry *);
+	const struct fs_parameter_description *parameters;
 	struct dentry *(*mount) (struct file_system_type *, int,
 				 const char *, void *, size_t);
 	void (*kill_sb) (struct super_block *);
@@ -2174,8 +2183,12 @@ void kill_litter_super(struct super_block *sb);
 void deactivate_super(struct super_block *sb);
 void deactivate_locked_super(struct super_block *sb);
 int set_anon_super(struct super_block *s, void *data);
+int set_anon_super_fc(struct super_block *s, struct fs_context *fc);
 int get_anon_bdev(dev_t *);
 void free_anon_bdev(dev_t);
+struct super_block *sget_fc(struct fs_context *fc,
+			    int (*test)(struct super_block *, struct fs_context *),
+			    int (*set)(struct super_block *, struct fs_context *));
 struct super_block *sget_userns(struct file_system_type *type,
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),
@@ -2218,8 +2231,8 @@ mount_pseudo(struct file_system_type *fs_type, char *name,
 
 extern int register_filesystem(struct file_system_type *);
 extern int unregister_filesystem(struct file_system_type *);
+extern struct vfsmount *kern_mount(struct file_system_type *);
 extern struct vfsmount *kern_mount_data(struct file_system_type *, void *, size_t);
-#define kern_mount(type) kern_mount_data(type, NULL, 0)
 extern void kern_unmount(struct vfsmount *mnt);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 83c40d30868e..0415510f64ed 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -106,6 +106,36 @@ struct fs_context_operations {
 	int (*reconfigure)(struct fs_context *fc);
 };
 
+/*
+ * fs_context manipulation functions.
+ */
+extern struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
+					     struct dentry *reference,
+					     unsigned int sb_flags,
+					     unsigned int sb_flags_mask,
+					     enum fs_context_purpose purpose);
+extern struct fs_context *vfs_dup_fs_context(struct fs_context *src,
+					     enum fs_context_purpose purpose);
+extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
+extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
+			       const char *value, size_t v_size);
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
 #define logfc(FC, FMT, ...) pr_notice(FMT, ## __VA_ARGS__)
 
 /**
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 814643f7ee52..0f6bb8e1bc83 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -25,6 +25,7 @@ struct seq_file;
 struct vm_area_struct;
 struct super_block;
 struct file_system_type;
+struct fs_context;
 
 struct kernfs_open_node;
 struct kernfs_iattrs;
@@ -358,6 +359,7 @@ struct dentry *kernfs_mount_ns(struct file_system_type *fs_type, int flags,
 			       bool *new_sb_created, const void *ns);
 void kernfs_kill_sb(struct super_block *sb);
 struct super_block *kernfs_pin_sb(struct kernfs_root *root, const void *ns);
+int kernfs_reconfigure(struct fs_context *fc);
 
 void kernfs_init(void);
 
diff --git a/include/linux/mount.h b/include/linux/mount.h
index c9edd284f0af..41b6b080ffd0 100644
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

