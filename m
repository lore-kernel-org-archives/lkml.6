Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeBQLhr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:37:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53233 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeBQLhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:37:45 -0500
Date: Sat, 17 Feb 2018 03:27:23 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e8f3879f762ffe75a24fd354dd87f073214428fa@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, tglx@linutronix.de,
        dsahern@gmail.com, mingo@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, peterz@infradead.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com
Reply-To: hpa@zytor.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, jolsa@kernel.org
In-Reply-To: <20180215122635.24029-8-jolsa@kernel.org>
References: <20180215122635.24029-8-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Remove machine__load_kallsyms()
Git-Commit-ID: e8f3879f762ffe75a24fd354dd87f073214428fa
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e8f3879f762ffe75a24fd354dd87f073214428fa
Gitweb:     https://git.kernel.org/tip/e8f3879f762ffe75a24fd354dd87f073214428fa
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 15 Feb 2018 13:26:33 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:25:58 -0300

perf machine: Remove machine__load_kallsyms()

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
index f6789fb..5834929 100644
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
index 2db8d7d..fe27ef5 100644
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
index 50d587d..66cc200 100644
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
