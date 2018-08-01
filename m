Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62745C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E63A208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E63A208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390234AbeHASAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:00:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390206AbeHASAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:00:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D9654021703;
        Wed,  1 Aug 2018 16:14:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 561B7202020C;
        Wed,  1 Aug 2018 16:14:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/5] vfs: Allow fsinfo() to be used to query an fs parameter
 description
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 17:14:20 +0100
Message-ID: <153314006086.18964.11151889178652213916.stgit@warthog.procyon.org.uk>
In-Reply-To: <153314002975.18964.1773855756473041897.stgit@warthog.procyon.org.uk>
References: <153314002975.18964.1773855756473041897.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 01 Aug 2018 16:14:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 01 Aug 2018 16:14:22 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
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
 samples/statx/Makefile        |    4 +
 samples/statx/test-fs-query.c |  137 +++++++++++++++++++++++++++++++++++++++++
 samples/statx/test-fsinfo.c   |    8 ++
 5 files changed, 299 insertions(+), 2 deletions(-)
 create mode 100644 samples/statx/test-fs-query.c

diff --git a/fs/statfs.c b/fs/statfs.c
index 2757fbaa80fb..567bf48c38e6 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -10,6 +10,7 @@
 #include <linux/uaccess.h>
 #include <linux/compat.h>
 #include <linux/fsinfo.h>
+#include <linux/fs_parser.h>
 #include "internal.h"
 
 static int flags_by_mnt(int mnt_flags)
@@ -568,12 +569,72 @@ static int fsinfo_generic_io_size(struct dentry *dentry,
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
 #define _gen(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(dentry, params->buffer)
+#define _genf(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(f, params)
 
 	switch (params->request) {
 	case _gen(STATFS,		statfs);
@@ -586,6 +647,10 @@ int generic_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
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
@@ -626,7 +691,8 @@ int vfs_fsinfo(const struct path *path, struct fsinfo_kparams *params)
 		return ret;
 
 	if (params->request == FSINFO_ATTR_IDS &&
-	    params->buffer) {
+	    params->buffer &&
+	    path->mnt) {
 		struct fsinfo_ids *p = params->buffer;
 
 		p->f_flags |= flags_by_mnt(path->mnt->mnt_flags);
@@ -670,11 +736,24 @@ static int vfs_fsinfo_path(int dfd, const char __user *filename,
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
@@ -749,6 +828,10 @@ static const u16 fsinfo_buffer_sizes[FSINFO_ATTR__NR] = {
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
index ca82cfb5f38a..73dea8e7a68d 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -35,6 +35,10 @@ enum fsinfo_attribute {
 	FSINFO_ATTR_NAME_ENCODING	= 17,	/* Filename encoding (string) */
 	FSINFO_ATTR_NAME_CODEPAGE	= 18,	/* Filename codepage (string) */
 	FSINFO_ATTR_IO_SIZE		= 19,	/* Optimal I/O sizes */
+	FSINFO_ATTR_PARAM_DESCRIPTION	= 20,	/* General fs parameter description */
+	FSINFO_ATTR_PARAM_SPECIFICATION	= 21,	/* Nth parameter specification */
+	FSINFO_ATTR_PARAM_NAME		= 22,	/* Nth name to param index */
+	FSINFO_ATTR_PARAM_ENUM		= 23,	/* Nth enum-to-val */
 	FSINFO_ATTR__NR
 };
 
@@ -232,4 +236,67 @@ struct fsinfo_fsinfo {
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
index 000000000000..25c69d0df084
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
diff --git a/samples/statx/test-fsinfo.c b/samples/statx/test-fsinfo.c
index 5fb3dcccff26..21714ef7ef5b 100644
--- a/samples/statx/test-fsinfo.c
+++ b/samples/statx/test-fsinfo.c
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
@@ -87,6 +91,10 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
 	FSINFO_NAME		(NAME_ENCODING,		name_encoding),
 	FSINFO_NAME		(NAME_CODEPAGE,		name_codepage),
 	FSINFO_NAME		(IO_SIZE,		io_size),
+	FSINFO_NAME		(PARAM_DESCRIPTION,	param_description),
+	FSINFO_NAME		(PARAM_SPECIFICATION,	param_specification),
+	FSINFO_NAME		(PARAM_NAME,		param_name),
+	FSINFO_NAME		(PARAM_ENUM,		param_enum),
 };
 
 union reply {

