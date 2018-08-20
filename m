Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E0CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFBD21733
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaGwpjVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFBD21733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeHTTd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:33:25 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B6EE2172D;
        Mon, 20 Aug 2018 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781829;
        bh=Q8AqcWdtNzo5scJi3L+n64RQfp0cQQJU9eFiafm0gpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RaGwpjVMonRaADgYIh/P+9yDQj6Jw2XYtPWOODxhEHUBpnGqkz+m+aJG2mhKmhzL6
         ZJ8fQXf227ELDjeZ4FGBzN903GK5IV8q5MOSUktPDo9amoGU69Oip4fsXhHvu4ZN8B
         zKGt0GrDb+TnZhZONSkMq0PofFnBkaCAExprJLHI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/21] perf tools: Remove ext from struct kmod_path
Date:   Mon, 20 Aug 2018 13:15:58 -0300
Message-Id: <20180820161602.6830-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Having comp carrying the compression ID, we no longer need return the
extension. Removing it and updating the automated test.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/kmod-path.c | 136 +++++++++++++++++++++----------------------
 tools/perf/util/dso.c        |  10 +---
 tools/perf/util/dso.h        |   8 +--
 3 files changed, 69 insertions(+), 85 deletions(-)

diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index f92f78f683ea..0579a70bbbff 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -5,34 +5,28 @@
 #include "dso.h"
 #include "debug.h"
 
-static int test(const char *path, bool alloc_name, bool alloc_ext,
-		bool kmod, int comp, const char *name, const char *ext)
+static int test(const char *path, bool alloc_name, bool kmod,
+		int comp, const char *name)
 {
 	struct kmod_path m;
 
 	memset(&m, 0x0, sizeof(m));
 
 	TEST_ASSERT_VAL("kmod_path__parse",
-			!__kmod_path__parse(&m, path, alloc_name, alloc_ext));
+			!__kmod_path__parse(&m, path, alloc_name));
 
-	pr_debug("%s - alloc name %d, alloc ext %d, kmod %d, comp %d, name '%s', ext '%s'\n",
-		 path, alloc_name, alloc_ext, m.kmod, m.comp, m.name, m.ext);
+	pr_debug("%s - alloc name %d, kmod %d, comp %d, name '%s'\n",
+		 path, alloc_name, m.kmod, m.comp, m.name);
 
 	TEST_ASSERT_VAL("wrong kmod", m.kmod == kmod);
 	TEST_ASSERT_VAL("wrong comp", m.comp == comp);
 
-	if (ext)
-		TEST_ASSERT_VAL("wrong ext", m.ext && !strcmp(ext, m.ext));
-	else
-		TEST_ASSERT_VAL("wrong ext", !m.ext);
-
 	if (name)
 		TEST_ASSERT_VAL("wrong name", m.name && !strcmp(name, m.name));
 	else
 		TEST_ASSERT_VAL("wrong name", !m.name);
 
 	free(m.name);
-	free(m.ext);
 	return 0;
 }
 
@@ -45,118 +39,118 @@ static int test_is_kernel_module(const char *path, int cpumode, bool expect)
 	return 0;
 }
 
-#define T(path, an, ae, k, c, n, e) \
-	TEST_ASSERT_VAL("failed", !test(path, an, ae, k, c, n, e))
+#define T(path, an, k, c, n) \
+	TEST_ASSERT_VAL("failed", !test(path, an, k, c, n))
 
 #define M(path, c, e) \
 	TEST_ASSERT_VAL("failed", !test_is_kernel_module(path, c, e))
 
 int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
