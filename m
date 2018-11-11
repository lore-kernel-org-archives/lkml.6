Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928ECC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA8620881
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA8620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbeKLGyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:54:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeKLGyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:54:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0289183F46;
        Sun, 11 Nov 2018 21:04:42 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19E175C1B4;
        Sun, 11 Nov 2018 21:04:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/3] perf stat: Add cputime metric support
Date:   Sun, 11 Nov 2018 22:04:26 +0100
Message-Id: <20181111210426.28712-4-jolsa@kernel.org>
In-Reply-To: <20181111210426.28712-1-jolsa@kernel.org>
References: <20181111210426.28712-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 11 Nov 2018 21:04:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --top/--top-full options to provide metrics based
on the cputime PMU events. Simply all the metrics are simple
ratios of events to STAT_NSECS time to get their % value.

The --top option provides basic subset of cputime metrics:

  # perf stat --top -I 1000
  #           time       Idle     System       User        Irq    Softirq    IO wait
       1.001692690     100.0%       0.0%       0.0%       0.7%       0.2%       0.0%
       2.002994039      98.9%       0.0%       0.0%       0.9%       0.2%       0.0%
       3.004164038      98.5%       0.2%       0.2%       0.9%       0.2%       0.0%
       4.005312773      98.9%       0.0%       0.0%       0.9%       0.2%       0.0%

The --top-full option provides all cputime metrics:

  # perf stat --top-full -I 1000
  #           time       Idle     System       User        Irq    Softirq    IO wait      Guest Guest nice       Nice      Steal
       1.001750803     100.0%       0.0%       0.0%       0.7%       0.2%       0.0%       0.0%       0.0%       0.0%       0.0%
       2.003159490      99.0%       0.0%       0.0%       0.9%       0.2%       0.0%       0.0%       0.0%       0.0%       0.0%
       3.004358366      99.0%       0.0%       0.0%       0.9%       0.2%       0.0%       0.0%       0.0%       0.0%       0.0%
       4.005592436      98.9%       0.0%       0.0%       0.9%       0.2%       0.0%       0.0%       0.0%       0.0%       0.0%

Link: http://lkml.kernel.org/n/tip-zue4s78pxc1cybb954t52ks4@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt | 65 +++++++++++++++++++++++
 tools/perf/builtin-stat.c              | 47 +++++++++++++++++
 tools/perf/util/stat-shadow.c          | 72 ++++++++++++++++++++++++++
 tools/perf/util/stat.c                 | 10 ++++
 tools/perf/util/stat.h                 | 10 ++++
 5 files changed, 204 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index b10a90b6a718..9330765b7225 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -310,6 +310,71 @@ The output is SMI cycles%, equals to (aperf - unhalted core cycles) / aperf
 
 Users who wants to get the actual value can apply --no-metric-only.
 
+--top::
+--top-full:
+Measure cputime PMU events and display percentage of CPU utilization rates.
+
+The --top option displays rates for following events:
+  idle system user irq softirq iowait
+
+The --top-full option displays additional rates:
+  guest guest_nice nice steal
+
+Examples:
+  # perf stat --top
+  ^C
+   Performance counter stats for 'system wide':
+
+        Idle     System       User        Irq    Softirq    IO wait
+        1.3%      89.5%       7.4%       1.8%       0.1%       0.0%
+
+         7.282332605 seconds time elapsed
+
+  # perf stat --top-full
+  ^C
+   Performance counter stats for 'system wide':
+
+        Idle     System       User        Irq    Softirq    IO wait      Guest Guest nice       Nice      Steal
+        5.4%      85.4%       8.6%       0.5%       0.1%       0.0%       0.0%       0.0%       0.0%       0.0%
+
+         7.618359683 seconds time elapsed
+
+  # perf stat --top -I 1000
+  #           time       Idle     System       User        Irq    Softirq    IO wait
+       1.000525839       5.4%      85.3%       8.8%       0.4%       0.1%       0.0%
+       2.001032632       5.1%      85.7%       8.7%       0.4%       0.1%       0.0%
+       3.001388414       5.2%      85.7%       8.6%       0.4%       0.1%       0.0%
+       4.001758697       5.7%      85.2%       8.6%       0.5%       0.1%       0.0%
+
+  # perf stat --top -I 1000 -A
+  #           time CPU           Idle     System       User        Irq    Softirq    IO wait
+       1.000485174 CPU0          6.9%      84.0%       8.6%       0.5%       0.1%       0.0%
+       1.000485174 CPU1          5.5%      84.8%       9.1%       0.5%       0.1%       0.0%
+       1.000485174 CPU2          5.5%      86.6%       7.4%       0.5%       0.1%       0.0%
+       ...
+
+  # perf stat --top -I 1000 --per-core
+  #           time core         cpus       Idle     System       User        Irq    Softirq    IO wait
+       1.000450719 S0-C0           2       4.6%      87.0%       7.9%       0.4%       0.1%       0.0%
+       1.000450719 S0-C1           2       4.8%      86.3%       8.3%       0.4%       0.1%       0.0%
+       1.000450719 S0-C2           2       5.3%      86.3%       7.8%       0.4%       0.1%       0.0%
+       1.000450719 S0-C3           2       5.2%      85.5%       8.7%       0.4%       0.1%       0.0%
+       1.000450719 S0-C4           2       4.5%      86.7%       8.3%       0.4%       0.1%       0.0%
+
+  # perf stat --top ./perf bench sched messaging -l 10000
+  ...
+     Total time: 7.089 [sec]
+
+   Performance counter stats for './perf bench sched messaging -l 10000':
+
+        Idle     System       User        Irq    Softirq    IO wait
+        0.0%      90.1%       8.9%       0.5%       0.1%       0.0%
+
+         7.186366800 seconds time elapsed
+
+        14.527066000 seconds user
+       146.254278000 seconds sys
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a635abfa77b6..23e4e1b76ebb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -133,6 +133,34 @@ static const char *smi_cost_attrs = {
 	"}"
 };
 
