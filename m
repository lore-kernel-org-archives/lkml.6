Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCNJYs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:24:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751379AbeCNJWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:22:09 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/2] perf report: Support forced leader feature in pipe mode
Date: Wed, 14 Mar 2018 10:22:05 +0100
Message-Id: <20180314092205.23291-2-jolsa@kernel.org>
In-Reply-To: <20180314092205.23291-1-jolsa@kernel.org>
References: <20180314092205.23291-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan reported a problem with forced leader in pipe mode,
where report does not force the group output. The reason is
that we don't force the leader in pipe mode.

This patch adds HEADER_LAST_FEATURE mark to have a point
where we have all events and features received, and
force the group if requested.

  $ perf record --group -e '{cycles, instructions}' -o - kill | perf report -i - --group

  SNIP

  #         Overhead  Command  Shared Object     Symbol
  # ................  .......  ................  .......................
  #
      28.36%   0.00%  kill     libc-2.25.so      [.] __unregister_atfork
      26.32%   0.00%  kill     libc-2.25.so      [.] _dl_addr
      26.10%   0.00%  kill     ld-2.25.so        [.] _dl_relocate_object
      17.32%   0.00%  kill     ld-2.25.so        [.] __tunables_init
       1.70%   0.01%  kill     [unknown]         [k] 0xffffffffafa01a40
       0.20%   0.00%  kill     ld-2.25.so        [.] _start
       0.00%  48.77%  kill     ld-2.25.so        [.] do_lookup_x
       0.00%  42.97%  kill     libc-2.25.so      [.] _IO_getline
       0.00%   6.35%  kill     ld-2.25.so        [.] strcmp
       0.00%   1.71%  kill     ld-2.25.so        [.] _dl_sysdep_start
       0.00%   0.19%  kill     ld-2.25.so        [.] _dl_start

Link: http://lkml.kernel.org/n/tip-afxv5ufoxsbtxfhzupcv9ktg@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c | 57 ++++++++++++++++++++++++++++++++++-----------
 tools/perf/util/header.c    | 11 ++++++++-
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 971ccba85464..91da12975642 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -68,6 +68,7 @@ struct report {
 	bool			header;
 	bool			header_only;
 	bool			nonany_branch_mode;
+	bool			group_set;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
 	const char		*pretty_printing_style;
@@ -193,6 +194,45 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	return err;
 }
 
+/*
+ * Events in data file are not collect in groups, but we still want
+ * the group display. Set the artificial group and set the leader's
+ * forced_leader flag to notify the display code.
+ */
+static void setup_forced_leader(struct report *report,
+				struct perf_evlist *evlist)
+{
+	if (report->group_set && !evlist->nr_groups) {
+		struct perf_evsel *leader = perf_evlist__first(evlist);
+
+		perf_evlist__set_leader(evlist);
+		leader->forced_leader = true;
+	}
+}
+
+static int process_feature_event(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_session *session __maybe_unused)
+{
+	struct report *rep = container_of(tool, struct report, tool);
+
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(tool, event, session);
+
+	if (event->feat.feat_id != HEADER_LAST_FEATURE) {
+		pr_err("failed: wrong feature ID: %" PRIu64 "\n",
+		       event->feat.feat_id);
+		return -1;
+	}
+
+	/*
+	 * All features are received, we can force the
+	 * group if needed.
+	 */
+	setup_forced_leader(rep, session->evlist);
+	return 0;
+}
+
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -940,7 +980,6 @@ int cmd_report(int argc, const char **argv)
 		"perf report [<options>]",
 		NULL
 	};
-	bool group_set = false;
 	struct report report = {
 		.tool = {
 			.sample		 = process_sample_event,
@@ -958,7 +997,7 @@ int cmd_report(int argc, const char **argv)
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_event__process_auxtrace_info,
 			.auxtrace	 = perf_event__process_auxtrace,
-			.feature	 = perf_event__process_feature,
+			.feature	 = process_feature_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
 		},
@@ -1060,7 +1099,7 @@ int cmd_report(int argc, const char **argv)
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
-	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &group_set,
+	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &report.group_set,
 		    "Show event group information together"),
 	OPT_CALLBACK_NOOPT('b', "branch-stack", &branch_mode, "",
 		    "use branch records for per branch histogram filling",
@@ -1177,17 +1216,7 @@ int cmd_report(int argc, const char **argv)
 	has_br_stack = perf_header__has_feat(&session->header,
 					     HEADER_BRANCH_STACK);
 
-	/*
-	 * Events in data file are not collect in groups, but we still want
-	 * the group display. Set the artificial group and set the leader's
-	 * forced_leader flag to notify the display code.
-	 */
-	if (group_set && !session->evlist->nr_groups) {
-		struct perf_evsel *leader = perf_evlist__first(session->evlist);
-
-		perf_evlist__set_leader(session->evlist);
-		leader->forced_leader = true;
-	}
+	setup_forced_leader(&report, session->evlist);
 
 	if (itrace_synth_opts.last_branch)
 		has_br_stack = true;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e14b3f7c7212..121df1683c36 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3415,8 +3415,17 @@ int perf_event__synthesize_features(struct perf_tool *tool,
 			return ret;
 		}
 	}
+
+	/* Send HEADER_LAST_FEATURE mark. */
+	fe = ff.buf;
+	fe->feat_id     = HEADER_LAST_FEATURE;
+	fe->header.type = PERF_RECORD_HEADER_FEATURE;
+	fe->header.size = sizeof(*fe);
+
+	ret = process(tool, ff.buf, NULL, NULL);
+
 	free(ff.buf);
-	return 0;
+	return ret;
 }
 
 int perf_event__process_feature(struct perf_tool *tool,
-- 
2.13.6
