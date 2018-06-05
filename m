Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeFERv6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752663AbeFERvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:53 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 24/46] perf hists browser: Pass annotation_options from tool to browser
Date: Tue,  5 Jun 2018 14:50:08 -0300
Message-Id: <20180605175030.32549-25-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that things changed in the command line may percolate to the browser
code without using globals.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-5daawc40zhl6gcs600com1ua@git.kernel.org
[ Merged fix for NO_SLANG=1 build provided by Jiri Olsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c     |  2 +-
 tools/perf/builtin-report.c       |  2 +-
 tools/perf/builtin-top.c          |  3 ++-
 tools/perf/ui/browsers/annotate.c | 19 ++++++++++++-------
 tools/perf/ui/browsers/hists.c    | 29 ++++++++++++++++++++---------
 tools/perf/ui/browsers/hists.h    |  3 +++
 tools/perf/util/annotate.h        |  7 ++++---
 tools/perf/util/hist.h            | 20 ++++++++++++++------
 8 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 3ee063598364..2339ae719e1d 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -341,7 +341,7 @@ static void hists__find_annotations(struct hists *hists,
 			/* skip missing symbols */
 			nd = rb_next(nd);
 		} else if (use_browser == 1) {
-			key = hist_entry__tui_annotate(he, evsel, NULL);
+			key = hist_entry__tui_annotate(he, evsel, NULL, &ann->opts);
 
 			switch (key) {
 			case -1:
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c74f9a219ad1..14b516a3a0de 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -561,7 +561,7 @@ static int report__browse_hists(struct report *rep)
 		ret = perf_evlist__tui_browse_hists(evlist, help, NULL,
 						    rep->min_percent,
 						    &session->header.env,
-						    true);
+						    true, &rep->annotation_opts);
 		/*
 		 * Usually "ret" is the last pressed key, and we only
 		 * care if the key notifies us to switch data file.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 739c158fb39e..bd60a631a481 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -606,7 +606,8 @@ static void *display_thread_tui(void *arg)
 	perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
 				      top->min_percent,
 				      &top->session->header.env,
-				      !top->record_opts.overwrite);
+				      !top->record_opts.overwrite,
+				      &top->annotation_opts);
 
 	done = 1;
 	return NULL;
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3bfe17e176fe..3b4f1c10ff57 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -29,6 +29,7 @@ struct annotate_browser {
 	struct rb_node		   *curr_hot;
 	struct annotation_line	   *selection;
 	struct arch		   *arch;
+	struct annotation_options  *opts;
 	bool			    searching_backwards;
 	char			    search_bf[128];
 };
@@ -418,7 +419,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	}
 
 	pthread_mutex_unlock(&notes->lock);
-	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt);
+	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt, browser->opts);
 	sym_title(ms->sym, ms->map, title, sizeof(title));
 	ui_browser__show_title(&browser->b, title);
 	return true;
@@ -817,24 +818,27 @@ static int annotate_browser__run(struct annotate_browser *browser,
 }
 
 int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt)
+			     struct hist_browser_timer *hbt,
+			     struct annotation_options *opts)
 {
-	return symbol__tui_annotate(ms->sym, ms->map, evsel, hbt);
+	return symbol__tui_annotate(ms->sym, ms->map, evsel, hbt, opts);
 }
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt)
+			     struct hist_browser_timer *hbt,
+			     struct annotation_options *opts)
 {
 	/* reset abort key so that it can get Ctrl-C as a key */
 	SLang_reset_tty();
 	SLang_init_tty(0, 0, 0);
 
-	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
+	return map_symbol__tui_annotate(&he->ms, evsel, hbt, opts);
 }
 
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
-			 struct hist_browser_timer *hbt)
+			 struct hist_browser_timer *hbt,
+			 struct annotation_options *opts)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct map_symbol ms = {
@@ -851,6 +855,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			.priv	 = &ms,
 			.use_navkeypressed = true,
 		},
+		.opts = opts,
 	};
 	int ret = -1, err;
 
@@ -860,7 +865,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate2(sym, map, evsel, &annotation__default_options, &browser.arch);
+	err = symbol__annotate2(sym, map, evsel, opts, &browser.arch);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index e5f247247daa..3af1b74608ab 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2175,7 +2175,8 @@ struct hist_browser *hist_browser__new(struct hists *hists)
 static struct hist_browser *
 perf_evsel_browser__new(struct perf_evsel *evsel,
 			struct hist_browser_timer *hbt,
-			struct perf_env *env)
+			struct perf_env *env,
+			struct annotation_options *annotation_opts)
 {
 	struct hist_browser *browser = hist_browser__new(evsel__hists(evsel));
 
@@ -2183,6 +2184,7 @@ perf_evsel_browser__new(struct perf_evsel *evsel,
 		browser->hbt   = hbt;
 		browser->env   = env;
 		browser->title = hists_browser__scnprintf_title;
+		browser->annotation_opts = annotation_opts;
 	}
 	return browser;
 }
@@ -2344,7 +2346,8 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 		return 0;
 
 	evsel = hists_to_evsel(browser->hists);
