Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xV9oJevpGFsVWAAAmS7hNA
	; Thu, 07 Jun 2018 08:17:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 931466089E; Thu,  7 Jun 2018 08:17:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E7D160115;
	Thu,  7 Jun 2018 08:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E7D160115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932492AbeFGIRM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:17:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60511 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbeFGIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:17:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578GxPG2125563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:16:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578Gx2Y2125560;
        Thu, 7 Jun 2018 01:16:59 -0700
Date: Thu, 7 Jun 2018 01:16:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0sas5cm4dsw2obn75g7ruz69@git.kernel.org>
Cc: hpa@zytor.com, wangnan0@huawei.com, namhyung@kernel.org,
        dsahern@gmail.com, acme@redhat.com, adrian.hunter@intel.com,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jolsa@kernel.org
Reply-To: wangnan0@huawei.com, namhyung@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          dsahern@gmail.com, tglx@linutronix.de, mingo@kernel.org,
          adrian.hunter@intel.com, acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists: Check if a hist_entry has callchains
 before using them
Git-Commit-ID: fabd37b837f6e80aedba9ad706b517f5eeea9a50
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

Commit-ID:  fabd37b837f6e80aedba9ad706b517f5eeea9a50
Gitweb:     https://git.kernel.org/tip/fabd37b837f6e80aedba9ad706b517f5eeea9a50
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 29 May 2018 13:59:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:03 -0300

perf hists: Check if a hist_entry has callchains before using them

So far if we use 'perf record -g' this will make
symbol_conf.use_callchain 'true' and logic will assume that all events
have callchains enabled, but ever since we added the possibility of
setting up callchains for some events (e.g.: -e
cycles/call-graph=dwarf/) while not for others, we limit usage scenarios
by looking at that symbol_conf.use_callchain global boolean, we better
look at each event attributes.

On the road to that we need to look if a hist_entry has callchains, that
is, to go from hist_entry->hists to the evsel that contains it, to then
look at evsel->sample_type for PERF_SAMPLE_CALLCHAIN.

The next step is to add a symbol_conf.ignore_callchains global, to use
in the places where what we really want to know is if callchains should
be ignored, even if present.

Then -g will mean just to select a callchain mode to be applied to all
events not explicitely setting some other callchain mode, i.e. a default
callchain mode, and --no-call-graph will set
symbol_conf.ignore_callchains with that clear intention.

That too will at some point become a per evsel thing, that tools can set
for all or just a few of its evsels.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0sas5cm4dsw2obn75g7ruz69@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 11 ++++++-----
 tools/perf/ui/gtk/hists.c      |  5 +++--
 tools/perf/ui/hist.c           |  2 +-
 tools/perf/ui/stdio/hist.c     |  4 ++--
 tools/perf/util/hist.c         | 11 ++++++-----
 tools/perf/util/hist.h         |  6 ++++++
 tools/perf/util/sort.h         |  3 +--
 7 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 22054107f1af..a96f62ca984a 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1231,6 +1231,7 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 	int width = browser->b.width;
 	char folded_sign = ' ';
 	bool current_entry = ui_browser__is_current_entry(&browser->b, row);
+	bool use_callchain = hist_entry__has_callchains(entry) && symbol_conf.use_callchain;
 	off_t row_offset = entry->row_offset;
 	bool first = true;
 	struct perf_hpp_fmt *fmt;
@@ -1240,7 +1241,7 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 		browser->selection = &entry->ms;
 	}
 
