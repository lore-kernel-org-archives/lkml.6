Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeBGOsz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:48:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932091AbeBGOsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:48:52 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 08/10] perf tools: Remove machine__load_kallsyms function
Date: Wed,  7 Feb 2018 15:48:36 +0100
Message-Id: <20180207144838.16823-9-jolsa@kernel.org>
In-Reply-To: <20180207144838.16823-1-jolsa@kernel.org>
References: <20180207144838.16823-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And replacing it with __machine__load_kallsyms function.

The current machine__load_kallsyms function has no caller,
so replacing it directly with __machine__load_kallsyms.
Also removing the no_kcore argument as it was always called
with true value.

Link: http://lkml.kernel.org/n/tip-kj9bpn6v213n6vaoe6ryxv2q@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index a02242eb25a1..9074c63c056e 100644
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
@@ -992,11 +992,11 @@ int machines__create_kernel_maps(struct machines *machines, pid_t pid)
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
@@ -1011,12 +1011,6 @@ int __machine__load_kallsyms(struct machine *machine, const char *filename,
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
2.13.6
