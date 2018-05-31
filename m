Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755096AbeEaM3X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:29:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48695 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754917AbeEaM26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:28:58 -0400
Date: Thu, 31 May 2018 05:28:34 -0700
From: tip-bot for Paul Burton <tipbot@zytor.com>
Message-ID: <tip-7af443ee1697607541c6346c87385adab2214743@git.kernel.org>
Cc: peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org,
        paul.burton@mips.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org, hpa@zytor.com,
        paul.burton@mips.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
In-Reply-To: <20180526154648.11635-2-paul.burton@mips.com>
References: <20180526154648.11635-2-paul.burton@mips.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/core: Require cpu_active() in
 select_task_rq(), for user tasks
Git-Commit-ID: 7af443ee1697607541c6346c87385adab2214743
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

Commit-ID:  7af443ee1697607541c6346c87385adab2214743
Gitweb:     https://git.kernel.org/tip/7af443ee1697607541c6346c87385adab2214743
Author:     Paul Burton <paul.burton@mips.com>
AuthorDate: Sat, 26 May 2018 08:46:47 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 31 May 2018 12:24:25 +0200

sched/core: Require cpu_active() in select_task_rq(), for user tasks

select_task_rq() is used in a few paths to select the CPU upon which a
thread should be run - for example it is used by try_to_wake_up() & by
fork or exec balancing. As-is it allows use of any online CPU that is
present in the task's cpus_allowed mask.

This presents a problem because there is a period whilst CPUs are
brought online where a CPU is marked online, but is not yet fully
initialized - ie. the period where CPUHP_AP_ONLINE_IDLE <= state <
CPUHP_ONLINE. Usually we don't run any user tasks during this window,
but there are corner cases where this can happen. An example observed
is:

  - Some user task A, running on CPU X, forks to create task B.

  - sched_fork() calls __set_task_cpu() with cpu=X, setting task B's
    task_struct::cpu field to X.

  - CPU X is offlined.

  - Task A, currently somewhere between the __set_task_cpu() in
    copy_process() and the call to wake_up_new_task(), is migrated to
    CPU Y by migrate_tasks() when CPU X is offlined.

  - CPU X is onlined, but still in the CPUHP_AP_ONLINE_IDLE state. The
    scheduler is now active on CPU X, but there are no user tasks on
    the runqueue.

  - Task A runs on CPU Y & reaches wake_up_new_task(). This calls
    select_task_rq() with cpu=X, taken from task B's task_struct,
    and select_task_rq() allows CPU X to be returned.

  - Task A enqueues task B on CPU X's runqueue, via activate_task() &
    enqueue_task().

  - CPU X now has a user task on its runqueue before it has reached the
    CPUHP_ONLINE state.

In most cases, the user tasks that schedule on the newly onlined CPU
have no idea that anything went wrong, but one case observed to be
problematic is if the task goes on to invoke the sched_setaffinity
syscall. The newly onlined CPU reaches the CPUHP_AP_ONLINE_IDLE state
before the CPU that brought it online calls stop_machine_unpark(). This
means that for a portion of the window of time between
CPUHP_AP_ONLINE_IDLE & CPUHP_ONLINE the newly onlined CPU's struct
cpu_stopper has its enabled field set to false. If a user thread is
executed on the CPU during this window and it invokes sched_setaffinity
with a CPU mask that does not include the CPU it's running on, then when
__set_cpus_allowed_ptr() calls stop_one_cpu() intending to invoke
migration_cpu_stop() and perform the actual migration away from the CPU
it will simply return -ENOENT rather than calling migration_cpu_stop().
We then return from the sched_setaffinity syscall back to the user task
that is now running on a CPU which it just asked not to run on, and
which is not present in its cpus_allowed mask.

This patch resolves the problem by having select_task_rq() enforce that
user tasks run on CPUs that are active - the same requirement that
select_fallback_rq() already enforces. This should ensure that newly
onlined CPUs reach the CPUHP_AP_ACTIVE state before being able to
schedule user tasks, and also implies that bringup_wait_for_ap() will
have called stop_machine_unpark() which resolves the sched_setaffinity
issue above.

I haven't yet investigated them, but it may be of interest to review
whether any of the actions performed by hotplug states between
CPUHP_AP_ONLINE_IDLE & CPUHP_AP_ACTIVE could have similar unintended
effects on user tasks that might schedule before they are reached, which
might widen the scope of the problem from just affecting the behaviour
of sched_setaffinity.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180526154648.11635-2-paul.burton@mips.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1c58f54b9114..211890edf37e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1560,8 +1560,7 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 	 * [ this allows ->select_task() to simply return task_cpu(p) and
 	 *   not worry about this generic constraint ]
 	 */
-	if (unlikely(!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
-		     !cpu_online(cpu)))
+	if (unlikely(!is_cpu_allowed(p, cpu)))
 		cpu = select_fallback_rq(task_cpu(p), p);
 
 	return cpu;
