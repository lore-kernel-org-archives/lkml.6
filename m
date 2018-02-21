Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933177AbeBUKah (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:30:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60575 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbeBUKaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:30:35 -0500
Date: Wed, 21 Feb 2018 02:28:08 -0800
From: tip-bot for Mel Gorman <tipbot@zytor.com>
Message-ID: <tip-eeb60398639143c11ff2c8b509e3a471411bb5d3@git.kernel.org>
Cc: hpa@zytor.com, efault@gmx.de, matt@codeblueprint.co.uk,
        torvalds@linux-foundation.org, mingo@kernel.org, ggherdovich@suse.cz,
        mgorman@techsingularity.net, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mgorman@techsingularity.net, ggherdovich@suse.cz, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, matt@codeblueprint.co.uk, efault@gmx.de,
        hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180213133730.24064-3-mgorman@techsingularity.net>
References: <20180213133730.24064-3-mgorman@techsingularity.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Defer calculation of 'prev_eff_load'
 in wake_affine_weight() until needed
Git-Commit-ID: eeb60398639143c11ff2c8b509e3a471411bb5d3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  eeb60398639143c11ff2c8b509e3a471411bb5d3
Gitweb:     https://git.kernel.org/tip/eeb60398639143c11ff2c8b509e3a471411bb5d3
Author:     Mel Gorman <mgorman@techsingularity.net>
AuthorDate: Tue, 13 Feb 2018 13:37:26 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 08:49:07 +0100

sched/fair: Defer calculation of 'prev_eff_load' in wake_affine_weight() until needed

On sync wakeups, the previous CPU effective load may not be used so delay
the calculation until it's needed.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180213133730.24064-3-mgorman@techsingularity.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0132572..ae3e6f8 100644
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
