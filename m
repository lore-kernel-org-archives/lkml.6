Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D70C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E20E20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E20E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933170AbeFTREI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:04:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933134AbeFTREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:04:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGww5G035106
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:04:04 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqswv310t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:04:04 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:04:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:03:58 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH3vkJ28115134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:03:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FDBFA404D;
        Wed, 20 Jun 2018 17:54:38 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AA5EA4040;
        Wed, 20 Jun 2018 17:54:36 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:36 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 16/19] sched/numa: Detect if node actively handling migration
Date:   Wed, 20 Jun 2018 22:32:57 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-0016-0000-0000-000001DE2FCA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0017-0000-0000-00003232458D
Message-Id: <1529514181-9842-17-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a node is the destination for a task migration under numa balancing,
then any parallel movements to the node will be restricted. In such a
scenario, detect at the earliest and avoid evaluation for a task
movement.

While here, avoid task migration if the numa imbalance is very minimal.
Especially consider two tasks A and B racing with each other to find the
best cpu to swap. If task A already has found one task/cpu pair to
swap and trying to find a better cpu. Task B is yet to find a better
cpu/task to swap. Task A can race with task B and deprive it from
getting a task/cpu to swap.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25960       26015.6     0.214
1     73550       73484       -0.08

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     120071      120453      0.31
1     176249      181140      2.77

Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      493.19      672.88      597.51       59.38
numa01.sh       Sys:      150.09      245.48      207.76       34.26
numa01.sh      User:    41928.51    53779.17    48747.06     3901.39
numa02.sh      Real:       60.63       62.87       61.22        0.83
numa02.sh       Sys:       16.64       27.97       20.25        4.06
numa02.sh      User:     5222.92     5309.60     5254.03       29.98
numa03.sh      Real:      821.52      902.15      863.60       32.41
numa03.sh       Sys:      112.04      130.66      118.35        7.08
numa03.sh      User:    62245.16    69165.14    66443.04     2450.32
numa04.sh      Real:      414.53      519.57      476.25       37.00
numa04.sh       Sys:      181.84      335.67      280.41       54.07
numa04.sh      User:    33924.50    39115.39    37343.78     1934.26
numa05.sh      Real:      408.30      441.45      417.90       12.05
numa05.sh       Sys:      233.41      381.60      295.58       57.37
numa05.sh      User:    33301.31    35972.50    34335.19      938.94

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      428.48      837.17      700.45      162.77 	 -14.6%
numa01.sh       Sys:       78.64      247.70      164.45       58.32 	 26.33%
numa01.sh      User:    37487.25    63728.06    54399.27    10088.13 	 -10.3%
numa02.sh      Real:       60.07       62.65       61.41        0.85 	 -0.30%
numa02.sh       Sys:       15.83       29.36       21.04        4.48 	 -3.75%
numa02.sh      User:     5194.27     5280.60     5236.55       28.01 	 0.333%
numa03.sh      Real:      814.33      881.93      849.69       27.06 	 1.637%
numa03.sh       Sys:      111.45      134.02      125.28        7.69 	 -5.53%
numa03.sh      User:    63007.36    68013.46    65590.46     2023.37 	 1.299%
numa04.sh      Real:      412.19      438.75      424.43        9.28 	 12.20%
numa04.sh       Sys:      232.97      315.77      268.98       26.98 	 4.249%
numa04.sh      User:    33997.30    35292.88    34711.66      415.78 	 7.582%
numa05.sh      Real:      394.88      449.45      424.30       22.53 	 -1.50%
numa05.sh       Sys:      262.03      390.10      314.53       51.01 	 -6.02%
numa05.sh      User:    33389.03    35684.40    34561.34      942.34 	 -0.65%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v1->v2:
 - Handle trivial changes due to variable name change.
 - Also reevaluate node active migration for every cpu.
 - Now detect active migration in task_numa_find_cpu as
	suggested by Rik Van Riel.

 kernel/sched/fair.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9db09a6..c07ac30 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1535,6 +1535,13 @@ static bool load_too_imbalanced(long src_load, long dst_load,
 }
 
 /*
+ * Maximum numa importance can be 1998 (2*999);
+ * SMALLIMP @ 30 would be close to 1998/64.
+ * Used to deter task migration.
+ */
+#define SMALLIMP	30
+
+/*
  * This checks if the overall compute and NUMA accesses of the system would
  * be improved if the source tasks was migrated to the target dst_cpu taking
  * into account that it might be best if task running on the dst_cpu should
@@ -1567,7 +1574,7 @@ static void task_numa_compare(struct task_numa_env *env,
 		goto unlock;
 
 	if (!cur) {
-		if (maymove || imp > env->best_imp)
+		if (maymove && moveimp >= env->best_imp)
 			goto assign;
 		else
 			goto unlock;
@@ -1610,16 +1617,22 @@ static void task_numa_compare(struct task_numa_env *env,
 			       task_weight(cur, env->dst_nid, dist);
 	}
 
-	if (imp <= env->best_imp)
-		goto unlock;
-
 	if (maymove && moveimp > imp && moveimp > env->best_imp) {
-		imp = moveimp - 1;
+		imp = moveimp;
 		cur = NULL;
 		goto assign;
 	}
 
 	/*
+	 * If the numa importance is less than SMALLIMP,
+	 * task migration might only result in ping pong
+	 * of tasks and also hurt performance due to cache
+	 * misses.
+	 */
+	if (imp < SMALLIMP)
+		goto unlock;
+
+	/*
 	 * In the overloaded case, try and keep the load balanced.
 	 */
 	load = task_h_load(env->p) - task_h_load(cur);
@@ -1656,6 +1669,7 @@ static void task_numa_compare(struct task_numa_env *env,
 static void task_numa_find_cpu(struct task_numa_env *env,
 				long taskimp, long groupimp)
 {
+	pg_data_t *pgdat = NODE_DATA(cpu_to_node(env->dst_cpu));
 	long src_load, dst_load, load;
 	bool maymove = false;
 	int cpu;
@@ -1671,12 +1685,14 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 	maymove = !load_too_imbalanced(src_load, dst_load, env);
 
 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
+		bool move = maymove && !READ_ONCE(pgdat->active_node_migrate);
+
 		/* Skip this CPU if the source task cannot migrate */
 		if (!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
 			continue;
 
 		env->dst_cpu = cpu;
-		task_numa_compare(env, taskimp, groupimp, maymove);
+		task_numa_compare(env, taskimp, groupimp, move);
 	}
 }
 
-- 
1.8.3.1