-	/* path                alloc_name  alloc_ext   kmod  comp   name     ext */
-	T("/xxxx/xxxx/x-x.ko", true      , true      , true, 0    , "[x_x]", NULL);
-	T("/xxxx/xxxx/x-x.ko", false     , true      , true, 0    , NULL   , NULL);
-	T("/xxxx/xxxx/x-x.ko", true      , false     , true, 0    , "[x_x]", NULL);
-	T("/xxxx/xxxx/x-x.ko", false     , false     , true, 0    , NULL   , NULL);
+	/* path                alloc_name  kmod  comp   name   */
+	T("/xxxx/xxxx/x-x.ko", true      , true, 0    , "[x_x]");
+	T("/xxxx/xxxx/x-x.ko", false     , true, 0    , NULL   );
+	T("/xxxx/xxxx/x-x.ko", true      , true, 0    , "[x_x]");
+	T("/xxxx/xxxx/x-x.ko", false     , true, 0    , NULL   );
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_KERNEL, true);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_USER, false);
 
 #ifdef HAVE_ZLIB_SUPPORT
-	/* path                alloc_name  alloc_ext   kmod  comp  name   ext */
-	T("/xxxx/xxxx/x.ko.gz", true     , true      , true, 1   , "[x]", "gz");
-	T("/xxxx/xxxx/x.ko.gz", false    , true      , true, 1   , NULL , "gz");
-	T("/xxxx/xxxx/x.ko.gz", true     , false     , true, 1   , "[x]", NULL);
-	T("/xxxx/xxxx/x.ko.gz", false    , false     , true, 1   , NULL , NULL);
+	/* path                alloc_name   kmod  comp  name  */
+	T("/xxxx/xxxx/x.ko.gz", true     , true, 1   , "[x]");
+	T("/xxxx/xxxx/x.ko.gz", false    , true, 1   , NULL );
+	T("/xxxx/xxxx/x.ko.gz", true     , true, 1   , "[x]");
+	T("/xxxx/xxxx/x.ko.gz", false    , true, 1   , NULL );
 	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
 	M("/xxxx/xxxx/x.ko.gz", PERF_RECORD_MISC_USER, false);
 
-	/* path              alloc_name  alloc_ext  kmod   comp  name    ext */
-	T("/xxxx/xxxx/x.gz", true      , true     , false, 1   , "x.gz" ,"gz");
-	T("/xxxx/xxxx/x.gz", false     , true     , false, 1   , NULL   ,"gz");
-	T("/xxxx/xxxx/x.gz", true      , false    , false, 1   , "x.gz" , NULL);
-	T("/xxxx/xxxx/x.gz", false     , false    , false, 1   , NULL   , NULL);
+	/* path              alloc_name  kmod   comp  name  */
+	T("/xxxx/xxxx/x.gz", true      , false, 1   , "x.gz");
+	T("/xxxx/xxxx/x.gz", false     , false, 1   , NULL  );
+	T("/xxxx/xxxx/x.gz", true      , false, 1   , "x.gz");
+	T("/xxxx/xxxx/x.gz", false     , false, 1   , NULL  );
 	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_KERNEL, false);
 	M("/xxxx/xxxx/x.gz", PERF_RECORD_MISC_USER, false);
 
