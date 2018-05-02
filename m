Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeEBP04 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeEBPVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:40 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 32/52] perf symbols: Remove map_type arg from dso__find_symbol()
Date: Wed,  2 May 2018 12:19:22 -0300
Message-Id: <20180502151942.20542-33-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step to ditch MAP__{VARIABLE,FUNCTION}

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-919d1k13ts62pjipnpibvgwd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c |  3 +--
 tools/perf/util/map.c       |  4 ++--
 tools/perf/util/symbol.c    | 10 +++++-----
 tools/perf/util/symbol.h    | 12 ++++++++----
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index b0c2b5c5d337..04fb1a99c737 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -315,8 +315,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		al.addr = node->ip;
 
 		if (al.map && !al.sym)
-			al.sym = dso__find_symbol(al.map->dso, MAP__FUNCTION,
-						  al.addr);
+			al.sym = dso__find_symbol(al.map->dso, al.addr);
 
 		db_ids_from_al(dbe, &al, &dso_db_id, &sym_db_id, &offset);
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 91e2afb010f8..ab12f2bc7669 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -353,7 +353,7 @@ struct symbol *map__find_symbol(struct map *map, u64 addr)
 	if (map__load(map) < 0)
 		return NULL;
 
-	return dso__find_symbol(map->dso, map->type, addr);
+	return __dso__find_symbol(map->dso, map->type, addr);
 }
 
 struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
@@ -364,7 +364,7 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 	if (!dso__sorted_by_name(map->dso, map->type))
 		dso__sort_by_name(map->dso, map->type);
 
-	return dso__find_symbol_by_name(map->dso, map->type, name);
+	return __dso__find_symbol_by_name(map->dso, map->type, name);
 }
 
 struct map *map__clone(struct map *from)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5d77c60e63bf..2b81ccc94a7e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -504,8 +504,8 @@ void dso__insert_symbol(struct dso *dso, enum map_type type, struct symbol *sym)
 	}
 }
 
-struct symbol *dso__find_symbol(struct dso *dso,
-				enum map_type type, u64 addr)
+struct symbol *__dso__find_symbol(struct dso *dso,
+				  enum map_type type, u64 addr)
 {
 	if (dso->last_find_result[type].addr != addr || dso->last_find_result[type].symbol == NULL) {
 		dso->last_find_result[type].addr   = addr;
@@ -549,10 +549,10 @@ struct symbol *symbol__next_by_name(struct symbol *sym)
 }
 
  /*
-  * Teturns first symbol that matched with @name.
+  * Returns first symbol that matched with @name.
   */
-struct symbol *dso__find_symbol_by_name(struct dso *dso, enum map_type type,
-					const char *name)
+struct symbol *__dso__find_symbol_by_name(struct dso *dso, enum map_type type,
+					  const char *name)
 {
 	struct symbol *s = symbols__find_by_name(&dso->symbol_names[type], name,
 						 SYMBOL_TAG_INCLUDE__NONE);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 924f465307b1..2b985ff2e725 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -262,10 +262,14 @@ int dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map);
 void dso__insert_symbol(struct dso *dso, enum map_type type,
 			struct symbol *sym);
 
-struct symbol *dso__find_symbol(struct dso *dso, enum map_type type,
-				u64 addr);
-struct symbol *dso__find_symbol_by_name(struct dso *dso, enum map_type type,
-					const char *name);
+struct symbol *__dso__find_symbol(struct dso *dso, enum map_type type, u64 addr);
+struct symbol *__dso__find_symbol_by_name(struct dso *dso, enum map_type type, const char *name);
+
+static inline struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
+{
+	return __dso__find_symbol(dso, MAP__FUNCTION, addr);
+}
+
 struct symbol *symbol__next_by_name(struct symbol *sym);
 
 struct symbol *dso__first_symbol(struct dso *dso);
-- 
2.14.3
