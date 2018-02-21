Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933167AbeBUKaL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:30:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57767 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932785AbeBUKaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:30:09 -0500
Date: Wed, 21 Feb 2018 02:27:38 -0800
From: tip-bot for Mel Gorman <tipbot@zytor.com>
Message-ID: <tip-7ebb66a12f85bc375beaf45ca900427fe47aa8f7@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
        ggherdovich@suse.cz, efault@gmx.de, tglx@linutronix.de,
        mgorman@techsingularity.net, mingo@kernel.org,
        matt@codeblueprint.co.uk, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@kernel.org, mgorman@techsingularity.net, ggherdovich@suse.cz,
        tglx@linutronix.de, efault@gmx.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, matt@codeblueprint.co.uk
In-Reply-To: <20180213133730.24064-2-mgorman@techsingularity.net>
References: <20180213133730.24064-2-mgorman@techsingularity.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Avoid an unnecessary lookup of current
 CPU ID during wake_affine
Git-Commit-ID: 7ebb66a12f85bc375beaf45ca900427fe47aa8f7
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

Commit-ID:  7ebb66a12f85bc375beaf45ca900427fe47aa8f7
Gitweb:     https://git.kernel.org/tip/7ebb66a12f85bc375beaf45ca900427fe47aa8f7
Author:     Mel Gorman <mgorman@techsingularity.net>
AuthorDate: Tue, 13 Feb 2018 13:37:25 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 08:49:07 +0100

sched/fair: Avoid an unnecessary lookup of current CPU ID during wake_affine

The only caller of wake_affine() knows the CPU ID. Pass it in instead of
rechecking it.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180213133730.24064-2-mgorman@techsingularity.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 820f94c..0132572 100644
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
