Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCIIiD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:38:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeCIIiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:38:02 -0500
Date: Fri, 9 Mar 2018 00:37:40 -0800
From: tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-99a3c3a91382a7e5e841a98467a8409b47b540f0@git.kernel.org>
Cc: namhyung@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, jolsa@kernel.org, acme@redhat.com, hpa@zytor.com,
        changbin.du@intel.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, peterz@infradead.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, changbin.du@intel.com, hpa@zytor.com,
        acme@redhat.com, namhyung@kernel.org, mingo@kernel.org
In-Reply-To: <1520307457-23668-3-git-send-email-changbin.du@intel.com>
References: <1520307457-23668-3-git-send-email-changbin.du@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf sched map: Re-annotate shortname if thread
 comm changed
Git-Commit-ID: 99a3c3a91382a7e5e841a98467a8409b47b540f0
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

Commit-ID:  99a3c3a91382a7e5e841a98467a8409b47b540f0
Gitweb:     https://git.kernel.org/tip/99a3c3a91382a7e5e841a98467a8409b47b540f0
Author:     Changbin Du <changbin.du@intel.com>
AuthorDate: Tue, 6 Mar 2018 11:37:37 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:26 -0300

perf sched map: Re-annotate shortname if thread comm changed

This is to show the real name of thread that created via fork-exec.  See
below example for shortname *A0*.

$ sudo ./perf sched map
              *A0   80393.050639 secs A0 => perf:22368
          *.   A0   80393.050748 secs .  => swapper:0
           .  *.    80393.050887 secs
      *B0  .   .    80393.052735 secs B0 => rcu_sched:8
      *.   .   .    80393.052743 secs
       .  *C0  .    80393.056264 secs C0 => kworker/2:1H:287
       .  *A0  .    80393.056270 secs
       .  *D0  .    80393.056769 secs D0 => ksoftirqd/2:22
-      .  *A0  .    80393.056804 secs
+      .  *A0  .    80393.056804 secs A0 => pi:22368
       .  *.   .    80393.056854 secs
      *B0  .   .    80393.060727 secs
      ...

Signed-off-by: Changbin Du <changbin.du@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1520307457-23668-3-git-send-email-changbin.du@intel.com
[ Optimally pack struct thread_runtime when adding the new bool member ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0a632a6b6228..4dfdee668b0c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -256,6 +256,8 @@ struct thread_runtime {
 	int last_state;
 
 	char shortname[3];
+	bool comm_changed;
+
 	u64 migrations;
 };
 
@@ -1626,7 +1628,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 
 	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
 	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
-	if (new_shortname || (verbose > 0 && sched_in->tid)) {
+	if (new_shortname || tr->comm_changed || (verbose > 0 && sched_in->tid)) {
 		const char *pid_color = color;
 
 		if (thread__has_color(sched_in))
@@ -1634,6 +1636,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 
 		color_fprintf(stdout, pid_color, "%s => %s:%d",
 		       tr->shortname, thread__comm_str(sched_in), sched_in->tid);
+		tr->comm_changed = false;
 	}
 
 	if (sched->map.comp && new_cpu)
@@ -1737,6 +1740,37 @@ static int perf_sched__process_tracepoint_sample(struct perf_tool *tool __maybe_
 	return err;
 }
 
+static int perf_sched__process_comm(struct perf_tool *tool __maybe_unused,
+				    union perf_event *event,
+				    struct perf_sample *sample,
+				    struct machine *machine)
+{
+	struct thread *thread;
+	struct thread_runtime *tr;
+	int err;
+
+	err = perf_event__process_comm(tool, event, sample, machine);
+	if (err)
+		return err;
+
+	thread = machine__find_thread(machine, sample->pid, sample->tid);
+	if (!thread) {
+		pr_err("Internal error: can't find thread\n");
+		return -1;
+	}
+
+	tr = thread__get_runtime(thread);
+	if (tr == NULL) {
+		thread__put(thread);
+		return -1;
+	}
+
+	tr->comm_changed = true;
+	thread__put(thread);
+
+	return 0;
+}
+
 static int perf_sched__read_events(struct perf_sched *sched)
 {
 	const struct perf_evsel_str_handler handlers[] = {
@@ -3306,7 +3340,7 @@ int cmd_sched(int argc, const char **argv)
 	struct perf_sched sched = {
 		.tool = {
 			.sample		 = perf_sched__process_tracepoint_sample,
-			.comm		 = perf_event__process_comm,
+			.comm		 = perf_sched__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
 			.lost		 = perf_event__process_lost,
 			.fork		 = perf_sched__process_fork_event,
