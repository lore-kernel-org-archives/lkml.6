Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1869FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50FE2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50FE2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbeGYPu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:50:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33445 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbeGYPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:50:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PETkq2402588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:29:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PETjBB402585;
        Wed, 25 Jul 2018 07:29:45 -0700
Date:   Wed, 25 Jul 2018 07:29:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-f35678b6a17063f3b0d391af5ab8f8c83cf31b0c@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, riel@surriel.com, hpa@zytor.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        srikar@linux.vnet.ibm.com
Reply-To: riel@surriel.com, torvalds@linux-foundation.org,
          mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mgorman@techsingularity.net
In-Reply-To: <1529514181-9842-16-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-16-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Use group_weights to identify if
 migration degrades locality
Git-Commit-ID: f35678b6a17063f3b0d391af5ab8f8c83cf31b0c
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

Commit-ID:  f35678b6a17063f3b0d391af5ab8f8c83cf31b0c
Gitweb:     https://git.kernel.org/tip/f35678b6a17063f3b0d391af5ab8f8c83cf31b0c
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:56 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:08 +0200

sched/numa: Use group_weights to identify if migration degrades locality

On NUMA_BACKPLANE and NUMA_GLUELESS_MESH systems, tasks/memory should be
consolidated to the closest group of nodes. In such a case, relying on
group_fault metric may not always help to consolidate. There can always
be a case where a node closer to the preferred node may have lesser
faults than a node further away from the preferred node. In such a case,
moving to node with more faults might avoid numa consolidation.

Using group_weight would help to consolidate task/memory around the
preferred_node.

While here, to be on the conservative side, don't override migrate thread
degrades locality logic for CPU_NEWLY_IDLE load balancing.

Note: Similar problems exist with should_numa_migrate_memory and will be
dealt separately.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25645.4     25960       1.22
1     72142       73550       1.95

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     110199      120071      8.958
1     176303      176249      -0.03

(numbers from v1 based on v4.17-rc5)
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      490.04      774.86      596.26       96.46
numa01.sh       Sys:      151.52      242.88      184.82       31.71
numa01.sh      User:    41418.41    60844.59    48776.09     6564.27
numa02.sh      Real:       60.14       62.94       60.98        1.00
numa02.sh       Sys:       16.11       30.77       21.20        5.28
numa02.sh      User:     5184.33     5311.09     5228.50       44.24
numa03.sh      Real:      790.95      856.35      826.41       24.11
numa03.sh       Sys:      114.93      118.85      117.05        1.63
numa03.sh      User:    60990.99    64959.28    63470.43     1415.44
numa04.sh      Real:      434.37      597.92      504.87       59.70
numa04.sh       Sys:      237.63      397.40      289.74       55.98
numa04.sh      User:    34854.87    41121.83    38572.52     2615.84
numa05.sh      Real:      386.77      448.90      417.22       22.79
numa05.sh       Sys:      149.23      379.95      303.04       79.55
numa05.sh      User:    32951.76    35959.58    34562.18     1034.05

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      493.19      672.88      597.51       59.38 	 -0.20%
numa01.sh       Sys:      150.09      245.48      207.76       34.26 	 -11.0%
numa01.sh      User:    41928.51    53779.17    48747.06     3901.39 	 0.059%
numa02.sh      Real:       60.63       62.87       61.22        0.83 	 -0.39%
numa02.sh       Sys:       16.64       27.97       20.25        4.06 	 4.691%
numa02.sh      User:     5222.92     5309.60     5254.03       29.98 	 -0.48%
numa03.sh      Real:      821.52      902.15      863.60       32.41 	 -4.30%
numa03.sh       Sys:      112.04      130.66      118.35        7.08 	 -1.09%
numa03.sh      User:    62245.16    69165.14    66443.04     2450.32 	 -4.47%
numa04.sh      Real:      414.53      519.57      476.25       37.00 	 6.009%
numa04.sh       Sys:      181.84      335.67      280.41       54.07 	 3.327%
numa04.sh      User:    33924.50    39115.39    37343.78     1934.26 	 3.290%
numa05.sh      Real:      408.30      441.45      417.90       12.05 	 -0.16%
numa05.sh       Sys:      233.41      381.60      295.58       57.37 	 2.523%
numa05.sh      User:    33301.31    35972.50    34335.19      938.94 	 0.661%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-16-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fc33a4b40a09..9c9e54ea65d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6899,8 +6899,8 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 {
 	struct numa_group *numa_group = rcu_dereference(p->numa_group);
-	unsigned long src_faults, dst_faults;
-	int src_nid, dst_nid;
+	unsigned long src_weight, dst_weight;
+	int src_nid, dst_nid, dist;
 
 	if (!static_branch_likely(&sched_numa_balancing))
 		return -1;
@@ -6927,18 +6927,19 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 		return 0;
 
 	/* Leaving a core idle is often worse than degrading locality. */
-	if (env->idle != CPU_NOT_IDLE)
+	if (env->idle == CPU_IDLE)
 		return -1;
 
+	dist = node_distance(src_nid, dst_nid);
 	if (numa_group) {
-		src_faults = group_faults(p, src_nid);
-		dst_faults = group_faults(p, dst_nid);
+		src_weight = group_weight(p, src_nid, dist);
+		dst_weight = group_weight(p, dst_nid, dist);
 	} else {
-		src_faults = task_faults(p, src_nid);
-		dst_faults = task_faults(p, dst_nid);
+		src_weight = task_weight(p, src_nid, dist);
+		dst_weight = task_weight(p, dst_nid, dist);
 	}
 
-	return dst_faults < src_faults;
+	return dst_weight < src_weight;
 }
 
 #else
