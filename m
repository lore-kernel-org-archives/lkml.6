Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DBBC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01EE20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01EE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeIMSEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbeIMSEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8E6F2C974B;
        Thu, 13 Sep 2018 12:55:11 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09F37600C8;
        Thu, 13 Sep 2018 12:55:09 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 08/48] perf report: Skip dummy tracking event
Date:   Thu, 13 Sep 2018 14:54:10 +0200
Message-Id: <20180913125450.21342-9-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Sep 2018 12:55:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

The dummy tracking event is only for tracking task/comom/mmap events
and has no sample data for itself. So no need to report, just skip it.

Link: http://lkml.kernel.org/n/tip-l2hq7g8c7lt73aqmqpo6dywj@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c    |  3 +++
 tools/perf/ui/browsers/hists.c | 30 ++++++++++++++++++++++++------
 tools/perf/ui/gtk/hists.c      |  3 +++
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 7507e4d6dce1..3666a6b82ff1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -471,6 +471,9 @@ static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
 		struct hists *hists = evsel__hists(pos);
 		const char *evname = perf_evsel__name(pos);
 
+		if (perf_evsel__is_dummy_tracking(pos))
+			continue;
+
 		if (symbol_conf.event_group &&
 		    !perf_evsel__is_group_leader(pos))
 			continue;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index a96f62ca984a..a517becda28a 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3214,14 +3214,17 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 	return key;
 }
 
-static bool filter_group_entries(struct ui_browser *browser __maybe_unused,
-				 void *entry)
+static bool filter_entries(struct ui_browser *browser __maybe_unused,
+			   void *entry)
 {
 	struct perf_evsel *evsel = list_entry(entry, struct perf_evsel, node);
 
 	if (symbol_conf.event_group && !perf_evsel__is_group_leader(evsel))
 		return true;
 
+	if (perf_evsel__is_dummy_tracking(evsel))
+		return true;
+
 	return false;
 }
 
@@ -3240,7 +3243,7 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 			.refresh    = ui_browser__list_head_refresh,
 			.seek	    = ui_browser__list_head_seek,
 			.write	    = perf_evsel_menu__write,
-			.filter	    = filter_group_entries,
+			.filter	    = filter_entries,
 			.nr_entries = nr_entries,
 			.priv	    = evlist,
 		},
@@ -3271,11 +3274,11 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct annotation_options *annotation_opts)
 {
 	int nr_entries = evlist->nr_entries;
+	struct perf_evsel *first = perf_evlist__first(evlist);
+	struct perf_evsel *pos;
 
 single_entry:
 	if (nr_entries == 1) {
-		struct perf_evsel *first = perf_evlist__first(evlist);
-
 		return perf_evsel__hists_browse(first, nr_entries, help,
 						false, hbt, min_pcnt,
 						env, warn_lost_event,
@@ -3283,10 +3286,11 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 	}
 
 	if (symbol_conf.event_group) {
-		struct perf_evsel *pos;
 
 		nr_entries = 0;
 		evlist__for_each_entry(evlist, pos) {
+			if (perf_evsel__is_dummy_tracking(pos))
+				continue;
 			if (perf_evsel__is_group_leader(pos))
 				nr_entries++;
 		}
@@ -3295,6 +3299,20 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 			goto single_entry;
 	}
 
+	evlist__for_each_entry(evlist, pos) {
+		if (perf_evsel__is_dummy_tracking(pos))
+			nr_entries--;
+	}
+
+	if (nr_entries == 1) {
+		evlist__for_each_entry(evlist, pos) {
+			if (!perf_evsel__is_dummy_tracking(pos)) {
+				first = pos;
+				goto single_entry;
+			}
+		}
+	}
+
 	return __perf_evlist__tui_browse_hists(evlist, nr_entries, help,
 					       hbt, min_pcnt, env,
 					       warn_lost_event,
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 4ab663ec3e5e..adbece4e0071 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -639,6 +639,9 @@ int perf_evlist__gtk_browse_hists(struct perf_evlist *evlist,
 		char buf[512];
 		size_t size = sizeof(buf);
 
+		if (perf_evsel__is_dummy_tracking(pos))
+			continue;
+
 		if (symbol_conf.event_group) {
 			if (!perf_evsel__is_group_leader(pos))
 				continue;
-- 
2.17.1

