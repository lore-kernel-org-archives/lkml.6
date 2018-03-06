Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbeCFFzK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:55:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57028 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750743AbeCFFzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:55:09 -0500
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig102.frc2.facebook.com
To: <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <jolsa@redhat.com>
CC: <kernel-team@fb.com>, <ephiepark@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: frc2c02
Subject: [PATCH] perf: correct ctx_event_type in ctx_resched()
Date: Mon, 5 Mar 2018 21:55:04 -0800
Message-ID: <20180306055504.3283731-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ctx_resched(), EVENT_FLEXIBLE should be sched_out when EVENT_PINNED is
added. However, ctx_resched() calculates ctx_event_type before checking
this condition. As a result, pinned events will NOT get higher priority
than flexible events.

The following shows this issue on an Intel CPU (where ref-cycles can
only use one hardware counter).

  1. First start:
       perf stat -C 0 -e ref-cycles  -I 1000
  2. Then, in the second console, run:
       perf stat -C 0 -e ref-cycles:D -I 1000

The second perf uses pinned events, which is expected to have higher
priority. However, because it failed in ctx_resched(). It is never
run.

This patch fixes this by calculating ctx_event_type after re-evaluating
event_type.

Fixes: 487f05e18aa4 ("perf/core: Optimize event rescheduling on active contexts")
Signed-off-by: Song Liu <songliubraving@fb.com>
Reported-by: Ephraim Park <ephiepark@fb.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5789810..cf52fc0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2246,7 +2246,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 			struct perf_event_context *task_ctx,
 			enum event_type_t event_type)
 {
-	enum event_type_t ctx_event_type = event_type & EVENT_ALL;
+	enum event_type_t ctx_event_type;
 	bool cpu_event = !!(event_type & EVENT_CPU);
 
 	/*
@@ -2256,6 +2256,8 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	if (event_type & EVENT_PINNED)
 		event_type |= EVENT_FLEXIBLE;
 
+	ctx_event_type = event_type & EVENT_ALL;
+
 	perf_pmu_disable(cpuctx->ctx.pmu);
 	if (task_ctx)
 		task_ctx_sched_out(cpuctx, task_ctx, event_type);
-- 
2.9.5
