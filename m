Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeCOOrw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:47:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40070 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752674AbeCOOrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:47:36 -0400
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv2 7/7] sched/fair: Set sd->overload when misfit
Date: Thu, 15 Mar 2018 14:47:04 +0000
Message-Id: <1521125224-15434-8-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
References: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

Idle balance is a great opportunity to pull a misfit task. However,
there are scenarios where misfit tasks are present but idle balance is
prevented by the overload flag.

A good example of this is a workload of n identical tasks. Let's suppose
we have a 2+2 Arm big.LITTLE system. We then spawn 4 fairly
CPU-intensive tasks - for the sake of simplicity let's say they are just
CPU hogs, even when running on big CPUs.

They are identical tasks, so on an SMP system they should all end at
(roughly) the same time. However, in our case the LITTLE CPUs are less
performing than the big CPUs, so tasks running on the LITTLEs will have
a longer completion time.

This means that the big CPUs will complete their work earlier, at which
point they should pull the tasks from the LITTLEs. What we want to
happen is summarized as follows:

a,b,c,d are our CPU-hogging tasks
_ signifies idling

LITTLE_0 | a a a a _ _
LITTLE_1 | b b b b _ _
---------|-------------
  big_0  | c c c c a a
  big_1  | d d d d b b
                  ^
                  ^
    Tasks end on the big CPUs, idle balance happens
    and the misfit tasks are pulled straight away

This however won't happen, because currently the overload flag is only
set when there is any CPU that has more than one runnable task - which
may very well not be the case here if our CPU-hogging workload is all
there is to run.

As such, this commit sets the overload flag in update_sg_lb_stats when
a group is flagged as having a misfit task.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c  | 6 ++++--
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e79ec8760be..7952e9491713 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7964,7 +7964,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
  * @load_idx: Load index of sched_domain of this_cpu for load calc.
  * @local_group: Does group contain this_cpu.
  * @sgs: variable to hold the statistics for this group.
- * @overload: Indicate more than one runnable task for any CPU.
+ * @overload: Indicate pullable load (e.g. >1 runnable task).
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
 			struct sched_group *group, int load_idx,
@@ -8008,8 +8008,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			sgs->idle_cpus++;
 
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
-		    !sgs->group_misfit_task_load && rq->misfit_task_load)
+		    !sgs->group_misfit_task_load && rq->misfit_task_load) {
 			sgs->group_misfit_task_load = rq->misfit_task_load;
+			*overload = 1;
+		}
 	}
 
 	/* Adjust by relative CPU capacity of the group */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 31847b7f7d47..2981a162d9c0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -688,7 +688,11 @@ struct root_domain {
 	cpumask_var_t		span;
 	cpumask_var_t		online;
 
-	/* Indicate more than one runnable task for any CPU */
+	/*
+	 * Indicate pullable load on at least one CPU, e.g:
+	 * - More than one runnable task
+	 * - Running task is misfit
+	 */
 	int			overload;
 
 	/*
-- 
2.7.4
