Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeEBPcO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbeEBPUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:40 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 11/52] perf map: Introduce map__has_symbols()
Date: Wed,  2 May 2018 12:19:01 -0300
Message-Id: <20180502151942.20542-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
