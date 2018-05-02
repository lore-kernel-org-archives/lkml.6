Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeEBP3v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbeEBPVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:08 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 21/52] perf machine: Shorten machine__load_kallsyms() signature
Date: Wed,  2 May 2018 12:19:11 -0300
Message-Id: <20180502151942.20542-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So far the only use is for MAP__FUNCTION, and since we're going to
remove that split, remove the map_type argument in machine__load_kallsyms().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-5dhgh7x8g9hx5hpxlp3k08jp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c |  2 +-
 tools/perf/util/machine.c           |  8 +++-----
 tools/perf/util/machine.h           | 10 ++++++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 9bb84fe365e2..b99e60593664 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -56,7 +56,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 	 * be compacted against the list of modules found in the "vmlinux"
 	 * code and with the one got from /proc/modules from the "kallsyms" code.
 	 */
-	if (machine__load_kallsyms(&kallsyms, "/proc/kallsyms", type) <= 0) {
+	if (machine__load_kallsyms(&kallsyms, "/proc/kallsyms") <= 0) {
 		pr_debug("dso__load_kallsyms ");
 		goto out;
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fc71f2c69c8b..d39432c7db86 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -137,13 +137,11 @@ struct machine *machine__new_kallsyms(void)
 	struct machine *machine = machine__new_host();
 	/*
 	 * FIXME:
-	 * 1) MAP__FUNCTION will go away when we stop loading separate maps for
-	 *    functions and data objects.
-	 * 2) We should switch to machine__load_kallsyms(), i.e. not explicitely
+	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitely
 	 *    ask for not using the kcore parsing code, once this one is fixed
 	 *    to create a map per module.
 	 */
-	if (machine && machine__load_kallsyms(machine, "/proc/kallsyms", MAP__FUNCTION) <= 0) {
+	if (machine && machine__load_kallsyms(machine, "/proc/kallsyms") <= 0) {
 		machine__delete(machine);
 		machine = NULL;
 	}
@@ -988,7 +986,7 @@ int machines__create_kernel_maps(struct machines *machines, pid_t pid)
 	return machine__create_kernel_maps(machine);
 }
 
-int machine__load_kallsyms(struct machine *machine, const char *filename,
+int __machine__load_kallsyms(struct machine *machine, const char *filename,
 			     enum map_type type)
 {
 	struct map *map = machine__kernel_map(machine);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 92303ac718a6..dc95404959ee 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -237,8 +237,14 @@ struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 					const char *filename);
 int arch__fix_module_text_start(u64 *start, const char *name);
 
-int machine__load_kallsyms(struct machine *machine, const char *filename,
-			   enum map_type type);
+int __machine__load_kallsyms(struct machine *machine, const char *filename,
+			     enum map_type type);
+
+static inline int machine__load_kallsyms(struct machine *machine, const char *filename)
+{
+	return __machine__load_kallsyms(machine, filename, MAP__FUNCTION);
+}
+
 int machine__load_vmlinux_path(struct machine *machine, enum map_type type);
 
 size_t machine__fprintf_dsos_buildid(struct machine *machine, FILE *fp,
-- 
2.14.3
