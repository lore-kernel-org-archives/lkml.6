Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032661AbeCAPkQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:40:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:18846 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032646AbeCAPkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:40:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="208109396"
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [RFC PATCH] perf/core: exposing type of context-switch-out event
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitri Prokhorov <Dmitry.Prohorov@intel.com>
Organization: Intel Corp.
Message-ID: <06006a92-3745-0785-cb11-ddbf70e84ded@linux.intel.com>
Date: Thu, 1 Mar 2018 18:40:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch prototypes exposing the type of context-switch-out event using
PERF_RECORD_MISC_EXT_RESERVED bit for PERF_RECORD_SWITCH[_CPU_WIDE] records.

Types of context-switch-out events introduced by the patch meant to be 
a) preempted (task->state == TASK_RUNNING) or b) yielded == !preempted;

The changes have been manually tested on Fedora 27 with the patched kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57898102847f..e3ca597f4e2b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7216,6 +7216,8 @@ static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in)
 {
 	struct perf_switch_event switch_event;
+	__u16 switch_type = sched_in ? 0 : PERF_RECORD_MISC_SWITCH_OUT |
+		(task->state == TASK_RUNNING ? 0 : PERF_RECORD_MISC_EXT_RESERVED);
 
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
