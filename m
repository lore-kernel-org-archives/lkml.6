Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD70C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632AD2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632AD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbeGZJwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:52:03 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:33304 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbeGZJwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:52:03 -0400
X-Greylist: delayed 930 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2018 05:52:01 EDT
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 37BE326C0F2AD2F28CCE;
        Thu, 26 Jul 2018 16:20:45 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6Q8KREF069041;
        Thu, 26 Jul 2018 16:20:27 +0800 (GMT-8)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072616203476-1946370 ;
          Thu, 26 Jul 2018 16:20:34 +0800 
From:   Cheng Lin <cheng.lin130@zte.com.cn>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn, tan.hu@zte.com.cn.cn,
        Cheng Lin <cheng.lin130@zte.com.cn>
Subject: [PATCH v2] sched/numa: do not balance tasks onto isolated cpus
Date:   Thu, 26 Jul 2018 16:19:08 +0800
Message-Id: <1532593148-106266-1-git-send-email-cheng.lin130@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-26 16:20:34,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-26 16:20:15,
        Serialize complete at 2018-07-26 16:20:15
X-MAIL: mse01.zte.com.cn w6Q8KREF069041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, there is one sched domain covering all CPUs, including
those isolated ones using "isolcpus=" boot parameter. However, the
isolated CPUs will not participate in load balancing, and will not
have tasks running on them unless explicitly assigning by CPU
affinity.

But, NUMA balancing has not taken *isolcpus(isolated cpus)* into 
consideration. It may migrate tasks onto isolated cpus and the 
migrated tasks will never escape from the isolated cpus, which will
break the isolation provided by *isolcpus* boot parameter and 
intrduce various problems. The typical scenario is,

When we wanna use the isolated CPUs in a cgroup, cpuset must include
them(e.g. in container).In that case, task's CPU-affinity in the
cgroup includes the isolated CPU by default; If we pin a task onto an
isolated CPU or a CPU which on the same NUMA node with the isolated
CPU, and if there is another task sharing memory with the pinned task,
it will be migrated to the same NUMA node by NUMA-balancing for better
performance. In this case, the isolated CPU maybe chosen as the target
CPU.

Although Load-balancing never migrate a task onto isolated CPU, 
NUMA-balancing does not consider isolated CPU currently. This patch
ensure NUMA balancing not to balance tasks onto isolated

Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
v2: 
* rework and retest on latest kernel
* detail the scenario in the commit log
* fix the SoB chain

 kernel/sched/core.c | 9 ++++++---
 kernel/sched/fair.c | 3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe365c9..170a673 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1302,10 +1302,12 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p)
 	if (!cpu_active(arg.src_cpu) || !cpu_active(arg.dst_cpu))
 		goto out;
 
-	if (!cpumask_test_cpu(arg.dst_cpu, &arg.src_task->cpus_allowed))
+	if ((!cpumask_test_cpu(arg.dst_cpu, &arg.src_task->cpus_allowed))
+		|| !housekeeping_test_cpu(arg.dst_cpu, HK_FLAG_DOMAIN))
 		goto out;
 
-	if (!cpumask_test_cpu(arg.src_cpu, &arg.dst_task->cpus_allowed))
+	if ((!cpumask_test_cpu(arg.src_cpu, &arg.dst_task->cpus_allowed))
+		|| !housekeeping_test_cpu(arg.src_cpu, HK_FLAG_DOMAIN))
 		goto out;
 
 	trace_sched_swap_numa(cur, arg.src_cpu, p, arg.dst_cpu);
@@ -5508,7 +5510,8 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	if (curr_cpu == target_cpu)
 		return 0;
 
-	if (!cpumask_test_cpu(target_cpu, &p->cpus_allowed))
+	if ((!cpumask_test_cpu(target_cpu, &p->cpus_allowed))
+		|| !housekeeping_test_cpu(target_cpu, HK_FLAG_DOMAIN))
 		return -EINVAL;
 
 	/* TODO: This is not properly updating schedstats */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f0a0be..1ea2953 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1724,7 +1724,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 
 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
 		/* Skip this CPU if the source task cannot migrate */
-		if (!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
+		if ((!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
+			|| !housekeeping_test_cpu(cpu, HK_FLAG_DOMAIN))
 			continue;
 
 		env->dst_cpu = cpu;
-- 
1.8.3.1

