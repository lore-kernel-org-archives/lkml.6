Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD057C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D5B20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D5B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933013AbeFTRDx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:03:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932430AbeFTRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:03:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGxhSd069656
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqs2adgu9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:49 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:03:47 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:03:45 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH3iGA31326342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:03:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52924A4053;
        Wed, 20 Jun 2018 17:54:24 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC055A4055;
        Wed, 20 Jun 2018 17:54:22 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:22 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 11/19] sched/numa: Restrict migrating in parallel to the same node.
Date:   Wed, 20 Jun 2018 22:32:52 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-0028-0000-0000-000002D306AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0029-0000-0000-0000238A4CB1
Message-Id: <1529514181-9842-12-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since task migration under numa balancing can happen in parallel, more
than one task might choose to move to the same node at the same time.
This can cause load imbalances at the node level.

The problem is more likely if there are more cores per node or more
nodes in system.

Use a per-node variable to indicate if task migration
to the node under numa balance is currently active.
This per-node variable will not track swapping of tasks.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25436.1     25657.9     0.87
1     74031       74435       0.54

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     110355      101748      -7.79
1     178401      170818      -4.25

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

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 include/linux/mmzone.h |  1 +
 kernel/sched/fair.c    | 14 ++++++++++++++
 mm/page_alloc.c        |  1 +
 3 files changed, 16 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2..b0767703 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -677,6 +677,7 @@ struct zonelist {
 
 	/* Number of pages migrated during the rate limiting time interval */
 	unsigned long numabalancing_migrate_nr_pages;
+	int active_node_migrate;
 #endif
 	/*
 	 * This is a per-node reserve of pages that are not available
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 50c7727..87fb20e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1478,11 +1478,22 @@ struct task_numa_env {
 static void task_numa_assign(struct task_numa_env *env,
 			     struct task_struct *p, long imp)
 {
+	pg_data_t *pgdat = NODE_DATA(cpu_to_node(env->dst_cpu));
 	struct rq *rq = cpu_rq(env->dst_cpu);
 
 	if (xchg(&rq->numa_migrate_on, 1))
 		return;
 
+	if (!env->best_task && env->best_cpu != -1)
+		WRITE_ONCE(pgdat->active_node_migrate, 0);
+
+	if (!p) {
+		if (xchg(&pgdat->active_node_migrate, 1)) {
+			WRITE_ONCE(rq->numa_migrate_on, 0);
+			return;
+		}
+	}
+
 	if (env->best_cpu != -1) {
 		rq = cpu_rq(env->best_cpu);
 		WRITE_ONCE(rq->numa_migrate_on, 0);
@@ -1818,8 +1829,11 @@ static int task_numa_migrate(struct task_struct *p)
 
 	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
+		pg_data_t *pgdat = NODE_DATA(cpu_to_node(env.dst_cpu));
+
 		ret = migrate_task_to(p, env.best_cpu);
 		WRITE_ONCE(best_rq->numa_migrate_on, 0);
+		WRITE_ONCE(pgdat->active_node_migrate, 0);
 		if (ret != 0)
 			trace_sched_stick_numa(p, env.src_cpu, env.best_cpu);
 		return ret;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 22320ea27..8a522d2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6209,6 +6209,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 #ifdef CONFIG_NUMA_BALANCING
 	spin_lock_init(&pgdat->numabalancing_migrate_lock);
 	pgdat->numabalancing_migrate_nr_pages = 0;
+	pgdat->active_node_migrate = 0;
 	pgdat->numabalancing_migrate_next_window = jiffies;
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-- 
1.8.3.1

