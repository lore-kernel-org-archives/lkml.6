Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933978AbeCGPub (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:50:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933386AbeCGPu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:26 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 01/19] perf report: Fix the output for stdio events list
Date: Wed,  7 Mar 2018 16:50:02 +0100
Message-Id: <20180307155020.32613-2-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the output header for reporting forced groups
via --groups option on non grouped events, like:

  $ perf record -e 'cycles,instructions'
  $ perf report --stdio --group

Before:
  # Samples: 24  of event 'anon group { cycles:u, instructions:u }'

After:
  # Samples: 24  of events 'cycles:u, instructions:u'

Link: http://lkml.kernel.org/n/tip-1uizixi38t1v9cj2sgtmkj8o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c    | 17 ++++++++++++++---
 tools/perf/ui/browsers/hists.c |  5 +++--
 tools/perf/util/evsel.c        | 20 ++++++++++++++++----
 tools/perf/util/evsel.h        |  1 +
 4 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1eedb1815c4c..c3603d4c0c57 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -400,8 +400,10 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 
 	nr_samples = convert_unit(nr_samples, &unit);
 	ret = fprintf(fp, "# Samples: %lu%c", nr_samples, unit);
-	if (evname != NULL)
-		ret += fprintf(fp, " of event '%s'", evname);
+	if (evname != NULL) {
+		ret += fprintf(fp, " of event%s '%s'",
+			       evsel->nr_members > 1 ? "s" : "", evname);
+	}
 
 	if (rep->time_str)
 		ret += fprintf(fp, " (time slices: %s)", rep->time_str);
@@ -1175,8 +1177,17 @@ int cmd_report(int argc, const char **argv)
 	has_br_stack = perf_header__has_feat(&session->header,
 					     HEADER_BRANCH_STACK);
 
-	if (group_set && !session->evlist->nr_groups)
+	/*
+	 * Events in data file are not collect in groups, but we still want
+	 * the group display. Set the artificial group and set the leader's
+	 * forced_leader flag to notify the display code.
+	 */
+	if (group_set && !session->evlist->nr_groups) {
+		struct perf_evsel *leader = perf_evlist__first(session->evlist);
+
 		perf_evlist__set_leader(session->evlist);
+		leader->forced_leader = true;
+	}
 
 	if (itrace_synth_opts.last_branch)
 		has_br_stack = true;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index de2bde232cb3..8b4e82548f8e 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2261,8 +2261,9 @@ static int perf_evsel_browser_title(struct hist_browser *browser,
 
 	nr_samples = convert_unit(nr_samples, &unit);
 	printed = scnprintf(bf, size,
-			   "Samples: %lu%c of event '%s',%s%sEvent count (approx.): %" PRIu64,
-			   nr_samples, unit, ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
+			   "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
+			   nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
+			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
 
 
 	if (hists->uid_filter_str)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f1f883bb41a8..8948a8c1c187 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -621,22 +621,34 @@ const char *perf_evsel__group_name(struct perf_evsel *evsel)
 	return evsel->group_name ?: "anon group";
 }
 
+/*
+ * Returns the group details for the specified leader,
+ * with following rules.
+ *
+ *  For record -e '{cycles,instructions}'
+ *    'anon group { cycles:u, instructions:u }'
+ *
+ *  For record -e 'cycles,instructions' and report --group
+ *    'cycles:u, instructions:u'
+ */
 int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size)
 {
-	int ret;
+	int ret = 0;
 	struct perf_evsel *pos;
 	const char *group_name = perf_evsel__group_name(evsel);
 
-	ret = scnprintf(buf, size, "%s", group_name);
+	if (!evsel->forced_leader)
+		ret = scnprintf(buf, size, "%s { ", group_name);
 
-	ret += scnprintf(buf + ret, size - ret, " { %s",
+	ret += scnprintf(buf + ret, size - ret, "%s",
 			 perf_evsel__name(evsel));
 
 	for_each_group_member(pos, evsel)
 		ret += scnprintf(buf + ret, size - ret, ", %s",
 				 perf_evsel__name(pos));
 
-	ret += scnprintf(buf + ret, size - ret, " }");
+	if (!evsel->forced_leader)
+		ret += scnprintf(buf + ret, size - ret, " }");
 
 	return ret;
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 92ba001b627f..bb17afc429d9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -125,6 +125,7 @@ struct perf_evsel {
 	bool			per_pkg;
 	bool			precise_max;
 	bool			ignore_missing_thread;
+	bool			forced_leader;
 	/* parse modifier helper */
 	int			exclude_GH;
 	int			nr_members;
-- 
2.13.6
