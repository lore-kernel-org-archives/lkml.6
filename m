Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF85DC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABB22083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABB22083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933119AbeFTRED (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:04:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41621 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933084AbeFTREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:04:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGww5D035106
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqswv30xf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:59 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:03:57 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:03:55 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH3thd35913956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:03:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DE68A4059;
        Wed, 20 Jun 2018 17:54:35 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3EDBA405D;
        Wed, 20 Jun 2018 17:54:33 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:33 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 15/19] sched/numa: Use group_weights to identify if migration degrades locality
Date:   Wed, 20 Jun 2018 22:32:56 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-4275-0000-0000-0000028FF4A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-4276-0000-0000-000037973E8D
Message-Id: <1529514181-9842-16-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=733 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/fair.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 711b533..9db09a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7222,8 +7222,8 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 {
 	struct numa_group *numa_group = rcu_dereference(p->numa_group);
-	unsigned long src_faults, dst_faults;
-	int src_nid, dst_nid;
+	unsigned long src_weight, dst_weight;
+	int src_nid, dst_nid, dist;
 
 	if (!static_branch_likely(&sched_numa_balancing))
 		return -1;
@@ -7250,18 +7250,19 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
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
-- 
1.8.3.1

