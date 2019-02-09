Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA9AC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA62321919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBIMu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:50:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:50:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CoEOe2632527
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:50:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CoDMg2632524;
        Sat, 9 Feb 2019 04:50:13 -0800
Date:   Sat, 9 Feb 2019 04:50:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-dbd2a1d57f4ee6b909c94072ae9484199308acbd@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, kan.liang@linux.intel.com,
        namhyung@kernel.org, yao.jin@linux.intel.com, acme@redhat.com
Reply-To: peterz@infradead.org, namhyung@kernel.org,
          kan.liang@linux.intel.com, yao.jin@linux.intel.com,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, jolsa@kernel.org, mingo@kernel.org
In-Reply-To: <20190204141808.23031-4-jolsa@kernel.org>
References: <20190204141808.23031-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Move symbol annotation to the resort
 phase
Git-Commit-ID: dbd2a1d57f4ee6b909c94072ae9484199308acbd
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

Commit-ID:  dbd2a1d57f4ee6b909c94072ae9484199308acbd
Gitweb:     https://git.kernel.org/tip/dbd2a1d57f4ee6b909c94072ae9484199308acbd
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 4 Feb 2019 15:18:08 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf report: Move symbol annotation to the resort phase

Currently we make the annotation for the IPC column during the entry
display, already outside of the progress bar scope, so it appears like
'perf report' is stuck.

Move the annotation retrieval to the resort phase, so that all the data
are ready for display.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190204141808.23031-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 21 +++++++++++++++++++--
 tools/perf/util/sort.c      |  7 -------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index a007ea9a3874..2e8c74d6430c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -616,6 +616,21 @@ static int report__collapse_hists(struct report *rep)
 	return ret;
 }
 
+static int hists__resort_cb(struct hist_entry *he, void *arg)
+{
+	struct report *rep = arg;
+	struct symbol *sym = he->ms.sym;
+
+	if (rep->symbol_ipc && sym && !sym->annotate2) {
+		struct perf_evsel *evsel = hists_to_evsel(he->hists);
+
+		symbol__annotate2(sym, he->ms.map, evsel,
+				  &annotation__default_options, NULL);
+	}
+
+	return 0;
+}
+
 static void report__output_resort(struct report *rep)
 {
 	struct ui_progress prog;
@@ -623,8 +638,10 @@ static void report__output_resort(struct report *rep)
 
 	ui_progress__init(&prog, rep->nr_entries, "Sorting events for output...");
 
-	evlist__for_each_entry(rep->session->evlist, pos)
-		perf_evsel__output_resort(pos, &prog);
+	evlist__for_each_entry(rep->session->evlist, pos) {
+		perf_evsel__output_resort_cb(pos, &prog,
+					     hists__resort_cb, rep);
+	}
 
 	ui_progress__finish();
 }
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 79e794406bef..2b6c1ccb878c 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -429,8 +429,6 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 {
 
 	struct symbol *sym = he->ms.sym;
-	struct map *map = he->ms.map;
-	struct perf_evsel *evsel = hists_to_evsel(he->hists);
 	struct annotation *notes;
 	double ipc = 0.0, coverage = 0.0;
 	char tmp[64];
@@ -438,11 +436,6 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 	if (!sym)
 		return repsep_snprintf(bf, size, "%-*s", width, "-");
 
-	if (!sym->annotate2 && symbol__annotate2(sym, map, evsel,
-		&annotation__default_options, NULL) < 0) {
-		return 0;
-	}
-
 	notes = symbol__annotation(sym);
 
 	if (notes->hit_cycles)
