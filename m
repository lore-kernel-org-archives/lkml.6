Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032101AbeEZPrr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 11:47:47 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:37311 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031908AbeEZPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 11:47:44 -0400
From: Paul Burton <paul.burton@mips.com>
To: <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 1/2] sched: Make select_task_rq() require cpu_active() for user tasks
Date: Sat, 26 May 2018 08:46:47 -0700
Message-ID: <20180526154648.11635-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180526154648.11635-1-paul.burton@mips.com>
References: <20180526154648.11635-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1527349614-321459-6793-23952-2
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193394
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
    struct task_struct cpu field to X.

  - CPU X is offlined.

  - Task A, currently somewhere between the __set_task_cpu() in
    copy_process() and the call to wake_up_new_task(), is migrated to
    CPU Y by migrate_tasks() when CPU X is offlined.

  - CPU X is onlined, but still in the CPUHP_AP_ONLINE_IDLE state. The
    scheduler is now active on CPU X, but there are no user tasks on
    the runqueue.

  - Task A runs on CPU Y & reaches wake_up_new_task(). This calls
    select_task_rq() with cpu=X, taken from task B's struct task_struct,
    and select_task_rq() allows cpu X to be returned.

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
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org

---
As described in the series' cover letter I've created a small test case
for the observed problem here:

  https://gist.github.com/paulburton/25187c4f537263a6be9c8aac67bd33bf

The issue was first observed on a MIPS system running a test program
that was sensitive to CPU affinity, but has been reproduced on x86_64
using the above program too. On my laptop with an Intel i7-5600U CPU the
test tends to fail within 10 minutes, but with this series applied runs
cleanly overnight.

 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7bf32aabfda..2380bc228dd0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1565,7 +1565,8 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 	 *   not worry about this generic constraint ]
 	 */
 	if (unlikely(!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
-		     !cpu_online(cpu)))
+		     !cpu_online(cpu) ||
+		     (!cpu_active(cpu) && !(p->flags & PF_KTHREAD))))
 		cpu = select_fallback_rq(task_cpu(p), p);
 
 	return cpu;
-- 
2.17.0
