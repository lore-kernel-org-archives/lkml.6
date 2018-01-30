Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeA3KqW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:46:22 -0500
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:44227 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751561AbeA3Kp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:45:57 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle candidate and the basis for SIS
Date: Tue, 30 Jan 2018 10:45:55 +0000
Message-Id: <20180130104555.4125-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180130104555.4125-1-mgorman@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The select_idle_sibling (SIS) rewrite in commit 10e2f1acd010 ("sched/core:
Rewrite and improve select_idle_siblings()") replaced a domain iteration
with a search that broadly speaking does a wrapped walk of the scheduler
domain sharing a last-level-cache. While this had a number of improvements,
one consequence is that two tasks that share a waker/wakee relationship push
each other around a socket. Even though two tasks may be active, all cores
are evenly used. This is great from a search perspective and spreads a load
across individual cores but it has adverse consequences for cpufreq. As each
CPU has relatively low utilisation, cpufreq may decide the utilisation is
too low to used a higher P-state and overall computation throughput suffers.
While individual cpufreq and cpuidle drivers may compensate by artifically
boosting P-state (at c0) or avoiding lower C-states (during idle), it does
not help if hardware-based cpufreq (e.g. HWP) is used.

This patch tracks a recently used CPU based on what CPU a task was running
on when it last was a waker a CPU it was recently using when a task is a
wakee. During SIS, the recently used CPU is used as a target if it's still
allowed by the task and is idle.

The benefit may be non-obvious so consider an example of two tasks
communicating back and forth. Task A may be an application doing IO where
task B is a kworker or kthread like journald. Task A may issue IO, wake
B and B wakes up A on completion.  With the existing scheme this may look
like the following (potentially different IDs if SMT is in use but similar
principal applies).

A (cpu 0)	wake	B (wakes on cpu 1)
B (cpu 1)	wake	A (wakes on cpu 2)
A (cpu 2)	wake	B (wakes on cpu 3)
etc.

A careful reader may wonder why cpu 0 was not idle when B wakes A the
first time and it's simply due to the fact that A can be rescheduled to
another CPU and the pattern is that prev == target when B tries to wakeup
A and the information about CPU 0 has been lost.

With this patch, the pattern is more likely to be

A (cpu 0)	wake	B (wakes on cpu 1)
B (cpu 1)	wake	A (wakes on cpu 0)
A (cpu 0)	wake	B (wakes on cpu 1)
etc

i.e. two communicating casts are more likely to use just two cores instead
of all available cores sharing a LLC.

The most dramatic speedup was noticed on dbench using the XFS filesystem on
UMA as clients interact heavily with workqueues in that configuration. Note
that a similar speedup is not observed on ext4 as the wakeup pattern
is different

                         4.15.0-rc9             4.15.0-rc9
                          waprev-v1        biasancestor-v1
Hmean     1       287.54 (   0.00%)      817.01 ( 184.14%)
Hmean     2      1268.12 (   0.00%)     1781.24 (  40.46%)
Hmean     4      1739.68 (   0.00%)     1594.47 (  -8.35%)
Hmean     8      2464.12 (   0.00%)     2479.56 (   0.63%)
Hmean     64     1455.57 (   0.00%)     1434.68 (  -1.44%)

The results can be less dramatic on NUMA where automatic balancing interferes
with the test. It's also known that network benchmarks running on localhost
also benefit quite a bit from this patch (roughly 10% on netperf RR for UDP
and TCP depending on the machine). Hackbench also seens small improvements
(6-11% depending on machine and thread count). The facebook schbench was also
tested but in most cases showed little or no different to wakeup latencies.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/sched.h |  8 ++++++++
 kernel/sched/core.c   |  1 +
 kernel/sched/fair.c   | 22 ++++++++++++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2588263a989..d9140ddaa4e1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -551,6 +551,14 @@ struct task_struct {
 	unsigned long			wakee_flip_decay_ts;
 	struct task_struct		*last_wakee;
 
+	/*
+	 * recent_used_cpu is initially set as the last CPU used by a task
+	 * that wakes affine another task. Waker/wakee relationships can
+	 * push tasks around a CPU where each wakeup moves to the next one.
+	 * Tracking a recently used CPU allows a quick search for a recently
+	 * used CPU that may be idle.
+	 */
+	int				recent_used_cpu;
 	int				wake_cpu;
 #endif
 	int				on_rq;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7bf32aabfda..68d7bcaf0fc7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2460,6 +2460,7 @@ void wake_up_new_task(struct task_struct *p)
 	 * Use __set_task_cpu() to avoid calling sched_class::migrate_task_rq,
 	 * as we're not fully set-up yet.
 	 */
+	p->recent_used_cpu = task_cpu(p);
 	__set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0));
 #endif
 	rq = __task_rq_lock(p, &rf);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b732caa6fba..e96b0c1b43ad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6201,7 +6201,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	struct sched_domain *sd;
-	int i;
+	int i, recent_used_cpu;
 
 	if (idle_cpu(target))
 		return target;
@@ -6212,6 +6212,21 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (prev != target && cpus_share_cache(prev, target) && idle_cpu(prev))
 		return prev;
 
+	/* Check a recently used CPU as a potential idle candidate */
+	recent_used_cpu = p->recent_used_cpu;
+	if (recent_used_cpu != prev &&
+	    recent_used_cpu != target &&
+	    cpus_share_cache(recent_used_cpu, target) &&
+	    idle_cpu(recent_used_cpu) &&
+	    cpumask_test_cpu(p->recent_used_cpu, &p->cpus_allowed)) {
+		/*
+		 * Replace recent_used_cpu with prev as it is a potential
+		 * candidate for the next wake.
+		 */
+		p->recent_used_cpu = prev;
+		return recent_used_cpu;
+	}
+
 	sd = rcu_dereference(per_cpu(sd_llc, target));
 	if (!sd)
 		return target;
@@ -6379,9 +6394,12 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 
 	if (!sd) {
 pick_cpu:
-		if (sd_flag & SD_BALANCE_WAKE) /* XXX always ? */
+		if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
 			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
+			if (want_affine)
+				current->recent_used_cpu = cpu;
+		}
 	} else {
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	}
-- 
2.15.1
