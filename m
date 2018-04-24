Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDXSVD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:21:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:3113 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbeDXSU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:20:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="35837922"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, ganapatrao.kulkarni@cavium.com,
        zhangshaokun@hisilicon.com, yao.jin@linux.intel.com,
        will.deacon@arm.com, ak@linux.intel.com, agustinv@codeaurora.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/5] perf stat: Print out hint for mixed PMU group error
Date: Tue, 24 Apr 2018 11:20:11 -0700
Message-Id: <1524594014-79243-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
References: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
---
 tools/perf/builtin-stat.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 147a27e..30e6b37 100644
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
-- 
2.7.4