+static const char *top_attrs = {
+	"{"
+	"cpu-clock,"
+	"cputime/idle/,"
+	"cputime/system/,"
+	"cputime/user/,"
+	"cputime/irq/,"
+	"cputime/softirq/,"
+	"cputime/iowait/"
+	"}"
+};
+
+static const char *top_full_attrs = {
+	"{"
+	"cpu-clock,"
+	"cputime/idle/,"
+	"cputime/system/,"
+	"cputime/user/,"
+	"cputime/irq/,"
+	"cputime/softirq/,"
+	"cputime/iowait/,"
+	"cputime/guest/,"
+	"cputime/guest_nice/,"
+	"cputime/nice/,"
+	"cputime/steal/"
+	"}"
+};
+
 static struct perf_evlist	*evsel_list;
 
 static struct target target = {
@@ -145,6 +173,8 @@ static volatile pid_t		child_pid			= -1;
 static int			detailed_run			=  0;
 static bool			transaction_run;
 static bool			topdown_run			= false;
+static bool			top_run				= false;
+static bool			top_run_full			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
 static int			big_num_opt			=  -1;
@@ -786,6 +816,8 @@ static const struct option stat_options[] = {
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
 		     parse_metric_groups),
+	OPT_BOOLEAN(0, "top", &top_run, "show CPU utilization"),
+	OPT_BOOLEAN(0, "top-full", &top_run_full, "show extended CPU utilization"),
 	OPT_END()
 };
 
@@ -1186,6 +1218,21 @@ static int add_default_attributes(void)
 		return 0;
 	}
 
+	if (top_run || top_run_full) {
+		const char *attrs = top_run ? top_attrs : top_full_attrs;
+
+		err = parse_events(evsel_list, attrs, &errinfo);
+		if (err) {
+			fprintf(stderr, "Cannot set up cputime events\n");
+			parse_events_print_error(&errinfo, attrs);
+			return -1;
+		}
+		if (!force_metric_only)
+			stat_config.metric_only = true;
+		stat_config.metric_only_len = 10;
+		return 0;
+	}
+
 	if (smi_cost) {
 		int smi;
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 8ad32763cfff..7e24b042d0d2 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -760,6 +760,46 @@ static void generic_metric(struct perf_stat_config *config,
 		print_metric(config, ctxp, NULL, NULL, "", 0);
 }
 
+static void cputime_color_name(struct perf_evsel *evsel,
+			       const char **color, const char **name,
+			       double ratio)
+{
+	if (perf_stat_evsel__is(evsel, CPUTIME_IDLE)) {
+		if (ratio < 0.8)
+			*color = PERF_COLOR_GREEN;
+		if (ratio < 0.5)
+			*color = PERF_COLOR_RED;
+		*name = "Idle";
+		return;
+	}
+
+	if (ratio > (MIN_GREEN / 100))
+		*color = PERF_COLOR_GREEN;
+	if (ratio > (MIN_RED / 100))
+		*color = PERF_COLOR_RED;
+
+	if (perf_stat_evsel__is(evsel, CPUTIME_GUEST))
+		*name = "Guest";
+	else if (perf_stat_evsel__is(evsel, CPUTIME_GUEST_NICE))
+		*name = "Guest nice";
+	else if (perf_stat_evsel__is(evsel, CPUTIME_IOWAIT))
+		*name = "IO wait";
+	else if (perf_stat_evsel__is(evsel, CPUTIME_IRQ))
+		*name = "Irq";
+	else if (perf_stat_evsel__is(evsel, CPUTIME_NICE))
+		*name = "Nice";
+	else if (perf_stat_evsel__is(evsel, CPUTIME_SOFTIRQ))
+		*name = "Softirq";
+	else if (perf_stat_evsel__is(evsel, CPUTIME_STEAL))
+		*name = "Steal";
+	else if (perf_stat_evsel__is(evsel, CPUTIME_SYSTEM))
+		*name = "System";
+	else if (perf_stat_evsel__is(evsel, CPUTIME_USER))
+		*name = "User";
+	else
+		*name = "unknown";
+}
+
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct perf_evsel *evsel,
 				   double avg, int cpu,
@@ -970,6 +1010,38 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					be_bound * 100.);
 		else
 			print_metric(config, ctxp, NULL, NULL, name, 0);
