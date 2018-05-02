Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeEBRow (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:44:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52621 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:44:48 -0400
Date: Wed, 2 May 2018 10:44:37 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-iyfoyvbfdti5uehgpjum3qrq@git.kernel.org>
Cc: jolsa@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, wangnan0@huawei.com,
        hpa@zytor.com, adrian.hunter@intel.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        dsahern@gmail.com, acme@redhat.com, hpa@zytor.com,
        adrian.hunter@intel.com, wangnan0@huawei.com, tglx@linutronix.de,
        mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf map: Introduce map__has_symbols()
Git-Commit-ID: e94b861a231501e73d786970ed5a1fb3ea643906
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

Commit-ID:  e94b861a231501e73d786970ed5a1fb3ea643906
Gitweb:     https://git.kernel.org/tip/e94b861a231501e73d786970ed5a1fb3ea643906
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 23 Apr 2018 17:13:49 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:06 -0300

perf map: Introduce map__has_symbols()

To further simplify checking if symbols are available for a given map
and to reduce the number of users of MAP__{FUNCTION,VARIABLE}.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-iyfoyvbfdti5uehgpjum3qrq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 9 +++------
 tools/perf/builtin-top.c    | 5 ++---
 tools/perf/util/map.c       | 5 +++++
 tools/perf/util/map.h       | 2 ++
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index a4104e447f56..68ea336bf311 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -523,12 +523,9 @@ static void report__warn_kptr_restrict(const struct report *rep)
 		    "As no suitable kallsyms nor vmlinux was found, kernel samples\n"
 		    "can't be resolved.";
 
-		if (kernel_map) {
-			const struct dso *kdso = kernel_map->dso;
-			if (dso__has_symbols(kdso, MAP__FUNCTION)) {
-				desc = "If some relocation was applied (e.g. "
-				       "kexec) symbols may be misresolved.";
-			}
+		if (kernel_map && map__has_symbols(kernel_map)) {
+			desc = "If some relocation was applied (e.g. "
+			       "kexec) symbols may be misresolved.";
 		}
 
 		ui__warning(
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c11b46b411d5..3c061c57afb6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -742,7 +742,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 "Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
 "Check /proc/sys/kernel/kptr_restrict.\n\n"
 "Kernel%s samples will not be resolved.\n",
-			  al.map && dso__has_symbols(al.map->dso, MAP__FUNCTION) ?
+			  al.map && map__has_symbols(al.map) ?
 			  " modules" : "");
 			if (use_browser <= 0)
 				sleep(5);
@@ -764,8 +764,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		 * invalid --vmlinux ;-)
 		 */
 		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
-		    __map__is_kernel(al.map) &&
-		    dso__has_symbols(al.map->dso, MAP__FUNCTION)) {
+		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
 				dso__strerror_load(al.map->dso, serr, sizeof(serr));
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 8fe57031e1a8..f553e302bf9c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -259,6 +259,11 @@ bool __map__is_kernel(const struct map *map)
 	return __machine__kernel_map(map->groups->machine, map->type) == map;
 }
 
+bool map__has_symbols(const struct map *map)
+{
+	return dso__has_symbols(map->dso, map->type);
+}
+
 static void map__exit(struct map *map)
 {
 	BUG_ON(!RB_EMPTY_NODE(&map->rb_node));
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 0e9bbe01b0ab..fc91bac8fed0 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -264,4 +264,6 @@ static inline bool __map__is_kmodule(const struct map *map)
 	return !__map__is_kernel(map);
 }
 
+bool map__has_symbols(const struct map *map);
+
 #endif /* __PERF_MAP_H */
