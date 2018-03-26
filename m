Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeCZJUi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:20:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:55258 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbeCZJUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:20:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="186024703"
Subject: [PATCH v3 1/3] perf/core: store context switch out type into Perf
 trace
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0b5dcf43-cfd4-b64e-3d0d-6aa743ff4d4a@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2f5b6bf3-0321-ec79-8d24-ba1eb536758f@linux.intel.com>
Date: Mon, 26 Mar 2018 12:20:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0b5dcf43-cfd4-b64e-3d0d-6aa743ff4d4a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Store thread context-switch-out event type into Perf trace as a part of 
PERF_RECORD_SWITCH[_CPU_WIDE] records.

Introduced types of switch-out events assumed to be 
a) preempt: task->state == TASK_RUNNING and b) !preempt;

New !preempt event type is encoded using new 
PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit extending 
existing PERF_RECORD_MISC_SWITCH_OUT bit of switch out event:

    misc &= PERF_RECORD_MISC_SWITCH_OUT | PERF_RECORD_MISC_SWITCH_OUT_PREEMPT
	
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 include/uapi/linux/perf_event.h       | 4 ++++
 kernel/events/core.c                  | 4 +++-
 tools/include/uapi/linux/perf_event.h | 4 ++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 912b85b52344..cd6ad7e13824 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -655,6 +655,10 @@ struct perf_event_mmap_page {
  * perf_event_attr::precise_ip.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+/*
+ * Indicates that thread was preempted in TASK_RUNNING state
+ */
+#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 74a6e8f12a3c..0d39192215bc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7556,6 +7556,8 @@ static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in)
 {
 	struct perf_switch_event switch_event;
+	__u16 switch_type = sched_in ? 0 : PERF_RECORD_MISC_SWITCH_OUT |
+		(task->state == TASK_RUNNING ? PERF_RECORD_MISC_SWITCH_OUT_PREEMPT : 0);
 
 	/* N.B. caller checks nr_switch_events != 0 */
 
@@ -7565,7 +7567,7 @@ static void perf_event_switch(struct task_struct *task,
 		.event_id	= {
 			.header = {
 				/* .type */
-				.misc = sched_in ? 0 : PERF_RECORD_MISC_SWITCH_OUT,
+				.misc = switch_type,
 				/* .size */
 			},
 			/* .next_prev_pid */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 912b85b52344..cd6ad7e13824 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -655,6 +655,10 @@ struct perf_event_mmap_page {
  * perf_event_attr::precise_ip.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+/*
+ * Indicates that thread was preempted in TASK_RUNNING state
+ */
+#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
