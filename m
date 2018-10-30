Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4ACC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B73C2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B73C2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeJ3Kpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 06:45:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:10921 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbeJ3Kpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 06:45:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 18:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,442,1534834800"; 
   d="scan'208";a="269852945"
Received: from otc-lr-04.jf.intel.com ([10.54.39.124])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2018 18:54:17 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     wangnan0@huawei.com, jolsa@kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com, peterz@infradead.org,
        kan.liang@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH] perf top: Move the timeout warning from event processing thread to display thread
Date:   Mon, 29 Oct 2018 18:52:37 -0700
Message-Id: <1540864357-63097-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The main event processing thread may hang if the ring buffer event
processing timeouts.

Analysis from David Miller:
"It hangs the event thread, because the ui call waits for a keypress
but the display thread will eat them up and the event thread thus
hangs in select()."

The timeout warning is moved to display thread.

The nr_rb_read is introduced to track the times of
perf_top__mmap_read(), which is the main function of event processing.
If the nr_rb_read doesn't increase during the refresh time, the display
thread may output stale data. The timeout warning will be triggered.

The timeout warning can only be triggered one time to avoid the annoying
and duplicated warning message.

The first perf_top__mmap_read() is moved to after display thread create.
Because the perf_top__mmap_read() could cost long time. For example, the
function may cost tens of minutes on Knights Landing platform with
parallel kernel build. There will be nothing displayed on the screen.
The display thread has to be created before perf_top__mmap_read(). But
at that time, the data is not ready. Display thread has to sleep
refresh time.

Fix: 8cc42de736b6 ("perf top: Check the latency of
perf_top__mmap_read()")
Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-c2c.c       |  4 +--
 tools/perf/builtin-report.c    |  3 ++-
 tools/perf/builtin-top.c       | 39 +++++++++++++++++++---------
 tools/perf/ui/browsers/hists.c | 58 ++++++++++++++++++++++++++++++++++--------
 tools/perf/ui/browsers/hists.h |  2 +-
 tools/perf/util/hist.h         |  6 +++--
 tools/perf/util/top.h          |  1 +
 7 files changed, 85 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f3aa9d0..1e77515 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2371,7 +2371,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, NULL);
 
 		switch (key) {
 		case 's':
@@ -2440,7 +2440,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, NULL);
 
 		switch (key) {
 		case 'q':
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 257c9c1..2fc1273 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -561,7 +561,8 @@ static int report__browse_hists(struct report *rep)
 		ret = perf_evlist__tui_browse_hists(evlist, help, NULL,
 						    rep->min_percent,
 						    &session->header.env,
-						    true, &rep->annotation_opts);
+						    true, &rep->annotation_opts,
+						    NULL);
 		/*
 		 * Usually "ret" is the last pressed key, and we only
 		 * care if the key notifies us to switch data file.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d21d875..95409de 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -584,6 +584,8 @@ static void *display_thread_tui(void *arg)
 		.refresh	= top->delay_secs,
 	};
 
+	sleep(top->delay_secs);
+
 	/* In order to read symbols from other namespaces perf to  needs to call
 	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
 	 * unshare(2) the fs so that we may continue to setns into namespaces
@@ -607,7 +609,8 @@ static void *display_thread_tui(void *arg)
 				      top->min_percent,
 				      &top->session->header.env,
 				      !top->record_opts.overwrite,
-				      &top->annotation_opts);
+				      &top->annotation_opts,
+				      &top->nr_rb_read);
 
 	done = 1;
 	return NULL;
@@ -633,6 +636,11 @@ static void *display_thread(void *arg)
 	struct termios save;
 	struct perf_top *top = arg;
 	int delay_msecs, c;
+	bool rb_read_timeout_warned = false;
+	bool rb_read_timeout = false;
+	int last_nr_rb_read = 0;
+
+	sleep(top->delay_secs);
 
 	/* In order to read symbols from other namespaces perf to  needs to call
 	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
@@ -651,12 +659,26 @@ static void *display_thread(void *arg)
 
 	while (!done) {
 		perf_top__print_sym_table(top);
+
+		if (!rb_read_timeout_warned && rb_read_timeout) {
+			color_fprintf(stdout, PERF_COLOR_RED,
+				      "Too slow to read ring buffer.\n"
+				      "Please try increasing the period (-c) or\n"
+				      "decreasing the freq (-F) or\n"
+				      "limiting the number of CPUs (-C)\n");
+			rb_read_timeout_warned = true;
+		}
 		/*
 		 * Either timeout expired or we got an EINTR due to SIGWINCH,
 		 * refresh screen in both cases.
 		 */
 		switch (poll(&stdin_poll, 1, delay_msecs)) {
 		case 0:
+			if (atomic_read(&top->nr_rb_read) == last_nr_rb_read)
+				rb_read_timeout = true;
+			else
+				rb_read_timeout = false;
+			last_nr_rb_read = atomic_read(&top->nr_rb_read);
 			continue;
 		case -1:
 			if (errno == EINTR)
@@ -881,10 +903,10 @@ static void perf_top__mmap_read(struct perf_top *top)
 {
 	bool overwrite = top->record_opts.overwrite;
 	struct perf_evlist *evlist = top->evlist;
-	unsigned long long start, end;
 	int i;
 
-	start = rdclock();
+	atomic_inc(&top->nr_rb_read);
+
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_DATA_PENDING);
 
@@ -895,13 +917,6 @@ static void perf_top__mmap_read(struct perf_top *top)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 	}
-	end = rdclock();
-
-	if ((end - start) > (unsigned long long)top->delay_secs * NSEC_PER_SEC)
-		ui__warning("Too slow to read ring buffer.\n"
-			    "Please try increasing the period (-c) or\n"
-			    "decreasing the freq (-F) or\n"
-			    "limiting the number of CPUs (-C)\n");
 }
 
 /*
@@ -1137,8 +1152,6 @@ static int __cmd_top(struct perf_top *top)
 	/* Wait for a minimal set of events before starting the snapshot */
 	perf_evlist__poll(top->evlist, 100);
 
