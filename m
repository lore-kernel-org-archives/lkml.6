Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeBWLtd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:49:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:46911 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbeBWLtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:49:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="22496405"
From: changbin.du@intel.com
To: acme@kernel.org, jolsa@redhat.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [RESEND PATCH] perf sched map: re-annotate shortname if thread comm changed
Date: Fri, 23 Feb 2018 19:40:40 +0800
Message-Id: <1519386040-25874-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This is to show the real name of thread that created via fork-exec.
See below example for shortname *A0*.

$ sudo ./perf sched map
              *A0   80393.050639 secs A0 => perf:22368
          *.   A0   80393.050748 secs .  => swapper:0
           .  *.    80393.050887 secs
      *B0  .   .    80393.052735 secs B0 => rcu_sched:8
      *.   .   .    80393.052743 secs
       .  *C0  .    80393.056264 secs C0 => kworker/2:1H:287
       .  *A0  .    80393.056270 secs
       .  *D0  .    80393.056769 secs D0 => ksoftirqd/2:22
       .  *A0  .    80393.056804 secs A0 => pi:22368
       .  *.   .    80393.056854 secs
      *B0  .   .    80393.060727 secs
      ...

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 tools/perf/builtin-sched.c | 4 +++-
 tools/perf/util/thread.c   | 1 +
 tools/perf/util/thread.h   | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 83283fe..53bb8df 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1580,7 +1580,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 
 	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
 	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
-	if (new_shortname || (verbose > 0 && sched_in->tid)) {
+	if (new_shortname || sched_in->comm_changed || (verbose > 0 && sched_in->tid)) {
 		const char *pid_color = color;
 
 		if (thread__has_color(sched_in))
@@ -1588,6 +1588,8 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 
 		color_fprintf(stdout, pid_color, "%s => %s:%d",
 		       sched_in->shortname, thread__comm_str(sched_in), sched_in->tid);
+
+		sched_in->comm_changed = false;
 	}
 
 	if (sched->map.comp && new_cpu)
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 68b65b1..c660fe6 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -212,6 +212,7 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
 			unwind__flush_access(thread);
 	}
 
+	thread->comm_changed = true;
 	thread->comm_set = true;
 
 	return 0;
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 40cfa36..b9a328b 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -27,6 +27,7 @@ struct thread {
 	int			cpu;
 	refcount_t		refcnt;
 	char			shortname[3];
+	bool			comm_changed;
 	bool			comm_set;
 	int			comm_len;
 	bool			dead; /* if set thread has exited */
-- 
2.7.4
