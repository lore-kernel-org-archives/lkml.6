Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755076AbeEXN0z convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:26:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49845 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755000AbeEXN0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:26:51 -0400
Date: Thu, 24 May 2018 15:26:48 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] sched,tracing: Correct trace_sched_pi_setprio() for
 deboosting
Message-ID: <20180524132647.gg6ziuogczdmjjzu@linutronix.de>
References: <20180523141107.6417-1-bigeasy@linutronix.de>
 <20180523172819.GW12198@hirez.programming.kicks-ass.net>
 <20180524074413.dukslrbgqfvaab5b@linutronix.de>
 <20180524083754.GD12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180524083754.GD12198@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b91473ff6e97 ("sched,tracing: Update
trace_sched_pi_setprio()") the sched_pi_setprio trace point shows the
"newprio" during a deboost:
|futex sched_pi_setprio: comm=futex_requeue_p pid=2234 oldprio=98 newprio=98
|futex sched_switch: prev_comm=futex_requeue_p prev_pid=2234 prev_prio=120

This patch open codes __rt_effective_prio() in the tracepoint as the
`newprio' to get the old behaviour back / the correct priority:

|futex sched_pi_setprio: comm=futex_requeue_p pid=2220 oldprio=98 newprio=120
|futex sched_switch: prev_comm=futex_requeue_p prev_pid=2220 prev_prio=120

Peter suggested to open code the new priority so people using tracehook
could get the deadline data out.

Reported-by: Mansky Christian <man@keba.com>
Fixes: b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: Open code __rt_effective_prio() in sched_pi_setprio macro as
suggested by PeterZ.

 include/trace/events/sched.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index bc01e06bc716..0be866c91f62 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -435,7 +435,9 @@ TRACE_EVENT(sched_pi_setprio,
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
 		__entry->pid		= tsk->pid;
 		__entry->oldprio	= tsk->prio;
-		__entry->newprio	= pi_task ? pi_task->prio : tsk->prio;
+		__entry->newprio	= pi_task ?
+				min(tsk->normal_prio, pi_task->prio) :
+				tsk->normal_prio;
 		/* XXX SCHED_DEADLINE bits missing */
 	),
 
-- 
2.17.0
