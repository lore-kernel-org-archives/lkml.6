Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeEBRsS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:48:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40613 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbeEBRsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:48:11 -0400
Date: Wed, 2 May 2018 10:48:00 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8a1hvrqe3r5i0kw865u3uxwt@git.kernel.org>
Cc: adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        dsahern@gmail.com, wangnan0@huawei.com
Reply-To: namhyung@kernel.org, acme@redhat.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org, wangnan0@huawei.com, dsahern@gmail.com,
        hpa@zytor.com, tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf map: Shorten map_groups__find_by_name()
 signature
Git-Commit-ID: 83cf774b028fa67acfdd0176d54aa9387c2ad10d
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

Commit-ID:  83cf774b028fa67acfdd0176d54aa9387c2ad10d
Gitweb:     https://git.kernel.org/tip/83cf774b028fa67acfdd0176d54aa9387c2ad10d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 24 Apr 2018 12:16:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:09 -0300

perf map: Shorten map_groups__find_by_name() signature

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
@@ -183,7 +183,7 @@ next_pair:
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
@@ -1667,8 +1666,7 @@ out:
 	return ret;
 }
 
-struct map *map_groups__find_by_name(struct map_groups *mg,
-				     enum map_type type, const char *name)
+struct map *__map_groups__find_by_name(struct map_groups *mg, enum map_type type, const char *name)
 {
 	struct maps *maps = &mg->maps[type];
 	struct map *map;
