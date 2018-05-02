Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeEBPVn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbeEBPVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:37 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 31/52] perf map: Remove enum_type arg to map_groups__first()
Date: Wed,  2 May 2018 12:19:21 -0300
Message-Id: <20180502151942.20542-32-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Only the symbol core needs to use that, so provide a __ variant for that
case, that will end up removed when we ditch the MAP__ split.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-x29k9e1ohastsoqbilp3mguh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h    |  6 +-----
 tools/perf/util/symbol.c | 14 ++++++++++++--
 tools/perf/util/vdso.c   |  6 ++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index b4bcf569a131..579ad7d2711d 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -225,11 +225,7 @@ static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
 	return __map_groups__find(mg, MAP__FUNCTION, addr);
 }
 
-static inline struct map *map_groups__first(struct map_groups *mg,
-					    enum map_type type)
-{
-	return maps__first(&mg->maps[type]);
-}
+struct map *map_groups__first(struct map_groups *mg);
 
 static inline struct map *map_groups__next(struct map *map)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8d9967357354..5d77c60e63bf 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1044,6 +1044,16 @@ int compare_proc_modules(const char *from, const char *to)
 	return ret;
 }
 
+static struct map *__map_groups__first(struct map_groups *mg, enum map_type type)
+{
+	return maps__first(&mg->maps[type]);
+}
+
+struct map *map_groups__first(struct map_groups *mg)
+{
+	return __map_groups__first(mg, MAP__FUNCTION);
+}
+
 static int do_validate_kcore_modules(const char *filename, struct map *map,
 				  struct map_groups *kmaps)
 {
@@ -1055,7 +1065,7 @@ static int do_validate_kcore_modules(const char *filename, struct map *map,
 	if (err)
 		return err;
 
-	old_map = map_groups__first(kmaps, map->type);
+	old_map = __map_groups__first(kmaps, map->type);
 	while (old_map) {
 		struct map *next = map_groups__next(old_map);
 		struct module_info *mi;
@@ -1218,7 +1228,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	old_map = map_groups__first(kmaps, map->type);
+	old_map = __map_groups__first(kmaps, map->type);
 	while (old_map) {
 		struct map *next = map_groups__next(old_map);
 
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 0acb1ec0e2f0..741af209b19d 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -139,12 +139,10 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
 					      struct thread *thread)
 {
 	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
-	struct map *map;
-	struct dso *dso;
+	struct map *map = map_groups__first(thread->mg);
 
-	map = map_groups__first(thread->mg, MAP__FUNCTION);
 	for (; map ; map = map_groups__next(map)) {
-		dso = map->dso;
+		struct dso *dso = map->dso;
 		if (!dso || dso->long_name[0] != '/')
 			continue;
 		dso_type = dso__type(dso, machine);
-- 
2.14.3
