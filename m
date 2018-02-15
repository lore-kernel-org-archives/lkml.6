Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425778AbeBOQWX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:22:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57136 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425717AbeBOQVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:21:35 -0500
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH 7/7] sched/fair: Set sd->should_idle_balance when misfit
Date: Thu, 15 Feb 2018 16:20:54 +0000
Message-Id: <1518711654-23503-8-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

Idle balance is a great opportunity to pull a misfit task. However,
there are scenarios where misfit tasks are present but idle balance is
prevented by the should_idle_balance flag.

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

This however won't happen, because currently the should_idle_balance
flag is only set when there is any CPU that has more than one runnable
task - which may very well not be the case here if our CPU-hogging
workload is all there is to run.

As such, this commit sets the should_idle_balance flag in
update_sg_lb_stats when a group is flagged as having a misfit task.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d2302b7b584..d080a144f87f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7871,8 +7871,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			sgs->idle_cpus++;
 
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
-		    !sgs->group_misfit_task_load && rq->misfit_task_load)
+		    !sgs->group_misfit_task_load && rq->misfit_task_load) {
 			sgs->group_misfit_task_load = rq->misfit_task_load;
+			*should_idle_balance = true;
+		}
 	}
 
 	/* Adjust by relative CPU capacity of the group */
-- 
2.7.4
