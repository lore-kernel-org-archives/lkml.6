Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbeBPTTM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:19:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753597AbeBPTTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DAD217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/41] perf machine: Remove machine__load_kallsyms()
Date: Fri, 16 Feb 2018 16:17:22 -0300
Message-Id: <20180216191746.11095-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The current machine__load_kallsyms() function has no caller, so replace
it directly with __machine__load_kallsyms().  Also remove the no_kcore
argument as it was always called with a 'true' value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180215122635.24029-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c |  2 +-
 tools/perf/util/machine.c           | 14 ++++----------
 tools/perf/util/machine.h           |  2 --
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index f6789fb029d6..58349297f9fb 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -56,7 +56,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 	 * be compacted against the list of modules found in the "vmlinux"
 	 * code and with the one got from /proc/modules from the "kallsyms" code.
 	 */
-	if (__machine__load_kallsyms(&kallsyms, "/proc/kallsyms", type, true) <= 0) {
+	if (machine__load_kallsyms(&kallsyms, "/proc/kallsyms", type) <= 0) {
 		pr_debug("dso__load_kallsyms ");
 		goto out;
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2db8d7dd0f80..fe27ef55cbb9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -151,7 +151,7 @@ struct machine *machine__new_kallsyms(void)
 	 *    ask for not using the kcore parsing code, once this one is fixed
 	 *    to create a map per module.
 	 */
-	if (machine && __machine__load_kallsyms(machine, "/proc/kallsyms", MAP__FUNCTION, true) <= 0) {
+	if (machine && machine__load_kallsyms(machine, "/proc/kallsyms", MAP__FUNCTION) <= 0) {
 		machine__delete(machine);
 		machine = NULL;
 	}
@@ -991,11 +991,11 @@ int machines__create_kernel_maps(struct machines *machines, pid_t pid)
 	return machine__create_kernel_maps(machine);
 }
 
-int __machine__load_kallsyms(struct machine *machine, const char *filename,
-			     enum map_type type, bool no_kcore)
+int machine__load_kallsyms(struct machine *machine, const char *filename,
+			     enum map_type type)
 {
 	struct map *map = machine__kernel_map(machine);
-	int ret = __dso__load_kallsyms(map->dso, filename, map, no_kcore);
+	int ret = __dso__load_kallsyms(map->dso, filename, map, true);
 
 	if (ret > 0) {
 		dso__set_loaded(map->dso, type);
@@ -1010,12 +1010,6 @@ int __machine__load_kallsyms(struct machine *machine, const char *filename,
 	return ret;
 }
 
-int machine__load_kallsyms(struct machine *machine, const char *filename,
-			   enum map_type type)
-{
-	return __machine__load_kallsyms(machine, filename, type, false);
-}
-
 int machine__load_vmlinux_path(struct machine *machine, enum map_type type)
 {
 	struct map *map = machine__kernel_map(machine);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 50d587d34459..66cc200ef86f 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -225,8 +225,6 @@ struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 					const char *filename);
 int arch__fix_module_text_start(u64 *start, const char *name);
 
-int __machine__load_kallsyms(struct machine *machine, const char *filename,
-			     enum map_type type, bool no_kcore);
 int machine__load_kallsyms(struct machine *machine, const char *filename,
 			   enum map_type type);
 int machine__load_vmlinux_path(struct machine *machine, enum map_type type);
-- 
2.14.3
