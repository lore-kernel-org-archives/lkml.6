Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rt/+BRjpGFu5UgAAmS7hNA
	; Thu, 07 Jun 2018 08:13:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0472E6089E; Thu,  7 Jun 2018 08:13:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E1A35607E7;
	Thu,  7 Jun 2018 08:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1A35607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbeFGINH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:13:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41851 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932148AbeFGINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:13:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578Csff2125068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:12:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578CsDr2125065;
        Thu, 7 Jun 2018 01:12:54 -0700
Date: Thu, 7 Jun 2018 01:12:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5daawc40zhl6gcs600com1ua@git.kernel.org>
Cc: namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        dsahern@gmail.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, wangnan0@huawei.com, acme@redhat.com,
        hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, namhyung@kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, dsahern@gmail.com, hpa@zytor.com,
          acme@redhat.com, wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists browser: Pass annotation_options from
 tool to browser
Git-Commit-ID: cd0cccbae9f654479a1c5abcd876c7fc4356b882
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

Commit-ID:  cd0cccbae9f654479a1c5abcd876c7fc4356b882
Gitweb:     https://git.kernel.org/tip/cd0cccbae9f654479a1c5abcd876c7fc4356b882
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 13:54:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:53 -0300

perf hists browser: Pass annotation_options from tool to browser

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
@@ -341,7 +341,7 @@ find_next:
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
@@ -817,24 +818,27 @@ out:
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
@@ -3062,6 +3066,7 @@ out:
 struct perf_evsel_menu {
 	struct ui_browser b;
 	struct perf_evsel *selection;
+	struct annotation_options *annotation_opts;
 	bool lost_events, lost_events_warned;
 	float min_pcnt;
 	struct perf_env *env;
@@ -3163,7 +3168,8 @@ browse_hists:
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
 
@@ -3267,7 +3276,8 @@ single_entry:
 
 		return perf_evsel__hists_browse(first, nr_entries, help,
 						false, hbt, min_pcnt,
-						env, warn_lost_event);
+						env, warn_lost_event,
+						annotation_opts);
 	}
 
 	if (symbol_conf.event_group) {
@@ -3285,5 +3295,6 @@ single_entry:
 
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
