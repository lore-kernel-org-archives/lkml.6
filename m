Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeCXUDa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753031AbeCXUD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:03:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81D82172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/44] perf annotate: Stop using a global config struct
Date: Sat, 24 Mar 2018 17:01:36 -0300
Message-Id: <20180324200211.21326-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For the TUI, that is interactive, its interesting to have a
configuration that one can go on changing and then when moving from one
symbol annotation to another symbol, the options set while browsing the
first symbol to be kept.

But since we're trying to make this code reusable by a --stdio
formatter, we better have a pointer in struct annotation and in the TUI
case set it to the global, but use something else for other cases, such
as --stdio2.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kv1ngr159jfu5h9ddgiuwcvg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 84 +++++++++++++++++++++++----------------
 tools/perf/util/annotate.h        |  1 +
 2 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8a110765b328..b20e0ae72466 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -63,10 +63,12 @@ static inline struct browser_line *browser_line(struct annotation_line *al)
 	return ptr - sizeof(struct browser_line);
 }
 
-static bool disasm_line__filter(struct ui_browser *browser __maybe_unused,
-				void *entry)
+static bool disasm_line__filter(struct ui_browser *browser, void *entry)
 {
-	if (annotate_browser__opts.hide_src_code) {
+	struct map_symbol *ms = browser->priv;
+	struct annotation *notes = symbol__annotation(ms->sym);
+
+	if (notes->options->hide_src_code) {
 		struct annotation_line *al = list_entry(entry, struct annotation_line, node);
 
 		return al->offset == -1;
@@ -98,12 +100,15 @@ static int annotate_browser__pcnt_width(struct annotate_browser *ab)
 {
 	struct map_symbol *ms = ab->b.priv;
 	struct annotation *notes = symbol__annotation(ms->sym);
-	return (annotate_browser__opts.show_total_period ? 12 : 7) * notes->nr_events;
+	return (notes->options->show_total_period ? 12 : 7) * notes->nr_events;
 }
 
 static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browser,
 			       char *bf, size_t size)
 {
+	struct map_symbol *ms = browser->priv;
+	struct annotation *notes = symbol__annotation(ms->sym);
+
 	if (dl->ins.ops && dl->ins.ops->scnprintf) {
 		if (ins__is_jump(&dl->ins)) {
 			bool fwd = dl->ops.target.offset > dl->al.offset;
@@ -124,7 +129,7 @@ static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browse
 		ui_browser__write_nstring(browser, " ", 2);
 	}
 
-	disasm_line__scnprintf(dl, bf, size, !annotate_browser__opts.use_offset);
+	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset);
 }
 
 static void annotate_browser__write(struct ui_browser *browser, void *entry, int row)
@@ -136,7 +141,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	struct annotation_line *al = list_entry(entry, struct annotation_line, node);
 	struct browser_line *bl = browser_line(al);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
-	bool change_color = (!annotate_browser__opts.hide_src_code &&
+	bool change_color = (!notes->options->hide_src_code &&
 			     (!current_entry || (browser->use_navkeypressed &&
 					         !browser->navkeypressed)));
 	int width = browser->width, printed;
@@ -164,10 +169,10 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			ui_browser__set_percent_color(browser,
 						al->samples[i].percent,
 						current_entry);
-			if (annotate_browser__opts.show_total_period) {
+			if (notes->options->show_total_period) {
 				ui_browser__printf(browser, "%11" PRIu64 " ",
 						   al->samples[i].he.period);
-			} else if (annotate_browser__opts.show_nr_samples) {
+			} else if (notes->options->show_nr_samples) {
 				ui_browser__printf(browser, "%6" PRIu64 " ",
 						   al->samples[i].he.nr_samples);
 			} else {
@@ -182,8 +187,8 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			ui_browser__write_nstring(browser, " ", pcnt_width);
 		else {
 			ui_browser__printf(browser, "%*s", pcnt_width,
-					   annotate_browser__opts.show_total_period ? "Period" :
-					   annotate_browser__opts.show_nr_samples ? "Samples" : "Percent");
+					   notes->options->show_total_period ? "Period" :
+					   notes->options->show_nr_samples ? "Samples" : "Percent");
 		}
 	}
 	if (notes->have_cycles) {
@@ -212,7 +217,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (!*al->line)
 		ui_browser__write_nstring(browser, " ", width - pcnt_width - cycles_width);
 	else if (al->offset == -1) {
-		if (al->line_nr && annotate_browser__opts.show_linenr)
+		if (al->line_nr && notes->options->show_linenr)
 			printed = scnprintf(bf, sizeof(bf), "%-*d ",
 					ab->addr_width + 1, al->line_nr);
 		else
@@ -224,14 +229,14 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		u64 addr = al->offset;
 		int color = -1;
 
-		if (!annotate_browser__opts.use_offset)
+		if (!notes->options->use_offset)
 			addr += ab->start;
 
-		if (!annotate_browser__opts.use_offset) {
+		if (!notes->options->use_offset) {
 			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
 		} else {
 			if (bl->jump_sources) {
-				if (annotate_browser__opts.show_nr_jumps) {
+				if (notes->options->show_nr_jumps) {
 					int prev;
 					printed = scnprintf(bf, sizeof(bf), "%*d ",
 							    ab->jumps_width,
@@ -345,7 +350,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	bcursor = browser_line(&cursor->al);
 	btarget = browser_line(target);
 
-	if (annotate_browser__opts.hide_src_code) {
+	if (notes->options->hide_src_code) {
 		from = bcursor->idx_asm;
 		to = btarget->idx_asm;
 	} else {
@@ -371,10 +376,12 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
+	struct map_symbol *ms = browser->priv;
+	struct annotation *notes = symbol__annotation(ms->sym);
 	int ret = ui_browser__list_head_refresh(browser);
 	int pcnt_width = annotate_browser__pcnt_width(ab);
 
-	if (annotate_browser__opts.jump_arrows)
+	if (notes->options->jump_arrows)
 		annotate_browser__draw_current_jump(browser);
 
 	ui_browser__set_color(browser, HE_COLORSET_NORMAL);
@@ -439,6 +446,8 @@ static void annotate_browser__set_top(struct annotate_browser *browser,
 static void annotate_browser__set_rb_top(struct annotate_browser *browser,
 					 struct rb_node *nd)
 {
+	struct map_symbol *ms = browser->b.priv;
+	struct annotation *notes = symbol__annotation(ms->sym);
 	struct browser_line *bpos;
 	struct annotation_line *pos;
 	u32 idx;
@@ -447,7 +456,7 @@ static void annotate_browser__set_rb_top(struct annotate_browser *browser,
 	bpos = browser_line(pos);
 
 	idx = bpos->idx;
-	if (annotate_browser__opts.hide_src_code)
+	if (notes->options->hide_src_code)
 		idx = bpos->idx_asm;
 	annotate_browser__set_top(browser, pos, idx);
 	browser->curr_hot = nd;
@@ -496,6 +505,8 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 
 static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 {
+	struct map_symbol *ms = browser->b.priv;
+	struct annotation *notes = symbol__annotation(ms->sym);
 	struct annotation_line *al;
 	struct browser_line *bl;
 	off_t offset = browser->b.index - browser->b.top_idx;
@@ -504,12 +515,12 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 	al = list_entry(browser->b.top, struct annotation_line, node);
 	bl = browser_line(al);
 
-	if (annotate_browser__opts.hide_src_code) {
+	if (notes->options->hide_src_code) {
 		if (bl->idx_asm < offset)
 			offset = bl->idx;
 
 		browser->b.nr_entries = browser->nr_entries;
-		annotate_browser__opts.hide_src_code = false;
+		notes->options->hide_src_code = false;
 		browser->b.seek(&browser->b, -offset, SEEK_CUR);
 		browser->b.top_idx = bl->idx - offset;
 		browser->b.index = bl->idx;
@@ -524,7 +535,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 			offset = bl->idx_asm;
 
 		browser->b.nr_entries = browser->nr_asm_entries;
-		annotate_browser__opts.hide_src_code = true;
+		notes->options->hide_src_code = true;
 		browser->b.seek(&browser->b, -offset, SEEK_CUR);
 		browser->b.top_idx = bl->idx_asm - offset;
 		browser->b.index = bl->idx_asm;
@@ -750,14 +761,17 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 
 static void annotate_browser__update_addr_width(struct annotate_browser *browser)
 {
-	if (annotate_browser__opts.use_offset)
+	struct map_symbol *ms = browser->b.priv;
+	struct annotation *notes = symbol__annotation(ms->sym);
+
+	if (notes->options->use_offset)
 		browser->target_width = browser->min_addr_width;
 	else
 		browser->target_width = browser->max_addr_width;
 
 	browser->addr_width = browser->target_width;
 
-	if (annotate_browser__opts.show_nr_jumps)
+	if (notes->options->show_nr_jumps)
 		browser->addr_width += browser->jumps_width + 1;
 }
 
@@ -768,6 +782,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 	struct rb_node *nd = NULL;
 	struct map_symbol *ms = browser->b.priv;
 	struct symbol *sym = ms->sym;
+	struct annotation *notes = symbol__annotation(ms->sym);
 	const char *help = "Press 'h' for help on key bindings";
 	int delay_secs = hbt ? hbt->refresh : 0;
 	int key;
@@ -851,8 +866,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				continue;
 			}
 		case 'k':
-			annotate_browser__opts.show_linenr =
-				!annotate_browser__opts.show_linenr;
+			notes->options->show_linenr = !notes->options->show_linenr;
 			break;
 		case 'H':
 			nd = browser->curr_hot;
@@ -862,14 +876,14 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				ui_helpline__puts(help);
 			continue;
 		case 'o':
-			annotate_browser__opts.use_offset = !annotate_browser__opts.use_offset;
+			notes->options->use_offset = !notes->options->use_offset;
 			annotate_browser__update_addr_width(browser);
 			continue;
 		case 'j':
-			annotate_browser__opts.jump_arrows = !annotate_browser__opts.jump_arrows;
+			notes->options->jump_arrows = !notes->options->jump_arrows;
 			continue;
 		case 'J':
-			annotate_browser__opts.show_nr_jumps = !annotate_browser__opts.show_nr_jumps;
+			notes->options->show_nr_jumps = !notes->options->show_nr_jumps;
 			annotate_browser__update_addr_width(browser);
 			continue;
 		case '/':
@@ -920,13 +934,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		}
 		case 't':
-			if (annotate_browser__opts.show_total_period) {
-				annotate_browser__opts.show_total_period = false;
-				annotate_browser__opts.show_nr_samples = true;
-			} else if (annotate_browser__opts.show_nr_samples)
-				annotate_browser__opts.show_nr_samples = false;
+			if (notes->options->show_total_period) {
+				notes->options->show_total_period = false;
+				notes->options->show_nr_samples = true;
+			} else if (notes->options->show_nr_samples)
+				notes->options->show_nr_samples = false;
 			else
-				annotate_browser__opts.show_total_period = true;
+				notes->options->show_total_period = true;
 			annotate_browser__update_addr_width(browser);
 			continue;
 		case K_LEFT:
@@ -1048,6 +1062,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
+	notes->options = &annotate_browser__opts;
+
 	notes->offsets = zalloc(size * sizeof(struct annotation_line *));
 	if (notes->offsets == NULL) {
 		ui__error("Not enough memory!");
@@ -1105,7 +1121,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	browser.b.entries = &notes->src->source,
 	browser.b.width += 18; /* Percentage */
 
-	if (annotate_browser__opts.hide_src_code)
+	if (notes->options->hide_src_code)
 		annotate_browser__init_asm_mode(&browser);
 
 	annotate_browser__update_addr_width(&browser);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5d15cdf22fc9..5936605b5dac 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -164,6 +164,7 @@ struct annotated_source {
 struct annotation {
 	pthread_mutex_t		lock;
 	u64			max_coverage;
+	struct annotation_options *options;
 	struct annotation_line	**offsets;
 	int			nr_events;
 	bool			have_cycles;
-- 
2.14.3
