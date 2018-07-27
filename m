Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CE7C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABCB20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABCB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389837AbeG0S6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:58:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730511AbeG0S6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:58:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC56A8197020;
        Fri, 27 Jul 2018 17:35:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6A001102E29;
        Fri, 27 Jul 2018 17:35:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 38/38] vfs: Allow fsinfo() to be used to query an fs
 parameter description [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:35:36 +0100
Message-ID: <153271293616.9458.15619129237108569309.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:35:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:35:37 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide fsinfo() attributes that can be used to query a filesystem
parameter description.  To do this, fsinfo() can be called on an
fs_context that doesn't yet have a superblock created and attached.

It can be obtained by doing, for example:

	fd = fsopen("ext4", 0);

	struct fsinfo_param_name name;
	struct fsinfo_params params = {
		.request = fsinfo_attr_param_name,
		.Nth	 = 3,
	};
	fsinfo(fd, NULL, &params, &name, sizeof(name));

to query the 4th parameter name in the name to parameter ID mapping table.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/statfs.c                   |   85 +++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h   |   67 ++++++++++++++++++++
 samples/Kconfig               |    1 
 samples/statx/Makefile        |    4 +
 samples/statx/test-fs-query.c |  137 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 291 insertions(+), 3 deletions(-)
 create mode 100644 samples/statx/test-fs-query.c

diff --git a/fs/statfs.c b/fs/statfs.c
index 480ac4be8c2a..d3e6b0d33173 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -10,6 +10,7 @@
 #include <linux/uaccess.h>
 #include <linux/compat.h>
 #include <linux/fsinfo.h>
+#include <linux/fs_parser.h>
 #include "internal.h"
 
 static int flags_by_mnt(int mnt_flags)
@@ -570,12 +571,72 @@ static int fsinfo_generic_io_size(struct dentry *dentry,
 	return sizeof(*c);
 }
 
+static int fsinfo_generic_param_description(struct file_system_type *f,
+					    struct fsinfo_kparams *params)
+{
+	const struct fs_parameter_description *desc = f->parameters;
+	struct fsinfo_param_description *p = params->buffer;
+
+	if (!desc)
+		return -ENODATA;
+
+	p->nr_params = desc->nr_params;
+	p->nr_names = desc->nr_keys;
+	p->nr_enum_names = desc->nr_enums;
+	return sizeof(*p);
+}
+
+static int fsinfo_generic_param_specification(struct file_system_type *f,
+					      struct fsinfo_kparams *params)
+{
+	const struct fs_parameter_description *desc = f->parameters;
+	struct fsinfo_param_specification *p = params->buffer;
+
+	if (!desc || !desc->specs || params->Nth >= desc->nr_params)
+		return -ENODATA;
+
+	p->type = desc->specs[params->Nth].type;
+	p->flags = desc->specs[params->Nth].flags;
+	return sizeof(*p);
+}
+
+static int fsinfo_generic_param_name(struct file_system_type *f,
+				     struct fsinfo_kparams *params)
+{
+	const struct fs_parameter_description *desc = f->parameters;
+	struct fsinfo_param_name *p = params->buffer;
+
+	if (!desc || !desc->keys || params->Nth >= desc->nr_keys)
+		return -ENODATA;
+
+	p->param_index = desc->keys[params->Nth].value;
+	strcpy(p->name, desc->keys[params->Nth].name);
+	return sizeof(*p);
+}
+
+static int fsinfo_generic_param_enum(struct file_system_type *f,
+				     struct fsinfo_kparams *params)
+{
+	const struct fs_parameter_description *desc = f->parameters;
+	struct fsinfo_param_enum *p = params->buffer;
+
+	if (!desc || !desc->enums || params->Nth >= desc->nr_enums)
+		return -ENODATA;
+
+	p->param_index = desc->enums[params->Nth].param_id;
+	strcpy(p->name, desc->enums[params->Nth].name);
+	return sizeof(*p);
+}
+
 /*
  * Implement some queries generically from stuff in the superblock.
  */
 int generic_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
 {
+	struct file_system_type *f = dentry->d_sb->s_type;
+
 #define _gen(X) fsinfo_attr_##X: return fsinfo_generic_##X(dentry, params->buffer)
+#define _genf(X) fsinfo_attr_##X: return fsinfo_generic_##X(f, params)
 
 	switch (params->request) {
 	case _gen(statfs);
@@ -588,6 +649,10 @@ int generic_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
 	case _gen(volume_id);
 	case _gen(name_encoding);
 	case _gen(io_size);
+	case _genf(param_description);
+	case _genf(param_specification);
+	case _genf(param_name);
+	case _genf(param_enum);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -628,7 +693,8 @@ int vfs_fsinfo(const struct path *path, struct fsinfo_kparams *params)
 		return ret;
 
 	if (params->request == fsinfo_attr_ids &&
-	    params->buffer) {
+	    params->buffer &&
+	    path->mnt) {
 		struct fsinfo_ids *p = params->buffer;
 
 		p->f_flags |= flags_by_mnt(path->mnt->mnt_flags);
@@ -672,11 +738,24 @@ static int vfs_fsinfo_path(int dfd, const char __user *filename,
 static int vfs_fsinfo_fscontext(struct fs_context *fc,
 				struct fsinfo_kparams *params)
 {
+	struct file_system_type *f = fc->fs_type;
 	int ret;
 
 	if (fc->ops == &legacy_fs_context_ops)
 		return -EOPNOTSUPP;
 
+	/* Filesystem parameter query is static information and doesn't need a
+	 * lock to read it.
+	 */
+	switch (params->request) {
+	case _genf(param_description);
+	case _genf(param_specification);
+	case _genf(param_name);
+	case _genf(param_enum);
+	default:
+		break;
+	}
+
 	ret = mutex_lock_interruptible(&fc->uapi_mutex);
 	if (ret < 0)
 		return ret;
@@ -750,6 +829,10 @@ static const u16 fsinfo_buffer_sizes[fsinfo_attr__nr] = {
 	FSINFO_STRING		(name_encoding),
 	FSINFO_STRING		(name_codepage),
 	FSINFO_STRUCT		(io_size),
+	FSINFO_STRUCT		(param_description),
+	FSINFO_STRUCT_N		(param_specification),
+	FSINFO_STRUCT_N		(param_name),
+	FSINFO_STRUCT_N		(param_enum),
 };
 
 /**
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index abcf414dd3be..cd10ee90154d 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -35,6 +35,10 @@ enum fsinfo_attribute {
 	fsinfo_attr_name_encoding	= 17,	/* Filename encoding (string) */
 	fsinfo_attr_name_codepage	= 18,	/* Filename codepage (string) */
 	fsinfo_attr_io_size		= 19,	/* Optimal I/O sizes */
+	fsinfo_attr_param_description	= 20,	/* General fs parameter description */
+	fsinfo_attr_param_specification	= 21,	/* Nth parameter specification */
+	fsinfo_attr_param_name		= 22,	/* Nth name to param index */
+	fsinfo_attr_param_enum		= 23,	/* Nth enum-to-val */
 	fsinfo_attr__nr
 };
 
@@ -231,4 +235,67 @@ struct fsinfo_fsinfo {
 	__u32	max_cap;	/* Number of supported capabilities (fsinfo_cap__nr) */
 };
 
+/*
+ * Information struct for fsinfo(fsinfo_attr_param_description).
+ *
+ * Query the parameter set for a filesystem.
+ */
+struct fsinfo_param_description {
+	__u32		nr_params;		/* Number of individual parameters */
+	__u32		nr_names;		/* Number of parameter names */
+	__u32		nr_enum_names;		/* Number of enum names  */
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_param_specification).
+ *
+ * Query the specification of the Nth filesystem parameter.
+ */
+struct fsinfo_param_specification {
+	__u32		type;		/* enum fsinfo_param_specification_type */
+	__u32		flags;		/* Qualifiers */
+};
+
+enum fsinfo_param_specification_type {
+	fsinfo_param_spec_not_defined,
+	fsinfo_param_spec_takes_no_value,
+	fsinfo_param_spec_is_bool,
+	fsinfo_param_spec_is_u32,
+	fsinfo_param_spec_is_u32_octal,
+	fsinfo_param_spec_is_u32_hex,
+	fsinfo_param_spec_is_s32,
+	fsinfo_param_spec_is_enum,
+	fsinfo_param_spec_is_string,
+	fsinfo_param_spec_is_blob,
+	fsinfo_param_spec_is_blockdev,
+	fsinfo_param_spec_is_path,
+	fsinfo_param_spec_is_fd,
+	nr__fsinfo_param_spec
+};
+
+#define fsinfo_param_spec_value_is_optional	0x00000001
+#define fsinfo_param_spec_prefix_no_is_neg	0x00000002
+#define fsinfo_param_spec_empty_string_is_neg	0x00000004
+#define fsinfo_param_spec_deprecated		0x00000008
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_param_name).
+ *
+ * Query the Nth filesystem parameter name
+ */
+struct fsinfo_param_name {
+	__u32		param_index;	/* Index of the parameter specification */
+	char		name[252];	/* Name of the parameter */
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_param_enum).
+ *
+ * Query the Nth filesystem enum parameter value name.
+ */
+struct fsinfo_param_enum {
+	__u32		param_index;	/* Index of the relevant parameter specification */
+	char		name[252];	/* Name of the enum value */
+};
+
 #endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/samples/Kconfig b/samples/Kconfig
index daa17e9f3197..7ed7ce683416 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -148,7 +148,6 @@ config SAMPLE_VFIO_MDEV_MBOCHS
 
 config SAMPLE_STATX
 	bool "Build example extended-stat using code"
-	depends on BROKEN
 	help
 	  Build example userspace program to use the new extended-stat syscall.
 
diff --git a/samples/statx/Makefile b/samples/statx/Makefile
index 9cb9a88e3a10..05b4d30cdd3c 100644
--- a/samples/statx/Makefile
+++ b/samples/statx/Makefile
@@ -1,5 +1,5 @@
 # List of programs to build
-hostprogs-$(CONFIG_SAMPLE_STATX) := test-statx test-fsinfo
+hostprogs-$(CONFIG_SAMPLE_STATX) := test-statx test-fsinfo test-fs-query
 
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
@@ -8,3 +8,5 @@ HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
 
 HOSTCFLAGS_test-fsinfo.o += -I$(objtree)/usr/include
 HOSTLOADLIBES_test-fsinfo += -lm
+
+HOSTCFLAGS_test-fs-query.o += -I$(objtree)/usr/include
diff --git a/samples/statx/test-fs-query.c b/samples/statx/test-fs-query.c
new file mode 100644
index 000000000000..9a92e784fa54
--- /dev/null
+++ b/samples/statx/test-fs-query.c
@@ -0,0 +1,137 @@
+/* Test using the fsinfo() system call to query mount parameters.
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
+#define _GNU_SOURCE
+#define _ATFILE_SOURCE
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+#include <time.h>
+#include <math.h>
+#include <fcntl.h>
+#include <sys/syscall.h>
+#include <linux/fsinfo.h>
+#include <linux/socket.h>
+#include <sys/stat.h>
+
+static int fsopen(const char *fs_name, unsigned int flags)
+{
+	return syscall(__NR_fsopen, fs_name, flags);
+}
+
+static ssize_t fsinfo(int dfd, const char *filename, struct fsinfo_params *params,
+		      void *buffer, size_t buf_size)
+{
+	return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
+}
+
+static const char *param_types[nr__fsinfo_param_spec] = {
+	[fsinfo_param_spec_not_defined]		= "?undef",
+	[fsinfo_param_spec_takes_no_value]	= "no-val",
+	[fsinfo_param_spec_is_bool]		= "bool",
+	[fsinfo_param_spec_is_u32]		= "u32",
+	[fsinfo_param_spec_is_u32_octal]	= "octal",
+	[fsinfo_param_spec_is_u32_hex]		= "hex",
+	[fsinfo_param_spec_is_s32]		= "s32",
+	[fsinfo_param_spec_is_enum]		= "enum",
+	[fsinfo_param_spec_is_string]		= "string",
+	[fsinfo_param_spec_is_blob]		= "binary",
+	[fsinfo_param_spec_is_blockdev]		= "blockdev",
+	[fsinfo_param_spec_is_path]		= "path",
+	[fsinfo_param_spec_is_fd]		= "fd",
+};
+
+/*
+ *
+ */
+int main(int argc, char **argv)
+{
+	struct fsinfo_param_description desc;
+	struct fsinfo_param_specification spec;
+	struct fsinfo_param_name name;
+	struct fsinfo_param_enum enum_name;
+
+	struct fsinfo_params params = {
+		.at_flags = AT_SYMLINK_NOFOLLOW,
+	};
+	int fd;
+
+	if (argc != 2) {
+		printf("Format: test-fs-query <fs_name>\n");
+		exit(2);
+	}
+
+	fd = fsopen(argv[1], 0);
+	if (fd == -1) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	params.request = fsinfo_attr_param_description;
+	if (fsinfo(fd, NULL, &params, &desc, sizeof(desc)) == -1) {
+		perror("fsinfo/desc");
+		exit(1);
+	}
+
+	printf("Filesystem %s has %u parameters\n", argv[1], desc.nr_params);
+
+	params.request = fsinfo_attr_param_specification;
+	for (params.Nth = 0; params.Nth < desc.nr_params; params.Nth++) {
+		if (fsinfo(fd, NULL, &params, &spec, sizeof(spec)) == -1) {
+			if (errno == ENODATA)
+				break;
+			perror("fsinfo/spec");
+			exit(1);
+		}
+		printf("- PARAM[%3u] type=%u(%s)%s%s%s%s\n",
+		       params.Nth,
+		       spec.type,
+		       spec.type < nr__fsinfo_param_spec ? param_types[spec.type] : "?type",
+		       spec.flags & fsinfo_param_spec_value_is_optional ? " -opt" : "",
+		       spec.flags & fsinfo_param_spec_prefix_no_is_neg ? " -neg-no" : "",
+		       spec.flags & fsinfo_param_spec_empty_string_is_neg ? " -neg-empty" : "",
+		       spec.flags & fsinfo_param_spec_deprecated ? " -dep" : "");
+	}
+
+	printf("Filesystem has %u parameter names\n", desc.nr_names);
+
+	params.request = fsinfo_attr_param_name;
+	for (params.Nth = 0; params.Nth < desc.nr_names; params.Nth++) {
+		if (fsinfo(fd, NULL, &params, &name, sizeof(name)) == -1) {
+			if (errno == ENODATA)
+				break;
+			perror("fsinfo/name");
+			exit(1);
+		}
+		printf("- NAME[%3u] %s -> %u\n",
+		       params.Nth, name.name, name.param_index);
+	}
+
+	printf("Filesystem has %u enumeration values\n", desc.nr_enum_names);
+
+	params.request = fsinfo_attr_param_enum;
+	for (params.Nth = 0; params.Nth < desc.nr_enum_names; params.Nth++) {
+		if (fsinfo(fd, NULL, &params, &enum_name, sizeof(enum_name)) == -1) {
+			if (errno == ENODATA)
+				break;
+			perror("fsinfo/enum");
+			exit(1);
+		}
+		printf("- ENUM[%3u] %3u.%s\n",
+		       params.Nth, enum_name.param_index, enum_name.name);
+	}
+	return 0;
+}

