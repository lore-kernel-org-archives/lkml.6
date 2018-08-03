Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1C8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7437521700
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7437521700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeHCIJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:09:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728450AbeHCIJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:09:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w736EKcb046706
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 02:15:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmgb8ahxr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:15:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 3 Aug 2018 07:14:58 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 07:14:54 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w736Er6L23658546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 06:14:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B1B1AE055;
        Fri,  3 Aug 2018 09:14:52 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FD0DAE056;
        Fri,  3 Aug 2018 09:14:51 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.122.211.85])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 09:14:51 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5/6] sched/numa: Reset scan rate whenever task moves across nodes
Date:   Fri,  3 Aug 2018 11:44:00 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080306-0012-0000-0000-00000293343A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080306-0013-0000-0000-000020C54472
Message-Id: <1533276841-16341-6-git-send-email-srikar@linux.vnet.ibm.com>
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

Currently task scan rate is reset when numa balancer migrates the task
to a different node. If numa balancer initiates a swap, reset is only
applicable to the task that initiates the swap. Similarly no scan rate
reset is done if the task is migrated across nodes by traditional load
balancer.

Instead move the scan reset to the migrate_task_rq. This ensures the
task moved out of its preferred node, either gets back to its preferred
node quickly or finds a new preferred node. Doing so, would be fair to
all tasks migrating across nodes.

specjbb2005 / bops/JVM / higher bops are better
on 2 Socket/2 Node Intel
JVMS  Prev    Current  %Change
4     210118  208862   -0.597759
1     313171  307007   -1.96825


on 2 Socket/4 Node Power8 (PowerNV)
JVMS  Prev     Current  %Change
8     91027.5  89911.4  -1.22611
1     216460   216176   -0.131202


on 2 Socket/2 Node Power9 (PowerNV)
JVMS  Prev    Current  %Change
4     191918  196078   2.16759
1     207043  214664   3.68088


on 4 Socket/4 Node Power7
JVMS  Prev     Current  %Change
8     58462.1  60719.2  3.86079
1     108334   112615   3.95167


dbench / transactions / higher numbers are better
on 2 Socket/2 Node Intel
count  Min      Max      Avg      Variance  %Change
5      11851.8  11937.3  11890.9  33.5169
5      12511.7  12559.4  12539.5  15.5883   5.45459


on 2 Socket/4 Node Power8 (PowerNV)
count  Min      Max      Avg      Variance  %Change
5      4791     5016.08  4962.55  85.9625
5      4709.28  4979.28  4919.32  105.126   -0.871125


on 2 Socket/2 Node Power9 (PowerNV)
count  Min      Max      Avg     Variance  %Change
5      9353.43  9380.49  9369.6  9.04361
5      9388.38  9406.29  9395.1  5.98959   0.272157


on 4 Socket/4 Node Power7
count  Min      Max      Avg      Variance  %Change
5      149.518  215.412  179.083  21.5903
5      157.71   184.929  174.754  10.7275   -2.41731

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a5936ed..4ea0eff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1837,12 +1837,6 @@ static int task_numa_migrate(struct task_struct *p)
 	if (env.best_cpu == -1)
 		return -EAGAIN;
 
-	/*
-	 * Reset the scan period if the task is being rescheduled on an
-	 * alternative node to recheck if the tasks is now properly placed.
-	 */
-	p->numa_scan_period = task_scan_start(p);
-
 	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
 		ret = migrate_task_to(p, env.best_cpu);
@@ -6361,6 +6355,19 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unus
 
 	/* We have migrated, no longer consider this task hot */
 	p->se.exec_start = 0;
+
+#ifdef CONFIG_NUMA_BALANCING
+	if (!p->mm || (p->flags & PF_EXITING))
+		return;
+
+	if (p->numa_faults) {
+		int src_nid = cpu_to_node(task_cpu(p));
+		int dst_nid = cpu_to_node(new_cpu);
+
+		if (src_nid != dst_nid)
+			p->numa_scan_period = task_scan_start(p);
+	}
+#endif
 }
 
 static void task_dead_fair(struct task_struct *p)
-- 
1.8.3.1

