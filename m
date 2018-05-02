Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbeEBPar (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbeEBPVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:00 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 18/52] perf map: Shorten map_groups__find_by_name() signature
Date: Wed,  2 May 2018 12:19:08 -0300
Message-Id: <20180502151942.20542-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Another step in the road to elliminate the MAP_{FUNCTION,VARIABLE}
separation, reducing the exposure to these details in the tools using
the symbol APIs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8a1hvrqe3r5i0kw865u3uxwt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 2 +-
 tools/perf/util/machine.c           | 6 ++----
 tools/perf/util/map.h               | 8 ++++++--
 tools/perf/util/probe-event.c       | 2 +-
 tools/perf/util/symbol-elf.c        | 2 +-
 tools/perf/util/symbol.c            | 6 ++----
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 1e5adb65632a..d80416e07f4b 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -183,7 +183,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 		 * so use the short name, less descriptive but the same ("[kernel]" in
 		 * both cases.
 		 */
-		pair = map_groups__find_by_name(&kallsyms.kmaps, type,
+		pair = map_groups__find_by_name(&kallsyms.kmaps,
 						(map->dso->kernel ?
 							map->dso->short_name :
 							map->dso->name));
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e354d94a68e8..fc71f2c69c8b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -673,8 +673,7 @@ struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 	if (kmod_path__parse_name(&m, filename))
 		return NULL;
 
-	map = map_groups__find_by_name(&machine->kmaps, MAP__FUNCTION,
-				       m.name);
+	map = map_groups__find_by_name(&machine->kmaps, m.name);
 	if (map) {
 		/*
 		 * If the map's dso is an offline module, give dso__load()
@@ -1055,10 +1054,9 @@ static bool is_kmod_dso(struct dso *dso)
 static int map_groups__set_module_path(struct map_groups *mg, const char *path,
 				       struct kmod_path *m)
 {
-	struct map *map;
 	char *long_name;
+	struct map *map = map_groups__find_by_name(mg, m->name);
 
-	map = map_groups__find_by_name(mg, MAP__FUNCTION, m->name);
 	if (map == NULL)
 		return 0;
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index fc91bac8fed0..8ff75be0a965 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -254,8 +254,12 @@ struct symbol *map_groups__find_function_by_name(struct map_groups *mg,
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map,
 				   FILE *fp);
 
-struct map *map_groups__find_by_name(struct map_groups *mg,
-				     enum map_type type, const char *name);
+struct map *__map_groups__find_by_name(struct map_groups *mg, enum map_type type, const char *name);
+
+static inline struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
+{
+	return __map_groups__find_by_name(mg, MAP__FUNCTION, name);
+}
 
 bool __map__is_kernel(const struct map *map);
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e1dbc9821617..d5e2516d5981 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -341,7 +341,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 		char module_name[128];
 
 		snprintf(module_name, sizeof(module_name), "[%s]", module);
-		map = map_groups__find_by_name(&host_machine->kmaps, MAP__FUNCTION, module_name);
+		map = map_groups__find_by_name(&host_machine->kmaps, module_name);
 		if (map) {
 			dso = map->dso;
 			goto found;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 2de770511e70..75f578f3ed8e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1042,7 +1042,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			snprintf(dso_name, sizeof(dso_name),
 				 "%s%s", dso->short_name, section_name);
 
-			curr_map = map_groups__find_by_name(kmaps, map->type, dso_name);
+			curr_map = __map_groups__find_by_name(kmaps, map->type, dso_name);
 			if (curr_map == NULL) {
 				u64 start = sym.st_value;
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2b6292cff719..0bf4cf76f36a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -792,8 +792,7 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 							curr_map->type);
 				}
 
-				curr_map = map_groups__find_by_name(kmaps,
-							map->type, module);
+				curr_map = __map_groups__find_by_name(kmaps, map->type, module);
 				if (curr_map == NULL) {
 					pr_debug("%s/proc/{kallsyms,modules} "
 					         "inconsistency while looking "
@@ -1667,8 +1666,7 @@ int dso__load(struct dso *dso, struct map *map)
 	return ret;
 }
 
-struct map *map_groups__find_by_name(struct map_groups *mg,
-				     enum map_type type, const char *name)
+struct map *__map_groups__find_by_name(struct map_groups *mg, enum map_type type, const char *name)
 {
 	struct maps *maps = &mg->maps[type];
 	struct map *map;
-- 
2.14.3
