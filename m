Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0854C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A44921711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A44921711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeHCIJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:09:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726833AbeHCIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:09:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w736EHZn093247
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 02:14:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kmgpu9vj2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:14:48 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 3 Aug 2018 07:14:46 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 07:14:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w736Eh4A37093524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 06:14:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DDD8AE051;
        Fri,  3 Aug 2018 09:14:42 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6FD6AE04D;
        Fri,  3 Aug 2018 09:14:40 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.122.211.85])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 09:14:40 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/6] sched/numa: Stop multiple tasks from moving to the cpu at the same time
Date:   Fri,  3 Aug 2018 11:43:56 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080306-4275-0000-0000-000002A2F11D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080306-4276-0000-0000-000037AB0D91
Message-Id: <1533276841-16341-2-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Task migration under numa balancing can happen in parallel. More than
one task might choose to migrate to the same cpu at the same time. This
can result in
- During task swap, choosing a task that was not part of the evaluation.
- During task swap, task which just got moved into its preferred node,
  moving to a completely different node.
- During task swap, task failing to move to the preferred node, will have
  to wait an extra interval for the next migrate opportunity.
- During task movement, multiple task movements can cause load imbalance.

This problem is more likely if there are more cores per node or more
nodes in the system.

Use a per run-queue variable to check if numa-balance is active on the
run-queue.

specjbb2005 / bops/JVM / higher bops are better
on 2 Socket/2 Node Intel
JVMS  Prev    Current  %Change
4     199709  206350   3.32534
1     330830  319963   -3.28477


on 2 Socket/4 Node Power8 (PowerNV)
JVMS  Prev     Current  %Change
8     89011.9  89627.8  0.69193
1     218946   211338   -3.47483


on 2 Socket/2 Node Power9 (PowerNV)
JVMS  Prev    Current  %Change
4     180473  186539   3.36117
1     212805  220344   3.54268


on 4 Socket/4 Node Power7
JVMS  Prev     Current  %Change
8     56941.8  56836    -0.185804
1     111686   112970   1.14965


dbench / transactions / higher numbers are better
on 2 Socket/2 Node Intel
count  Min      Max      Avg      Variance  %Change
5      12029.8  12124.6  12060.9  34.0076
5      13136.1  13170.2  13150.2  14.7482   9.03166


on 2 Socket/4 Node Power8 (PowerNV)
count  Min      Max      Avg      Variance  %Change
5      4968.51  5006.62  4981.31  13.4151
5      4319.79  4998.19  4836.53  261.109   -2.90646


on 2 Socket/2 Node Power9 (PowerNV)
count  Min      Max      Avg      Variance  %Change
5      9342.92  9381.44  9363.92  12.8587
5      9325.56  9402.7   9362.49  25.9638   -0.0152714


on 4 Socket/4 Node Power7
count  Min      Max      Avg      Variance  %Change
5      143.4    188.892  170.225  16.9929
5      132.581  191.072  170.554  21.6444   0.193274

Acked-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v2->v3:
Add comments as requested by Peter.

 kernel/sched/fair.c  | 22 ++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93f..5cf921a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1514,6 +1514,21 @@ struct task_numa_env {
 static void task_numa_assign(struct task_numa_env *env,
 			     struct task_struct *p, long imp)
 {
+	struct rq *rq = cpu_rq(env->dst_cpu);
+
+	/* Bail out if run-queue part of active numa balance. */
+	if (xchg(&rq->numa_migrate_on, 1))
+		return;
+
+	/*
+	 * Clear previous best_cpu/rq numa-migrate flag, since task now
+	 * found a better cpu to move/swap.
+	 */
+	if (env->best_cpu != -1) {
+		rq = cpu_rq(env->best_cpu);
+		WRITE_ONCE(rq->numa_migrate_on, 0);
+	}
+
 	if (env->best_task)
 		put_task_struct(env->best_task);
 	if (p)
@@ -1569,6 +1584,9 @@ static void task_numa_compare(struct task_numa_env *env,
 	long moveimp = imp;
 	int dist = env->dist;
 
+	if (READ_ONCE(dst_rq->numa_migrate_on))
+		return;
+
 	rcu_read_lock();
 	cur = task_rcu_dereference(&dst_rq->curr);
 	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
@@ -1710,6 +1728,7 @@ static int task_numa_migrate(struct task_struct *p)
 		.best_cpu = -1,
 	};
 	struct sched_domain *sd;
+	struct rq *best_rq;
 	unsigned long taskweight, groupweight;
 	int nid, ret, dist;
 	long taskimp, groupimp;
@@ -1811,14 +1830,17 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	p->numa_scan_period = task_scan_start(p);
 
+	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
 		ret = migrate_task_to(p, env.best_cpu);
+		WRITE_ONCE(best_rq->numa_migrate_on, 0);
 		if (ret != 0)
 			trace_sched_stick_numa(p, env.src_cpu, env.best_cpu);
 		return ret;
 	}
 
 	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
+	WRITE_ONCE(best_rq->numa_migrate_on, 0);
 
 	if (ret != 0)
 		trace_sched_stick_numa(p, env.src_cpu, task_cpu(env.best_task));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8ca..0b91612 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -783,6 +783,7 @@ struct rq {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
 	unsigned int		nr_preferred_running;
+	unsigned int		numa_migrate_on;
 #endif
 	#define CPU_LOAD_IDX_MAX 5
 	unsigned long		cpu_load[CPU_LOAD_IDX_MAX];
-- 
1.8.3.1

