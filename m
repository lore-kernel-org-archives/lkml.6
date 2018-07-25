Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C65C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A5F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A5F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeGYPgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:36:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeGYPgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:36:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEOLJQ401972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:24:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEOLjW401969;
        Wed, 25 Jul 2018 07:24:21 -0700
Date:   Wed, 25 Jul 2018 07:24:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-305c1fac3225dfa7eeb89bfe91b7335a6edd5172@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        mgorman@techsingularity.net, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, riel@surriel.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
          riel@surriel.com, srikar@linux.vnet.ibm.com,
          peterz@infradead.org, mgorman@techsingularity.net,
          mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <1529514181-9842-3-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-3-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Evaluate move once per node
Git-Commit-ID: 305c1fac3225dfa7eeb89bfe91b7335a6edd5172
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  305c1fac3225dfa7eeb89bfe91b7335a6edd5172
Gitweb:     https://git.kernel.org/tip/305c1fac3225dfa7eeb89bfe91b7335a6edd5172
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:43 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:06 +0200

sched/numa: Evaluate move once per node

task_numa_compare() helps choose the best CPU to move or swap the
selected task. To achieve this task_numa_compare() is called for every
CPU in the node. Currently it evaluates if the task can be moved/swapped
for each of the CPUs. However the move evaluation is mostly independent
of the CPU. Evaluating the move logic once per node, provides scope for
simplifying task_numa_compare().

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25705.2     25058.2     -2.51
1     74433       72950       -1.99

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     96589.6     105930      9.670
1     181830      178624      -1.76

