Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3F2214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfAIDto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:49:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfAIDtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:49:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AA083DDB8;
        Wed,  9 Jan 2019 03:49:43 +0000 (UTC)
Received: from sky.random (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F033E608DD;
        Wed,  9 Jan 2019 03:49:42 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] sched/fair: skip select_idle_sibling() in presence of sync wakeups
Date:   Tue,  8 Jan 2019 22:49:41 -0500
Message-Id: <20190109034941.28759-2-aarcange@redhat.com>
In-Reply-To: <20190109034941.28759-1-aarcange@redhat.com>
References: <20190109034941.28759-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 09 Jan 2019 03:49:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__wake_up_sync() gives a very explicit hint to the scheduler that the
current task will immediately go to sleep and won't return running
until after the waken tasks has started running again.

This is common behavior for message passing through pipes or local
sockets (AF_UNIX or through the loopback interface).

The scheduler does everything right up to the point it calls
select_idle_sibling(). Up to that point the CPU selected for the next
task that got a sync-wakeup could very well be the local CPU. That way
the sync-waken task will start running immediately after the current
task goes to sleep without requiring remote CPU wakeups.

However when select_idle_sibling() is called (especially if
SCHED_MC=y) if there's at least one idle core in the same package, the
sync-waken task will be forcefully waken to run on a different idle
core, in turn destroying the "sync" information and all work done up
to that point.

Without this patch under such a workload there will be two different
CPUs at ~50% utilization and the __wake_up_sync() hint won't really
provide much of benefit if compared to the regular non-sync
wakeup. With this patch there will be a single CPU used at 100%
utilization and that increases performance for those common workloads.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 kernel/sched/fair.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d1907506318a..b2ac152a6935 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -691,7 +691,8 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #include "pelt.h"
 #include "sched-pelt.h"
 
-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu,
+			       int cpu, int target, int sync);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -1678,7 +1679,7 @@ static void task_numa_compare(struct task_numa_env *env,
 		 */
 		local_irq_disable();
 		env->dst_cpu = select_idle_sibling(env->p, env->src_cpu,
-						   env->dst_cpu);
+						   -1, env->dst_cpu, 0);
 		local_irq_enable();
 	}
 
@@ -6161,12 +6162,14 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target)
+static int select_idle_sibling(struct task_struct *p, int prev, int this_cpu,
+			       int target, int sync)
 {
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
-	if (available_idle_cpu(target))
+	if (available_idle_cpu(target) ||
+	    (sync && target == this_cpu && cpu_rq(this_cpu)->nr_running == 1))
 		return target;
 
 	/*
@@ -6649,7 +6652,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
 		/* Fast path */
 
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		new_cpu = select_idle_sibling(p, prev_cpu, cpu, new_cpu, sync);
 
 		if (want_affine)
 			current->recent_used_cpu = cpu;
