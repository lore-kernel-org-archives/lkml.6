Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C24AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFE42083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFE42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932966AbeFTRDu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:03:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932430AbeFTRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:03:47 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGwx5d142007
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqr7bre3n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:46 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:03:44 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:03:42 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH3fB332768066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:03:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B124A4065;
        Wed, 20 Jun 2018 17:54:21 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFADDA404D;
        Wed, 20 Jun 2018 17:54:19 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:19 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 10/19] sched/numa: Stop multiple tasks from moving to the cpu at the same time
Date:   Wed, 20 Jun 2018 22:32:51 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-0008-0000-0000-00000249E9B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0009-0000-0000-000021B03C93
Message-Id: <1529514181-9842-11-git-send-email-srikar@linux.vnet.ibm.com>
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

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25226.6     25436.1     0.83
1     73326       74031       0.96

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     108750      110355      1.475
1     183115      178401      -2.57

(numbers from v1 based on v4.17-rc5)
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      414.64      819.20      556.08      147.70
numa01.sh       Sys:       77.52      205.04      139.40       52.05
numa01.sh      User:    37043.24    61757.88    45517.48     9290.38
numa02.sh      Real:       60.80       63.32       61.63        0.88
numa02.sh       Sys:       17.35       39.37       25.71        7.33
numa02.sh      User:     5213.79     5374.73     5268.90       55.09
numa03.sh      Real:      780.09      948.64      831.43       63.02
numa03.sh       Sys:      104.96      136.92      116.31       11.34
numa03.sh      User:    60465.42    73339.78    64368.03     4700.14
numa04.sh      Real:      412.60      681.92      521.29       96.64
numa04.sh       Sys:      210.32      314.10      251.77       37.71
numa04.sh      User:    34026.38    45581.20    38534.49     4198.53
numa05.sh      Real:      394.79      439.63      411.35       16.87
numa05.sh       Sys:      238.32      330.09      292.31       38.32
numa05.sh      User:    33456.45    34876.07    34138.62      609.45

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      434.84      676.90      550.53      106.24 	 1.008%
numa01.sh       Sys:      125.98      217.34      179.41       30.35 	 -22.3%
numa01.sh      User:    38318.48    53789.56    45864.17     6620.80 	 -0.75%
numa02.sh      Real:       60.06       61.27       60.59        0.45 	 1.716%
numa02.sh       Sys:       14.25       17.86       16.09        1.28 	 59.78%
numa02.sh      User:     5190.13     5225.67     5209.24       13.19 	 1.145%
numa03.sh      Real:      748.21      960.25      823.15       73.51 	 1.005%
numa03.sh       Sys:       96.68      122.10      110.42       11.29 	 5.334%
numa03.sh      User:    58222.16    72595.27    63552.22     5048.87 	 1.283%
numa04.sh      Real:      433.08      630.55      499.30       68.15 	 4.404%
numa04.sh       Sys:      245.22      386.75      306.09       63.32 	 -17.7%
numa04.sh      User:    35014.68    46151.72    38530.26     3924.65 	 0.010%
numa05.sh      Real:      394.77      410.07      401.41        5.99 	 2.476%
numa05.sh       Sys:      212.40      301.82      256.23       35.41 	 14.08%
numa05.sh      User:    33224.86    34201.40    33665.61      313.40 	 1.405%

Acked-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c  | 17 +++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0d0248b..50c7727 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1478,6 +1478,16 @@ struct task_numa_env {
 static void task_numa_assign(struct task_numa_env *env,
 			     struct task_struct *p, long imp)
 {
+	struct rq *rq = cpu_rq(env->dst_cpu);
+
+	if (xchg(&rq->numa_migrate_on, 1))
+		return;
+
+	if (env->best_cpu != -1) {
+		rq = cpu_rq(env->best_cpu);
+		WRITE_ONCE(rq->numa_migrate_on, 0);
+	}
+
 	if (env->best_task)
 		put_task_struct(env->best_task);
 	if (p)
@@ -1533,6 +1543,9 @@ static void task_numa_compare(struct task_numa_env *env,
 	long moveimp = imp;
 	int dist = env->dist;
 
+	if (READ_ONCE(dst_rq->numa_migrate_on))
+		return;
+
 	rcu_read_lock();
 	cur = task_rcu_dereference(&dst_rq->curr);
 	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
@@ -1699,6 +1712,7 @@ static int task_numa_migrate(struct task_struct *p)
 		.best_cpu = -1,
 	};
 	struct sched_domain *sd;
+	struct rq *best_rq;
 	unsigned long taskweight, groupweight;
 	int nid, ret, dist;
 	long taskimp, groupimp;
@@ -1802,14 +1816,17 @@ static int task_numa_migrate(struct task_struct *p)
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
index 52ba2d6..5b15c52 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -756,6 +756,7 @@ struct rq {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
 	unsigned int		nr_preferred_running;
+	unsigned int		numa_migrate_on;
 #endif
 	#define CPU_LOAD_IDX_MAX 5
 	unsigned long		cpu_load[CPU_LOAD_IDX_MAX];
-- 
1.8.3.1

