Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0688CC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B742A217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfAZKEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:04:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38703 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:03:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QA3nSh511238
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:03:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QA3nMb511235;
        Sat, 26 Jan 2019 02:03:49 -0800
Date:   Sat, 26 Jan 2019 02:03:49 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-7137ff50b68a48bc28270c91b1c313259ab0c1c4@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
        tglx@linutronix.de, dave@stgolabs.net, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, dbueso@suse.de, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, dbueso@suse.de, hpa@zytor.com,
          mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
          tglx@linutronix.de, dave@stgolabs.net, namhyung@kernel.org
In-Reply-To: <20181206191819.30182-6-dave@stgolabs.net>
References: <20181206191819.30182-6-dave@stgolabs.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Use cached rbtrees
Git-Commit-ID: 7137ff50b68a48bc28270c91b1c313259ab0c1c4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7137ff50b68a48bc28270c91b1c313259ab0c1c4
Gitweb:     https://git.kernel.org/tip/7137ff50b68a48bc28270c91b1c313259ab0c1c4
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Thu, 6 Dec 2018 11:18:17 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:10 +0100

perf symbols: Use cached rbtrees

At the cost of an extra pointer, we can avoid the O(logN) cost of
finding the first element in the tree (smallest node).

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181206191819.30182-6-dave@stgolabs.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c    |  2 +-
 tools/perf/util/dso.c            |  4 +-
 tools/perf/util/dso.h            |  6 +--
 tools/perf/util/map.c            |  8 ++--
 tools/perf/util/probe-event.c    |  3 +-
 tools/perf/util/symbol.c         | 87 ++++++++++++++++++++++------------------
 tools/perf/util/symbol.h         | 13 +++---
 tools/perf/util/symbol_fprintf.c |  2 +-
 8 files changed, 67 insertions(+), 58 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 93d679eaf1f4..cc3da5564300 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -227,7 +227,7 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
 		 * the DSO?
 		 */
 		if (al->sym != NULL) {
-			rb_erase(&al->sym->rb_node,
+			rb_erase_cached(&al->sym->rb_node,
 				 &al->map->dso->symbols);
 			symbol__delete(al->sym);
 			dso__reset_find_symbol_cache(al->map->dso);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 9ec4b2e6d4ac..a8a54115b115 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1197,7 +1197,7 @@ struct dso *dso__new(const char *name)
 		strcpy(dso->name, name);
 		dso__set_long_name(dso, dso->name, false);
 		dso__set_short_name(dso, dso->name, false);
-		dso->symbols = dso->symbol_names = RB_ROOT;
+		dso->symbols = dso->symbol_names = RB_ROOT_CACHED;
 		dso->data.cache = RB_ROOT;
 		dso->inlined_nodes = RB_ROOT_CACHED;
 		dso->srclines = RB_ROOT_CACHED;
@@ -1469,7 +1469,7 @@ size_t dso__fprintf(struct dso *dso, FILE *fp)
 	ret += fprintf(fp, "%sloaded, ", dso__loaded(dso) ? "" : "NOT ");
 	ret += dso__fprintf_buildid(dso, fp);
 	ret += fprintf(fp, ")\n");
-	for (nd = rb_first(&dso->symbols); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&dso->symbols); nd; nd = rb_next(nd)) {
 		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
 		ret += symbol__fprintf(pos, fp);
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 40edfb375a8b..bb417c54c25a 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -141,8 +141,8 @@ struct dso {
 	struct list_head node;
 	struct rb_node	 rb_node;	/* rbtree node sorted by long name */
 	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
-	struct rb_root	 symbols;
-	struct rb_root	 symbol_names;
+	struct rb_root_cached symbols;
+	struct rb_root_cached symbol_names;
 	struct rb_root_cached inlined_nodes;
 	struct rb_root_cached srclines;
 	struct {
@@ -236,7 +236,7 @@ bool dso__loaded(const struct dso *dso);
 
 static inline bool dso__has_symbols(const struct dso *dso)
 {
-	return !RB_EMPTY_ROOT(&dso->symbols);
+	return !RB_EMPTY_ROOT(&dso->symbols.rb_root);
 }
 
 bool dso__sorted_by_name(const struct dso *dso);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6751301a755c..cf407cc9d915 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -286,8 +286,8 @@ void map__put(struct map *map)
 
 void map__fixup_start(struct map *map)
 {
-	struct rb_root *symbols = &map->dso->symbols;
-	struct rb_node *nd = rb_first(symbols);
+	struct rb_root_cached *symbols = &map->dso->symbols;
+	struct rb_node *nd = rb_first_cached(symbols);
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
 		map->start = sym->start;
@@ -296,8 +296,8 @@ void map__fixup_start(struct map *map)
 
 void map__fixup_end(struct map *map)
 {
-	struct rb_root *symbols = &map->dso->symbols;
-	struct rb_node *nd = rb_last(symbols);
+	struct rb_root_cached *symbols = &map->dso->symbols;
+	struct rb_node *nd = rb_last(&symbols->rb_root);
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
 		map->end = sym->end;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 736787a18b9e..4008f0cc36e5 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3529,7 +3529,8 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
 	/* Show all (filtered) symbols */
 	setup_pager();
 
-	for (nd = rb_first(&map->dso->symbol_names); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&map->dso->symbol_names); nd;
+	     nd = rb_next(nd)) {
 		struct symbol_name_rb_node *pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
 
 		if (strfilter__compare(_filter, pos->sym.name))
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 48efad6d0f90..bcbcbd610460 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -163,7 +163,7 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	return arch__choose_best_symbol(syma, symb);
 }
 
-void symbols__fixup_duplicate(struct rb_root *symbols)
+void symbols__fixup_duplicate(struct rb_root_cached *symbols)
 {
 	struct rb_node *nd;
 	struct symbol *curr, *next;
@@ -171,7 +171,7 @@ void symbols__fixup_duplicate(struct rb_root *symbols)
 	if (symbol_conf.allow_aliases)
 		return;
 
-	nd = rb_first(symbols);
+	nd = rb_first_cached(symbols);
 
 	while (nd) {
 		curr = rb_entry(nd, struct symbol, rb_node);
@@ -186,20 +186,20 @@ again:
 			continue;
 
 		if (choose_best_symbol(curr, next) == SYMBOL_A) {
-			rb_erase(&next->rb_node, symbols);
+			rb_erase_cached(&next->rb_node, symbols);
 			symbol__delete(next);
 			goto again;
 		} else {
 			nd = rb_next(&curr->rb_node);
-			rb_erase(&curr->rb_node, symbols);
+			rb_erase_cached(&curr->rb_node, symbols);
 			symbol__delete(curr);
 		}
 	}
 }
 
-void symbols__fixup_end(struct rb_root *symbols)
+void symbols__fixup_end(struct rb_root_cached *symbols)
 {
-	struct rb_node *nd, *prevnd = rb_first(symbols);
+	struct rb_node *nd, *prevnd = rb_first_cached(symbols);
 	struct symbol *curr, *prev;
 
 	if (prevnd == NULL)
@@ -282,25 +282,27 @@ void symbol__delete(struct symbol *sym)
 	free(((void *)sym) - symbol_conf.priv_size);
 }
 
-void symbols__delete(struct rb_root *symbols)
+void symbols__delete(struct rb_root_cached *symbols)
 {
 	struct symbol *pos;
-	struct rb_node *next = rb_first(symbols);
+	struct rb_node *next = rb_first_cached(symbols);
 
 	while (next) {
 		pos = rb_entry(next, struct symbol, rb_node);
 		next = rb_next(&pos->rb_node);
-		rb_erase(&pos->rb_node, symbols);
+		rb_erase_cached(&pos->rb_node, symbols);
 		symbol__delete(pos);
 	}
 }
 
-void __symbols__insert(struct rb_root *symbols, struct symbol *sym, bool kernel)
+void __symbols__insert(struct rb_root_cached *symbols,
+		       struct symbol *sym, bool kernel)
 {
-	struct rb_node **p = &symbols->rb_node;
+	struct rb_node **p = &symbols->rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	const u64 ip = sym->start;
 	struct symbol *s;
+	bool leftmost = true;
 
 	if (kernel) {
 		const char *name = sym->name;
@@ -318,26 +320,28 @@ void __symbols__insert(struct rb_root *symbols, struct symbol *sym, bool kernel)
 		s = rb_entry(parent, struct symbol, rb_node);
 		if (ip < s->start)
 			p = &(*p)->rb_left;
-		else
+		else {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 	}
 	rb_link_node(&sym->rb_node, parent, p);
-	rb_insert_color(&sym->rb_node, symbols);
+	rb_insert_color_cached(&sym->rb_node, symbols, leftmost);
 }
 
-void symbols__insert(struct rb_root *symbols, struct symbol *sym)
+void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
 	__symbols__insert(symbols, sym, false);
 }
 
-static struct symbol *symbols__find(struct rb_root *symbols, u64 ip)
+static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
 {
 	struct rb_node *n;
 
 	if (symbols == NULL)
 		return NULL;
 
-	n = symbols->rb_node;
+	n = symbols->rb_root.rb_node;
 
 	while (n) {
 		struct symbol *s = rb_entry(n, struct symbol, rb_node);
@@ -353,9 +357,9 @@ static struct symbol *symbols__find(struct rb_root *symbols, u64 ip)
 	return NULL;
 }
 
-static struct symbol *symbols__first(struct rb_root *symbols)
+static struct symbol *symbols__first(struct rb_root_cached *symbols)
 {
-	struct rb_node *n = rb_first(symbols);
+	struct rb_node *n = rb_first_cached(symbols);
 
 	if (n)
 		return rb_entry(n, struct symbol, rb_node);
@@ -363,9 +367,9 @@ static struct symbol *symbols__first(struct rb_root *symbols)
 	return NULL;
 }
 
-static struct symbol *symbols__last(struct rb_root *symbols)
+static struct symbol *symbols__last(struct rb_root_cached *symbols)
 {
-	struct rb_node *n = rb_last(symbols);
+	struct rb_node *n = rb_last(&symbols->rb_root);
 
 	if (n)
 		return rb_entry(n, struct symbol, rb_node);
@@ -383,11 +387,12 @@ static struct symbol *symbols__next(struct symbol *sym)
 	return NULL;
 }
 
-static void symbols__insert_by_name(struct rb_root *symbols, struct symbol *sym)
+static void symbols__insert_by_name(struct rb_root_cached *symbols, struct symbol *sym)
 {
-	struct rb_node **p = &symbols->rb_node;
+	struct rb_node **p = &symbols->rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	struct symbol_name_rb_node *symn, *s;
+	bool leftmost = true;
 
 	symn = container_of(sym, struct symbol_name_rb_node, sym);
 
@@ -396,19 +401,21 @@ static void symbols__insert_by_name(struct rb_root *symbols, struct symbol *sym)
 		s = rb_entry(parent, struct symbol_name_rb_node, rb_node);
 		if (strcmp(sym->name, s->sym.name) < 0)
 			p = &(*p)->rb_left;
-		else
+		else {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 	}
 	rb_link_node(&symn->rb_node, parent, p);
-	rb_insert_color(&symn->rb_node, symbols);
+	rb_insert_color_cached(&symn->rb_node, symbols, leftmost);
 }
 
-static void symbols__sort_by_name(struct rb_root *symbols,
-				  struct rb_root *source)
+static void symbols__sort_by_name(struct rb_root_cached *symbols,
+				  struct rb_root_cached *source)
 {
 	struct rb_node *nd;
 
-	for (nd = rb_first(source); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(source); nd; nd = rb_next(nd)) {
 		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
 		symbols__insert_by_name(symbols, pos);
 	}
@@ -431,7 +438,7 @@ int symbol__match_symbol_name(const char *name, const char *str,
 		return arch__compare_symbol_names(name, str);
 }
 
-static struct symbol *symbols__find_by_name(struct rb_root *symbols,
+static struct symbol *symbols__find_by_name(struct rb_root_cached *symbols,
 					    const char *name,
 					    enum symbol_tag_include includes)
 {
@@ -441,7 +448,7 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
 	if (symbols == NULL)
 		return NULL;
 
-	n = symbols->rb_node;
+	n = symbols->rb_root.rb_node;
 
 	while (n) {
 		int cmp;
@@ -644,7 +651,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 {
 	struct symbol *sym;
 	struct dso *dso = arg;
-	struct rb_root *root = &dso->symbols;
+	struct rb_root_cached *root = &dso->symbols;
 
 	if (!symbol_type__filter(type))
 		return 0;
@@ -681,14 +688,14 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
 	struct map *curr_map;
 	struct symbol *pos;
 	int count = 0;
-	struct rb_root old_root = dso->symbols;
-	struct rb_root *root = &dso->symbols;
-	struct rb_node *next = rb_first(root);
+	struct rb_root_cached old_root = dso->symbols;
+	struct rb_root_cached *root = &dso->symbols;
+	struct rb_node *next = rb_first_cached(root);
 
 	if (!kmaps)
 		return -1;
 
-	*root = RB_ROOT;
+	*root = RB_ROOT_CACHED;
 
 	while (next) {
 		char *module;
@@ -696,8 +703,8 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
 		pos = rb_entry(next, struct symbol, rb_node);
 		next = rb_next(&pos->rb_node);
 
-		rb_erase_init(&pos->rb_node, &old_root);
-
+		rb_erase_cached(&pos->rb_node, &old_root);
+		RB_CLEAR_NODE(&pos->rb_node);
 		module = strchr(pos->name, '\t');
 		if (module)
 			*module = '\0';
@@ -734,8 +741,8 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 	struct map *curr_map = initial_map;
 	struct symbol *pos;
 	int count = 0, moved = 0;
-	struct rb_root *root = &dso->symbols;
-	struct rb_node *next = rb_first(root);
+	struct rb_root_cached *root = &dso->symbols;
+	struct rb_node *next = rb_first_cached(root);
 	int kernel_range = 0;
 	bool x86_64;
 
@@ -849,7 +856,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 		}
 add_symbol:
 		if (curr_map != initial_map) {
-			rb_erase(&pos->rb_node, root);
+			rb_erase_cached(&pos->rb_node, root);
 			symbols__insert(&curr_map->dso->symbols, pos);
 			++moved;
 		} else
@@ -857,7 +864,7 @@ add_symbol:
 
 		continue;
 discard_symbol:
-		rb_erase(&pos->rb_node, root);
+		rb_erase_cached(&pos->rb_node, root);
 		symbol__delete(pos);
 	}
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 2162a5d9b3ac..56e2bcb907cc 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -68,7 +68,7 @@ struct symbol {
 };
 
 void symbol__delete(struct symbol *sym);
-void symbols__delete(struct rb_root *symbols);
+void symbols__delete(struct rb_root_cached *symbols);
 
 /* symbols__for_each_entry - iterate over symbols (rb_root)
  *
@@ -77,7 +77,7 @@ void symbols__delete(struct rb_root *symbols);
  * @nd: the 'struct rb_node *' to use as a temporary storage
  */
 #define symbols__for_each_entry(symbols, pos, nd)			\
-	for (nd = rb_first(symbols);					\
+	for (nd = rb_first_cached(symbols);					\
 	     nd && (pos = rb_entry(nd, struct symbol, rb_node));	\
 	     nd = rb_next(nd))
 
@@ -247,10 +247,11 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
-void __symbols__insert(struct rb_root *symbols, struct symbol *sym, bool kernel);
-void symbols__insert(struct rb_root *symbols, struct symbol *sym);
-void symbols__fixup_duplicate(struct rb_root *symbols);
-void symbols__fixup_end(struct rb_root *symbols);
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
+		       bool kernel);
+void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
+void symbols__fixup_duplicate(struct rb_root_cached *symbols);
+void symbols__fixup_end(struct rb_root_cached *symbols);
 void map_groups__fixup_end(struct map_groups *mg);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 50472c75da59..02e89b02c2ce 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -65,7 +65,7 @@ size_t dso__fprintf_symbols_by_name(struct dso *dso,
 	struct rb_node *nd;
 	struct symbol_name_rb_node *pos;
 
-	for (nd = rb_first(&dso->symbol_names); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&dso->symbol_names); nd; nd = rb_next(nd)) {
 		pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
 		fprintf(fp, "%s\n", pos->sym.name);
 	}
