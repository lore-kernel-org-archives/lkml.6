Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4065AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D353B208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D353B208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389444AbeG0SzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388886AbeG0SzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D08681663CF;
        Fri, 27 Jul 2018 17:32:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 936F92026D6B;
        Fri, 27 Jul 2018 17:32:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/38] vfs: Add configuration parser helpers [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:32:10 +0100
Message-ID: <153271273011.9458.7124664436451830998.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:32:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:32:11 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the new API passes in key,value parameters, match_token() cannot be
used with it.  Instead, provide three new helpers to aid with parsing:

 (1) fs_parse().  This takes a parameter and a simple static description of
     all the parameters and maps the key name to an ID.  It returns 1 on a
     match, 0 on no match if unknowns should be ignored and some other
     negative error code on a parse error.

     The parameter description includes a list of key names to IDs, desired
     parameter types and a list of enumeration name -> ID mappings.

     [!] Note that for the moment I've required that the key->ID mapping
     array is expected to be sorted and unterminated.  The size of the
     array is noted in the fsconfig_parser struct.  This allows me to use
     bsearch(), but I'm not sure any performance gain is worth the hassle
     of requiring people to keep the array sorted.

     The parameter type array is sized according to the number of parameter
     IDs and is indexed directly.  The optional enum mapping array is an
     unterminated, unsorted list and the size goes into the fsconfig_parser
     struct.

     The function can do some additional things:

	(a) If it's not ambiguous and no value is given, the prefix "no" on
	    a key name is permitted to indicate that the parameter should
	    be considered negatory.

	(b) If the desired type is a single simple integer, it will perform
	    an appropriate conversion and store the result in a union in
	    the parse result.

	(c) If the desired type is an enumeration, {key ID, name} will be
	    looked up in the enumeration list and the matching value will
	    be stored in the parse result union.

	(d) Optionally generate an error if the key is unrecognised.

     This is called something like:

	enum rdt_param {
		Opt_cdp,
		Opt_cdpl2,
		Opt_mba_mpbs,
		nr__rdt_params
	};

	const struct fs_parameter_spec rdt_param_specs[nr__rdt_params] = {
		[Opt_cdp]	= { fs_param_is_bool },
		[Opt_cdpl2]	= { fs_param_is_bool },
		[Opt_mba_mpbs]	= { fs_param_is_bool },
	};

	const struct constant_table rdt_param_keys[] = {
		{ "cdp",	Opt_cdp },
		{ "cdpl2",	Opt_cdpl2 },
		{ "mba_mbps",	Opt_mba_mpbs },
	};

	const struct fs_parameter_description rdt_parser = {
		.name		= "rdt",
		.nr_params	= nr__rdt_params,
		.nr_keys	= ARRAY_SIZE(rdt_param_keys),
		.keys		= rdt_param_keys,
		.specs		= rdt_param_specs,
		.no_source	= true,
	};

	int rdt_parse_param(struct fs_context *fc,
			    struct fs_parameter *param)
	{
		struct fs_parse_result parse;
		struct rdt_fs_context *ctx = rdt_fc2context(fc);
		int ret;

		ret = fs_parse(fc, &rdt_parser, param, &parse);
		if (ret < 0)
			return ret;

		switch (parse.key) {
		case Opt_cdp:
			ctx->enable_cdpl3 = true;
			return 0;
		case Opt_cdpl2:
			ctx->enable_cdpl2 = true;
			return 0;
		case Opt_mba_mpbs:
			ctx->enable_mba_mbps = true;
			return 0;
		}

		return -EINVAL;
	}

 (2) fs_lookup_param().  This takes a { dirfd, path, LOOKUP_EMPTY? } or
     string value and performs an appropriate path lookup to convert it
     into a path object, which it will then return.

     If the desired type was a blockdev, the type of the looked up inode
     will be checked to make sure it is one.

     This can be used like:

	enum foo_param {
		Opt_source,
		nr__foo_params
	};

	const struct fs_parameter_spec foo_param_specs[nr__foo_params] = {
		[Opt_source]	= { fs_param_is_blockdev },
	};

	const struct constant_table foo_param_keys[] = {
		{ "source",	Opt_source },
	};

	const struct fs_parameter_description foo_parser = {
		.name		= "foo",
		.nr_params	= nr__foo_params,
		.nr_keys	= ARRAY_SIZE(foo_param_keys),
		.keys		= foo_param_keys,
		.specs		= foo_param_specs,
	};

	int foo_parse_param(struct fs_context *fc,
			    struct fs_parameter *param)
	{
		struct fs_parse_result parse;
		struct foo_fs_context *ctx = foo_fc2context(fc);
		int ret;

		ret = fs_parse(fc, &foo_parser, param, &parse);
		if (ret < 0)
			return ret;

		switch (parse.key) {
		case Opt_source:
			return fs_lookup_param(fc, &foo_parser, param,
					       &parse, &ctx->source);
		default:
			return -EINVAL;
		}
	}

 (3) lookup_constant().  This takes a table of named constants and looks up
     the given name within it.  The table is expected to be sorted such
     that bsearch() be used upon it.

     Possibly I should require the table be terminated and just use a
     for-loop to scan it instead of using bsearch() to reduce hassle.

     Tables look something like:

	static const struct constant_table bool_names[] = {
		{ "0",		false },
		{ "1",		true },
		{ "false",	false },
		{ "no",		false },
		{ "true",	true },
		{ "yes",	true },
	};

     and a lookup is done with something like:

	b = lookup_constant(bool_names, param->string, -1);

Additionally, optional validation routines for the parameter description
are provided that can be enabled at compile time.  A later patch will
invoke these when a filesystem is registered.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/Kconfig                |    7 +
 fs/Makefile               |    3 
 fs/fs_parser.c            |  476 +++++++++++++++++++++++++++++++++++++++++++++
 fs/internal.h             |    2 
 fs/namei.c                |    4 
 include/linux/fs_parser.h |  116 +++++++++++
 6 files changed, 605 insertions(+), 3 deletions(-)
 create mode 100644 fs/fs_parser.c
 create mode 100644 include/linux/fs_parser.h

diff --git a/fs/Kconfig b/fs/Kconfig
index ac474a61be37..25700b152c75 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -8,6 +8,13 @@ menu "File systems"
 config DCACHE_WORD_ACCESS
        bool
 
+config VALIDATE_FS_PARSER
+	bool "Validate filesystem parameter description"
+	default y
+	help
+	  Enable this to perform validation of the parameter description for a
+	  filesystem when it is registered.
+
 if BLOCK
 
 config FS_IOMAP
diff --git a/fs/Makefile b/fs/Makefile
index 293733f61594..07b894227dce 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -12,7 +12,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
-		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o
+		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
+		fs_parser.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
new file mode 100644
index 000000000000..12401b38cd51
--- /dev/null
+++ b/fs/fs_parser.c
@@ -0,0 +1,476 @@
+/* Filesystem parameter parser.
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
+#include <linux/export.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+#include <linux/slab.h>
+#include <linux/security.h>
+#include <linux/namei.h>
+#include <linux/bsearch.h>
+#include "internal.h"
+
+static const struct constant_table bool_names[] = {
+	{ "0",		false },
+	{ "1",		true },
+	{ "false",	false },
+	{ "no",		false },
+	{ "true",	true },
+	{ "yes",	true },
+};
+
+static int cmp_constant(const void *name, const void *entry)
+{
+	const struct constant_table *e = entry;
+	return strcmp(name, e->name);
+}
+
+/**
+ * lookup_constant - Look up a constant by name in an ordered table
+ * @tbl: The table of constants to search.
+ * @tbl_size: The size of the table.
+ * @name: The name to look up.
+ * @not_found: The value to return if the name is not found.
+ */
+int __lookup_constant(const struct constant_table *tbl, size_t tbl_size,
+		      const char *name, int not_found)
+{
+	const struct constant_table *e;
+
+	e = bsearch(name, tbl, tbl_size, sizeof(tbl[0]), cmp_constant);
+	if (!e)
+		return not_found;
+	return e->value;
+}
+EXPORT_SYMBOL(__lookup_constant);
+
+/*
+ * fs_parse - Parse a filesystem configuration parameter
+ * @fc: The filesystem context to log errors through.
+ * @desc: The parameter description to use.
+ * @param: The parameter.
+ * @result: Where to place the result of the parse
+ *
+ * Parse a filesystem configuration parameter and attempt a conversion for a
+ * simple parameter for which this is requested.  If successful, the determined
+ * parameter ID is placed into @result->key, the desired type is indicated in
+ * @result->t and any converted value is placed into an appropriate member of
+ * the union in @result.
+ *
+ * The function returns 1 if the parameter was matched, 0 if it wasn't matched
+ * and @desc->ignore_unknown indicated that unknown parameters are okay and
+ * -EINVAL if there was a conversion issue or the parameter wasn't recognised
+ * and unknowns aren't okay.
+ */
+int fs_parse(struct fs_context *fc,
+	     const struct fs_parameter_description *desc,
+	     struct fs_parameter *param,
+	     struct fs_parse_result *result)
+{
+	int ret, k, i, b;
+
+	k = __lookup_constant(desc->keys, desc->nr_keys, param->key,
+			      -EAGAIN);
+	if (k == -EAGAIN) {
+		/* If we didn't find something that looks like "noxxx", see if
+		 * "xxx" takes the "no"-form negative - but only if there
+		 * wasn't an value.
+		 */
+		if (param->string || param->size > 0)
+			goto unknown_parameter;
+		if (param->key[0] != 'n' || param->key[1] != 'o' || !param->key[2])
+			goto unknown_parameter;
+
+		k = __lookup_constant(desc->keys, desc->nr_keys,
+				      param->key + 2, -EAGAIN);
+		if (k == -EAGAIN)
+			goto unknown_parameter;
+		if (!(desc->specs[k].flags & fs_param_neg_with_no))
+			goto unknown_parameter;
+		result->key = k;
+		result->uint_32 = 0;
+		result->negated = true;
+		goto okay;
+	}
+
+	result->key = k;
+	result->negated = false;
+	if (result->key == fsconfig_key_removed)
+		return invalf(fc, "%s: Unsupported parameter name '%s'",
+			      desc->name, param->key);
+
+	result->t = desc->specs[result->key];
+	if (result->t.flags & fs_param_deprecated)
+		warnf(fc, "%s: Deprecated parameter '%s'",
+		      desc->name, param->key);
+
+	/* Certain parameter types only take a string and convert it. */
+	switch (result->t.type) {
+	case __fs_param_wasnt_defined:
+		return -EINVAL;
+	case fs_param_is_u32:
+	case fs_param_is_u32_octal:
+	case fs_param_is_u32_hex:
+	case fs_param_is_s32:
+	case fs_param_is_enum:
+	case fs_param_is_string:
+		if (param->type != fs_value_is_string)
+			goto bad_value;
+		/* Fall through */
+	default:
+		break;
+	}
+
+	/* Try to turn the type we were given into the type desired by the
+	 * parameter and give an error if we can't.
+	 */
+	switch (result->t.type) {
+	case fs_param_takes_no_value:
+		if (param->type != fs_value_is_flag &&
+		    (param->type != fs_value_is_string || param->size > 0))
+			return invalf(fc, "%s: Unexpected value for '%s'",
+				      desc->name, param->key);
+		result->boolean = true;
+		goto okay;
+
+	case fs_param_is_bool:
+		switch (param->type) {
+		case fs_value_is_flag:
+			result->boolean = true;
+			goto okay;
+		case fs_value_is_string:
+			if (param->size == 0) {
+				result->boolean = true;
+				goto okay;
+			}
+			b = lookup_constant(bool_names, param->string, -1);
+			if (b == -1)
+				goto bad_value;
+			result->boolean = b;
+			goto okay;
+		default:
+			goto bad_value;
+		}
+
+	case fs_param_is_u32:
+		ret = kstrtouint(param->string, 0, &result->uint_32);
+		goto maybe_okay;
+	case fs_param_is_u32_octal:
+		ret = kstrtouint(param->string, 8, &result->uint_32);
+		goto maybe_okay;
+	case fs_param_is_u32_hex:
+		ret = kstrtouint(param->string, 16, &result->uint_32);
+		goto maybe_okay;
+	case fs_param_is_s32:
+		ret = kstrtoint(param->string, 0, &result->int_32);
+		goto maybe_okay;
+
+	case fs_param_is_enum:
+		for (i = 0; i < desc->nr_enums; i++) {
+			if (desc->enums[i].param_id == result->key &&
+			    strcmp(desc->enums[i].name, param->string) == 0) {
+				result->uint_32 = desc->enums[i].value;
+				goto okay;
+			}
+		}
+		goto bad_value;
+
+	case fs_param_is_string:
+		goto okay;
+	case fs_param_is_blob:
+		if (param->type != fs_value_is_blob)
+			goto bad_value;
+		goto okay;
+
+	case fs_param_is_fd: {
+		if (param->type != fs_value_is_file)
+			goto bad_value;
+		goto okay;
+	}
+
+	case fs_param_is_blockdev:
+	case fs_param_is_path:
+		goto okay;
+	default:
+		BUG();
+	}
+
+maybe_okay:
+	if (ret < 0)
+		goto bad_value;
+okay:
+	return 1;
+
+bad_value:
+	return invalf(fc, "%s: Bad value for '%s'", desc->name, param->key);
+unknown_parameter:
+	if (desc->ignore_unknown)
+		return 0;
+	if (desc->no_source && strcmp(param->key, "source") == 0)
+		return 0; /* The source parameter is special */
+	return invalf(fc, "%s: Unknown parameter '%s'", desc->name, param->key);
+}
+EXPORT_SYMBOL(fs_parse);
+
+/**
+ * fs_lookup_param - Look up a path referred to by a parameter
+ * @fc: The filesystem context to log errors through.
+ * @desc: The parameter description that was used
+ * @key: The name of the parameter.
+ * @value: The supplied value for the parameter
+ * @result: The result of the parse from a previous call to fs_parse()
+ * @_path: The result of the lookup
+ */
+int fs_lookup_param(struct fs_context *fc,
+		    const struct fs_parameter_description *desc,
+		    struct fs_parameter *param,
+		    struct fs_parse_result *result,
+		    struct path *_path)
+{
+	struct filename *f;
+	unsigned int flags = 0;
+	bool put_f;
+	int ret;
+
+	switch (param->type) {
+	case fs_value_is_string:
+		f = getname_kernel(param->string);
+		if (IS_ERR(f))
+			return PTR_ERR(f);
+		put_f = true;
+		break;
+	case fs_value_is_filename_empty:
+		flags = LOOKUP_EMPTY;
+		/* Fall through */
+	case fs_value_is_filename:
+		f = param->name;
+		put_f = false;
+		break;
+	default:
+		return invalf(fc, "%s: '%s' not usable as path",
+			      desc->name, param->key);
+	}
+
+	ret = filename_lookup(param->dirfd, f, flags, _path, NULL);
+	if (put_f)
+		putname(f);
+	if (ret < 0) {
+		errorf(fc, "%s: Lookup failure for '%s'",
+		       desc->name, param->key);
+		return ret;
+	}
+
+	if (result->t.type == fs_param_is_blockdev &&
+	    !S_ISBLK(d_real_inode(_path->dentry)->i_mode)) {
+		path_put(_path);
+		_path->dentry = NULL;
+		_path->mnt = NULL;
+		errorf(fc, "%s: Non-blockdev passed to '%s'",
+		       desc->name, param->key);
+		return -ENOTBLK;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(fs_lookup_param);
+
+#ifdef CONFIG_VALIDATE_FS_PARSER
+/**
+ * validate_constant_table - Validate a constant table
+ * @tbl: The constant table to validate.
+ * @tbl_size: The size of the table.
+ * @low: The lowest permissible value.
+ * @high: The highest permissible value.
+ * @special: One special permissible value outside of the range.
+ */
+bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
+			     int low, int high, int special)
+{
+	size_t i;
+	bool good = true;
+
+	if (tbl_size == 0) {
+		pr_warn("VALIDATE C-TBL: Empty\n");
+		return true;
+	}
+
+	for (i = 0; i < tbl_size; i++) {
+		if (!tbl[i].name) {
+			pr_err("VALIDATE C-TBL[%zu]: Null\n", i);
+			good = false;
+		} else if (i > 0 && tbl[i - 1].name) {
+			int c = strcmp(tbl[i-1].name, tbl[i].name);
+
+			if (c == 0) {
+				pr_err("VALIDATE C-TBL[%zu]: Duplicate %s\n",
+				       i, tbl[i].name);
+				good = false;
+			}
+			if (c > 0) {
+				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>=%s\n",
+				       i, tbl[i-1].name, tbl[i].name);
+				good = false;
+			}
+		}
+
+		if (tbl[i].value != special &&
+		    (tbl[i].value < low || tbl[i].value > high)) {
+			pr_err("VALIDATE C-TBL[%zu]: %s->%d const out of range (%d-%d)\n",
+			       i, tbl[i].name, tbl[i].value, low, high);
+			good = false;
+		}
+	}
+
+	if (!good)
+		dump_stack();
+	return good;
+}
+
+/**
+ * fs_validate_description - Validate a parameter description
+ * @desc: The parameter description to validate.
+ */
+bool fs_validate_description(const struct fs_parameter_description *desc)
+{
+	const char *name = desc->name;
+	bool good = true, dump = true, enums = false;
+	int i, j;
+
+	if (!name[0]) {
+		pr_err("Parser: No name\n");
+		name = "Unknown";
+		good = false;
+	}
+
+	if (desc->nr_params) {
+		if (!desc->specs) {
+			pr_err("%s: Parser: Missing types table\n", name);
+			good = false;
+			goto no_specs;
+		}
+
+		for (i = 0; i < desc->nr_params; i++) {
+			enum fs_parameter_type t = desc->specs[i].type;
+			if (t == __fs_param_wasnt_defined) {
+				pr_err("%s: Parser: [%u] Undefined type\n",
+				       name, i);
+				good = false;
+			} else if (t >= nr__fs_parameter_type) {
+				pr_err("%s: Parser: [%u] Bad type %u\n",
+				       name, i, t);
+				good = false;
+			} else if (t == fs_param_is_enum) {
+				enums = true;
+			}
+		}
+	}
+
+no_specs:
+	if (desc->nr_keys) {
+		if (!desc->nr_params) {
+			pr_err("%s: Parser: %u keys but 0 params\n",
+			       name, desc->nr_keys);
+			good = false;
+			goto no_keys;
+		}
+		if (!desc->keys) {
+			pr_err("%s: Parser: Missing keys table\n", name);
+			good = false;
+			goto no_keys;
+		}
+
+		if (!validate_constant_table(desc->keys, desc->nr_keys,
+					     0, desc->nr_params - 1,
+					     fsconfig_key_removed)) {
+			pr_err("%s: Parser: Bad keys table\n", name);
+			good = false;
+			dump = false;
+		}
+
+		/* The "source" key is used to convey the device/source
+		 * information.
+		 */
+		if (__lookup_constant(desc->keys, desc->nr_keys,
+				      "source", -1234) == -1234) {
+			if (!desc->no_source) {
+				pr_err("%s: Parser: Source key, but marked no_source\n",
+				       name);
+				good = false;
+			}
+		} else {
+			if (desc->no_source) {
+				pr_err("%s: Parser: Marked no_source, but no source key\n",
+				       name);
+				good = false;
+			}
+		}
+	}
+
+no_keys:
+	if (desc->nr_enums) {
+		if (!enums) {
+			pr_err("%s: Parser: Enum table but no enum-type values\n",
+			       name);
+			good = false;
+			goto no_enums;
+		}
+		if (!desc->enums) {
+			pr_err("%s: Parser: Missing enums table\n", name);
+			good = false;
+			goto no_enums;
+		}
+
+		for (j = 0; j < desc->nr_enums; j++) {
+			const struct fs_parameter_enum *e = &desc->enums[j];
+
+			if (!e->name[0]) {
+				pr_err("%s: Parser: e[%u] no name\n", name, j);
+				good = false;
+			}
+			if (e->param_id >= desc->nr_params) {
+				pr_err("%s: Parser: e[%u] bad param %u\n",
+				       name, j, e->param_id);
+				good = false;
+			}
+			if (desc->specs[e->param_id].type != fs_param_is_enum) {
+				pr_err("%s: Parser: e[%u] enum val for non-enum type %u\n",
+				       name, j, e->param_id);
+				good = false;
+			}
+		}
+
+		for (i = 0; i < desc->nr_params; i++) {
+			if (desc->specs[i].type != fs_param_is_enum)
+				continue;
+			for (j = 0; j < desc->nr_enums; j++)
+				if (desc->enums[j].param_id == i)
+					break;
+			if (j == desc->nr_enums) {
+				pr_err("%s: Parser: t[%u] enum with no vals\n",
+				       name, i);
+				good = false;
+			}
+		}
+	} else {
+		if (enums) {
+			pr_err("%s: Parser: enum-type values, but no enum table\n",
+			       name);
+			good = false;
+			goto no_enums;
+		}
+	}
+
+no_enums:
+	if (!good && dump)
+		dump_stack();
+	return good;
+}
+#endif /* CONFIG_VALIDATE_FS_PARSER */
diff --git a/fs/internal.h b/fs/internal.h
index 383ee4724f77..f11b834ff1e6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -52,6 +52,8 @@ extern void __init chrdev_init(void);
 /*
  * namei.c
  */
+extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
+			   struct path *path, struct path *root);
 extern int user_path_mountpoint_at(int, const char __user *, unsigned int, struct path *);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
