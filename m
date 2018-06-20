Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAB7C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAFB20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAFB20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbeFTRGe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:06:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932902AbeFTRDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:03:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGx0FP126443
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqs39nj0p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:43 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:03:41 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:03:39 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH3cf430277702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:03:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0D7EA4055;
        Wed, 20 Jun 2018 17:54:18 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F882A404D;
        Wed, 20 Jun 2018 17:54:17 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:17 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 09/19] sched/numa: Modify migrate_swap to accept additional params
Date:   Wed, 20 Jun 2018 22:32:50 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-0020-0000-0000-0000029D08BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0021-0000-0000-000020E95D00
Message-Id: <1529514181-9842-10-git-send-email-srikar@linux.vnet.ibm.com>
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

There are checks in migrate_swap_stop that check if the task/cpu
combination is as per migrate_swap_arg before migrating.

However atleast one of the two tasks to be swapped by migrate_swap could
have migrated to a completely different cpu before updating the
migrate_swap_arg. The new cpu where the task is currently running could
be a different node too. If the task has migrated, numa balancer might
end up placing a task in a wrong node.  Instead of achieving node
consolidation, it may end up spreading the load across nodes.

To avoid that pass the cpus as additional parameters.

While here, place migrate_swap under CONFIG_NUMA_BALANCING.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25377.3     25226.6     -0.59
1     72287       73326       1.437

Acked-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/core.c  | 9 ++++++---
 kernel/sched/fair.c  | 3 ++-
 kernel/sched/sched.h | 3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 211890e..36f1c7c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1197,6 +1197,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	__set_task_cpu(p, new_cpu);
 }
 
+#ifdef CONFIG_NUMA_BALANCING
 static void __migrate_swap_task(struct task_struct *p, int cpu)
 {
 	if (task_on_rq_queued(p)) {
@@ -1278,16 +1279,17 @@ static int migrate_swap_stop(void *data)
 /*
  * Cross migrate two tasks
  */
-int migrate_swap(struct task_struct *cur, struct task_struct *p)
+int migrate_swap(struct task_struct *cur, struct task_struct *p,
+		int target_cpu, int curr_cpu)
 {
 	struct migration_swap_arg arg;
 	int ret = -EINVAL;
 
 	arg = (struct migration_swap_arg){
 		.src_task = cur,
-		.src_cpu = task_cpu(cur),
+		.src_cpu = curr_cpu,
 		.dst_task = p,
-		.dst_cpu = task_cpu(p),
+		.dst_cpu = target_cpu,
 	};
 
 	if (arg.src_cpu == arg.dst_cpu)
@@ -1312,6 +1314,7 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p)
 out:
 	return ret;
 }
+#endif /* CONFIG_NUMA_BALANCING */
 
 /*
  * wait_task_inactive - wait for a thread to unschedule.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0580a27..0d0248b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1809,7 +1809,8 @@ static int task_numa_migrate(struct task_struct *p)
 		return ret;
 	}
 
-	ret = migrate_swap(p, env.best_task);
+	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
+
 	if (ret != 0)
 		trace_sched_stick_numa(p, env.src_cpu, task_cpu(env.best_task));
 	put_task_struct(env.best_task);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cb467c22..52ba2d6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1068,7 +1068,8 @@ enum numa_faults_stats {
 };
 extern void sched_setnuma(struct task_struct *p, int node);
 extern int migrate_task_to(struct task_struct *p, int cpu);
-extern int migrate_swap(struct task_struct *, struct task_struct *);
+extern int migrate_swap(struct task_struct *p, struct task_struct *t,
+			int cpu, int scpu);
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_SMP
-- 
1.8.3.1

