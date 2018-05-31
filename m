Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755136AbeEaM3c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:29:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbeEaM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:29:29 -0400
Date: Thu, 31 May 2018 05:29:03 -0700
From: tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-ecda2b66e263dfd6c1d6113add19150f4e235bb3@git.kernel.org>
Cc: claudio@evidence.eu.com, luca.abeni@santannapisa.it, hpa@zytor.com,
        xiaolong.ye@intel.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, mingo@kernel.org, peterz@infradead.org
Reply-To: claudio@evidence.eu.com, hpa@zytor.com, luca.abeni@santannapisa.it,
        xiaolong.ye@intel.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <20180530160809.9074-1-juri.lelli@redhat.com>
References: <20180530160809.9074-1-juri.lelli@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/deadline: Fix missing clock update
Git-Commit-ID: ecda2b66e263dfd6c1d6113add19150f4e235bb3
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

Commit-ID:  ecda2b66e263dfd6c1d6113add19150f4e235bb3
Gitweb:     https://git.kernel.org/tip/ecda2b66e263dfd6c1d6113add19150f4e235bb3
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Wed, 30 May 2018 18:08:09 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 31 May 2018 12:27:13 +0200

sched/deadline: Fix missing clock update

A missing clock update is causing the following warning:

 rq->clock_update_flags < RQCF_ACT_SKIP
 WARNING: CPU: 10 PID: 0 at kernel/sched/sched.h:963 inactive_task_timer+0x5d6/0x720
 Call Trace:
  <IRQ>
  __hrtimer_run_queues+0x10f/0x530
  hrtimer_interrupt+0xe5/0x240
  smp_apic_timer_interrupt+0x79/0x2b0
  apic_timer_interrupt+0xf/0x20
  </IRQ>
  do_idle+0x203/0x280
  cpu_startup_entry+0x6f/0x80
  start_secondary+0x1b0/0x200
  secondary_startup_64+0xa5/0xb0
 hardirqs last  enabled at (793919): [<ffffffffa27c5f6e>] cpuidle_enter_state+0x9e/0x360
 hardirqs last disabled at (793920): [<ffffffffa2a0096e>] interrupt_entry+0xce/0xe0
 softirqs last  enabled at (793922): [<ffffffffa20bef78>] irq_enter+0x68/0x70
 softirqs last disabled at (793921): [<ffffffffa20bef5d>] irq_enter+0x4d/0x70

This happens because inactive_task_timer() calls sub_running_bw() (if
TASK_DEAD and non_contending) that might trigger a schedutil update,
which might access the clock. Clock is however currently updated only
later in inactive_task_timer() function.

Fix the problem by updating the clock right after task_rq_lock().

Reported-by: kernel test robot <xiaolong.ye@intel.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Claudio Scordino <claudio@evidence.eu.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180530160809.9074-1-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1356afd1eeb6..fbfc3f1d368a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1259,6 +1259,9 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 
 	rq = task_rq_lock(p, &rf);
 
+	sched_clock_tick();
+	update_rq_clock(rq);
+
 	if (!dl_task(p) || p->state == TASK_DEAD) {
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
@@ -1278,9 +1281,6 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	if (dl_se->dl_non_contending == 0)
 		goto unlock;
 
-	sched_clock_tick();
-	update_rq_clock(rq);
-
 	sub_running_bw(dl_se, &rq->dl);
 	dl_se->dl_non_contending = 0;
 unlock:
