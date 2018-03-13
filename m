Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeCMGWp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:22:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:52838 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752151AbeCMGWj (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:22:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="scan'208";a="25162186"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 3/4] perf annotate: Process the new switch flag tui_dump
Date: Tue, 13 Mar 2018 22:16:53 +0800
Message-Id: <1520950614-22082-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
References: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tui_dump is created as a parameter and it will be finally passed to
symbol__tui_annotate() and be saved to browser.dump.

It's a switch for TUI routines to indicate if TUI output needs to be
dumped to stdio.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-annotate.c     |  2 +-
 tools/perf/ui/browsers/annotate.c | 41 +++++++++++++++++++++++++++------------
 tools/perf/ui/browsers/hists.c    |  2 +-
 tools/perf/util/annotate.h        |  6 ++++--
 tools/perf/util/hist.h            | 11 +++++++----
 5 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 2db5b50..8ba8e2c 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -334,7 +334,7 @@ static void hists__find_annotations(struct hists *hists,
 			/* skip missing symbols */
 			nd = rb_next(nd);
 		} else if (use_browser == 1) {
-			key = hist_entry__tui_annotate(he, evsel, NULL);
+			key = hist_entry__tui_annotate(he, evsel, NULL, false);
 
 			switch (key) {
 			case -1:
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 618edf9..bb7229d 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -122,7 +122,9 @@ static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browse
 			       char *bf, size_t size)
 {
 	if (dl->ins.ops && dl->ins.ops->scnprintf) {
-		if (ins__is_jump(&dl->ins)) {
+		if (browser->dump) {
+			ui_browser__write_nstring(browser, " ", 2);
+		} else if (ins__is_jump(&dl->ins)) {
 			bool fwd = dl->ops.target.offset > dl->al.offset;
 
 			ui_browser__write_graph(browser, fwd ? SLSMG_DARROW_CHAR :
@@ -217,7 +219,10 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			ui_browser__printf(browser, "%*s ", CYCLES_WIDTH - 1, "Cycle");
 	}
 
-	SLsmg_write_char(' ');
+	if (browser->dump)
+		putchar(' ');
+	else
+		SLsmg_write_char(' ');
 
 	/* The scroll bar isn't being used */
 	if (!browser->navkeypressed)
@@ -388,6 +393,9 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 	int ret = ui_browser__list_head_refresh(browser);
 	int pcnt_width = annotate_browser__pcnt_width(ab);
 
+	if (browser->dump)
+		return ret;
+
 	if (annotate_browser__opts.jump_arrows)
 		annotate_browser__draw_current_jump(browser);
 
@@ -589,7 +597,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	}
 
 	pthread_mutex_unlock(&notes->lock);
-	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt);
+	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt, false);
 	sym_title(ms->sym, ms->map, title, sizeof(title));
 	ui_browser__show_title(&browser->b, title);
 	return true;
@@ -961,7 +969,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 }
 
 int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt)
+			     struct hist_browser_timer *hbt, bool tui_dump)
 {
 	/* Set default value for show_total_period and show_nr_samples  */
 	annotate_browser__opts.show_total_period =
@@ -969,17 +977,19 @@ int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
 	annotate_browser__opts.show_nr_samples =
 		symbol_conf.show_nr_samples;
 
-	return symbol__tui_annotate(ms->sym, ms->map, evsel, hbt);
+	return symbol__tui_annotate(ms->sym, ms->map, evsel, hbt, tui_dump);
 }
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt)
+			     struct hist_browser_timer *hbt, bool tui_dump)
 {
 	/* reset abort key so that it can get Ctrl-C as a key */
-	SLang_reset_tty();
-	SLang_init_tty(0, 0, 0);
+	if (!tui_dump) {
+		SLang_reset_tty();
+		SLang_init_tty(0, 0, 0);
+	}
 
-	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
+	return map_symbol__tui_annotate(&he->ms, evsel, hbt, tui_dump);
 }
 
 
@@ -1100,7 +1110,8 @@ static inline int width_jumps(int n)
 
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
-			 struct hist_browser_timer *hbt)
+			 struct hist_browser_timer *hbt,
+			 bool tui_dump)
 {
 	struct annotation_line *al;
 	struct annotation *notes;
@@ -1117,6 +1128,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			.filter  = disasm_line__filter,
 			.priv	 = &ms,
 			.use_navkeypressed = true,
+			.dump	 = tui_dump,
 		},
 	};
 	int ret = -1, err;
@@ -1149,7 +1161,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 
 	symbol__calc_percent(sym, evsel);
 
-	ui_helpline__push("Press ESC to exit");
+	if (!tui_dump)
+		ui_helpline__push("Press ESC to exit");
 
 	notes = symbol__annotation(sym);
 	browser.start = map__rip_2objdump(map, sym->start);
@@ -1193,7 +1206,11 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 
 	annotate_browser__update_addr_width(&browser);
 
-	ret = annotate_browser__run(&browser, evsel, hbt);
+	if (tui_dump) {
+		browser.b.width = 80;
+		annotate_browser__refresh(&browser.b);
+	} else
+		ret = annotate_browser__run(&browser, evsel, hbt);
 
 	annotated_source__purge(notes->src);
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 8b4e825..f64ef80 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2418,7 +2418,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 		return 0;
 
 	evsel = hists_to_evsel(browser->hists);
-	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt);
+	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt, false);
 	he = hist_browser__selected_entry(browser);
 	/*
 	 * offer option to annotate the other branch source or target
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 7e914e8..1938907 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -218,13 +218,15 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 #ifdef HAVE_SLANG_SUPPORT
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
-			 struct hist_browser_timer *hbt);
+			 struct hist_browser_timer *hbt,
+			 bool tui_dump);
 #else
 static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 				struct map *map __maybe_unused,
 				struct perf_evsel *evsel  __maybe_unused,
 				struct hist_browser_timer *hbt
-				__maybe_unused)
+				__maybe_unused,
+				bool tui_dump)
 {
 	return 0;
 }
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index e869cad..72bd868 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -421,10 +421,11 @@ struct hist_browser_timer {
 #ifdef HAVE_SLANG_SUPPORT
 #include "../ui/keysyms.h"
 int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt);
+			     struct hist_browser_timer *hbt,
+			     bool tui_dump);
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt);
+			     struct hist_browser_timer *hbt, bool tui_dump);
 
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
@@ -445,14 +446,16 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
 }
 static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
 					   struct perf_evsel *evsel __maybe_unused,
-					   struct hist_browser_timer *hbt __maybe_unused)
+					   struct hist_browser_timer *hbt __maybe_unused,
+					   bool tui_dump __maybe_unused)
 {
 	return 0;
 }
 
 static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
 					   struct perf_evsel *evsel __maybe_unused,
-					   struct hist_browser_timer *hbt __maybe_unused)
+					   struct hist_browser_timer *hbt __maybe_unused,
+					   bool tui_dump __maybe_unused)
 {
 	return 0;
 }
-- 
2.7.4
