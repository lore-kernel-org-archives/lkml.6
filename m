Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753337AbeBFRDm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:03:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752660AbeBFQym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA0A21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/21] perf hists browser: Add parameter to disable lost event warning
Date: Tue,  6 Feb 2018 13:53:44 -0300
Message-Id: <20180206165350.2570-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

For overwrite mode, the ringbuffer will be paused. The event lost is
expected. It needs a way to notify the browser not print the warning.

It will be used later for perf top to disable lost event warning in
overwrite mode. There is no behavior change for now.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-15-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c       |  4 ++--
 tools/perf/builtin-report.c    |  3 ++-
 tools/perf/builtin-top.c       |  2 +-
 tools/perf/ui/browsers/hists.c | 38 +++++++++++++++++++++++++-------------
 tools/perf/ui/browsers/hists.h |  3 ++-
 tools/perf/util/hist.h         |  6 ++++--
 6 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c0815a37fdb5..539c3d460158 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2245,7 +2245,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help");
+		key = hist_browser__run(browser, "? - help", true);
 
 		switch (key) {
 		case 's':
@@ -2314,7 +2314,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help");
+		key = hist_browser__run(browser, "? - help", true);
 
 		switch (key) {
 		case 'q':
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 42a52dcc41cd..4ad5dc649716 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -530,7 +530,8 @@ static int report__browse_hists(struct report *rep)
 	case 1:
 		ret = perf_evlist__tui_browse_hists(evlist, help, NULL,
 						    rep->min_percent,
-						    &session->header.env);
+						    &session->header.env,
+						    true);
 		/*
 		 * Usually "ret" is the last pressed key, and we only
 		 * care if the key notifies us to switch data file.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ee4bba1e282c..7def861a9ec4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -611,7 +611,7 @@ static void *display_thread_tui(void *arg)
 
 	perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
 				      top->min_percent,
-				      &top->session->header.env);
+				      &top->session->header.env, true);
 
 	done = 1;
 	return NULL;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 68146f4620a5..6495ee55d9c3 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -608,7 +608,8 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
 	return browser->title ? browser->title(browser, bf, size) : 0;
 }
 
-int hist_browser__run(struct hist_browser *browser, const char *help)
+int hist_browser__run(struct hist_browser *browser, const char *help,
+		      bool warn_lost_event)
 {
 	int key;
 	char title[160];
@@ -638,8 +639,9 @@ int hist_browser__run(struct hist_browser *browser, const char *help)
 			nr_entries = hist_browser__nr_entries(browser);
 			ui_browser__update_nr_entries(&browser->b, nr_entries);
 
-			if (browser->hists->stats.nr_lost_warned !=
-			    browser->hists->stats.nr_events[PERF_RECORD_LOST]) {
+			if (warn_lost_event &&
+			    (browser->hists->stats.nr_lost_warned !=
+			    browser->hists->stats.nr_events[PERF_RECORD_LOST])) {
 				browser->hists->stats.nr_lost_warned =
 					browser->hists->stats.nr_events[PERF_RECORD_LOST];
 				ui_browser__warn_lost_events(&browser->b);
@@ -2763,7 +2765,8 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 				    bool left_exits,
 				    struct hist_browser_timer *hbt,
 				    float min_pcnt,
-				    struct perf_env *env)
+				    struct perf_env *env,
+				    bool warn_lost_event)
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env);
@@ -2844,7 +2847,8 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 
 		nr_options = 0;
 
-		key = hist_browser__run(browser, helpline);
+		key = hist_browser__run(browser, helpline,
+					warn_lost_event);
 
 		if (browser->he_selection != NULL) {
 			thread = hist_browser__selected_thread(browser);
@@ -3184,7 +3188,8 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 
 static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 				int nr_events, const char *help,
-				struct hist_browser_timer *hbt)
+				struct hist_browser_timer *hbt,
+				bool warn_lost_event)
 {
 	struct perf_evlist *evlist = menu->b.priv;
 	struct perf_evsel *pos;
@@ -3203,7 +3208,9 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 		case K_TIMER:
 			hbt->timer(hbt->arg);
 
-			if (!menu->lost_events_warned && menu->lost_events) {
+			if (!menu->lost_events_warned &&
+			    menu->lost_events &&
+			    warn_lost_event) {
 				ui_browser__warn_lost_events(&menu->b);
 				menu->lost_events_warned = true;
 			}
@@ -3224,7 +3231,8 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 			key = perf_evsel__hists_browse(pos, nr_events, help,
 						       true, hbt,
 						       menu->min_pcnt,
-						       menu->env);
+						       menu->env,
+						       warn_lost_event);
 			ui_browser__show_title(&menu->b, title);
 			switch (key) {
 			case K_TAB:
@@ -3282,7 +3290,8 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 					   int nr_entries, const char *help,
 					   struct hist_browser_timer *hbt,
 					   float min_pcnt,
-					   struct perf_env *env)
+					   struct perf_env *env,
+					   bool warn_lost_event)
 {
 	struct perf_evsel *pos;
 	struct perf_evsel_menu menu = {
@@ -3309,13 +3318,15 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 			menu.b.width = line_len;
 	}
 
-	return perf_evsel_menu__run(&menu, nr_entries, help, hbt);
+	return perf_evsel_menu__run(&menu, nr_entries, help,
+				    hbt, warn_lost_event);
 }
 
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt,
-				  struct perf_env *env)
+				  struct perf_env *env,
+				  bool warn_lost_event)
 {
 	int nr_entries = evlist->nr_entries;
 
@@ -3325,7 +3336,7 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 
 		return perf_evsel__hists_browse(first, nr_entries, help,
 						false, hbt, min_pcnt,
-						env);
+						env, warn_lost_event);
 	}
 
 	if (symbol_conf.event_group) {
@@ -3342,5 +3353,6 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 	}
 
 	return __perf_evlist__tui_browse_hists(evlist, nr_entries, help,
-					       hbt, min_pcnt, env);
+					       hbt, min_pcnt, env,
+					       warn_lost_event);
 }
diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
index ba431777f559..9428bee076f2 100644
--- a/tools/perf/ui/browsers/hists.h
+++ b/tools/perf/ui/browsers/hists.h
@@ -28,7 +28,8 @@ struct hist_browser {
 
 struct hist_browser *hist_browser__new(struct hists *hists);
 void hist_browser__delete(struct hist_browser *browser);
-int hist_browser__run(struct hist_browser *browser, const char *help);
+int hist_browser__run(struct hist_browser *browser, const char *help,
+		      bool warn_lost_event);
 void hist_browser__init(struct hist_browser *browser,
 			struct hists *hists);
 #endif /* _PERF_UI_BROWSER_HISTS_H_ */
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index f6630cb95eff..02721b579746 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -430,7 +430,8 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt,
-				  struct perf_env *env);
+				  struct perf_env *env,
+				  bool warn_lost_event);
 int script_browse(const char *script_opt);
 #else
 static inline
@@ -438,7 +439,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
 				  const char *help __maybe_unused,
 				  struct hist_browser_timer *hbt __maybe_unused,
 				  float min_pcnt __maybe_unused,
-				  struct perf_env *env __maybe_unused)
+				  struct perf_env *env __maybe_unused,
+				  bool warn_lost_event __maybe_unused)
 {
 	return 0;
 }
-- 
2.14.3
