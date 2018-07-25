Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A051C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC6B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC6B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeGYPlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:41:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeGYPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:41:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PESeog402501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:28:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PESefV402497;
        Wed, 25 Jul 2018 07:28:40 -0700
Date:   Wed, 25 Jul 2018 07:28:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-2d4056fafa196e1ab4e7161bae4df76f9602d56d@git.kernel.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, srikar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        peterz@infradead.org, riel@surriel.com
Reply-To: mingo@kernel.org, srikar@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
          peterz@infradead.org, riel@surriel.com,
          torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1529514181-9842-13-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-13-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Remove numa_has_capacity()
Git-Commit-ID: 2d4056fafa196e1ab4e7161bae4df76f9602d56d
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

Commit-ID:  2d4056fafa196e1ab4e7161bae4df76f9602d56d
Gitweb:     https://git.kernel.org/tip/2d4056fafa196e1ab4e7161bae4df76f9602d56d
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:53 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:08 +0200

sched/numa: Remove numa_has_capacity()

task_numa_find_cpu() helps to find the CPU to swap/move the task to.
It's guarded by numa_has_capacity(). However node not having capacity
shouldn't deter a task swapping if it helps NUMA placement.

Further load_too_imbalanced(), which evaluates possibilities of move/swap,
provides similar checks as numa_has_capacity.

Hence remove numa_has_capacity() to enhance possibilities of task
swapping even if load is imbalanced.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25657.9     25804.1     0.569
1     74435       73413       -1.37

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-13-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b4eddec3ccc..3bcf0e864613 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1456,7 +1456,6 @@ struct numa_stats {
 	unsigned long compute_capacity;
 
 	unsigned int nr_running;
-	int has_free_capacity;
 };
 
 /*
@@ -1483,8 +1482,7 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	 * the @ns structure is NULL'ed and task_numa_compare() will
 	 * not find this node attractive.
 	 *
-	 * We'll either bail at !has_free_capacity, or we'll detect a huge
-	 * imbalance and bail there.
+	 * We'll detect a huge imbalance and bail there.
 	 */
 	if (!cpus)
 		return;
@@ -1495,7 +1493,6 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 
 	capacity = min_t(unsigned, capacity,
 		DIV_ROUND_CLOSEST(ns->compute_capacity, SCHED_CAPACITY_SCALE));
-	ns->has_free_capacity = (ns->nr_running < capacity);
 }
 
 struct task_numa_env {
@@ -1698,31 +1695,6 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 	}
 }
 
-/* Only move tasks to a NUMA node less busy than the current node. */
-static bool numa_has_capacity(struct task_numa_env *env)
-{
-	struct numa_stats *src = &env->src_stats;
-	struct numa_stats *dst = &env->dst_stats;
-
-	if (src->has_free_capacity && !dst->has_free_capacity)
-		return false;
-
-	/*
-	 * Only consider a task move if the source has a higher load
-	 * than the destination, corrected for CPU capacity on each node.
-	 *
-	 *      src->load                dst->load
-	 * --------------------- vs ---------------------
-	 * src->compute_capacity    dst->compute_capacity
-	 */
-	if (src->load * dst->compute_capacity * env->imbalance_pct >
-
-	    dst->load * src->compute_capacity * 100)
-		return true;
-
-	return false;
-}
-
 static int task_numa_migrate(struct task_struct *p)
 {
 	struct task_numa_env env = {
@@ -1777,8 +1749,7 @@ static int task_numa_migrate(struct task_struct *p)
 	update_numa_stats(&env.dst_stats, env.dst_nid);
 
 	/* Try to find a spot on the preferred nid. */
-	if (numa_has_capacity(&env))
-		task_numa_find_cpu(&env, taskimp, groupimp);
+	task_numa_find_cpu(&env, taskimp, groupimp);
 
 	/*
 	 * Look at other nodes in these cases:
@@ -1808,8 +1779,7 @@ static int task_numa_migrate(struct task_struct *p)
 			env.dist = dist;
 			env.dst_nid = nid;
 			update_numa_stats(&env.dst_stats, env.dst_nid);
-			if (numa_has_capacity(&env))
-				task_numa_find_cpu(&env, taskimp, groupimp);
+			task_numa_find_cpu(&env, taskimp, groupimp);
 		}
 	}
 
