Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290ABC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DD3208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DD3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeLFTTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:19:06 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:33915 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeLFTSl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 6 Dec 2018 14:18:41 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 12:18:32 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 5/7] perf symbols: Use cached rbtrees
Date:   Thu,  6 Dec 2018 11:18:17 -0800
Message-Id: <20181206191819.30182-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181206191819.30182-1-dave@stgolabs.net>
References: <20181206191819.30182-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the cost of an extra pointer, we can avoid the O(logN) cost
of finding the first element in the tree (smallest node).

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
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
index 31edcc1d8661..6f9ddd6b6e23 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1195,7 +1195,7 @@ struct dso *dso__new(const char *name)
 		strcpy(dso->name, name);
 		dso__set_long_name(dso, dso->name, false);
 		dso__set_short_name(dso, dso->name, false);
-		dso->symbols = dso->symbol_names = RB_ROOT;
+		dso->symbols = dso->symbol_names = RB_ROOT_CACHED;
 		dso->data.cache = RB_ROOT;
 		dso->inlined_nodes = RB_ROOT_CACHED;
 		dso->srclines = RB_ROOT_CACHED;
@@ -1467,7 +1467,7 @@ size_t dso__fprintf(struct dso *dso, FILE *fp)
 	ret += fprintf(fp, "%sloaded, ", dso__loaded(dso) ? "" : "NOT ");
 	ret += dso__fprintf_buildid(dso, fp);
 	ret += fprintf(fp, ")\n");
-	for (nd = rb_first(&dso->symbols); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&dso->symbols); nd; nd = rb_next(nd)) {
 		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
 		ret += symbol__fprintf(pos, fp);
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 935fe99b38a8..53130b78cd37 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -140,8 +140,8 @@ struct dso {
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
@@ -235,7 +235,7 @@ bool dso__loaded(const struct dso *dso);
 
 static inline bool dso__has_symbols(const struct dso *dso)
 {
-	return !RB_EMPTY_ROOT(&dso->symbols);
+	return !RB_EMPTY_ROOT(&dso->symbols.rb_root);
 }
 
 bool dso__sorted_by_name(const struct dso *dso);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 781eed8e3265..e2d34c1ae07d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -285,8 +285,8 @@ void map__put(struct map *map)
 
 void map__fixup_start(struct map *map)
 {
-	struct rb_root *symbols = &map->dso->symbols;
-	struct rb_node *nd = rb_first(symbols);
+	struct rb_root_cached *symbols = &map->dso->symbols;
+	struct rb_node *nd = rb_first_cached(symbols);
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
 		map->start = sym->start;
@@ -295,8 +295,8 @@ void map__fixup_start(struct map *map)
 
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
index e86f8be89157..eaf91648b713 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3528,7 +3528,8 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
 	/* Show all (filtered) symbols */
 	setup_pager();
 
-	for (nd = rb_first(&map->dso->symbol_names); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&map->dso->symbol_names); nd;
+	     nd = rb_next(nd)) {
 		struct symbol_name_rb_node *pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
 
 		if (strfilter__compare(_filter, pos->sym.name))
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dcce74bae6de..81dd498453ca 100644
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
@@ -186,20 +186,20 @@ void symbols__fixup_duplicate(struct rb_root *symbols)
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
@@ -643,7 +650,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 {
 	struct symbol *sym;
 	struct dso *dso = arg;
-	struct rb_root *root = &dso->symbols;
+	struct rb_root_cached *root = &dso->symbols;
 
 	if (!symbol_type__filter(type))
 		return 0;
@@ -680,14 +687,14 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
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
@@ -695,8 +702,8 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
 		pos = rb_entry(next, struct symbol, rb_node);
 		next = rb_next(&pos->rb_node);
 
-		rb_erase_init(&pos->rb_node, &old_root);
-
+		rb_erase_cached(&pos->rb_node, &old_root);
+		RB_CLEAR_NODE(&pos->rb_node);
 		module = strchr(pos->name, '\t');
 		if (module)
 			*module = '\0';
@@ -733,8 +740,8 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 	struct map *curr_map = initial_map;
 	struct symbol *pos;
 	int count = 0, moved = 0;
-	struct rb_root *root = &dso->symbols;
-	struct rb_node *next = rb_first(root);
+	struct rb_root_cached *root = &dso->symbols;
+	struct rb_node *next = rb_first_cached(root);
 	int kernel_range = 0;
 	bool x86_64;
 
@@ -848,7 +855,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 		}
 add_symbol:
 		if (curr_map != initial_map) {
-			rb_erase(&pos->rb_node, root);
+			rb_erase_cached(&pos->rb_node, root);
 			symbols__insert(&curr_map->dso->symbols, pos);
 			++moved;
 		} else
@@ -856,7 +863,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 
 		continue;
 discard_symbol:
-		rb_erase(&pos->rb_node, root);
+		rb_erase_cached(&pos->rb_node, root);
 		symbol__delete(pos);
 	}
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d026d215bdc6..e21ba7299632 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -67,7 +67,7 @@ struct symbol {
 };
 
 void symbol__delete(struct symbol *sym);
-void symbols__delete(struct rb_root *symbols);
+void symbols__delete(struct rb_root_cached *symbols);
 
 /* symbols__for_each_entry - iterate over symbols (rb_root)
  *
@@ -76,7 +76,7 @@ void symbols__delete(struct rb_root *symbols);
  * @nd: the 'struct rb_node *' to use as a temporary storage
  */
 #define symbols__for_each_entry(symbols, pos, nd)			\
-	for (nd = rb_first(symbols);					\
+	for (nd = rb_first_cached(symbols);					\
 	     nd && (pos = rb_entry(nd, struct symbol, rb_node));	\
 	     nd = rb_next(nd))
 
@@ -309,10 +309,11 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
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
index ed0205cc7942..a86f89f357d9 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -64,7 +64,7 @@ size_t dso__fprintf_symbols_by_name(struct dso *dso,
 	struct rb_node *nd;
 	struct symbol_name_rb_node *pos;
 
-	for (nd = rb_first(&dso->symbol_names); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&dso->symbol_names); nd; nd = rb_next(nd)) {
 		pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
 		fprintf(fp, "%s\n", pos->sym.name);
 	}
-- 
2.16.4

