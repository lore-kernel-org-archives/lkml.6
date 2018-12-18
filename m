Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F324C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F29217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeLROR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:17:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeLROR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:17:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEH3MB2855053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:17:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEH3w82855050;
        Tue, 18 Dec 2018 06:17:03 -0800
Date:   Tue, 18 Dec 2018 06:17:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-2lj87zz8tq9ye1ntax3ulw0n@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, davem@davemloft.net, namhyung@kernel.org,
        mingo@kernel.org, hpa@zytor.com
Reply-To: jolsa@kernel.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          hpa@zytor.com, namhyung@kernel.org, peterz@infradead.org,
          tglx@linutronix.de, davem@davemloft.net,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Save and display the drop count stats
Git-Commit-ID: 97f7e0b33db81fd821828390e9095771abe62816
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
Message-ID: <20181218141703.CfTx_sOrer12R7ifC4Cvxf3TY_PDEtZ9gmIFqef2fN8@z>

Commit-ID:  97f7e0b33db81fd821828390e9095771abe62816
Gitweb:     https://git.kernel.org/tip/97f7e0b33db81fd821828390e9095771abe62816
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 11 Nov 2018 20:02:46 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:58:33 -0300

perf top: Save and display the drop count stats

Add drop count to 'perf top' headers:

  # perf top --stdio
   PerfTop:    3549 irqs/sec  kernel:51.8%  exact: 100.0% lost: 0/0 drop: 0/0 [4000Hz cycles:ppp],  (all, 8 CPUs)

  # perf top
  Samples: 0  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 0 lost: 0/0 drop: 0/0

The format is: <current period drop>/<total drop>

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-2lj87zz8tq9ye1ntax3ulw0n@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c       | 5 ++++-
 tools/perf/ui/browsers/hists.c | 4 ++++
 tools/perf/util/top.c          | 7 ++++---
 tools/perf/util/top.h          | 2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 234232d538c2..9166f6087e3f 100644
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
