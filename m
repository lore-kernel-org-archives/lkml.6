Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E0EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874BC2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874BC2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbeHWMKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:10:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56401 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHWMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:10:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8flCm3188858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:41:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8fllH3188851;
        Thu, 23 Aug 2018 01:41:47 -0700
Date:   Thu, 23 Aug 2018 01:41:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4b838b0db4e9cb3892b181ea9adc13cefb90d210@git.kernel.org>
Cc:     mingo@kernel.org, namhyung@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        jolsa@kernel.org, mpetlan@redhat.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, peterz@infradead.org, tglx@linutronix.de
Reply-To: peterz@infradead.org, tglx@linutronix.de, mpetlan@redhat.com,
          linux-kernel@vger.kernel.org, dsahern@gmail.com,
          jolsa@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          namhyung@kernel.org, mingo@kernel.org
In-Reply-To: <20180817094813.15086-7-jolsa@kernel.org>
References: <20180817094813.15086-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Add compression id into 'struct
 kmod_path'
Git-Commit-ID: 4b838b0db4e9cb3892b181ea9adc13cefb90d210
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4b838b0db4e9cb3892b181ea9adc13cefb90d210
Gitweb:     https://git.kernel.org/tip/4b838b0db4e9cb3892b181ea9adc13cefb90d210
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:06 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Add compression id into 'struct kmod_path'

Store a decompression ID in 'struct kmod_path', so it can be later
stored in 'struct dso'.

Switch 'struct kmod_path's 'comp' from 'bool' to 'int' to return the
compressions array index. Add 0 index item into compressions array, so
that the comp usage stays as it was: 0 - no compression, != 0
compression index.

Update the kmod_path tests.

Committer notes:

Use a designated initializer + terminating comma, e.g. { .fmt = NULL, }, to fix
the build in several distros:

  centos:6:       util/dso.c:201: error: missing initializer
  centos:6:       util/dso.c:201: error: (near initialization for 'compressions[0].decompress')
  debian:9:       util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
  fedora:25:      util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
  fedora:26:      util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
  fedora:27:      util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
  oraclelinux:6:  util/dso.c:201: error: missing initializer
  oraclelinux:6:  util/dso.c:201: error: (near initialization for 'compressions[0].decompress')
  ubuntu:12.04.5: util/dso.c:201:2: error: missing initializer [-Werror=missing-field-initializers]
  ubuntu:12.04.5: util/dso.c:201:2: error: (near initialization for 'compressions[0].decompress') [-Werror=missing-field-initializers]
  ubuntu:16.04:   util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
  ubuntu:16.10:   util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
  ubuntu:16.10:   util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]
  ubuntu:17.10:   util/dso.c:201:24: error: missing field 'decompress' initializer [-Werror,-Wmissing-field-initializers]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/kmod-path.c | 42 +++++++++++++++++++++---------------------
 tools/perf/util/dso.c        | 18 +++++++++++-------
 tools/perf/util/dso.h        |  2 +-
 3 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index 148dd31cc201..f92f78f683ea 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -6,7 +6,7 @@
 #include "debug.h"
 
 static int test(const char *path, bool alloc_name, bool alloc_ext,
-		bool kmod, bool comp, const char *name, const char *ext)
+		bool kmod, int comp, const char *name, const char *ext)
 {
 	struct kmod_path m;
 
@@ -54,47 +54,47 @@ static int test_is_kernel_module(const char *path, int cpumode, bool expect)
 int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	/* path                alloc_name  alloc_ext   kmod  comp   name     ext */
-	T("/xxxx/xxxx/x-x.ko", true      , true      , true, false, "[x_x]", NULL);
-	T("/xxxx/xxxx/x-x.ko", false     , true      , true, false, NULL   , NULL);
-	T("/xxxx/xxxx/x-x.ko", true      , false     , true, false, "[x_x]", NULL);
-	T("/xxxx/xxxx/x-x.ko", false     , false     , true, false, NULL   , NULL);
+	T("/xxxx/xxxx/x-x.ko", true      , true      , true, 0    , "[x_x]", NULL);
+	T("/xxxx/xxxx/x-x.ko", false     , true      , true, 0    , NULL   , NULL);
+	T("/xxxx/xxxx/x-x.ko", true      , false     , true, 0    , "[x_x]", NULL);
+	T("/xxxx/xxxx/x-x.ko", false     , false     , true, 0    , NULL   , NULL);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_KERNEL, true);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_USER, false);
 
 #ifdef HAVE_ZLIB_SUPPORT
 	/* path                alloc_name  alloc_ext   kmod  comp  name   ext */