-	perf_top__mmap_read(top);
-
 	ret = -1;
 	if (pthread_create(&thread, NULL, (use_browser > 0 ? display_thread_tui :
 							    display_thread), top)) {
@@ -1146,6 +1159,8 @@ static int __cmd_top(struct perf_top *top)
 		goto out_delete;
 	}
 
+	perf_top__mmap_read(top);
+
 	if (top->realtime_prio) {
 		struct sched_param param;
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index a96f62c..bda3e74 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -606,18 +606,29 @@ static void ui_browser__warn_lost_events(struct ui_browser *browser)
 		"Or reduce the sampling frequency.");
 }
 
+static void ui_browser__warn_rb_read_timeout(struct ui_browser *browser)
+{
+	ui_browser__warning(browser, 4,
+		"Too slow to read ring buffer.\n\n"
+		"Please try increasing the period (-c) or\n\n"
+		"decreasing the freq (-F) or\n\n"
+		"limiting the number of CPUs (-C)\n\n");
+}
+
 static int hist_browser__title(struct hist_browser *browser, char *bf, size_t size)
 {
 	return browser->title ? browser->title(browser, bf, size) : 0;
 }
 
 int hist_browser__run(struct hist_browser *browser, const char *help,
-		      bool warn_lost_event)
+		      bool warn_lost_event, atomic_t *nr_rb_read)
 {
 	int key;
 	char title[160];
 	struct hist_browser_timer *hbt = browser->hbt;
 	int delay_secs = hbt ? hbt->refresh : 0;
+	int last_nr_rb_read = nr_rb_read ? atomic_read(nr_rb_read) : 0;
+	bool rb_read_timeout_warned = false;
 
 	browser->b.entries = &browser->hists->entries;
 	browser->b.nr_entries = hist_browser__nr_entries(browser);
@@ -650,6 +661,15 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 				ui_browser__warn_lost_events(&browser->b);
 			}
 
+			if (nr_rb_read) {
+				if (!rb_read_timeout_warned &&
+				    (last_nr_rb_read == atomic_read(nr_rb_read))) {
+					ui_browser__warn_rb_read_timeout(&browser->b);
+					rb_read_timeout_warned = true;
+				}
+				last_nr_rb_read = atomic_read(nr_rb_read);
+			}
+
 			hist_browser__title(browser, title, sizeof(title));
 			ui_browser__show_title(&browser->b, title);
 			continue;
@@ -2703,7 +2723,8 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 				    float min_pcnt,
 				    struct perf_env *env,
 				    bool warn_lost_event,
-				    struct annotation_options *annotation_opts)
+				    struct annotation_options *annotation_opts,
+				    atomic_t *nr_rb_read)
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env, annotation_opts);
@@ -2785,7 +2806,8 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 		nr_options = 0;
 
 		key = hist_browser__run(browser, helpline,
-					warn_lost_event);
+					warn_lost_event,
+					nr_rb_read);
 
 		if (browser->he_selection != NULL) {
 			thread = hist_browser__selected_thread(browser);
@@ -3070,6 +3092,8 @@ struct perf_evsel_menu {
 	struct perf_evsel *selection;
 	struct annotation_options *annotation_opts;
 	bool lost_events, lost_events_warned;
+	bool rb_read_timeout_warned;
+	int last_nr_rb_read;
 	float min_pcnt;
 	struct perf_env *env;
 };
@@ -3127,7 +3151,8 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 				int nr_events, const char *help,
 				struct hist_browser_timer *hbt,
-				bool warn_lost_event)
+				bool warn_lost_event,
+				atomic_t *nr_rb_read)
 {
 	struct perf_evlist *evlist = menu->b.priv;
 	struct perf_evsel *pos;
@@ -3152,6 +3177,14 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 				ui_browser__warn_lost_events(&menu->b);
 				menu->lost_events_warned = true;
 			}
