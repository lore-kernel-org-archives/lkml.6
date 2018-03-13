Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeCMJ0v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:26:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752443AbeCMJ0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:26:48 -0400
Date: Tue, 13 Mar 2018 10:26:45 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Stephane Eranian <eranian@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Andi Kleen <ak@linux.intel.com>,
        David Carrillo-Cisneros <davidcc@google.com>
Subject: Re: [BUG] perf record: GROUP_DESC not supported in pipe mode
Message-ID: <20180313092645.GA16389@krava>
References: <CABPqkBSfsmvJ3P0zfkFmC17nJPrzmP+pO83TKoTByEZNJ+FH+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSfsmvJ3P0zfkFmC17nJPrzmP+pO83TKoTByEZNJ+FH+Q@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 06:06:54PM -0700, Stephane Eranian wrote:
> Hi,
> 
> I ran into a problem trying to group events in perf record while in pipe mode.
> If I do:
> 
> 
> $ perf record --group -e '{cycles, instructions}' -o - | perf report
> -i - --group
> 
> I do not get the profiles grouped together. Instead I get two profiles.
> 
> Looking at the code in util/header.c I see that a bunch of features and not
> supported in pipe mode (synthesized method). It is not clear to me why.
> Clearly grouping should be supported. This is a very commonly used mode.
> 
> Am I missing something?

nope, the support is missing.. attached patch fixes that for me
adding David to the loop, as it's touching the code he added

jirka


---
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d33103291b02..32f8ace5fdad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -754,13 +754,10 @@ static int record__synthesize(struct record *rec, bool tail)
 		return 0;
 
 	if (data->is_pipe) {
-		err = perf_event__synthesize_features(
-			tool, session, rec->evlist, process_synthesized_event);
-		if (err < 0) {
-			pr_err("Couldn't synthesize features.\n");
-			return err;
-		}
-
+		/*
+		 * We need to synthesize events first, because some
+		 * features works on top of them (on report side).
+		 */
 		err = perf_event__synthesize_attrs(tool, session,
 						   process_synthesized_event);
 		if (err < 0) {
@@ -768,6 +765,13 @@ static int record__synthesize(struct record *rec, bool tail)
 			goto out;
 		}
 
+		err = perf_event__synthesize_features(
+			tool, session, rec->evlist, process_synthesized_event);
+		if (err < 0) {
+			pr_err("Couldn't synthesize features.\n");
+			return err;
+		}
+
 		if (have_tracepoints(&rec->evlist->entries)) {
 			/*
 			 * FIXME err <= 0 here actually means that
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 971ccba85464..fbeb5ef8446a 100644
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
@@ -193,6 +194,44 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
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
+		pr_err("failed: wrong feature ID: %" PRIu64 "\n", event->feat.feat_id);
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
@@ -940,7 +979,6 @@ int cmd_report(int argc, const char **argv)
 		"perf report [<options>]",
 		NULL
 	};
-	bool group_set = false;
 	struct report report = {
 		.tool = {
 			.sample		 = process_sample_event,
@@ -958,7 +996,7 @@ int cmd_report(int argc, const char **argv)
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_event__process_auxtrace_info,
 			.auxtrace	 = perf_event__process_auxtrace,
-			.feature	 = perf_event__process_feature,
+			.feature	 = process_feature_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
 		},
@@ -1060,7 +1098,7 @@ int cmd_report(int argc, const char **argv)
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
-	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &group_set,
+	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &report.group_set,
 		    "Show event group information together"),
 	OPT_CALLBACK_NOOPT('b', "branch-stack", &branch_mode, "",
 		    "use branch records for per branch histogram filling",
@@ -1177,17 +1215,7 @@ int cmd_report(int argc, const char **argv)
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
index e14b3f7c7212..06bada952953 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3415,8 +3415,17 @@ int perf_event__synthesize_features(struct perf_tool *tool,
 			return ret;
 		}
 	}
+
+	/* Send LAST_FEATURE mark. */
+	fe = ff.buf;
+	fe->feat_id = HEADER_LAST_FEATURE;
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
