Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD05ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E4E21566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E4E21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390871AbeIUW2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:28:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389683AbeIUW2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:28:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DC7830833C4;
        Fri, 21 Sep 2018 16:38:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B856810694C4;
        Fri, 21 Sep 2018 16:38:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/5] vfs: Allow fsinfo() to be used to query an fs parameter
 description [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:38:19 +0100
Message-ID: <153754789899.19213.6434349758145214487.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
References: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 21 Sep 2018 16:38:21 +0000 (UTC)
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

 fs/statfs.c                 |   98 +++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |   68 +++++++++++++++++++++
 samples/vfs/Makefile        |    2 +
 samples/vfs/test-fs-query.c |  137 +++++++++++++++++++++++++++++++++++++++++++
 samples/vfs/test-fsinfo.c   |   17 +++++
 5 files changed, 322 insertions(+)
 create mode 100644 samples/vfs/test-fs-query.c

diff --git a/fs/statfs.c b/fs/statfs.c
index 790e21367d70..0e348b6c8241 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -10,6 +10,7 @@
 #include <linux/uaccess.h>
 #include <linux/compat.h>
 #include <linux/fsinfo.h>
+#include <linux/fs_parser.h>
 #include "internal.h"
 
 static int flags_by_mnt(int mnt_flags)
@@ -576,14 +577,90 @@ static int fsinfo_generic_io_size(struct dentry *dentry,
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
+	p->nr_names = desc->nr_params + desc->nr_alt_keys;
+	p->nr_enum_names = desc->nr_enums;
+	p->source_param = desc->no_source ? UINT_MAX : desc->source_param;
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
+	const char *name;
+	unsigned int n = params->Nth;
+
+	if (!desc || !desc->keys)
+		return -ENODATA;
+
+	if (n < desc->nr_params) {
+		p->param_index = n;
+		name = desc->keys[n];
+		goto out;
+	}
+
+	n -= desc->nr_params;
+	if (n < desc->nr_alt_keys) {
+		p->param_index = desc->alt_keys[n].value;
+		name = desc->alt_keys[n].name;
+		goto out;
+	}
+	return -ENODATA;
+
+out:
+	strcpy(p->name, name);
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
 int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
 {
 	struct dentry *dentry = path->dentry;
+	struct file_system_type *f = dentry->d_sb->s_type;
 	
 #define _gen(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(dentry, params->buffer)
+#define _genf(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(f, params)
 
 	switch (params->request) {
 	case _gen(STATFS,		statfs);
@@ -596,6 +673,10 @@ int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
 	case _gen(VOLUME_ID,		volume_id);
 	case _gen(NAME_ENCODING,	name_encoding);
 	case _gen(IO_SIZE,		io_size);
+	case _genf(PARAM_DESCRIPTION,	param_description);
+	case _genf(PARAM_SPECIFICATION,	param_specification);
+	case _genf(PARAM_NAME,		param_name);
+	case _genf(PARAM_ENUM,		param_enum);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -681,11 +762,24 @@ static int vfs_fsinfo_path(int dfd, const char __user *filename,
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
+	case _genf(PARAM_DESCRIPTION,	param_description);
+	case _genf(PARAM_SPECIFICATION,	param_specification);
+	case _genf(PARAM_NAME,		param_name);
+	case _genf(PARAM_ENUM,		param_enum);
+	default:
+		break;
+	}
+
 	ret = mutex_lock_interruptible(&fc->uapi_mutex);
 	if (ret < 0)
 		return ret;
@@ -759,6 +853,10 @@ static const u16 fsinfo_buffer_sizes[FSINFO_ATTR__NR] = {
 	FSINFO_STRING		(NAME_ENCODING,		name_encoding),
 	FSINFO_STRING		(NAME_CODEPAGE,		name_codepage),
 	FSINFO_STRUCT		(IO_SIZE,		io_size),
+	FSINFO_STRUCT		(PARAM_DESCRIPTION,	param_description),
+	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
+	FSINFO_STRUCT_N		(PARAM_NAME,		param_name),
+	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
 };
 
 /**
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index ab7f1e6ab60b..ec2ff86f49ce 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -34,6 +34,10 @@ enum fsinfo_attribute {
 	FSINFO_ATTR_NAME_ENCODING	= 16,	/* Filename encoding (string) */
 	FSINFO_ATTR_NAME_CODEPAGE	= 17,	/* Filename codepage (string) */
 	FSINFO_ATTR_IO_SIZE		= 18,	/* Optimal I/O sizes */
+	FSINFO_ATTR_PARAM_DESCRIPTION	= 19,	/* General fs parameter description */
+	FSINFO_ATTR_PARAM_SPECIFICATION	= 20,	/* Nth parameter specification */
+	FSINFO_ATTR_PARAM_NAME		= 21,	/* Nth name to param index */
+	FSINFO_ATTR_PARAM_ENUM		= 22,	/* Nth enum-to-val */
 	FSINFO_ATTR__NR
 };
 
@@ -231,4 +235,68 @@ struct fsinfo_fsinfo {
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
+	__u32		source_param;		/* Source parameter index (or UINT_MAX) */
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
+	FSINFO_PARAM_SPEC_NOT_DEFINED,
+	FSINFO_PARAM_SPEC_TAKES_NO_VALUE,
+	FSINFO_PARAM_SPEC_IS_BOOL,
+	FSINFO_PARAM_SPEC_IS_U32,
+	FSINFO_PARAM_SPEC_IS_U32_OCTAL,
+	FSINFO_PARAM_SPEC_IS_U32_HEX,
+	FSINFO_PARAM_SPEC_IS_S32,
+	FSINFO_PARAM_SPEC_IS_ENUM,
+	FSINFO_PARAM_SPEC_IS_STRING,
+	FSINFO_PARAM_SPEC_IS_BLOB,
+	FSINFO_PARAM_SPEC_IS_BLOCKDEV,
+	FSINFO_PARAM_SPEC_IS_PATH,
+	FSINFO_PARAM_SPEC_IS_FD,
+	NR__FSINFO_PARAM_SPEC
+};
+
+#define FSINFO_PARAM_SPEC_VALUE_IS_OPTIONAL	0X00000001
+#define FSINFO_PARAM_SPEC_PREFIX_NO_IS_NEG	0X00000002
+#define FSINFO_PARAM_SPEC_EMPTY_STRING_IS_NEG	0X00000004
+#define FSINFO_PARAM_SPEC_DEPRECATED		0X00000008
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
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index d2e1ac8d66ea..8552a347ccc2 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,6 +1,7 @@
 # List of programs to build
 hostprogs-$(CONFIG_SAMPLE_VFS) := \
 	test-fsinfo \
+	test-fs-query \
 	test-fsmount \
 	test-statx
 
@@ -10,5 +11,6 @@ always := $(hostprogs-y)
 HOSTCFLAGS_test-fsinfo.o += -I$(objtree)/usr/include
 HOSTLDLIBS_test-fsinfo += -lm
 
+HOSTCFLAGS_test-fs-query.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
diff --git a/samples/vfs/test-fs-query.c b/samples/vfs/test-fs-query.c
new file mode 100644
index 000000000000..25c69d0df084
--- /dev/null
+++ b/samples/vfs/test-fs-query.c
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
+static const char *param_types[NR__FSINFO_PARAM_SPEC] = {
+	[FSINFO_PARAM_SPEC_NOT_DEFINED]		= "?undef",
+	[FSINFO_PARAM_SPEC_TAKES_NO_VALUE]	= "no-val",
+	[FSINFO_PARAM_SPEC_IS_BOOL]		= "bool",
+	[FSINFO_PARAM_SPEC_IS_U32]		= "u32",
+	[FSINFO_PARAM_SPEC_IS_U32_OCTAL]	= "octal",
+	[FSINFO_PARAM_SPEC_IS_U32_HEX]		= "hex",
+	[FSINFO_PARAM_SPEC_IS_S32]		= "s32",
+	[FSINFO_PARAM_SPEC_IS_ENUM]		= "enum",
+	[FSINFO_PARAM_SPEC_IS_STRING]		= "string",
+	[FSINFO_PARAM_SPEC_IS_BLOB]		= "binary",
+	[FSINFO_PARAM_SPEC_IS_BLOCKDEV]		= "blockdev",
+	[FSINFO_PARAM_SPEC_IS_PATH]		= "path",
+	[FSINFO_PARAM_SPEC_IS_FD]		= "fd",
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
+	params.request = FSINFO_ATTR_PARAM_DESCRIPTION;
+	if (fsinfo(fd, NULL, &params, &desc, sizeof(desc)) == -1) {
+		perror("fsinfo/desc");
+		exit(1);
+	}
+
+	printf("Filesystem %s has %u parameters\n", argv[1], desc.nr_params);
+
+	params.request = FSINFO_ATTR_PARAM_SPECIFICATION;
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
+		       spec.type < NR__FSINFO_PARAM_SPEC ? param_types[spec.type] : "?type",
+		       spec.flags & FSINFO_PARAM_SPEC_VALUE_IS_OPTIONAL ? " -opt" : "",
+		       spec.flags & FSINFO_PARAM_SPEC_PREFIX_NO_IS_NEG ? " -neg-no" : "",
+		       spec.flags & FSINFO_PARAM_SPEC_EMPTY_STRING_IS_NEG ? " -neg-empty" : "",
+		       spec.flags & FSINFO_PARAM_SPEC_DEPRECATED ? " -dep" : "");
+	}
+
+	printf("Filesystem has %u parameter names\n", desc.nr_names);
+
+	params.request = FSINFO_ATTR_PARAM_NAME;
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
+	params.request = FSINFO_ATTR_PARAM_ENUM;
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
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index dbb231c30153..75f5c2a61445 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -63,6 +63,10 @@ static const __u16 fsinfo_buffer_sizes[FSINFO_ATTR__NR] = {
 	FSINFO_STRING		(NAME_ENCODING,		name_encoding),
 	FSINFO_STRING		(NAME_CODEPAGE,		name_codepage),
 	FSINFO_STRUCT		(IO_SIZE,		io_size),
+	FSINFO_STRUCT		(PARAM_DESCRIPTION,	param_description),
+	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
+	FSINFO_STRUCT_N		(PARAM_NAME,		param_name),
+	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
 };
 
 #define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
@@ -86,6 +90,10 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
 	FSINFO_NAME		(NAME_ENCODING,		name_encoding),
 	FSINFO_NAME		(NAME_CODEPAGE,		name_codepage),
 	FSINFO_NAME		(IO_SIZE,		io_size),
+	FSINFO_NAME		(PARAM_DESCRIPTION,	param_description),
+	FSINFO_NAME		(PARAM_SPECIFICATION,	param_specification),
+	FSINFO_NAME		(PARAM_NAME,		param_name),
+	FSINFO_NAME		(PARAM_ENUM,		param_enum),
 };
 
 union reply {
@@ -535,6 +543,15 @@ int main(int argc, char **argv)
 	}
 
 	for (attr = 0; attr <= FSINFO_ATTR__NR; attr++) {
+		switch (attr) {
+		case FSINFO_ATTR_PARAM_DESCRIPTION:
+		case FSINFO_ATTR_PARAM_SPECIFICATION:
+		case FSINFO_ATTR_PARAM_NAME:
+		case FSINFO_ATTR_PARAM_ENUM:
+			/* See test-fs-query.c instead */
+			continue;
+		}
+
 		Nth = 0;
 		do {
 			Mth = 0;

