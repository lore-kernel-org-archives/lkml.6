Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A937C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5410B25C38
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5410B25C38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeGBU5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:57:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752391AbeGBU5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:57:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A37881663D8;
        Mon,  2 Jul 2018 20:57:22 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-25.brq.redhat.com [10.40.204.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 584201C55F;
        Mon,  2 Jul 2018 20:57:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/2] perf stat: Get rid of extra clock events display function
Date:   Mon,  2 Jul 2018 22:57:17 +0200
Message-Id: <20180702205717.24945-2-jolsa@kernel.org>
In-Reply-To: <20180702205717.24945-1-jolsa@kernel.org>
References: <20180702205717.24945-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 20:57:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 20:57:22 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to have separate function to display clock
events. It's only purpose was to convert the nanosecond value
into microseconds. We do that now in generic code, if the unit
and scale values are properly set, which this patch do for
clock events.

The output differs in the unit field being displayed in its
columns rather than having it added as a suffix of the event
name. Plus the value is rounded into 2 decimal numbers as
for any other event.

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

There's small difference in csv output, as we now output the unit field,
which was empty before. It's in the proper spot, so there's no compatibility
issue.

Before:

  # perf stat  -e cpu-clock,task-clock -C 0 -x, sleep 3
  3001.065177,,cpu-clock,3001064187,100.00,1.000,CPUs utilized
  3001.077085,,task-clock,3001077085,100.00,1.000,CPUs utilized

  # perf stat  -e cpu-clock,task-clock -C 0 -x, sleep 3
  3000.80,msec,cpu-clock,3000799026,100.00,1.000,CPUs utilized
  3000.80,msec,task-clock,3000799550,100.00,1.000,CPUs utilized

Adding perf_evsel__is_clock to replace nsec_counter.

Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/n/tip-f5uxatzy4kw9sh2b6hwhx697@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c     | 48 ++---------------------------------
 tools/perf/util/evsel.c       | 11 ++++++++
 tools/perf/util/evsel.h       |  6 +++++
 tools/perf/util/stat-shadow.c |  5 ++--
 4 files changed, 21 insertions(+), 49 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 05be023c3f0e..75c00073ca1b 100644
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
2.17.1

