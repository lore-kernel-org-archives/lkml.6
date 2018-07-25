Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF3C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050D120833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT50pTsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050D120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeGYTPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYTPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:15:33 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B4620852;
        Wed, 25 Jul 2018 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541766;
        bh=wdYdDiev83WsDzfyt345PRKGVsS6DatqKz0NWGJ4PXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sT50pTsl8U/sz5t2EH2kTGbPVgo3tLdFBc/48I126MJ6atyc7jDRiUenMREsFJcN1
         97ju2aPqZBc9GKwZqMA2AX+thcFRefoYEtB4W4qd1umNDkNN2dXJxoMxkKzC4GhfIu
         YVB78Qv+gEDUCqBSOhlC5LUWMlTSM/bZ+bQ/766k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/27] perf stat: Get rid of extra clock display function
Date:   Wed, 25 Jul 2018 15:00:00 -0300
Message-Id: <20180725180001.15108-27-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no reason to have separate function to display clock events.
It's only purpose was to convert the nanosecond value into microseconds.
We do that now in generic code, if the unit and scale values are
properly set, which this patch do for clock events.

The output differs in the unit field being displayed in its columns
rather than having it added as a suffix of the event name. Plus the
value is rounded into 2 decimal numbers as for any other event.

Before:

  # perf stat  -e cpu-clock,task-clock -C 0 sleep 3

   Performance counter stats for 'CPU(s) 0':

       3001.123137      cpu-clock (msec)          #    1.000 CPUs utilized
       3001.133250      task-clock (msec)         #    1.000 CPUs utilized

       3.001159813 seconds time elapsed

Now:

  # perf stat  -e cpu-clock,task-clock -C 0 sleep 3

   Performance counter stats for 'CPU(s) 0':

          3,001.05 msec cpu-clock                 #    1.000 CPUs utilized
          3,001.05 msec task-clock                #    1.000 CPUs utilized

       3.001077794 seconds time elapsed

There's a small difference in csv output, as we now output the unit
field, which was empty before. It's in the proper spot, so there's no
compatibility issue.

Before:

  # perf stat  -e cpu-clock,task-clock -C 0 -x, sleep 3
  3001.065177,,cpu-clock,3001064187,100.00,1.000,CPUs utilized
  3001.077085,,task-clock,3001077085,100.00,1.000,CPUs utilized

  # perf stat  -e cpu-clock,task-clock -C 0 -x, sleep 3
  3000.80,msec,cpu-clock,3000799026,100.00,1.000,CPUs utilized
  3000.80,msec,task-clock,3000799550,100.00,1.000,CPUs utilized

Add perf_evsel__is_clock to replace nsec_counter.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180720110036.32251-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c     | 48 ++-----------------------------------------
 tools/perf/util/evsel.c       | 11 ++++++++++
 tools/perf/util/evsel.h       |  6 ++++++
 tools/perf/util/stat-shadow.c |  5 ++---
 4 files changed, 21 insertions(+), 49 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index dfd13d6e2931..d097b5b47eb8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -296,18 +296,6 @@ static int create_perf_stat_counter(struct perf_evsel *evsel)
 	return perf_evsel__open_per_thread(evsel, evsel_list->threads);
 }
 
-/*
- * Does the counter have nsecs as a unit?
- */
-static inline int nsec_counter(struct perf_evsel *evsel)
-{
-	if (perf_evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
-	    perf_evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK))
-		return 1;
-
-	return 0;
-}
-
 static int process_synthesized_event(struct perf_tool *tool __maybe_unused,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -1058,34 +1046,6 @@ static void print_metric_header(void *ctx, const char *color __maybe_unused,
 		fprintf(os->fh, "%*s ", metric_only_len, unit);
 }
 
-static void nsec_printout(int id, int nr, struct perf_evsel *evsel, double avg)
-{
-	FILE *output = stat_config.output;
-	double msecs = avg / NSEC_PER_MSEC;
-	const char *fmt_v, *fmt_n;
-	char name[25];
-
-	fmt_v = csv_output ? "%.6f%s" : "%18.6f%s";
-	fmt_n = csv_output ? "%s" : "%-25s";
-
-	aggr_printout(evsel, id, nr);
-
-	scnprintf(name, sizeof(name), "%s%s",
-		  perf_evsel__name(evsel), csv_output ? "" : " (msec)");
-
-	fprintf(output, fmt_v, msecs, csv_sep);
-
-	if (csv_output)
-		fprintf(output, "%s%s", evsel->unit, csv_sep);
-	else
-		fprintf(output, "%-*s%s", unit_width, evsel->unit, csv_sep);
-
-	fprintf(output, fmt_n, name);
-
-	if (evsel->cgrp)
-		fprintf(output, "%s%s", csv_sep, evsel->cgrp->name);
-}
-
 static int first_shadow_cpu(struct perf_evsel *evsel, int id)
 {
 	int i;
@@ -1241,11 +1201,7 @@ static void printout(int id, int nr, struct perf_evsel *counter, double uval,
 		return;
 	}
 
-	if (metric_only)
-		/* nothing */;
-	else if (nsec_counter(counter))
-		nsec_printout(id, nr, counter, uval);
-	else
+	if (!metric_only)
 		abs_printout(id, nr, counter, uval);
 
 	out.print_metric = pm;
@@ -1331,7 +1287,7 @@ static void collect_all_aliases(struct perf_evsel *counter,
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
 		    strcmp(alias->unit, counter->unit) ||
-		    nsec_counter(alias) != nsec_counter(counter))
+		    perf_evsel__is_clock(alias) != perf_evsel__is_clock(counter))
 			break;
 		alias->merged_stat = true;
 		cb(alias, data, false);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 94fce4f537e9..5285da0417c5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -260,6 +260,17 @@ struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 		evsel->attr.sample_period = 1;
 	}
 
+	if (perf_evsel__is_clock(evsel)) {
+		/*
+		 * The evsel->unit points to static alias->unit
+		 * so it's ok to use static string in here.
+		 */
+		static const char *unit = "msec";
+
+		evsel->unit = unit;
+		evsel->scale = 1e-6;
+	}
+
 	return evsel;
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 890babf9ce86..973c03167947 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -405,6 +405,12 @@ static inline bool perf_evsel__is_bpf_output(struct perf_evsel *evsel)
 	return perf_evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
 }
 
+static inline bool perf_evsel__is_clock(struct perf_evsel *evsel)
+{
+	return perf_evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
+	       perf_evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
+}
+
 struct perf_attr_details {
 	bool freq;
 	bool verbose;
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 594d14a02b67..99990f5f2512 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -913,11 +913,10 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 			ratio = total / avg;
 
 		print_metric(ctxp, NULL, "%8.0f", "cycles / elision", ratio);
-	} else if (perf_evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK) ||
-		   perf_evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK)) {
+	} else if (perf_evsel__is_clock(evsel)) {
 		if ((ratio = avg_stats(&walltime_nsecs_stats)) != 0)
 			print_metric(ctxp, NULL, "%8.3f", "CPUs utilized",
-				     avg / ratio);
+				     avg / (ratio * evsel->scale));
 		else
 			print_metric(ctxp, NULL, NULL, "CPUs utilized", 0);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
-- 
2.14.4