-	if (symbol_conf.use_callchain) {
+	if (use_callchain) {
 		hist_entry__init_have_children(entry);
 		folded_sign = hist_entry__folded(entry);
 	}
@@ -1276,7 +1277,7 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 			}
 
 			if (first) {
-				if (symbol_conf.use_callchain) {
+				if (use_callchain) {
 					ui_browser__printf(&browser->b, "%c ", folded_sign);
 					width -= 2;
 				}
@@ -1583,7 +1584,7 @@ hists_browser__scnprintf_headers(struct hist_browser *browser, char *buf,
 	int column = 0;
 	int span = 0;
 
-	if (symbol_conf.use_callchain) {
+	if (hists__has_callchains(hists) && symbol_conf.use_callchain) {
 		ret = scnprintf(buf, size, "  ");
 		if (advance_hpp_check(&dummy_hpp, ret))
 			return ret;
@@ -1987,7 +1988,7 @@ static int hist_browser__fprintf_entry(struct hist_browser *browser,
 	bool first = true;
 	int ret;
 
-	if (symbol_conf.use_callchain) {
+	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
 		folded_sign = hist_entry__folded(he);
 		printed += fprintf(fp, "%c ", folded_sign);
 	}
@@ -2671,7 +2672,7 @@ static void hist_browser__update_percent_limit(struct hist_browser *hb,
 			he->nr_rows = 0;
 		}
 
-		if (!he->leaf || !symbol_conf.use_callchain)
+		if (!he->leaf || !hist_entry__has_callchains(he) || !symbol_conf.use_callchain)
 			goto next;
 
 		if (callchain_param.mode == CHAIN_GRAPH_REL) {
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 24e1ec201ffd..b085f1b3e34d 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -382,7 +382,8 @@ static void perf_gtk__show_hists(GtkWidget *window, struct hists *hists,
 			gtk_tree_store_set(store, &iter, col_idx++, s, -1);
 		}
 
-		if (symbol_conf.use_callchain && hists__has(hists, sym)) {
+		if (hists__has_callchains(hists) &&
+		    symbol_conf.use_callchain && hists__has(hists, sym)) {
 			if (callchain_param.mode == CHAIN_GRAPH_REL)
 				total = symbol_conf.cumulate_callchain ?
 					h->stat_acc->period : h->stat.period;
@@ -479,7 +480,7 @@ static void perf_gtk__add_hierarchy_entries(struct hists *hists,
 			}
 		}
 
-		if (symbol_conf.use_callchain && he->leaf) {
+		if (he->leaf && hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
 			if (callchain_param.mode == CHAIN_GRAPH_REL)
 				total = symbol_conf.cumulate_callchain ?
 					he->stat_acc->period : he->stat.period;
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 706f6f1e9c7d..fe3dfaa64a91 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -207,7 +207,7 @@ static int __hpp__sort_acc(struct hist_entry *a, struct hist_entry *b,
 		if (ret)
 			return ret;
 
-		if (a->thread != b->thread || !symbol_conf.use_callchain)
+		if (a->thread != b->thread || !hist_entry__has_callchains(a) || !symbol_conf.use_callchain)
 			return 0;
 
 		ret = b->callchain->max_depth - a->callchain->max_depth;
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index c1eb476da91b..69b7a28f7a1c 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -516,7 +516,7 @@ static int hist_entry__hierarchy_fprintf(struct hist_entry *he,
 	}
 	printed += putc('\n', fp);
 
-	if (symbol_conf.use_callchain && he->leaf) {
+	if (he->leaf && hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
 		u64 total = hists__total_period(hists);
 
 		printed += hist_entry_callchain__fprintf(he, total, 0, fp);
@@ -550,7 +550,7 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 
 	ret = fprintf(fp, "%s\n", bf);
 
-	if (use_callchain)
+	if (hist_entry__has_callchains(he) && use_callchain)
 		callchain_ret = hist_entry_callchain__fprintf(he, total_period,
 							      0, fp);
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 34864c87cd3c..52e8fda93a47 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -410,7 +410,7 @@ static int hist_entry__init(struct hist_entry *he,
 		map__get(he->mem_info->daddr.map);
 	}
 
-	if (symbol_conf.use_callchain)
+	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
 		callchain_init(he->callchain);
 
 	if (he->raw_data) {
@@ -492,7 +492,7 @@ static u8 symbol__parent_filter(const struct symbol *parent)
 
 static void hist_entry__add_callchain_period(struct hist_entry *he, u64 period)
 {
-	if (!symbol_conf.use_callchain)
+	if (!hist_entry__has_callchains(he) || !symbol_conf.use_callchain)
 		return;
 
 	he->hists->callchain_period += period;
@@ -986,7 +986,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	iter->he = he;
 	he_cache[iter->curr++] = he;
 
-	if (symbol_conf.use_callchain)
+	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
 		callchain_append(he->callchain, &cursor, sample->period);
 	return 0;
 }
@@ -1373,7 +1373,8 @@ static int hists__hierarchy_insert_entry(struct hists *hists,
 	if (new_he) {
 		new_he->leaf = true;
 
-		if (symbol_conf.use_callchain) {
+		if (hist_entry__has_callchains(new_he) &&
+		    symbol_conf.use_callchain) {
 			callchain_cursor_reset(&callchain_cursor);
 			if (callchain_merge(&callchain_cursor,
 					    new_he->callchain,
@@ -1414,7 +1415,7 @@ static int hists__collapse_insert_entry(struct hists *hists,
 			if (symbol_conf.cumulate_callchain)
 				he_stat__add_stat(iter->stat_acc, he->stat_acc);
 
-			if (symbol_conf.use_callchain) {
+			if (hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
 				callchain_cursor_reset(&callchain_cursor);
 				if (callchain_merge(&callchain_cursor,
 						    iter->callchain,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index cafafbf2aa9f..06607c434949 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -220,6 +220,12 @@ static inline struct hists *evsel__hists(struct perf_evsel *evsel)
 	return &hevsel->hists;
 }
 
+static __pure inline bool hists__has_callchains(struct hists *hists)
+{
+	const struct perf_evsel *evsel = hists_to_evsel(hists);
+	return evsel__has_callchain(evsel);
+}
+
 int hists__init(void);
 int __hists__init(struct hists *hists, struct perf_hpp_list *hpp_list);
 
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 1a046157bfef..7cf2d5cc038e 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -153,8 +153,7 @@ struct hist_entry {
 
 static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
 {
-	const struct perf_evsel *evsel = hists_to_evsel(he->hists);
-	return evsel__has_callchain(evsel);
+	return hists__has_callchains(he->hists);
 }
 
 static inline bool hist_entry__has_pairs(struct hist_entry *he)
