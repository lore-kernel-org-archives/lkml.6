Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965667AbeEYJsQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:48:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53901 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965252AbeEYJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:48:14 -0400
Date: Fri, 25 May 2018 02:47:20 -0700
From: tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-4ff648decf4712d39f184fc2df3163f43975575a@git.kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        bigeasy@linutronix.de, man@keba.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, mingo@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, man@keba.com, bigeasy@linutronix.de,
        hpa@zytor.com
In-Reply-To: <20180524132647.gg6ziuogczdmjjzu@linutronix.de>
References: <20180524132647.gg6ziuogczdmjjzu@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched, tracing: Fix trace_sched_pi_setprio() for
 deboosting
Git-Commit-ID: 4ff648decf4712d39f184fc2df3163f43975575a
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

Commit-ID:  4ff648decf4712d39f184fc2df3163f43975575a
Gitweb:     https://git.kernel.org/tip/4ff648decf4712d39f184fc2df3163f43975575a
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Thu, 24 May 2018 15:26:48 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 25 May 2018 08:04:01 +0200

sched, tracing: Fix trace_sched_pi_setprio() for deboosting

Since the following commit:

  b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")

the sched_pi_setprio trace point shows the "newprio" during a deboost:

  |futex sched_pi_setprio: comm=futex_requeue_p pid"34 oldprio newprio=3D98
  |futex sched_switch: prev_comm=futex_requeue_p prev_pid"34 prev_prio=120

This patch open codes __rt_effective_prio() in the tracepoint as the
'newprio' to get the old behaviour back / the correct priority:

  |futex sched_pi_setprio: comm=futex_requeue_p pid"20 oldprio newprio=3D120
  |futex sched_switch: prev_comm=futex_requeue_p prev_pid"20 prev_prio=120

Peter suggested to open code the new priority so people using tracehook
could get the deadline data out.

Reported-by: Mansky Christian <man@keba.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")
Link: http://lkml.kernel.org/r/20180524132647.gg6ziuogczdmjjzu@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
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
 
