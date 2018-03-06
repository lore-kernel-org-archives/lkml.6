Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932314AbeCFDrw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:47:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:42932 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753160AbeCFDrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:47:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="22835515"
From: changbin.du@intel.com
To: acme@kernel.org, jolsa@redhat.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2 1/2] perf sched: move thread::shortname to thread_runtime
Date: Tue,  6 Mar 2018 11:37:36 +0800
Message-Id: <1520307457-23668-2-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
References: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

The thread::shortname only used by sched command, so move it
to sched private structure.

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 tools/perf/builtin-sched.c | 95 +++++++++++++++++++++++++++-------------------
 tools/perf/util/thread.h   |  1 -
 2 files changed, 55 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 83283fe..5bfc8d5 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -255,6 +255,8 @@ struct thread_runtime {
 
 	int last_state;
 	u64 migrations;
+
+	char shortname[3];
 };
 
 /* per event run time data */
@@ -897,6 +899,37 @@ struct sort_dimension {
 	struct list_head	list;
 };
 
+/*
+ * handle runtime stats saved per thread
+ */
+static struct thread_runtime *thread__init_runtime(struct thread *thread)
+{
+	struct thread_runtime *r;
+
+	r = zalloc(sizeof(struct thread_runtime));
+	if (!r)
+		return NULL;
+
+	init_stats(&r->run_stats);
+	thread__set_priv(thread, r);
+
+	return r;
+}
+
+static struct thread_runtime *thread__get_runtime(struct thread *thread)
+{
+	struct thread_runtime *tr;
+
+	tr = thread__priv(thread);
+	if (tr == NULL) {
+		tr = thread__init_runtime(thread);
+		if (tr == NULL)
+			pr_debug("Failed to malloc memory for runtime data.\n");
+	}
+
+	return tr;
+}
+
 static int
 thread_lat_cmp(struct list_head *list, struct work_atoms *l, struct work_atoms *r)
 {
@@ -1480,6 +1513,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 {
 	const u32 next_pid = perf_evsel__intval(evsel, sample, "next_pid");
 	struct thread *sched_in;
+	struct thread_runtime *tr;
 	int new_shortname;
 	u64 timestamp0, timestamp = sample->time;
 	s64 delta;
@@ -1519,22 +1553,28 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 	if (sched_in == NULL)
 		return -1;
 
+	tr = thread__get_runtime(sched_in);
+	if (tr == NULL) {
+		thread__put(sched_in);
+		return -1;
+	}
+
 	sched->curr_thread[this_cpu] = thread__get(sched_in);
 
 	printf("  ");
 
 	new_shortname = 0;
-	if (!sched_in->shortname[0]) {
+	if (!tr->shortname[0]) {
 		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
 			/*
 			 * Don't allocate a letter-number for swapper:0
 			 * as a shortname. Instead, we use '.' for it.
 			 */
-			sched_in->shortname[0] = '.';
-			sched_in->shortname[1] = ' ';
+			tr->shortname[0] = '.';
+			tr->shortname[1] = ' ';
 		} else {
-			sched_in->shortname[0] = sched->next_shortname1;
-			sched_in->shortname[1] = sched->next_shortname2;
+			tr->shortname[0] = sched->next_shortname1;
+			tr->shortname[1] = sched->next_shortname2;
 
 			if (sched->next_shortname1 < 'Z') {
 				sched->next_shortname1++;
@@ -1552,6 +1592,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 	for (i = 0; i < cpus_nr; i++) {
 		int cpu = sched->map.comp ? sched->map.comp_cpus[i] : i;
 		struct thread *curr_thread = sched->curr_thread[cpu];
+		struct thread_runtime *curr_tr;
 		const char *pid_color = color;
 		const char *cpu_color = color;
 
@@ -1569,9 +1610,14 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 		else
 			color_fprintf(stdout, cpu_color, "*");
 
-		if (sched->curr_thread[cpu])
-			color_fprintf(stdout, pid_color, "%2s ", sched->curr_thread[cpu]->shortname);
-		else
+		if (sched->curr_thread[cpu]) {
+			curr_tr = thread__get_runtime(sched->curr_thread[cpu]);
+			if (curr_tr == NULL) {
+				thread__put(sched_in);
+				return -1;
+			}
+			color_fprintf(stdout, pid_color, "%2s ", curr_tr->shortname);
+		} else
 			color_fprintf(stdout, color, "   ");
 	}
 
@@ -1587,7 +1633,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 			pid_color = COLOR_PIDS;
 
 		color_fprintf(stdout, pid_color, "%s => %s:%d",
-		       sched_in->shortname, thread__comm_str(sched_in), sched_in->tid);
+		       tr->shortname, thread__comm_str(sched_in), sched_in->tid);
 	}
 
 	if (sched->map.comp && new_cpu)
@@ -2200,37 +2246,6 @@ static void save_idle_callchain(struct idle_thread_runtime *itr,
 	callchain_cursor__copy(&itr->cursor, &callchain_cursor);
 }
 
-/*
- * handle runtime stats saved per thread
- */
-static struct thread_runtime *thread__init_runtime(struct thread *thread)
-{
-	struct thread_runtime *r;
-
-	r = zalloc(sizeof(struct thread_runtime));
-	if (!r)
-		return NULL;
-
-	init_stats(&r->run_stats);
-	thread__set_priv(thread, r);
-
-	return r;
-}
-
-static struct thread_runtime *thread__get_runtime(struct thread *thread)
-{
-	struct thread_runtime *tr;
-
-	tr = thread__priv(thread);
-	if (tr == NULL) {
-		tr = thread__init_runtime(thread);
-		if (tr == NULL)
-			pr_debug("Failed to malloc memory for runtime data.\n");
-	}
-
-	return tr;
-}
-
 static struct thread *timehist_get_thread(struct perf_sched *sched,
 					  struct perf_sample *sample,
 					  struct machine *machine,
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 40cfa36..14d44c3 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -26,7 +26,6 @@ struct thread {
 	pid_t			ppid;
 	int			cpu;
 	refcount_t		refcnt;
-	char			shortname[3];
 	bool			comm_set;
 	int			comm_len;
 	bool			dead; /* if set thread has exited */
-- 
2.7.4