-	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt);
+	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt,
+				       browser->annotation_opts);
 	he = hist_browser__selected_entry(browser);
 	/*
 	 * offer option to annotate the other branch source or target
@@ -2697,10 +2700,11 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 				    struct hist_browser_timer *hbt,
 				    float min_pcnt,
 				    struct perf_env *env,
-				    bool warn_lost_event)
+				    bool warn_lost_event,
+				    struct annotation_options *annotation_opts)
 {
 	struct hists *hists = evsel__hists(evsel);
-	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env);
+	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env, annotation_opts);
 	struct branch_info *bi;
 #define MAX_OPTIONS  16
 	char *options[MAX_OPTIONS];
@@ -3062,6 +3066,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 struct perf_evsel_menu {
 	struct ui_browser b;
 	struct perf_evsel *selection;
+	struct annotation_options *annotation_opts;
 	bool lost_events, lost_events_warned;
 	float min_pcnt;
 	struct perf_env *env;
@@ -3163,7 +3168,8 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 						       true, hbt,
 						       menu->min_pcnt,
 						       menu->env,
-						       warn_lost_event);
+						       warn_lost_event,
+						       menu->annotation_opts);
 			ui_browser__show_title(&menu->b, title);
 			switch (key) {
 			case K_TAB:
@@ -3222,7 +3228,8 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 					   struct hist_browser_timer *hbt,
 					   float min_pcnt,
 					   struct perf_env *env,
-					   bool warn_lost_event)
+					   bool warn_lost_event,
+					   struct annotation_options *annotation_opts)
 {
 	struct perf_evsel *pos;
 	struct perf_evsel_menu menu = {
@@ -3237,6 +3244,7 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 		},
 		.min_pcnt = min_pcnt,
 		.env = env,
+		.annotation_opts = annotation_opts,
 	};
 
 	ui_helpline__push("Press ESC to exit");
@@ -3257,7 +3265,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt,
 				  struct perf_env *env,
-				  bool warn_lost_event)
+				  bool warn_lost_event,
+				  struct annotation_options *annotation_opts)
 {
 	int nr_entries = evlist->nr_entries;
 
@@ -3267,7 +3276,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 
 		return perf_evsel__hists_browse(first, nr_entries, help,
 						false, hbt, min_pcnt,
-						env, warn_lost_event);
+						env, warn_lost_event,
+						annotation_opts);
 	}
 
 	if (symbol_conf.event_group) {
@@ -3285,5 +3295,6 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 
 	return __perf_evlist__tui_browse_hists(evlist, nr_entries, help,
 					       hbt, min_pcnt, env,
-					       warn_lost_event);
+					       warn_lost_event,
+					       annotation_opts);
 }
diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
index 9428bee076f2..91d3e18b50aa 100644
--- a/tools/perf/ui/browsers/hists.h
+++ b/tools/perf/ui/browsers/hists.h
@@ -4,6 +4,8 @@
 
 #include "ui/browser.h"
 
+struct annotation_options;
+
 struct hist_browser {
 	struct ui_browser   b;
 	struct hists	    *hists;
@@ -12,6 +14,7 @@ struct hist_browser {
 	struct hist_browser_timer *hbt;
 	struct pstack	    *pstack;
 	struct perf_env	    *env;
+	struct annotation_options *annotation_opts;
 	int		     print_seq;
 	bool		     show_dso;
 	bool		     show_headers;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 71a734b86873..6e6e2a571928 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -357,13 +357,14 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 #ifdef HAVE_SLANG_SUPPORT
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
-			 struct hist_browser_timer *hbt);
+			 struct hist_browser_timer *hbt,
+			 struct annotation_options *opts);
 #else
 static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 				struct map *map __maybe_unused,
 				struct perf_evsel *evsel  __maybe_unused,
-				struct hist_browser_timer *hbt
-				__maybe_unused)
+				struct hist_browser_timer *hbt __maybe_unused,
+				struct annotation_options *opts __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index fbabfd8a215d..cafafbf2aa9f 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -419,19 +419,24 @@ struct hist_browser_timer {
 	int refresh;
 };
 
+struct annotation_options;
+
 #ifdef HAVE_SLANG_SUPPORT
 #include "../ui/keysyms.h"
 int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt);
+			     struct hist_browser_timer *hbt,
+			     struct annotation_options *annotation_opts);
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt);
+			     struct hist_browser_timer *hbt,
+			     struct annotation_options *annotation_opts);
 
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt,
 				  struct perf_env *env,
-				  bool warn_lost_event);
+				  bool warn_lost_event,
+				  struct annotation_options *annotation_options);
 int script_browse(const char *script_opt);
 #else
 static inline
@@ -440,20 +445,23 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
 				  struct hist_browser_timer *hbt __maybe_unused,
 				  float min_pcnt __maybe_unused,
 				  struct perf_env *env __maybe_unused,
-				  bool warn_lost_event __maybe_unused)
+				  bool warn_lost_event __maybe_unused,
+				  struct annotation_options *annotation_options __maybe_unused)
 {
 	return 0;
 }
 static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
 					   struct perf_evsel *evsel __maybe_unused,
-					   struct hist_browser_timer *hbt __maybe_unused)
+					   struct hist_browser_timer *hbt __maybe_unused,
+					   struct annotation_options *annotation_options __maybe_unused)
 {
 	return 0;
 }
 
 static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
 					   struct perf_evsel *evsel __maybe_unused,
-					   struct hist_browser_timer *hbt __maybe_unused)
+					   struct hist_browser_timer *hbt __maybe_unused,
+					   struct annotation_options *annotation_opts __maybe_unused)
 {
 	return 0;
 }
-- 
2.14.3
