Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE79C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6535E2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6535E2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbeHWMOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:14:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeHWMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:14:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8jQ0D3191206
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:45:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8jQlf3191203;
        Thu, 23 Aug 2018 01:45:26 -0700
Date:   Thu, 23 Aug 2018 01:45:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b946cd37348aaef443a1d951144f79a70274867f@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        mpetlan@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        dsahern@gmail.com
Reply-To: jolsa@kernel.org, acme@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          mpetlan@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          peterz@infradead.org, mingo@kernel.org, dsahern@gmail.com
In-Reply-To: <20180817094813.15086-14-jolsa@kernel.org>
References: <20180817094813.15086-14-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Remove ext from struct kmod_path
Git-Commit-ID: b946cd37348aaef443a1d951144f79a70274867f
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

Commit-ID:  b946cd37348aaef443a1d951144f79a70274867f
Gitweb:     https://git.kernel.org/tip/b946cd37348aaef443a1d951144f79a70274867f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:13 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Remove ext from struct kmod_path

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