-	T("/xxxx/xxxx/x.ko.gz", true     , true      , true, true, "[x]", "gz");
-	T("/xxxx/xxxx/x.ko.gz", false    , true      , true, true, NULL , "gz");
-	T("/xxxx/xxxx/x.ko.gz", true     , false     , true, true, "[x]", NULL);
-	T("/xxxx/xxxx/x.ko.gz", false    , false     , true, true, NULL , NULL);
+	T("/xxxx/xxxx/x.ko.gz", true     , true      , true, 1   , "[x]", "gz");
+	T("/xxxx/xxxx/x.ko.gz", false    , true      , true, 1   , NULL , "gz");
+	T("/xxxx/xxxx/x.ko.gz", true     , false     , true, 1   , "[x]", NULL);
+	T("/xxxx/xxxx/x.ko.gz", false    , false     , true, 1   , NULL , NULL);
 	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
 	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_USER, false);
 
 	/* path              alloc_name  alloc_ext  kmod   comp  name    ext */
-	T("/xxxx/xxxx/x.gz", true      , true     , false, true, "x.gz" ,"gz");
-	T("/xxxx/xxxx/x.gz", false     , true     , false, true, NULL   ,"gz");
-	T("/xxxx/xxxx/x.gz", true      , false    , false, true, "x.gz" , NULL);
-	T("/xxxx/xxxx/x.gz", false     , false    , false, true, NULL   , NULL);
+	T("/xxxx/xxxx/x.gz", true      , true     , false, 1   , "x.gz" ,"gz");
+	T("/xxxx/xxxx/x.gz", false     , true     , false, 1   , NULL   ,"gz");
+	T("/xxxx/xxxx/x.gz", true      , false    , false, 1   , "x.gz" , NULL);
+	T("/xxxx/xxxx/x.gz", false     , false    , false, 1   , NULL   , NULL);
 	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_KERNEL, false);
 	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_USER, false);
 
 	/* path   alloc_name  alloc_ext  kmod   comp  name     ext */
-	T("x.gz", true      , true     , false, true, "x.gz", "gz");
-	T("x.gz", false     , true     , false, true, NULL  , "gz");
-	T("x.gz", true      , false    , false, true, "x.gz", NULL);
-	T("x.gz", false     , false    , false, true, NULL  , NULL);
+	T("x.gz", true      , true     , false, 1   , "x.gz", "gz");
+	T("x.gz", false     , true     , false, 1   , NULL  , "gz");
+	T("x.gz", true      , false    , false, 1   , "x.gz", NULL);
+	T("x.gz", false     , false    , false, 1   , NULL  , NULL);
 	M("x.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("x.gz", PERF_RECORD_MISC_KERNEL, false);
 	M("x.gz", PERF_RECORD_MISC_USER, false);
 
 	/* path      alloc_name  alloc_ext  kmod  comp  name  ext */
-	T("x.ko.gz", true      , true     , true, true, "[x]", "gz");
-	T("x.ko.gz", false     , true     , true, true, NULL , "gz");
-	T("x.ko.gz", true      , false    , true, true, "[x]", NULL);
-	T("x.ko.gz", false     , false    , true, true, NULL , NULL);
+	T("x.ko.gz", true      , true     , true, 1   , "[x]", "gz");
+	T("x.ko.gz", false     , true     , true, 1   , NULL , "gz");
+	T("x.ko.gz", true      , false    , true, 1   , "[x]", NULL);
+	T("x.ko.gz", false     , false    , true, 1   , NULL , NULL);
 	M("x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
 	M("x.ko.gz", PERF_RECORD_MISC_USER, false);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index b8b5fdb1a15b..d34e47bb09d9 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -189,10 +189,15 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	return ret;
 }
 
+enum {
+	COMP_ID__NONE = 0,
+};
+
 static const struct {
 	const char *fmt;
 	int (*decompress)(const char *input, int output);
 } compressions[] = {
+	[COMP_ID__NONE] = { .fmt = NULL, },
 #ifdef HAVE_ZLIB_SUPPORT
 	{ "gz", gzip_decompress_to_file },
 #endif
@@ -202,15 +207,15 @@ static const struct {
 	{ NULL, NULL },
 };
 
-static bool is_supported_compression(const char *ext)
+static int is_supported_compression(const char *ext)
 {
 	unsigned i;
 
-	for (i = 0; compressions[i].fmt; i++) {
+	for (i = 1; compressions[i].fmt; i++) {
 		if (!strcmp(ext, compressions[i].fmt))
-			return true;
+			return i;
 	}
-	return false;
+	return COMP_ID__NONE;
 }
 
 bool is_kernel_module(const char *pathname, int cpumode)
@@ -372,10 +377,9 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 		return 0;
 	}
 
-	if (is_supported_compression(ext + 1)) {
-		m->comp = true;
+	m->comp = is_supported_compression(ext + 1);
+	if (m->comp > COMP_ID__NONE)
 		ext -= 3;
-	}
 
 	/* Check .ko extension only if there's enough name left. */
 	if (ext > name)
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 870346b333ee..7bde23f6e5a9 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -262,7 +262,7 @@ int dso__decompress_kmodule_path(struct dso *dso, const char *name,
 struct kmod_path {
 	char *name;
 	char *ext;
-	bool  comp;
+	int   comp;
 	bool  kmod;
 };
 