+			if (nr_rb_read) {
+				if (!menu->rb_read_timeout_warned &&
+				    (menu->last_nr_rb_read == atomic_read(nr_rb_read))) {
+					ui_browser__warn_rb_read_timeout(&menu->b);
+					menu->rb_read_timeout_warned = true;
+				}
+				menu->last_nr_rb_read = atomic_read(nr_rb_read);
+			}
 			continue;
 		case K_RIGHT:
 		case K_ENTER:
@@ -3171,7 +3204,8 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 						       menu->min_pcnt,
 						       menu->env,
 						       warn_lost_event,
-						       menu->annotation_opts);
+						       menu->annotation_opts,
+						       nr_rb_read);
 			ui_browser__show_title(&menu->b, title);
 			switch (key) {
 			case K_TAB:
@@ -3231,7 +3265,8 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 					   float min_pcnt,
 					   struct perf_env *env,
 					   bool warn_lost_event,
-					   struct annotation_options *annotation_opts)
+					   struct annotation_options *annotation_opts,
+					   atomic_t *nr_rb_read)
 {
 	struct perf_evsel *pos;
 	struct perf_evsel_menu menu = {
@@ -3260,7 +3295,7 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 	}
 
 	return perf_evsel_menu__run(&menu, nr_entries, help,
-				    hbt, warn_lost_event);
+				    hbt, warn_lost_event, nr_rb_read);
 }
 
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
@@ -3268,7 +3303,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  float min_pcnt,
 				  struct perf_env *env,
 				  bool warn_lost_event,
-				  struct annotation_options *annotation_opts)
+				  struct annotation_options *annotation_opts,
+				  atomic_t *nr_rb_read)
 {
 	int nr_entries = evlist->nr_entries;
 
@@ -3279,7 +3315,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 		return perf_evsel__hists_browse(first, nr_entries, help,
 						false, hbt, min_pcnt,
 						env, warn_lost_event,
-						annotation_opts);
+						annotation_opts,
+						nr_rb_read);
 	}
 
 	if (symbol_conf.event_group) {
@@ -3298,5 +3335,6 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 	return __perf_evlist__tui_browse_hists(evlist, nr_entries, help,
 					       hbt, min_pcnt, env,
 					       warn_lost_event,
-					       annotation_opts);
+					       annotation_opts,
+					       nr_rb_read);
 }
diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
index 91d3e18..af6c1b9 100644
--- a/tools/perf/ui/browsers/hists.h
+++ b/tools/perf/ui/browsers/hists.h
@@ -32,7 +32,7 @@ struct hist_browser {
 struct hist_browser *hist_browser__new(struct hists *hists);
 void hist_browser__delete(struct hist_browser *browser);
 int hist_browser__run(struct hist_browser *browser, const char *help,
-		      bool warn_lost_event);
+		      bool warn_lost_event, atomic_t *nr_rb_read);
 void hist_browser__init(struct hist_browser *browser,
 			struct hists *hists);
 #endif /* _PERF_UI_BROWSER_HISTS_H_ */
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 3badd7f..67f31163 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -442,7 +442,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  float min_pcnt,
 				  struct perf_env *env,
 				  bool warn_lost_event,
-				  struct annotation_options *annotation_options);
+				  struct annotation_options *annotation_options,
+				  atomic_t *nr_rb_read);
 int script_browse(const char *script_opt);
 #else
 static inline
@@ -452,7 +453,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
 				  float min_pcnt __maybe_unused,
 				  struct perf_env *env __maybe_unused,
 				  bool warn_lost_event __maybe_unused,
-				  struct annotation_options *annotation_options __maybe_unused)
+				  struct annotation_options *annotation_options __maybe_unused,
+				  atomic_t *nr_rb_read __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 9add1f7..2869d9d 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -40,6 +40,7 @@ struct perf_top {
 	const char	   *sym_filter;
 	float		   min_percent;
 	unsigned int	   nr_threads_synthesize;
+	atomic_t	   nr_rb_read;
 };
 
 #define CONSOLE_CLEAR "[H[2J"
-- 
2.7.4

