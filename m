Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbeBLO7J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:59:09 -0500
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:34355 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932399AbeBLO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:58:59 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/4] sched/fair: Defer calculation of prev_eff_load in wake_affine until needed
Date: Mon, 12 Feb 2018 14:58:55 +0000
Message-Id: <20180212145857.8056-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212145857.8056-1-mgorman@techsingularity.net>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sync wakeups, the previous CPU effective load may not be used so delay
the calculation until it's needed.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4b3e86eb2222..c1091cb023c4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5724,7 +5724,6 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	unsigned long task_load;
 
 	this_eff_load = target_load(this_cpu, sd->wake_idx);
-	prev_eff_load = source_load(prev_cpu, sd->wake_idx);
 
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
@@ -5742,6 +5741,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		this_eff_load *= 100;
 	this_eff_load *= capacity_of(prev_cpu);
 
+	prev_eff_load = source_load(prev_cpu, sd->wake_idx);
 	prev_eff_load -= task_load;
 	if (sched_feat(WA_BIAS))
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
-- 
2.15.1
