Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbeCTNE3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:04:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:4455 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753090AbeCTNE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:04:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="26032403"
Subject: [PATCH v1 1/3] perf/core: store context switch out type into Perf
 trace
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4857e3ba-a42f-a9a2-2668-91ca9b44727c@linux.intel.com>
Organization: Intel Corp.
Message-ID: <99ab3682-4e41-6b97-22dc-e80e9f311e83@linux.intel.com>
Date: Tue, 20 Mar 2018 16:04:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4857e3ba-a42f-a9a2-2668-91ca9b44727c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store thread context-switch-out event type into Perf trace as a part of 
PERF_RECORD_SWITCH[_CPU_WIDE] records.

Introduced types of switch-out events assumed to be 
a) preempt: task->state == TASK_RUNNING and b) yield: !preempt;

New yield event type is encoded using special 
PERF_RECORD_MISC_SWITCH_OUT_YIELD bit extending PERF_RECORD_MISC_SWITCH_OUT 
meaning traditional preemption switch out event:

    misc &= PERF_RECORD_MISC_SWITCH_OUT | PERF_RECORD_MISC_SWITCH_OUT_YIELD
	
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 include/uapi/linux/perf_event.h       | 5 +++++
 kernel/events/core.c                  | 4 +++-
 tools/include/uapi/linux/perf_event.h | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 6f873503552d..0339c829cda5 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -654,6 +654,11 @@ struct perf_event_mmap_page {
  * perf_event_attr::precise_ip.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+/*
+ * Indicates that thread explicitly yielded cpu due to
+ * a call of some synchronization API e.g. futex system call
+ */
+#define PERF_RECORD_MISC_SWITCH_OUT_YIELD	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57898102847f..1faa6dde090c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7216,6 +7216,8 @@ static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in)
 {
 	struct perf_switch_event switch_event;
+	__u16 switch_type = sched_in ? 0 : PERF_RECORD_MISC_SWITCH_OUT |
+		(task->state == TASK_RUNNING ? 0 : PERF_RECORD_MISC_SWITCH_OUT_YIELD);
 
 	/* N.B. caller checks nr_switch_events != 0 */
 
@@ -7225,7 +7227,7 @@ static void perf_event_switch(struct task_struct *task,
 		.event_id	= {
 			.header = {
 				/* .type */
-				.misc = sched_in ? 0 : PERF_RECORD_MISC_SWITCH_OUT,
+				.misc = switch_type,
 				/* .size */
 			},
 			/* .next_prev_pid */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 6f873503552d..0339c829cda5 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -654,6 +654,11 @@ struct perf_event_mmap_page {
  * perf_event_attr::precise_ip.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+/*
+ * Indicates that thread explicitly yielded cpu due to
+ * a call of some synchronization API e.g. futex system call
+ */
+#define PERF_RECORD_MISC_SWITCH_OUT_YIELD	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