(numbers from v1 based on v4.17-rc5)
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      440.65      941.32      758.98      189.17
numa01.sh       Sys:      183.48      320.07      258.42       50.09
numa01.sh      User:    37384.65    71818.14    60302.51    13798.96
numa02.sh      Real:       61.24       65.35       62.49        1.49
numa02.sh       Sys:       16.83       24.18       21.40        2.60
numa02.sh      User:     5219.59     5356.34     5264.03       49.07
numa03.sh      Real:      822.04      912.40      873.55       37.35
numa03.sh       Sys:      118.80      140.94      132.90        7.60
numa03.sh      User:    62485.19    70025.01    67208.33     2967.10
numa04.sh      Real:      690.66      872.12      778.49       65.44
numa04.sh       Sys:      459.26      563.03      494.03       42.39
numa04.sh      User:    51116.44    70527.20    58849.44     8461.28
numa05.sh      Real:      418.37      562.28      525.77       54.27
numa05.sh       Sys:      299.45      481.00      392.49       64.27
numa05.sh      User:    34115.09    41324.02    39105.30     2627.68

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      516.14      892.41      739.84      151.32 	 2.587%
numa01.sh       Sys:      153.16      192.99      177.70       14.58 	 45.42%
numa01.sh      User:    39821.04    69528.92    57193.87    10989.48 	 5.435%
numa02.sh      Real:       60.91       62.35       61.58        0.63 	 1.477%
numa02.sh       Sys:       16.47       26.16       21.20        3.85 	 0.943%
numa02.sh      User:     5227.58     5309.61     5265.17       31.04 	 -0.02%
numa03.sh      Real:      739.07      917.73      795.75       64.45 	 9.776%
numa03.sh       Sys:       94.46      136.08      109.48       14.58 	 21.39%
numa03.sh      User:    57478.56    72014.09    61764.48     5343.69 	 8.813%
numa04.sh      Real:      442.61      715.43      530.31       96.12 	 46.79%
numa04.sh       Sys:      224.90      348.63      285.61       48.83 	 72.97%
numa04.sh      User:    35836.84    47522.47    40235.41     3985.26 	 46.26%
numa05.sh      Real:      386.13      489.17      434.94       43.59 	 20.88%
numa05.sh       Sys:      144.29      438.56      278.80      105.78 	 40.77%
numa05.sh      User:    33255.86    36890.82    34879.31     1641.98 	 12.11%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-3-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 128 +++++++++++++++++++++++-----------------------------
 1 file changed, 57 insertions(+), 71 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 14c3fddf822a..b10e0663a49e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1580,9 +1580,8 @@ static bool load_too_imbalanced(long src_load, long dst_load,
  * be exchanged with the source task
  */
 static void task_numa_compare(struct task_numa_env *env,
-			      long taskimp, long groupimp)
+			      long taskimp, long groupimp, bool maymove)
 {
-	struct rq *src_rq = cpu_rq(env->src_cpu);
 	struct rq *dst_rq = cpu_rq(env->dst_cpu);
 	struct task_struct *cur;
 	long src_load, dst_load;
@@ -1603,97 +1602,73 @@ static void task_numa_compare(struct task_numa_env *env,
 	if (cur == env->p)
 		goto unlock;
 
+	if (!cur) {
+		if (maymove || imp > env->best_imp)
+			goto assign;
+		else
+			goto unlock;
+	}
+
 	/*
 	 * "imp" is the fault differential for the source task between the
 	 * source and destination node. Calculate the total differential for
 	 * the source task and potential destination task. The more negative
-	 * the value is, the more rmeote accesses that would be expected to
+	 * the value is, the more remote accesses that would be expected to
 	 * be incurred if the tasks were swapped.
 	 */
-	if (cur) {
-		/* Skip this swap candidate if cannot move to the source CPU: */
-		if (!cpumask_test_cpu(env->src_cpu, &cur->cpus_allowed))
-			goto unlock;
+	/* Skip this swap candidate if cannot move to the source cpu */
+	if (!cpumask_test_cpu(env->src_cpu, &cur->cpus_allowed))
+		goto unlock;
 
+	/*
+	 * If dst and source tasks are in the same NUMA group, or not
+	 * in any group then look only at task weights.
+	 */
+	if (cur->numa_group == env->p->numa_group) {
+		imp = taskimp + task_weight(cur, env->src_nid, dist) -
+		      task_weight(cur, env->dst_nid, dist);
 		/*
-		 * If dst and source tasks are in the same NUMA group, or not
-		 * in any group then look only at task weights.
+		 * Add some hysteresis to prevent swapping the
+		 * tasks within a group over tiny differences.
 		 */
-		if (cur->numa_group == env->p->numa_group) {
-			imp = taskimp + task_weight(cur, env->src_nid, dist) -
-			      task_weight(cur, env->dst_nid, dist);
-			/*
-			 * Add some hysteresis to prevent swapping the
-			 * tasks within a group over tiny differences.
-			 */
-			if (cur->numa_group)
-				imp -= imp/16;
-		} else {
-			/*
-			 * Compare the group weights. If a task is all by
-			 * itself (not part of a group), use the task weight
-			 * instead.
-			 */
-			if (cur->numa_group)
-				imp += group_weight(cur, env->src_nid, dist) -
-				       group_weight(cur, env->dst_nid, dist);
-			else
-				imp += task_weight(cur, env->src_nid, dist) -
-				       task_weight(cur, env->dst_nid, dist);
-		}
+		if (cur->numa_group)
+			imp -= imp / 16;
+	} else {
+		/*
+		 * Compare the group weights. If a task is all by itself
+		 * (not part of a group), use the task weight instead.
+		 */
+		if (cur->numa_group && env->p->numa_group)
+			imp += group_weight(cur, env->src_nid, dist) -
+			       group_weight(cur, env->dst_nid, dist);
+		else
+			imp += task_weight(cur, env->src_nid, dist) -
+			       task_weight(cur, env->dst_nid, dist);
 	}
 
-	if (imp <= env->best_imp && moveimp <= env->best_imp)
+	if (imp <= env->best_imp)
 		goto unlock;
 
-	if (!cur) {
-		/* Is there capacity at our destination? */
-		if (env->src_stats.nr_running <= env->src_stats.task_capacity &&
-		    !env->dst_stats.has_free_capacity)
-			goto unlock;
-
-		goto balance;
-	}
-
-	/* Balance doesn't matter much if we're running a task per CPU: */
-	if (imp > env->best_imp && src_rq->nr_running == 1 &&
-			dst_rq->nr_running == 1)
+	if (maymove && moveimp > imp && moveimp > env->best_imp) {
+		imp = moveimp - 1;
+		cur = NULL;
 		goto assign;
+	}
 
 	/*
 	 * In the overloaded case, try and keep the load balanced.
 	 */
-balance:
-	load = task_h_load(env->p);
+	load = task_h_load(env->p) - task_h_load(cur);
+	if (!load)
+		goto assign;
+
 	dst_load = env->dst_stats.load + load;
 	src_load = env->src_stats.load - load;
 
-	if (moveimp > imp && moveimp > env->best_imp) {
-		/*
-		 * If the improvement from just moving env->p direction is
-		 * better than swapping tasks around, check if a move is
-		 * possible. Store a slightly smaller score than moveimp,
-		 * so an actually idle CPU will win.
-		 */
-		if (!load_too_imbalanced(src_load, dst_load, env)) {
-			imp = moveimp - 1;
-			cur = NULL;
-			goto assign;
-		}
-	}
-
-	if (imp <= env->best_imp)
-		goto unlock;
-
-	if (cur) {
-		load = task_h_load(cur);
-		dst_load -= load;
-		src_load += load;
-	}
-
 	if (load_too_imbalanced(src_load, dst_load, env))
 		goto unlock;
 
+assign:
 	/*
 	 * One idle CPU per node is evaluated for a task numa move.
 	 * Call select_idle_sibling to maybe find a better one.
@@ -1709,7 +1684,6 @@ balance:
 		local_irq_enable();
 	}
 
-assign:
 	task_numa_assign(env, cur, imp);
 unlock:
 	rcu_read_unlock();
@@ -1718,15 +1692,27 @@ unlock:
 static void task_numa_find_cpu(struct task_numa_env *env,
 				long taskimp, long groupimp)
 {
+	long src_load, dst_load, load;
+	bool maymove = false;
 	int cpu;
 
+	load = task_h_load(env->p);
+	dst_load = env->dst_stats.load + load;
+	src_load = env->src_stats.load - load;
+
+	/*
+	 * If the improvement from just moving env->p direction is better
+	 * than swapping tasks around, check if a move is possible.
+	 */
+	maymove = !load_too_imbalanced(src_load, dst_load, env);
+
 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
 		/* Skip this CPU if the source task cannot migrate */
 		if (!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
 			continue;
 
 		env->dst_cpu = cpu;
-		task_numa_compare(env, taskimp, groupimp);
+		task_numa_compare(env, taskimp, groupimp, maymove);
 	}
 }
 
