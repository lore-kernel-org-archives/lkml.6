Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932770AbeBLO7Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:59:16 -0500
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:34635 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932397AbeBLO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:58:59 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/4] sched/fair: Avoid an unnecessary lookup of current CPU ID during wake_affine
Date: Mon, 12 Feb 2018 14:58:54 +0000
Message-Id: <20180212145857.8056-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212145857.8056-1-mgorman@techsingularity.net>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of wake_affine() knows the CPU ID. Pass it in instead of
rechecking it.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5eb3ffc9be84..4b3e86eb2222 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5751,9 +5751,8 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 }
 
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
-		       int prev_cpu, int sync)
+		       int this_cpu, int prev_cpu, int sync)
 {
-	int this_cpu = smp_processor_id();
 	int target = nr_cpumask_bits;
 
 	if (sched_feat(WA_IDLE))
@@ -6376,7 +6375,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		if (cpu == prev_cpu)
 			goto pick_cpu;
 
-		new_cpu = wake_affine(affine_sd, p, prev_cpu, sync);
+		new_cpu = wake_affine(affine_sd, p, cpu, prev_cpu, sync);
 	}
 
 	if (sd && !(sd_flag & SD_BALANCE_FORK)) {
-- 
2.15.1