+	} else if (perf_stat_evsel__is(evsel, CPUTIME_GUEST)      ||
+		   perf_stat_evsel__is(evsel, CPUTIME_GUEST_NICE) ||
+		   perf_stat_evsel__is(evsel, CPUTIME_IDLE)       ||
+		   perf_stat_evsel__is(evsel, CPUTIME_IOWAIT)     ||
+		   perf_stat_evsel__is(evsel, CPUTIME_IRQ)        ||
+		   perf_stat_evsel__is(evsel, CPUTIME_NICE)       ||
+		   perf_stat_evsel__is(evsel, CPUTIME_SOFTIRQ)    ||
+		   perf_stat_evsel__is(evsel, CPUTIME_STEAL)      ||
+		   perf_stat_evsel__is(evsel, CPUTIME_SYSTEM)     ||
+		   perf_stat_evsel__is(evsel, CPUTIME_USER)) {
+
+		const char *name = NULL;
+
+		total = runtime_stat_avg(st, STAT_NSECS, ctx, cpu);
+		/* STAT_NSECS is usec, cputime in nsec, converting */
+		total *= 1e6;
+
+		if (total)
+			ratio = avg / total;
+
+		cputime_color_name(evsel, &color, &name, ratio);
+
+		/*
+		 * The cputime meassures are tricky, we can easily get some noise
+		 * over 100% ... so let's be proactive and don't confuse users ;-)
+		 */
+		ratio = min(1., ratio);
+
+		if (total)
+			print_metric(config, ctxp, color, "%8.1f%%", name, ratio * 100.);
+		else
+			print_metric(config, ctxp, NULL, NULL, name, 0);
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, evsel->name,
 				evsel->metric_name, avg, cpu, out, st);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4d40515307b8..c07d97083333 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -89,6 +89,16 @@ static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 	ID(TOPDOWN_RECOVERY_BUBBLES, topdown-recovery-bubbles),
 	ID(SMI_NUM, msr/smi/),
 	ID(APERF, msr/aperf/),
+	ID(CPUTIME_GUEST,	cputime/guest/),
+	ID(CPUTIME_GUEST_NICE,	cputime/guest_nice/),
+	ID(CPUTIME_IDLE,	cputime/idle/),
+	ID(CPUTIME_IOWAIT,	cputime/iowait/),
+	ID(CPUTIME_IRQ,		cputime/irq/),
+	ID(CPUTIME_NICE,	cputime/nice/),
+	ID(CPUTIME_SOFTIRQ,	cputime/softirq/),
+	ID(CPUTIME_STEAL,	cputime/steal/),
+	ID(CPUTIME_SYSTEM,	cputime/system/),
+	ID(CPUTIME_USER,	cputime/user/),
 };
 #undef ID
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 2f9c9159a364..f2582d89ef35 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -31,6 +31,16 @@ enum perf_stat_evsel_id {
 	PERF_STAT_EVSEL_ID__TOPDOWN_RECOVERY_BUBBLES,
 	PERF_STAT_EVSEL_ID__SMI_NUM,
 	PERF_STAT_EVSEL_ID__APERF,
+	PERF_STAT_EVSEL_ID__CPUTIME_GUEST,
+	PERF_STAT_EVSEL_ID__CPUTIME_GUEST_NICE,
+	PERF_STAT_EVSEL_ID__CPUTIME_IDLE,
+	PERF_STAT_EVSEL_ID__CPUTIME_IOWAIT,
+	PERF_STAT_EVSEL_ID__CPUTIME_IRQ,
+	PERF_STAT_EVSEL_ID__CPUTIME_NICE,
+	PERF_STAT_EVSEL_ID__CPUTIME_SOFTIRQ,
+	PERF_STAT_EVSEL_ID__CPUTIME_STEAL,
+	PERF_STAT_EVSEL_ID__CPUTIME_SYSTEM,
+	PERF_STAT_EVSEL_ID__CPUTIME_USER,
 	PERF_STAT_EVSEL_ID__MAX,
 };
 
-- 
2.17.2

