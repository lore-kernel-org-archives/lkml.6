Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeFERvk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeFERvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:35 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 18/46] perf srcline: Introduce map__srcline() to make code more compact
Date: Tue,  5 Jun 2018 14:50:02 -0300
Message-Id: <20180605175030.32549-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Replacing a common open coded sequence.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2d7d1nzd3ksqornloqeer99r@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c  | 12 ++++++----
 tools/perf/util/map.h  |  1 +
 tools/perf/util/sort.c | 60 +++++++++++---------------------------------------
 3 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6ae97eda370b..92abc8e248c5 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -415,16 +415,20 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 	return fprintf(fp, "%s", dsoname);
 }
 
+char *map__srcline(struct map *map, u64 addr, struct symbol *sym)
+{
+	if (map == NULL)
+		return SRCLINE_UNKNOWN;
+	return get_srcline(map->dso, map__rip_2objdump(map, addr), sym, true, true, addr);
+}
+
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp)
 {
-	char *srcline;
 	int ret = 0;
 
 	if (map && map->dso) {
-		srcline = get_srcline(map->dso,
-				      map__rip_2objdump(map, addr), NULL,
-				      true, true, addr);
+		char *srcline = map__srcline(map, addr, NULL);
 		if (srcline != SRCLINE_UNKNOWN)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
 		free_srcline(srcline);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 97e2a063bd65..4cb90f242bed 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -169,6 +169,7 @@ static inline void __map__zput(struct map **map)
 int map__overlap(struct map *l, struct map *r);
 size_t map__fprintf(struct map *map, FILE *fp);
 size_t map__fprintf_dsoname(struct map *map, FILE *fp);
+char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 4058ade352a5..71096dbfeb88 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -333,13 +333,7 @@ struct sort_entry sort_sym = {
 
 char *hist_entry__get_srcline(struct hist_entry *he)
 {
-	struct map *map = he->ms.map;
-
-	if (!map)
-		return SRCLINE_UNKNOWN;
-
-	return get_srcline(map->dso, map__rip_2objdump(map, he->ip),
-			   he->ms.sym, true, true, he->ip);
+	return map__srcline(he->ms.map, he->ip, he->ms.sym);
 }
 
 static int64_t
@@ -375,28 +369,14 @@ static int64_t
 sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->branch_info->srcline_from) {
-		struct map *map = left->branch_info->from.map;
-		if (!map)
-			left->branch_info->srcline_from = SRCLINE_UNKNOWN;
-		else
-			left->branch_info->srcline_from = get_srcline(map->dso,
-					   map__rip_2objdump(map,
-							     left->branch_info->from.al_addr),
-							 left->branch_info->from.sym,
-							 true, true,
-							 left->branch_info->from.al_addr);
+		left->branch_info->srcline_from = map__srcline(left->branch_info->from.map,
+							       left->branch_info->from.al_addr,
+							       left->branch_info->from.sym);
 	}
 	if (!right->branch_info->srcline_from) {
-		struct map *map = right->branch_info->from.map;
-		if (!map)
-			right->branch_info->srcline_from = SRCLINE_UNKNOWN;
-		else
-			right->branch_info->srcline_from = get_srcline(map->dso,
-					     map__rip_2objdump(map,
-							       right->branch_info->from.al_addr),
-						     right->branch_info->from.sym,
-						     true, true,
-						     right->branch_info->from.al_addr);
+		right->branch_info->srcline_from = map__srcline(right->branch_info->from.map,
+								right->branch_info->from.al_addr,
+								right->branch_info->from.sym);
 	}
 	return strcmp(right->branch_info->srcline_from, left->branch_info->srcline_from);
 }
@@ -420,28 +400,14 @@ static int64_t
 sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->branch_info->srcline_to) {
-		struct map *map = left->branch_info->to.map;
-		if (!map)
-			left->branch_info->srcline_to = SRCLINE_UNKNOWN;
-		else
-			left->branch_info->srcline_to = get_srcline(map->dso,
-					   map__rip_2objdump(map,
-							     left->branch_info->to.al_addr),
-							 left->branch_info->from.sym,
-							 true, true,
-							 left->branch_info->to.al_addr);
+		left->branch_info->srcline_to = map__srcline(left->branch_info->to.map,
+							     left->branch_info->to.al_addr,
+							     left->branch_info->to.sym);
 	}
 	if (!right->branch_info->srcline_to) {
-		struct map *map = right->branch_info->to.map;
-		if (!map)
-			right->branch_info->srcline_to = SRCLINE_UNKNOWN;
-		else
-			right->branch_info->srcline_to = get_srcline(map->dso,
-					     map__rip_2objdump(map,
-							       right->branch_info->to.al_addr),
-						     right->branch_info->to.sym,
-						     true, true,
-						     right->branch_info->to.al_addr);
+		right->branch_info->srcline_to = map__srcline(right->branch_info->to.map,
+							      right->branch_info->to.al_addr,
+							      right->branch_info->to.sym);
 	}
 	return strcmp(right->branch_info->srcline_to, left->branch_info->srcline_to);
 }
-- 
2.14.3
