Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932785AbeBPJvW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:51:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57923 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932677AbeBPJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:51:04 -0500
Date: Fri, 16 Feb 2018 01:40:40 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-06cc1a470ab237b991901729b125404c164f3660@git.kernel.org>
Cc: jolsa@kernel.org, yao.jin@linux.intel.com, peterz@infradead.org,
        hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        kan.liang@intel.com, tglx@linutronix.de, wangnan0@huawei.com,
        namhyung@kernel.org, ak@linux.intel.com, mingo@kernel.org
Reply-To: namhyung@kernel.org, wangnan0@huawei.com, tglx@linutronix.de,
        mingo@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        kan.liang@intel.com, acme@redhat.com, hpa@zytor.com,
        yao.jin@linux.intel.com, peterz@infradead.org, jolsa@kernel.org
In-Reply-To: <1516310792-208685-15-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-15-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists browser: Add parameter to disable lost
 event warning
Git-Commit-ID: 06cc1a470ab237b991901729b125404c164f3660
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

Commit-ID:  06cc1a470ab237b991901729b125404c164f3660
Gitweb:     https://git.kernel.org/tip/06cc1a470ab237b991901729b125404c164f3660
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:29 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:56:26 -0300

perf hists browser: Add parameter to disable lost event warning

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
index c0815a3..539c3d4 100644
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
index 42a52dc..4ad5dc6 100644
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
index ee4bba1..7def861 100644
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
index 68146f4..6495ee5 100644
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
@@ -3224,7 +3231,8 @@ browse_hists:
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
 
@@ -3325,7 +3336,7 @@ single_entry:
 
 		return perf_evsel__hists_browse(first, nr_entries, help,
 						false, hbt, min_pcnt,
-						env);
+						env, warn_lost_event);
 	}
 
 	if (symbol_conf.event_group) {
@@ -3342,5 +3353,6 @@ single_entry:
 	}
 
 	return __perf_evlist__tui_browse_hists(evlist, nr_entries, help,
-					       hbt, min_pcnt, env);
+					       hbt, min_pcnt, env,
+					       warn_lost_event);
 }
diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
index ba43177..9428bee 100644
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
index f6630cb..02721b57 100644
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
