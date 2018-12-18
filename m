Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A02421873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeLRON4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:13:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45763 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLRONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:13:55 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEDTBJ2854505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:13:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEDTLs2854502;
        Tue, 18 Dec 2018 06:13:29 -0800
Date:   Tue, 18 Dec 2018 06:13:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-zo11rn270gij5jtp8fknpf8u@git.kernel.org>
Cc:     jolsa@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@redhat.com, namhyung@kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, davem@davemloft.net
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, davem@davemloft.net
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Save and display the lost count stats
Git-Commit-ID: d24e3c98ac11b941669885cc09d88b3b970e9d66
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
Message-ID: <20181218141329.8Rj4MLBHmn12-mH1PhvfTU-bUe5Zn8KGXKBsUwH7we0@z>

Commit-ID:  d24e3c98ac11b941669885cc09d88b3b970e9d66
Gitweb:     https://git.kernel.org/tip/d24e3c98ac11b941669885cc09d88b3b970e9d66
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 6 Nov 2018 15:45:14 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:57:36 -0300

perf top: Save and display the lost count stats

Add a 'lost count' to 'perf top' headers:

  # perf top --stdio
   PerfTop:    3850 irqs/sec  kernel:49.0%  exact: 100.0% lost: 0/0 [4000Hz cycles:ppp],  (all, 8 CPUs)

  # perf top
  Samples: 0  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 0 lost: 0/0

The format is: <current period lost>/<total lost>

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-zo11rn270gij5jtp8fknpf8u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c       | 27 +++++++++++++++++++++++++++
 tools/perf/ui/browsers/hists.c |  4 ++++
 tools/perf/util/top.c          |  6 +++---
 tools/perf/util/top.h          |  2 +-
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1beb3e360521..c02ea537d5a7 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -800,6 +800,29 @@ static void perf_event__process_sample(struct perf_tool *tool,
 	addr_location__put(&al);
 }
 
+static void
+perf_top__process_lost(struct perf_top *top, union perf_event *event,
+		       struct perf_evsel *evsel)
+{
+	struct hists *hists = evsel__hists(evsel);
+
+	top->lost += event->lost.lost;
+	top->lost_total += event->lost.lost;
+	hists->stats.total_lost += event->lost.lost;
+}
+
+static void
+perf_top__process_lost_samples(struct perf_top *top,
+			       union perf_event *event,
+			       struct perf_evsel *evsel)
+{
+	struct hists *hists = evsel__hists(evsel);
+
+	top->lost += event->lost_samples.lost;
+	top->lost_total += event->lost_samples.lost;
+	hists->stats.total_lost_samples += event->lost_samples.lost;
+}
+
 static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 {
 	struct record_opts *opts = &top->record_opts;
@@ -865,6 +888,10 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		if (event->header.type == PERF_RECORD_SAMPLE) {
 			perf_event__process_sample(&top->tool, event, evsel,
 						   &sample, machine);
+		} else if (event->header.type == PERF_RECORD_LOST) {
+			perf_top__process_lost(top, event, evsel);
+		} else if (event->header.type == PERF_RECORD_LOST_SAMPLES) {
+			perf_top__process_lost_samples(top, event, evsel);
 		} else if (event->header.type < PERF_RECORD_MAX) {
 			hists__inc_nr_events(evsel__hists(evsel), event->header.type);
 			machine__process_event(machine, event, &sample);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index a96f62ca984a..ae208c16c8a3 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2219,6 +2219,10 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 	if (!is_report_browser(hbt)) {
 		struct perf_top *top = hbt->arg;
 
+		printed += scnprintf(bf + printed, size - printed,
+				     " lost: %" PRIu64 "/%" PRIu64,
+				     top->lost, top->lost_total);
+
 		if (top->zero)
 			printed += scnprintf(bf + printed, size - printed, " [z]");
 	}
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 8e517def925b..e6582fa6a4db 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -46,8 +46,8 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 							samples_per_sec;
 		ret = SNPRINTF(bf, size,
 			       "   PerfTop:%8.0f irqs/sec  kernel:%4.1f%%"
-			       "  exact: %4.1f%% [", samples_per_sec,
-			       ksamples_percent, esamples_percent);
+			       "  exact: %4.1f%% lost: %" PRIu64 "/%" PRIu64 " [", samples_per_sec,
+			       ksamples_percent, esamples_percent, top->lost, top->lost_total);
 	} else {
 		float us_samples_per_sec = top->us_samples / top->delay_secs;
 		float guest_kernel_samples_per_sec = top->guest_kernel_samples / top->delay_secs;
@@ -113,5 +113,5 @@ void perf_top__reset_sample_counters(struct perf_top *top)
 {
 	top->samples = top->us_samples = top->kernel_samples =
 	top->exact_samples = top->guest_kernel_samples =
-	top->guest_us_samples = 0;
+	top->guest_us_samples = top->lost = 0;
 }
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 9add1f72ce95..1fbcbd79720a 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -22,7 +22,7 @@ struct perf_top {
 	 * Symbols will be added here in perf_event__process_sample and will
 	 * get out after decayed.
 	 */
-	u64		   samples;
+	u64		   samples, lost, lost_total;
 	u64		   kernel_samples, us_samples;
 	u64		   exact_samples;
 	u64		   guest_us_samples, guest_kernel_samples;
