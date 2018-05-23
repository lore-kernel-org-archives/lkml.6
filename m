Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933159AbeEWOLQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:11:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44480 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbeEWOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:11:14 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] sched,tracing: Correct trace_sched_pi_setprio() for deboosting
Date: Wed, 23 May 2018 16:11:07 +0200
Message-Id: <20180523141107.6417-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mostly a revert of commit b91473ff6e97 ("sched,tracing: Update
trace_sched_pi_setprio()") except for the XXX comments.
Since that commit I see during a deboost a task this:
|futex sched_pi_setprio: comm=3Dfutex_requeue_p pid=3D2234 oldprio=3D98 new=
prio=3D98
|futex sched_switch: prev_comm=3Dfutex_requeue_p prev_pid=3D2234 prev_prio=
=3D120

and after the revert, the `newprio' shows the correct value again:

|futex sched_pi_setprio: comm=3Dfutex_requeue_p pid=3D2220 oldprio=3D98 new=
prio=3D120
|futex sched_switch: prev_comm=3Dfutex_requeue_p prev_pid=3D2220 prev_prio=
=3D120

Reported-by: Mansky Christian <man@keba.com>
Fixes: b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/trace/events/sched.h | 6 +++---
 kernel/sched/core.c          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index bc01e06bc716..c6fdb5aac723 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -420,9 +420,9 @@ DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
  */
 TRACE_EVENT(sched_pi_setprio,
=20
-	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
+	TP_PROTO(struct task_struct *tsk, int new_prio),
=20
-	TP_ARGS(tsk, pi_task),
+	TP_ARGS(tsk, new_prio),
=20
 	TP_STRUCT__entry(
 		__array( char,	comm,	TASK_COMM_LEN	)
@@ -435,7 +435,7 @@ TRACE_EVENT(sched_pi_setprio,
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
 		__entry->pid		=3D tsk->pid;
 		__entry->oldprio	=3D tsk->prio;
-		__entry->newprio	=3D pi_task ? pi_task->prio : tsk->prio;
+		__entry->newprio	=3D new_prio;
 		/* XXX SCHED_DEADLINE bits missing */
 	),
=20
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 092f7c4de903..888df643b99b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3823,7 +3823,7 @@ void rt_mutex_setprio(struct task_struct *p, struct t=
ask_struct *pi_task)
 		goto out_unlock;
 	}
=20
-	trace_sched_pi_setprio(p, pi_task);
+	trace_sched_pi_setprio(p, prio);
 	oldprio =3D p->prio;
=20
 	if (oldprio =3D=3D prio)
--=20
2.17.0
