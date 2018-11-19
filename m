Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749BF20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749BF20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeKSWoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:44:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbeKSWoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:44:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBDFC3082E4D;
        Mon, 19 Nov 2018 12:20:45 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B58F35C8A1;
        Mon, 19 Nov 2018 12:20:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 10/12] perf top: Save and display the drop count stats
Date:   Mon, 19 Nov 2018 13:20:14 +0100
Message-Id: <20181119122016.22423-11-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 19 Nov 2018 12:20:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding drop count to perf top headers:

  # perf top --stdio
   PerfTop:    3549 irqs/sec  kernel:51.8%  exact: 100.0% lost: 0/0 drop: 0/0 [4000Hz cycles:ppp],  (all, 8 CPUs)

  # perf top
  Samples: 0  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 0 lost: 0/0 drop: 0/0

The format is: <current period drop>/<total drop>

Link: http://lkml.kernel.org/n/tip-2lj87zz8tq9ye1ntax3ulw0n@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c       | 5 ++++-
 tools/perf/ui/browsers/hists.c | 4 ++++
 tools/perf/util/top.c          | 7 ++++---
 tools/perf/util/top.h          | 2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a509d8c0a846..7c60bd4419be 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1112,8 +1112,11 @@ static int deliver_event(struct ordered_events *qe,
 	struct machine *machine;
 	int ret = -1;
 
-	if (should_drop(qevent, top))
+	if (should_drop(qevent, top)) {
+		top->drop++;
+		top->drop_total++;
 		return 0;
+	}
 
 	ret = perf_evlist__parse_sample(evlist, event, &sample);
 	if (ret) {
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ae208c16c8a3..36b262c49f51 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2223,6 +2223,10 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 				     " lost: %" PRIu64 "/%" PRIu64,
 				     top->lost, top->lost_total);
 
+		printed += scnprintf(bf + printed, size - printed,
+				     " drop: %" PRIu64 "/%" PRIu64,
+				     top->drop, top->drop_total);
+
 		if (top->zero)
 			printed += scnprintf(bf + printed, size - printed, " [z]");
 	}
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index e6582fa6a4db..31a8dee9af69 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -46,8 +46,9 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 							samples_per_sec;
 		ret = SNPRINTF(bf, size,
 			       "   PerfTop:%8.0f irqs/sec  kernel:%4.1f%%"
-			       "  exact: %4.1f%% lost: %" PRIu64 "/%" PRIu64 " [", samples_per_sec,
-			       ksamples_percent, esamples_percent, top->lost, top->lost_total);
+			       "  exact: %4.1f%% lost: %" PRIu64 "/%" PRIu64 " drop: %" PRIu64 "/%" PRIu64 " [",
+			       samples_per_sec, ksamples_percent, esamples_percent,
+			       top->lost, top->lost_total, top->drop, top->drop_total);
 	} else {
 		float us_samples_per_sec = top->us_samples / top->delay_secs;
 		float guest_kernel_samples_per_sec = top->guest_kernel_samples / top->delay_secs;
@@ -113,5 +114,5 @@ void perf_top__reset_sample_counters(struct perf_top *top)
 {
 	top->samples = top->us_samples = top->kernel_samples =
 	top->exact_samples = top->guest_kernel_samples =
-	top->guest_us_samples = top->lost = 0;
+	top->guest_us_samples = top->lost = top->drop = 0;
 }
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 5bce62ebcf14..19f95eaf75c8 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -22,7 +22,7 @@ struct perf_top {
 	 * Symbols will be added here in perf_event__process_sample and will
 	 * get out after decayed.
 	 */
-	u64		   samples, lost, lost_total;
+	u64		   samples, lost, lost_total, drop, drop_total;
 	u64		   kernel_samples, us_samples;
 	u64		   exact_samples;
 	u64		   guest_us_samples, guest_kernel_samples;
-- 
2.17.2

