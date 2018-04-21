Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeDUHrP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:47:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32931 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeDUHrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:47:13 -0400
Date: Sat, 21 Apr 2018 00:46:44 -0700
From: tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-101592b4904ecf6b8ed2a4784d41d180319d95a1@git.kernel.org>
Cc: jolsa@redhat.com, hpa@zytor.com, peterz@infradead.org,
        alexey.budankov@linux.intel.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, namhyung@kernel.org,
        tglx@linutronix.de, acme@redhat.com, mingo@kernel.org
Reply-To: alexey.budankov@linux.intel.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        hpa@zytor.com, jolsa@redhat.com, peterz@infradead.org
In-Reply-To: <9ff84e83-a0ca-dd82-a6d0-cb951689be74@linux.intel.com>
References: <9ff84e83-a0ca-dd82-a6d0-cb951689be74@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Store context switch out type in
 PERF_RECORD_SWITCH[_CPU_WIDE]
Git-Commit-ID: 101592b4904ecf6b8ed2a4784d41d180319d95a1
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

Commit-ID:  101592b4904ecf6b8ed2a4784d41d180319d95a1
Gitweb:     https://git.kernel.org/tip/101592b4904ecf6b8ed2a4784d41d180319d95a1
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 9 Apr 2018 10:25:32 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 17 Apr 2018 09:47:39 -0300

perf/core: Store context switch out type in PERF_RECORD_SWITCH[_CPU_WIDE]

Store preempting context switch out event into Perf trace as a part of
PERF_RECORD_SWITCH[_CPU_WIDE] record.

Percentage of preempting and non-preempting context switches help
understanding the nature of workloads (CPU or IO bound) that are running
on a machine;

The event is treated as preemption one when task->state value of the
thread being switched out is TASK_RUNNING. Event type encoding is
implemented using PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit;

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/9ff84e83-a0ca-dd82-a6d0-cb951689be74@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/uapi/linux/perf_event.h       | 18 +++++++++++++++---
 kernel/events/core.c                  |  4 ++++
 tools/include/uapi/linux/perf_event.h | 18 +++++++++++++++---
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 912b85b52344..b8e288a1f740 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -650,11 +650,23 @@ struct perf_event_mmap_page {
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
 /*
- * Indicates that the content of PERF_SAMPLE_IP points to
- * the actual instruction that triggered the event. See also
- * perf_event_attr::precise_ip.
+ * These PERF_RECORD_MISC_* flags below are safely reused
+ * for the following events:
+ *
+ *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
+ *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
+ *
+ *
+ * PERF_RECORD_MISC_EXACT_IP:
+ *   Indicates that the content of PERF_SAMPLE_IP points to
+ *   the actual instruction that triggered the event. See also
+ *   perf_event_attr::precise_ip.
+ *
+ * PERF_RECORD_MISC_SWITCH_OUT_PREEMPT:
+ *   Indicates that thread was preempted in TASK_RUNNING state.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2d5fe26551f8..1bae80aaabfb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7587,6 +7587,10 @@ static void perf_event_switch(struct task_struct *task,
 		},
 	};
 
+	if (!sched_in && task->state == TASK_RUNNING)
+		switch_event.event_id.header.misc |=
+				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
+
 	perf_iterate_sb(perf_event_switch_output,
 		       &switch_event,
 		       NULL);
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 912b85b52344..b8e288a1f740 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -650,11 +650,23 @@ struct perf_event_mmap_page {
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
 /*
- * Indicates that the content of PERF_SAMPLE_IP points to
- * the actual instruction that triggered the event. See also
- * perf_event_attr::precise_ip.
+ * These PERF_RECORD_MISC_* flags below are safely reused
+ * for the following events:
+ *
+ *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
+ *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
+ *
+ *
+ * PERF_RECORD_MISC_EXACT_IP:
+ *   Indicates that the content of PERF_SAMPLE_IP points to
+ *   the actual instruction that triggered the event. See also
+ *   perf_event_attr::precise_ip.
+ *
+ * PERF_RECORD_MISC_SWITCH_OUT_PREEMPT:
+ *   Indicates that thread was preempted in TASK_RUNNING state.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
