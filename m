Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8EDECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 03:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543FF2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 03:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543FF2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJVLU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 07:20:57 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:39064 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbeJVLU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 07:20:57 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 851F7C45D9F38FADE042;
        Mon, 22 Oct 2018 11:04:18 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9M34DRo082145;
        Mon, 22 Oct 2018 11:04:13 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018102211041768-5939534 ;
          Mon, 22 Oct 2018 11:04:17 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn, liu.yi24@zte.com.cn
Subject: [PATCH] sched/numa: fix choosing isolated CPUs when task_numa_migrate()
Date:   Mon, 22 Oct 2018 11:05:16 +0800
Message-Id: <1540177516-38613-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-22 11:04:17,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-22 11:04:13,
        Serialize complete at 2018-10-22 11:04:13
X-MAIL: mse01.zte.com.cn w9M34DRo082145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to migrate to a CPU in task_numa_migrate(), we invoke
task_numa_find_cpu() to choose a spot, in which function we skip
the CPU which is not in cpus_allowed, but forgot to concern the
isolated CPUs, and this may cause the task would run on the isolcpus.

This patch fixes this issue by checking the load_balance_mask.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Yi Liu <liu.yi24@zte.com.cn>
---
 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 908c9cd..0fa0cee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1709,6 +1709,7 @@ static void task_numa_compare(struct task_numa_env *env,
 	rcu_read_unlock();
 }
 
+static int is_cpu_load_balance(int cpu);
 static void task_numa_find_cpu(struct task_numa_env *env,
 				long taskimp, long groupimp)
 {
@@ -1731,6 +1732,9 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		if (!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
 			continue;
 
+		if (!is_cpu_load_balance(cpu))
+			continue;
+
 		env->dst_cpu = cpu;
 		task_numa_compare(env, taskimp, groupimp, maymove);
 	}
@@ -8528,6 +8532,12 @@ static int should_we_balance(struct lb_env *env)
 	return balance_cpu == env->dst_cpu;
 }
 
+static int is_cpu_load_balance(int cpu)
+{
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
+
+	return cpumask_test_cpu(cpu, cpus);
+}
+
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
-- 
1.8.3.1