-	/* path   alloc_name  alloc_ext  kmod   comp  name     ext */
-	T("x.gz", true      , true     , false, 1   , "x.gz", "gz");
-	T("x.gz", false     , true     , false, 1   , NULL  , "gz");
-	T("x.gz", true      , false    , false, 1   , "x.gz", NULL);
-	T("x.gz", false     , false    , false, 1   , NULL  , NULL);
+	/* path   alloc_name  kmod   comp  name   */
+	T("x.gz", true      , false, 1   , "x.gz");
+	T("x.gz", false     , false, 1   , NULL  );
+	T("x.gz", true      , false, 1   , "x.gz");
+	T("x.gz", false     , false, 1   , NULL  );
 	M("x.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("x.gz", PERF_RECORD_MISC_KERNEL, false);
 	M("x.gz", PERF_RECORD_MISC_USER, false);
 
-	/* path      alloc_name  alloc_ext  kmod  comp  name  ext */
-	T("x.ko.gz", true      , true     , true, 1   , "[x]", "gz");
-	T("x.ko.gz", false     , true     , true, 1   , NULL , "gz");
-	T("x.ko.gz", true      , false    , true, 1   , "[x]", NULL);
-	T("x.ko.gz", false     , false    , true, 1   , NULL , NULL);
+	/* path      alloc_name  kmod  comp  name  */
+	T("x.ko.gz", true      , true, 1   , "[x]");
+	T("x.ko.gz", false     , true, 1   , NULL );
+	T("x.ko.gz", true      , true, 1   , "[x]");
+	T("x.ko.gz", false     , true, 1   , NULL );
 	M("x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
 	M("x.ko.gz", PERF_RECORD_MISC_USER, false);
 #endif
 
-	/* path            alloc_name  alloc_ext  kmod  comp   name             ext */
-	T("[test_module]", true      , true     , true, false, "[test_module]", NULL);
-	T("[test_module]", false     , true     , true, false, NULL           , NULL);
-	T("[test_module]", true      , false    , true, false, "[test_module]", NULL);
-	T("[test_module]", false     , false    , true, false, NULL           , NULL);
+	/* path            alloc_name  kmod  comp   name           */
+	T("[test_module]", true      , true, false, "[test_module]");
+	T("[test_module]", false     , true, false, NULL           );
+	T("[test_module]", true      , true, false, "[test_module]");
+	T("[test_module]", false     , true, false, NULL           );
 	M("[test_module]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("[test_module]", PERF_RECORD_MISC_KERNEL, true);
 	M("[test_module]", PERF_RECORD_MISC_USER, false);
 
-	/* path            alloc_name  alloc_ext  kmod  comp   name             ext */
-	T("[test.module]", true      , true     , true, false, "[test.module]", NULL);
-	T("[test.module]", false     , true     , true, false, NULL           , NULL);
-	T("[test.module]", true      , false    , true, false, "[test.module]", NULL);
-	T("[test.module]", false     , false    , true, false, NULL           , NULL);
+	/* path            alloc_name  kmod  comp   name           */
+	T("[test.module]", true      , true, false, "[test.module]");
+	T("[test.module]", false     , true, false, NULL           );
+	T("[test.module]", true      , true, false, "[test.module]");
+	T("[test.module]", false     , true, false, NULL           );
 	M("[test.module]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("[test.module]", PERF_RECORD_MISC_KERNEL, true);
 	M("[test.module]", PERF_RECORD_MISC_USER, false);
 
-	/* path     alloc_name  alloc_ext  kmod   comp   name      ext */
-	T("[vdso]", true      , true     , false, false, "[vdso]", NULL);
-	T("[vdso]", false     , true     , false, false, NULL    , NULL);
-	T("[vdso]", true      , false    , false, false, "[vdso]", NULL);
-	T("[vdso]", false     , false    , false, false, NULL    , NULL);
+	/* path     alloc_name  kmod   comp   name    */
+	T("[vdso]", true      , false, false, "[vdso]");
+	T("[vdso]", false     , false, false, NULL    );
+	T("[vdso]", true      , false, false, "[vdso]");
+	T("[vdso]", false     , false, false, NULL    );
 	M("[vdso]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("[vdso]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vdso]", PERF_RECORD_MISC_USER, false);
 
-	T("[vdso32]", true      , true     , false, false, "[vdso32]", NULL);
-	T("[vdso32]", false     , true     , false, false, NULL    , NULL);
-	T("[vdso32]", true      , false    , false, false, "[vdso32]", NULL);
-	T("[vdso32]", false     , false    , false, false, NULL    , NULL);
+	T("[vdso32]", true      , false, false, "[vdso32]");
+	T("[vdso32]", false     , false, false, NULL      );
+	T("[vdso32]", true      , false, false, "[vdso32]");
+	T("[vdso32]", false     , false, false, NULL      );
 	M("[vdso32]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("[vdso32]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vdso32]", PERF_RECORD_MISC_USER, false);
 
-	T("[vdsox32]", true      , true     , false, false, "[vdsox32]", NULL);
-	T("[vdsox32]", false     , true     , false, false, NULL    , NULL);
-	T("[vdsox32]", true      , false    , false, false, "[vdsox32]", NULL);
-	T("[vdsox32]", false     , false    , false, false, NULL    , NULL);
+	T("[vdsox32]", true      , false, false, "[vdsox32]");
+	T("[vdsox32]", false     , false, false, NULL       );
+	T("[vdsox32]", true      , false, false, "[vdsox32]");
+	T("[vdsox32]", false     , false, false, NULL       );
 	M("[vdsox32]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("[vdsox32]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vdsox32]", PERF_RECORD_MISC_USER, false);
 
-	/* path         alloc_name  alloc_ext  kmod   comp   name          ext */
-	T("[vsyscall]", true      , true     , false, false, "[vsyscall]", NULL);
-	T("[vsyscall]", false     , true     , false, false, NULL        , NULL);
-	T("[vsyscall]", true      , false    , false, false, "[vsyscall]", NULL);
-	T("[vsyscall]", false     , false    , false, false, NULL        , NULL);
+	/* path         alloc_name  kmod   comp   name        */
+	T("[vsyscall]", true      , false, false, "[vsyscall]");
+	T("[vsyscall]", false     , false, false, NULL        );
+	T("[vsyscall]", true      , false, false, "[vsyscall]");
+	T("[vsyscall]", false     , false, false, NULL        );
 	M("[vsyscall]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("[vsyscall]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vsyscall]", PERF_RECORD_MISC_USER, false);
 
-	/* path                alloc_name  alloc_ext  kmod   comp   name      ext */
-	T("[kernel.kallsyms]", true      , true     , false, false, "[kernel.kallsyms]", NULL);
-	T("[kernel.kallsyms]", false     , true     , false, false, NULL               , NULL);
-	T("[kernel.kallsyms]", true      , false    , false, false, "[kernel.kallsyms]", NULL);
-	T("[kernel.kallsyms]", false     , false    , false, false, NULL               , NULL);
+	/* path                alloc_name  kmod   comp   name      */
+	T("[kernel.kallsyms]", true      , false, false, "[kernel.kallsyms]");
+	T("[kernel.kallsyms]", false     , false, false, NULL               );
+	T("[kernel.kallsyms]", true      , false, false, "[kernel.kallsyms]");
+	T("[kernel.kallsyms]", false     , false, false, NULL               );
 	M("[kernel.kallsyms]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
 	M("[kernel.kallsyms]", PERF_RECORD_MISC_KERNEL, false);
 	M("[kernel.kallsyms]", PERF_RECORD_MISC_USER, false);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 8b9243f13b88..bbed90e5d9bb 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -331,7 +331,7 @@ int dso__decompress_kmodule_path(struct dso *dso, const char *name,
  * Returns 0 if there's no strdup error, -ENOMEM otherwise.
  */
 int __kmod_path__parse(struct kmod_path *m, const char *path,
-		       bool alloc_name, bool alloc_ext)
+		       bool alloc_name)
 {
 	const char *name = strrchr(path, '/');
 	const char *ext  = strrchr(path, '.');
@@ -391,14 +391,6 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 		strxfrchar(m->name, '-', '_');
 	}
 
-	if (alloc_ext && m->comp) {
-		m->ext = strdup(ext + 4);
-		if (!m->ext) {
-			free((void *) m->name);
-			return -ENOMEM;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index a6c7af52115f..c5380500bed4 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -262,17 +262,15 @@ int dso__decompress_kmodule_path(struct dso *dso, const char *name,
 
 struct kmod_path {
 	char *name;
-	char *ext;
 	int   comp;
 	bool  kmod;
 };
 
 int __kmod_path__parse(struct kmod_path *m, const char *path,
-		     bool alloc_name, bool alloc_ext);
+		     bool alloc_name);
 
-#define kmod_path__parse(__m, __p)      __kmod_path__parse(__m, __p, false, false)
-#define kmod_path__parse_name(__m, __p) __kmod_path__parse(__m, __p, true , false)
-#define kmod_path__parse_ext(__m, __p)  __kmod_path__parse(__m, __p, false, true)
+#define kmod_path__parse(__m, __p)      __kmod_path__parse(__m, __p, false)
+#define kmod_path__parse_name(__m, __p) __kmod_path__parse(__m, __p, true)
 
 void dso__set_module_info(struct dso *dso, struct kmod_path *m,
 			  struct machine *machine);
-- 
2.14.4

