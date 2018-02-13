Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965019AbeBMNhh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:37:37 -0500
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:44186 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964845AbeBMNhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:37:32 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/6] sched/fair: Defer calculation of prev_eff_load in wake_affine until needed
Date: Tue, 13 Feb 2018 13:37:26 +0000
Message-Id: <20180213133730.24064-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213133730.24064-1-mgorman@techsingularity.net>
References: <20180213133730.24064-1-mgorman@techsingularity.net>
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
