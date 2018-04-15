Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeDONcC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 09:32:02 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:41458 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbeDONcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 09:32:01 -0400
X-Google-Smtp-Source: AIpwx49AoaF3F8sCiHeJUyBYdRBeRhWgTyfuFy8qRPfPeHvVb78juMyE8R57OJcZqvsXb7k9YxtEdg==
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [RFC PATCH] kernel/sched/core: busy wait before going idle
Date: Sun, 15 Apr 2018 23:31:49 +1000
Message-Id: <20180415133149.24112-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a quick hack for comments, but I've always wondered --
if we have a short term polling idle states in cpuidle for performance
-- why not skip the context switch and entry into all the idle states,
and just wait for a bit to see if something wakes up again.

It's not uncommon to see various going-to-idle work in kernel profiles.
This might be a way to reduce that (and just the cost of switching
registers and kernel stack to idle thread). This can be an important
path for single thread request-response throughput.

tbench bandwidth seems to be improved (the numbers aren't too stable
but they pretty consistently show some gain). 10-20% would be a pretty
nice gain for such workloads

clients     1     2     4     8    16   128
vanilla   232   467   823  1819  3218  9065
patched   310   503   962  2465  3743  9820

---
 kernel/sched/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e8afd6086f23..30a0b13edfa5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3404,6 +3404,7 @@ static void __sched notrace __schedule(bool preempt)
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
+	bool do_idle_spin = true;
 
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
@@ -3428,6 +3429,7 @@ static void __sched notrace __schedule(bool preempt)
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
 
+idle_spin_end:
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
@@ -3437,6 +3439,32 @@ static void __sched notrace __schedule(bool preempt)
 		if (unlikely(signal_pending_state(prev->state, prev))) {
 			prev->state = TASK_RUNNING;
 		} else {
+			/*
+			 * Busy wait before switching to idle thread. This
+			 * is marked unlikely because we're idle so jumping
+			 * out of line doesn't matter too much.
+			 */
+			if (unlikely(do_idle_spin && rq->nr_running == 1)) {
+				u64 start;
+
+				do_idle_spin = false;
+
+				rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
+				rq_unlock_irq(rq, &rf);
+
+				spin_begin();
+				start = local_clock();
+				while (!need_resched() && prev->state &&
+					!signal_pending_state(prev->state, prev)) {
+					spin_cpu_relax();
+					if (local_clock() - start > 1000000)
+						break;
+				}
+				spin_end();
+
+				rq_lock_irq(rq, &rf);
+				goto idle_spin_end;
+			}
 			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
 			prev->on_rq = 0;
 
-- 
2.17.0
