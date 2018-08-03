Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE380C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F1621700
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F1621700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeHCIJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:09:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726833AbeHCIJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:09:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w736EGdh033723
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 02:14:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmgwn9exj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:14:54 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 3 Aug 2018 07:14:53 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 07:14:49 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w736EmXj35979466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 06:14:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 528CFAE055;
        Fri,  3 Aug 2018 09:14:47 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1107EAE057;
        Fri,  3 Aug 2018 09:14:46 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.122.211.85])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 09:14:45 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/6] sched/numa: Avoid task migration for small numa improvement
Date:   Fri,  3 Aug 2018 11:43:58 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080306-0020-0000-0000-000002B065AA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080306-0021-0000-0000-000020FC969C
Message-Id: <1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com>
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

If numa improvement from the task migration is going to be very
minimal, then avoid task migration.

specjbb2005 / bops/JVM / higher bops are better
on 2 Socket/2 Node Intel
JVMS  Prev    Current  %Change
4     200892  210118   4.59252
1     325766  313171   -3.86627


on 2 Socket/4 Node Power8 (PowerNV)
JVMS  Prev     Current  %Change
8     89011.9  91027.5  2.26442
1     211338   216460   2.42361


on 2 Socket/2 Node Power9 (PowerNV)
JVMS  Prev    Current  %Change
4     190261  191918   0.870909
1     195305  207043   6.01009


on 4 Socket/4 Node Power7
JVMS  Prev     Current  %Change
8     57651.1  58462.1  1.40674
1     111351   108334   -2.70945


dbench / transactions / higher numbers are better
on 2 Socket/2 Node Intel
count  Min      Max      Avg      Variance  %Change
5      12254.7  12331.9  12297.8  28.1846
5      11851.8  11937.3  11890.9  33.5169   -3.30872


on 2 Socket/4 Node Power8 (PowerNV)
count  Min      Max      Avg      Variance  %Change
5      4997.83  5030.14  5015.54  12.947
5      4791     5016.08  4962.55  85.9625   -1.05652


on 2 Socket/2 Node Power9 (PowerNV)
count  Min      Max      Avg      Variance  %Change
5      9331.84  9375.11  9352.04  16.0703
5      9353.43  9380.49  9369.6   9.04361   0.187767


on 4 Socket/4 Node Power7
count  Min      Max      Avg      Variance  %Change
5      147.55   181.605  168.963  11.3513
5      149.518  215.412  179.083  21.5903   5.98948

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v1->v2:
 - Handle trivial changes due to variable name change. (Rik Van Riel)
 - Drop changes where subsequent better cpu find was rejected for
   small numa improvement (Rik Van Riel).

 kernel/sched/fair.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5cf921a..a717870 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1568,6 +1568,13 @@ static bool load_too_imbalanced(long src_load, long dst_load,
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
@@ -1600,7 +1607,7 @@ static void task_numa_compare(struct task_numa_env *env,
 		goto unlock;
 
 	if (!cur) {
-		if (maymove || imp > env->best_imp)
+		if (maymove && moveimp >= env->best_imp)
 			goto assign;
 		else
 			goto unlock;
@@ -1643,16 +1650,22 @@ static void task_numa_compare(struct task_numa_env *env,
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
+	if (imp < SMALLIMP || imp <= env->best_imp + SMALLIMP / 2)
+		goto unlock;
+
+	/*
 	 * In the overloaded case, try and keep the load balanced.
 	 */
 	load = task_h_load(env->p) - task_h_load(cur);
-- 
1.8.3.1

