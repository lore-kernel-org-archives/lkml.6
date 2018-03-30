Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeC3FAT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 01:00:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:16873 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeC3FAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 01:00:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,380,1517904000";
   d="scan'208";a="38074070"
Subject: [PATCH v5 1/3] perf/core: store context switch out type into Perf
 trace
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <45f6ea8a-a420-d176-50aa-9b3975c0ea7a@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7693b616-f284-179d-b3a8-30d28df9efb0@linux.intel.com>
Date: Fri, 30 Mar 2018 08:00:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <45f6ea8a-a420-d176-50aa-9b3975c0ea7a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Store preempting context switch out event into Perf trace as a part of 
PERF_RECORD_SWITCH[_CPU_WIDE] record.

Percentage of preempting and non-preempting context switches help 
understanding the nature of workloads (CPU or IO bound) that are running 
on a machine;

The event is treated as preemption one when task->state value of the 
thread being switched out is TASK_RUNNING. Event type encoding is 
implemented using PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit;
	
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
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
index fc1c330c6bd6..872a5aaa77eb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7584,6 +7584,10 @@ static void perf_event_switch(struct task_struct *task,
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
