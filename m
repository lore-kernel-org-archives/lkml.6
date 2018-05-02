Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbeEBRxJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:53:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40793 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeEBRxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:53:06 -0400
Date: Wed, 2 May 2018 10:52:55 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-sm72zwt1f03ma5uw78l6zze0@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        dsahern@gmail.com, hpa@zytor.com, mingo@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, acme@redhat.com,
        wangnan0@huawei.com
Reply-To: acme@redhat.com, wangnan0@huawei.com, adrian.hunter@intel.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org, dsahern@gmail.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Shorten dso__(first|last)_symbol()
Git-Commit-ID: 5cf88a6325ad75efe4f01204086d216b5d7f1ea8
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

Commit-ID:  5cf88a6325ad75efe4f01204086d216b5d7f1ea8
Gitweb:     https://git.kernel.org/tip/5cf88a6325ad75efe4f01204086d216b5d7f1ea8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 17:01:46 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:13 -0300

perf symbols: Shorten dso__(first|last)_symbol()

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
