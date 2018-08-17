Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38FCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F0E218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F0E218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeHQMvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeHQMvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41B4540201C4;
        Fri, 17 Aug 2018 09:48:26 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C972A175BC;
        Fri, 17 Aug 2018 09:48:24 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 06/13] perf tools: Add compression id into struct kmod_path
Date:   Fri, 17 Aug 2018 11:48:06 +0200
Message-Id: <20180817094813.15086-7-jolsa@kernel.org>
In-Reply-To: <20180817094813.15086-1-jolsa@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 17 Aug 2018 09:48:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 17 Aug 2018 09:48:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Storing decompression ID in the struct kmod_path, so it
can be later stored in the struct dso.

Switching the struct kmod_path::comp from bool to int
to return the compressions array index. Adding 0 index
item into compressions array, so the comp usage stays
as it was: 0 - no compression, != 0 index of compression.

Updating the kmod_path tests.

Link: http://lkml.kernel.org/n/tip-vxxfco32fh5veg1817udcx2c@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/kmod-path.c | 42 ++++++++++++++++++------------------
 tools/perf/util/dso.c        | 18 ++++++++++------
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
index 4449a7257340..f5f8babea17c 100644
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
+	[COMP_ID__NONE] = { 0 },
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
@@ -373,10 +378,9 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
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
 
-- 
2.17.1

