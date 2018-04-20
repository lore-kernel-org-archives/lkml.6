Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755200AbeDTOdB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754968AbeDTOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:33:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7966F217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/17] perf/core: Store context switch out type in PERF_RECORD_SWITCH[_CPU_WIDE]
Date: Fri, 20 Apr 2018 11:32:12 -0300
Message-Id: <20180420143227.16030-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

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
-- 
2.14.3
