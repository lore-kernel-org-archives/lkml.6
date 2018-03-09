Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeCIJHx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:07:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46397 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeCIJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:07:50 -0500
Date: Fri, 9 Mar 2018 01:07:23 -0800
From: tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-bd903afeb504db5655a45bb4cf86f38be5b1bf62@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ephiepark@fb.com,
        vincent.weaver@maine.edu, songliubraving@fb.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        kernel-team@fb.com, jolsa@redhat.com, acme@redhat.com,
        eranian@google.com
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        ephiepark@fb.com, alexander.shishkin@linux.intel.com,
        songliubraving@fb.com, peterz@infradead.org, kernel-team@fb.com,
        jolsa@redhat.com, acme@redhat.com, eranian@google.com
In-Reply-To: <20180306055504.3283731-1-songliubraving@fb.com>
References: <20180306055504.3283731-1-songliubraving@fb.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Fix ctx_event_type in ctx_resched()
Git-Commit-ID: bd903afeb504db5655a45bb4cf86f38be5b1bf62
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

Commit-ID:  bd903afeb504db5655a45bb4cf86f38be5b1bf62
Gitweb:     https://git.kernel.org/tip/bd903afeb504db5655a45bb4cf86f38be5b1bf62
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 5 Mar 2018 21:55:04 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:03:02 +0100

perf/core: Fix ctx_event_type in ctx_resched()

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

Reported-by: Ephraim Park <ephiepark@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <jolsa@redhat.com>
Cc: <kernel-team@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 487f05e18aa4 ("perf/core: Optimize event rescheduling on active contexts")
Link: http://lkml.kernel.org/r/20180306055504.3283731-1-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 96db9ae5d5af..4b838470fac4 100644
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
