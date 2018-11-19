Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DB420823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DB420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeKSWn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbeKSWn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:43:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10A2FC056807;
        Mon, 19 Nov 2018 12:20:31 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15EB945F35;
        Mon, 19 Nov 2018 12:20:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 04/12] perf top: Save and display the lost count stats
Date:   Mon, 19 Nov 2018 13:20:08 +0100
Message-Id: <20181119122016.22423-5-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 19 Nov 2018 12:20:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding lost count to perf top headers:

  # perf top --stdio
   PerfTop:    3850 irqs/sec  kernel:49.0%  exact: 100.0% lost: 0/0 [4000Hz cycles:ppp],  (all, 8 CPUs)

  # perf top
  Samples: 0  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 0 lost: 0/0

The format is: <current period lost>/<total lost>

Link: http://lkml.kernel.org/n/tip-3emb7g87k872rbr4pzmc47dm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c       | 27 +++++++++++++++++++++++++++
 tools/perf/ui/browsers/hists.c |  4 ++++
 tools/perf/util/top.c          |  6 +++---
 tools/perf/util/top.h          |  2 +-
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index aa0c73e57924..047e99de09f3 100644
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
-- 
2.17.2

