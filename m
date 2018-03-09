Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeCIIwU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:52:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeCIIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:52:19 -0500
Date: Fri, 9 Mar 2018 00:51:56 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-8ef278bb9305e1269f236013718801fe06a183d1@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com, mingo@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        eranian@google.com, hpa@zytor.com
Reply-To: eranian@google.com, hpa@zytor.com, namhyung@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        peterz@infradead.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de
In-Reply-To: <20180307155020.32613-2-jolsa@kernel.org>
References: <20180307155020.32613-2-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Fix the output for stdio events list
Git-Commit-ID: 8ef278bb9305e1269f236013718801fe06a183d1
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

Commit-ID:  8ef278bb9305e1269f236013718801fe06a183d1
Gitweb:     https://git.kernel.org/tip/8ef278bb9305e1269f236013718801fe06a183d1
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:50:02 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:36 -0300

perf report: Fix the output for stdio events list

Changing the output header for reporting forced groups via --groups
option on non grouped events, like:

  $ perf record -e 'cycles,instructions'
  $ perf report --stdio --group

Before:

  # Samples: 24  of event 'anon group { cycles:u, instructions:u }'

After:

  # Samples: 24  of events 'cycles:u, instructions:u'

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Fixes: ad52b8cb4886 ("perf report: Add support to display group output for non group events")
Link: http://lkml.kernel.org/r/20180307155020.32613-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
@@ -1175,8 +1177,17 @@ repeat:
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
index e937894654b2..1ac8d9236efd 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -622,22 +622,34 @@ const char *perf_evsel__group_name(struct perf_evsel *evsel)
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
index 55ae1cda7396..d3ee3af618ef 100644
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
