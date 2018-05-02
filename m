Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbeEBP2J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752052AbeEBPV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:26 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 27/52] perf symbols: Shorten dso__(first|last)_symbol()
Date: Wed,  2 May 2018 12:19:17 -0300
Message-Id: <20180502151942.20542-28-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

All users want MAP__FUNCTION, and this split is going away.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-sm72zwt1f03ma5uw78l6zze0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c |  8 ++++----
 tools/perf/util/intel-pt.c |  2 +-
 tools/perf/util/symbol.c   | 16 +++++++++++++---
 tools/perf/util/symbol.h   |  4 ++--
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 857de69a5361..eaf1e10ae755 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1915,7 +1915,7 @@ static void print_duplicate_syms(struct dso *dso, const char *sym_name)
 
 	pr_err("Multiple symbols with name '%s'\n", sym_name);
 
-	sym = dso__first_symbol(dso, MAP__FUNCTION);
+	sym = dso__first_symbol(dso);
 	while (sym) {
 		if (dso_sym_match(sym, sym_name, &cnt, -1)) {
 			pr_err("#%d\t0x%"PRIx64"\t%c\t%s\n",
@@ -1945,7 +1945,7 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 	*start = 0;
 	*size = 0;
 
-	sym = dso__first_symbol(dso, MAP__FUNCTION);
+	sym = dso__first_symbol(dso);
 	while (sym) {
 		if (*start) {
 			if (!*size)
@@ -1972,8 +1972,8 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 
 static int addr_filter__entire_dso(struct addr_filter *filt, struct dso *dso)
 {
-	struct symbol *first_sym = dso__first_symbol(dso, MAP__FUNCTION);
-	struct symbol *last_sym = dso__last_symbol(dso, MAP__FUNCTION);
+	struct symbol *first_sym = dso__first_symbol(dso);
+	struct symbol *last_sym = dso__last_symbol(dso);
 
 	if (!first_sym || !last_sym) {
 		pr_err("Failed to determine filter for %s\nNo symbols found.\n",
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a272b35f6c5a..492986a25ef6 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1563,7 +1563,7 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 	if (map__load(map))
 		return 0;
 
-	start = dso__first_symbol(map->dso, MAP__FUNCTION);
+	start = dso__first_symbol(map->dso);
 
 	for (sym = start; sym; sym = dso__next_symbol(sym)) {
 		if (sym->binding == STB_GLOBAL &&
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 25701078beab..7aa32372f08c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -515,16 +515,26 @@ struct symbol *dso__find_symbol(struct dso *dso,
 	return dso->last_find_result[type].symbol;
 }
 
-struct symbol *dso__first_symbol(struct dso *dso, enum map_type type)
+static struct symbol *__dso__first_symbol(struct dso *dso, enum map_type type)
 {
 	return symbols__first(&dso->symbols[type]);
 }
 
-struct symbol *dso__last_symbol(struct dso *dso, enum map_type type)
+struct symbol *dso__first_symbol(struct dso *dso)
+{
+	return __dso__first_symbol(dso, MAP__FUNCTION);
+}
+
+static struct symbol *__dso__last_symbol(struct dso *dso, enum map_type type)
 {
 	return symbols__last(&dso->symbols[type]);
 }
 
+struct symbol *dso__last_symbol(struct dso *dso)
+{
+	return __dso__last_symbol(dso, MAP__FUNCTION);
+}
+
 struct symbol *dso__next_symbol(struct symbol *sym)
 {
 	return symbols__next(sym);
@@ -1218,7 +1228,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Find the kernel map using the first symbol */
-	sym = dso__first_symbol(dso, map->type);
+	sym = __dso__first_symbol(dso, map->type);
 	list_for_each_entry(new_map, &md.maps, node) {
 		if (sym && sym->start >= new_map->start &&
 		    sym->start < new_map->end) {
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 70c16741f50a..0e95d9478783 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -268,8 +268,8 @@ struct symbol *dso__find_symbol_by_name(struct dso *dso, enum map_type type,
 					const char *name);
 struct symbol *symbol__next_by_name(struct symbol *sym);
 
-struct symbol *dso__first_symbol(struct dso *dso, enum map_type type);
-struct symbol *dso__last_symbol(struct dso *dso, enum map_type type);
+struct symbol *dso__first_symbol(struct dso *dso);
+struct symbol *dso__last_symbol(struct dso *dso);
 struct symbol *dso__next_symbol(struct symbol *sym);
 
 enum dso_type dso__type_fd(int fd);
-- 
2.14.3
