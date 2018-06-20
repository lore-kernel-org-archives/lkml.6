Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B87C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6E0208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6E0208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933081AbeFTRD7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:03:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933015AbeFTRDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:03:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGwws8054588
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqsmnupm6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:53 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:03:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:03:47 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH3kUT19792064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:03:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08A94A4065;
        Wed, 20 Jun 2018 17:54:27 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F358A404D;
        Wed, 20 Jun 2018 17:54:25 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:25 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 12/19] sched/numa: Remove numa_has_capacity
Date:   Wed, 20 Jun 2018 22:32:53 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-0020-0000-0000-0000029D08BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0021-0000-0000-000020E95D02
Message-Id: <1529514181-9842-13-git-send-email-srikar@linux.vnet.ibm.com>
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

task_numa_find_cpu helps to find the cpu to swap/move the task.
Its guarded by numa_has_capacity(). However node not having capacity
shouldn't deter a task swapping if it helps numa placement.

Further load_too_imbalanced, which evaluates possibilities of move/swap,
provides similar checks as numa_has_capacity.

Hence remove numa_has_capacity() to enhance possibilities of task
swapping even if load is imbalanced.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25657.9     25804.1     0.569
1     74435       73413       -1.37

Acked-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 87fb20e..10b6886 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1417,7 +1417,6 @@ struct numa_stats {
 	unsigned long compute_capacity;
 
 	unsigned int nr_running;
-	int has_free_capacity;
 };
 
 /*
@@ -1444,8 +1443,7 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	 * the @ns structure is NULL'ed and task_numa_compare() will
 	 * not find this node attractive.
 	 *
-	 * We'll either bail at !has_free_capacity, or we'll detect a huge
-	 * imbalance and bail there.
+	 * We'll detect a huge imbalance and bail there.
 	 */
 	if (!cpus)
 		return;
@@ -1456,7 +1454,6 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 
 	capacity = min_t(unsigned, capacity,
 		DIV_ROUND_CLOSEST(ns->compute_capacity, SCHED_CAPACITY_SCALE));
-	ns->has_free_capacity = (ns->nr_running < capacity);
 }
 
 struct task_numa_env {
@@ -1683,31 +1680,6 @@ static void task_numa_find_cpu(struct task_numa_env *env,
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
@@ -1763,8 +1735,7 @@ static int task_numa_migrate(struct task_struct *p)
 	update_numa_stats(&env.dst_stats, env.dst_nid);
 
 	/* Try to find a spot on the preferred nid. */
-	if (numa_has_capacity(&env))
-		task_numa_find_cpu(&env, taskimp, groupimp);
+	task_numa_find_cpu(&env, taskimp, groupimp);
 
 	/*
 	 * Look at other nodes in these cases:
@@ -1794,8 +1765,7 @@ static int task_numa_migrate(struct task_struct *p)
 			env.dist = dist;
 			env.dst_nid = nid;
 			update_numa_stats(&env.dst_stats, env.dst_nid);
-			if (numa_has_capacity(&env))
-				task_numa_find_cpu(&env, taskimp, groupimp);
+			task_numa_find_cpu(&env, taskimp, groupimp);
 		}
 	}
 
-- 
1.8.3.1

