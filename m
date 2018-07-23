Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93124ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08C120858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08C120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbeGWG4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:56:38 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:24346 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbeGWG4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:56:38 -0400
X-Greylist: delayed 952 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2018 02:56:37 EDT
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id A32921351163F6BD2E92;
        Mon, 23 Jul 2018 13:41:17 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6N5fClO026933;
        Mon, 23 Jul 2018 13:41:12 +0800 (GMT-8)
        (envelope-from chen.lin130@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072313411423-1253827 ;
          Mon, 23 Jul 2018 13:41:14 +0800 
From:   Chen Lin <chen.lin130@zte.com.cn>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn, tan.hu@zte.com.cn.cn,
        Chen Lin <cheng.lin130@zte.com.cn>, Tan Hu <tan.hu@zte.com.cn>
Subject: [PATCH] sched/numa: do not balance tasks onto isolated cpus
Date:   Mon, 23 Jul 2018 13:39:30 +0800
Message-Id: <1532324370-80651-1-git-send-email-chen.lin130@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-23 13:41:14,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-23 13:41:12,
        Serialize complete at 2018-07-23 13:41:12
X-MAIL: mse01.zte.com.cn w6N5fClO026933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Lin <cheng.lin130@zte.com.cn>

NUMA balancing has not taken *isolcpus(isolated cpus)* into 
consideration. It may migrate tasks onto isolated cpus and the 
migrated tasks will never escape from the isolated cpus, which will
break the isolation provided by *isolcpus* boot parameter and 
intrduce various problems.

This patch ensure NUMA balancing not to balance tasks onto iaolated
cpus. 

Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 kernel/sched/core.c | 9 ++++++---
 kernel/sched/fair.c | 3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe365c9..f9ce90c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1302,10 +1302,12 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p)
 	if (!cpu_active(arg.src_cpu) || !cpu_active(arg.dst_cpu))
 		goto out;

-	if (!cpumask_test_cpu(arg.dst_cpu, &arg.src_task->cpus_allowed))
+	if ((!cpumask_test_cpu(arg.dst_cpu, &arg.src_task->cpus_allowed))
+            || cpumask_test_cpu(arg.dst_cpu, cpu_isolated_map))
 		goto out;

-	if (!cpumask_test_cpu(arg.src_cpu, &arg.dst_task->cpus_allowed))
+	if ((!cpumask_test_cpu(arg.src_cpu, &arg.dst_task->cpus_allowed))
+            || cpumask_test_cpu(arg.src_cpu, cpu_isolated_map))
 		goto out;

 	trace_sched_swap_numa(cur, arg.src_cpu, p, arg.dst_cpu);
@@ -5508,7 +5510,8 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	if (curr_cpu == target_cpu)
 		return 0;

-	if (!cpumask_test_cpu(target_cpu, &p->cpus_allowed))
+	if ((!cpumask_test_cpu(target_cpu, &p->cpus_allowed))
+            || cpumask_test_cpu(target_cpu, cpu_isolated_map))
 		return -EINVAL;

 	/* TODO: This is not properly updating schedstats */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f0a0be..a91f8fe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1724,7 +1724,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,

 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
 		/* Skip this CPU if the source task cannot migrate */
-		if (!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
+		if ((!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
+                    || cpumask_test_cpu(cpu, cpu_isolated_map))
 			continue;

 		env->dst_cpu = cpu;
--
1.8.3.1

