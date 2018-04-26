Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbeDZF5U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:57:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57215 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeDZF5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:57:17 -0400
Date: Wed, 25 Apr 2018 22:56:48 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-30060eaed769039c6e523b9d159f2b2858fa8907@git.kernel.org>
Cc: will.deacon@arm.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        tglx@linutronix.de, ganapatrao.kulkarni@cavium.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        zhangshaokun@hisilicon.com, hpa@zytor.com, kan.liang@linux.intel.com,
        peterz@infradead.org, agustinv@codeaurora.org, namhyung@kernel.org,
        jolsa@redhat.com
Reply-To: acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        ganapatrao.kulkarni@cavium.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, will.deacon@arm.com, ak@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, agustinv@codeaurora.org,
        peterz@infradead.org, kan.liang@linux.intel.com, hpa@zytor.com,
        zhangshaokun@hisilicon.com
In-Reply-To: <1524594014-79243-2-git-send-email-kan.liang@linux.intel.com>
References: <1524594014-79243-2-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Print out hint for mixed PMU group
 error
Git-Commit-ID: 30060eaed769039c6e523b9d159f2b2858fa8907
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  30060eaed769039c6e523b9d159f2b2858fa8907
Gitweb:     https://git.kernel.org/tip/30060eaed769039c6e523b9d159f2b2858fa8907
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 24 Apr 2018 11:20:11 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Apr 2018 16:11:59 -0300

perf stat: Print out hint for mixed PMU group error

Perf doesn't support mixed events from different PMUs (except software
event) in a group. For this case, only "<not counted>" or "<not
supported>" are printed out. There is no hint which guides users to fix
the issue.

Checking the PMU type of events to determine if they are from the same
PMU. There may be false alarm for the checking. E.g. the core PMU has
different PMU type. But it should not happen often.

The false alarm can also be tolerated, because:

- It only happens on error path.
- It just provides a possible solution for the issue.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1524594014-79243-2-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 147a27e8c937..30e6b374e095 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -172,6 +172,7 @@ static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
+static int			print_mixed_hw_group_error;
 
 struct perf_stat {
 	bool			 record;
@@ -1126,6 +1127,30 @@ static void abs_printout(int id, int nr, struct perf_evsel *evsel, double avg)
 		fprintf(output, "%s%s", csv_sep, evsel->cgrp->name);
 }
 
+static bool is_mixed_hw_group(struct perf_evsel *counter)
+{
+	struct perf_evlist *evlist = counter->evlist;
+	u32 pmu_type = counter->attr.type;
+	struct perf_evsel *pos;
+
+	if (counter->nr_members < 2)
+		return false;
+
+	evlist__for_each_entry(evlist, pos) {
+		/* software events can be part of any hardware group */
+		if (pos->attr.type == PERF_TYPE_SOFTWARE)
+			continue;
+		if (pmu_type == PERF_TYPE_SOFTWARE) {
+			pmu_type = pos->attr.type;
+			continue;
+		}
+		if (pmu_type != pos->attr.type)
+			return true;
+	}
+
+	return false;
+}
+
 static void printout(int id, int nr, struct perf_evsel *counter, double uval,
 		     char *prefix, u64 run, u64 ena, double noise,
 		     struct runtime_stat *st)
@@ -1178,8 +1203,11 @@ static void printout(int id, int nr, struct perf_evsel *counter, double uval,
 			counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
 			csv_sep);
 
-		if (counter->supported)
+		if (counter->supported) {
 			print_free_counters_hint = 1;
+			if (is_mixed_hw_group(counter))
+				print_mixed_hw_group_error = 1;
+		}
 
 		fprintf(stat_config.output, "%-*s%s",
 			csv_output ? 0 : unit_width,
@@ -1757,6 +1785,11 @@ static void print_footer(void)
 "	echo 0 > /proc/sys/kernel/nmi_watchdog\n"
 "	perf stat ...\n"
 "	echo 1 > /proc/sys/kernel/nmi_watchdog\n");
+
+	if (print_mixed_hw_group_error)
+		fprintf(output,
+			"The events in group usually have to be from "
+			"the same PMU. Try reorganizing the group.\n");
 }
 
 static void print_counters(struct timespec *ts, int argc, const char **argv)