diff --git a/fs/namei.c b/fs/namei.c
index 734cef54fdf8..097f6ec1ae0e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2306,8 +2306,8 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 	return err;
 }
 
-static int filename_lookup(int dfd, struct filename *name, unsigned flags,
-			   struct path *path, struct path *root)
+int filename_lookup(int dfd, struct filename *name, unsigned flags,
+		    struct path *path, struct path *root)
 {
 	int retval;
 	struct nameidata nd;
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
new file mode 100644
index 000000000000..a5ba9b1d87c6
--- /dev/null
+++ b/include/linux/fs_parser.h
@@ -0,0 +1,116 @@
+/* Filesystem parameter description and parser
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
+#ifndef _LINUX_FS_PARSER_H
+#define _LINUX_FS_PARSER_H
+
+#include <linux/fs_context.h>
+
+struct path;
+
+struct constant_table {
+	const char	*name;
+	int		value;
+};
+
+#define fsconfig_key_removed	-5678	/* Parameter name is no longer valid */
+
+/*
+ * The type of parameter expected.
+ */
+enum fs_parameter_type {
+	__fs_param_wasnt_defined,
+	fs_param_takes_no_value,
+	fs_param_is_bool,
+	fs_param_is_u32,
+	fs_param_is_u32_octal,
+	fs_param_is_u32_hex,
+	fs_param_is_s32,
+	fs_param_is_enum,
+	fs_param_is_string,
+	fs_param_is_blob,
+	fs_param_is_blockdev,
+	fs_param_is_path,
+	fs_param_is_fd,
+	nr__fs_parameter_type,
+};
+
+/*
+ * Specification of the type of value a parameter wants.
+ */
+struct fs_parameter_spec {
+	enum fs_parameter_type	type:8;	/* The desired parameter type */
+	u8			flags;
+#define fs_param_v_optional	0x01	/* The value is optional */
+#define fs_param_neg_with_no	0x02	/* "noxxx" is negative param */
+#define fs_param_neg_with_empty	0x04	/* "xxx=" is negative param */
+#define fs_param_deprecated	0x08	/* The param is deprecated */
+};
+
+struct fs_parameter_enum {
+	u8		param_id;
+	char		name[14];
+	u8		value;
+};
+
+struct fs_parameter_description {
+	const char	name[16];	/* Name for logging purposes */
+	u8		nr_params;	/* Number of parameter IDs */
+	u8		nr_keys;	/* Number of key names */
+	u8		nr_enums;	/* Number of enum value names */
+	bool		ignore_unknown;	/* Set to ignore unknown parameters */
+	bool		no_source;	/* Set if no source is expected */
+	const struct constant_table *keys; /* List of key names */
+	const struct fs_parameter_spec *specs; /* List of param specifications */
+	const struct fs_parameter_enum *enums; /* Enum values */
+};
+
+/*
+ * Result of parse.
+ */
+struct fs_parse_result {
+	struct fs_parameter_spec t;
+	u8			key;		/* Looked up key ID */
+	bool			negated;	/* T if param was "noxxx" */
+	union {
+		bool		boolean;	/* For spec_bool */
+		int		int_32;		/* For spec_s32/spec_enum */
+		unsigned int	uint_32;	/* For spec_u32{,_octal,_hex}/spec_enum */
+	};
+};
+
+extern int fs_parse(struct fs_context *fc,
+		    const struct fs_parameter_description *desc,
+		    struct fs_parameter *value,
+		    struct fs_parse_result *result);
+extern int fs_lookup_param(struct fs_context *fc,
+			   const struct fs_parameter_description *desc,
+			   struct fs_parameter *param,
+			   struct fs_parse_result *result,
+			   struct path *_path);
+
+extern int __lookup_constant(const struct constant_table tbl[], size_t tbl_size,
+			     const char *name, int not_found);
+#define lookup_constant(t, n, nf) __lookup_constant(t, ARRAY_SIZE(t), (n), (nf))
+
+#ifdef CONFIG_VALIDATE_FS_PARSER
+extern bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
+				    int low, int high, int special);
+extern bool fs_validate_description(const struct fs_parameter_description *desc);
+#else
+static inline bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
+					   int low, int high, int special)
+{ return true; }
+static inline bool fs_validate_description(const struct fs_parameter_description *desc)
+{ return true; }
+#endif
+
+#endif /* _LINUX_FS_PARSER_H */

