Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935583AbeB1WkT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:40:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50443 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935511AbeB1WkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:40:14 -0500
Date: Wed, 28 Feb 2018 14:40:06 -0800
From: tip-bot for Lingutla Chandrasekhar <tipbot@zytor.com>
Message-ID: <tip-c52232a49e203a65a6e1a670cd5262f59e9364a0@git.kernel.org>
Cc: neeraju@codeaurora.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, clingutla@codeaurora.org, anna-maria@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, neeraju@codeaurora.org,
        linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
        clingutla@codeaurora.org, tglx@linutronix.de
In-Reply-To: <20180118115022.6368-1-clingutla@codeaurora.org>
References: <20180118115022.6368-1-clingutla@codeaurora.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] timers: Forward timer base before migrating
 timers
Git-Commit-ID: c52232a49e203a65a6e1a670cd5262f59e9364a0
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

Commit-ID:  c52232a49e203a65a6e1a670cd5262f59e9364a0
Gitweb:     https://git.kernel.org/tip/c52232a49e203a65a6e1a670cd5262f59e9364a0
Author:     Lingutla Chandrasekhar <clingutla@codeaurora.org>
AuthorDate: Thu, 18 Jan 2018 17:20:22 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 23:34:33 +0100

timers: Forward timer base before migrating timers

On CPU hotunplug the enqueued timers of the unplugged CPU are migrated to a
live CPU. This happens from the control thread which initiated the unplug.

If the CPU on which the control thread runs came out from a longer idle
period then the base clock of that CPU might be stale because the control
thread runs prior to any event which forwards the clock.

In such a case the timers from the unplugged CPU are queued on the live CPU
based on the stale clock which can cause large delays due to increased
granularity of the outer timer wheels which are far away from base:;clock.

But there is a worse problem than that. The following sequence of events
illustrates it:

 - CPU0 timer1 is queued expires = 59969 and base->clk = 59131.

   The timer is queued at wheel level 2, with resulting expiry time = 60032
   (due to level granularity).

 - CPU1 enters idle @60007, with next timer expiry @60020.

 - CPU0 is hotplugged at @60009

 - CPU1 exits idle and runs the control thread which migrates the
   timers from CPU0

   timer1 is now queued in level 0 for immediate handling in the next
   softirq because the requested expiry time 59969 is before CPU1 base->clk
   60007

 - CPU1 runs code which forwards the base clock which succeeds because the
   next expiring timer. which was collected at idle entry time is still set
   to 60020.

   So it forwards beyond 60007 and therefore misses to expire the migrated
   timer1. That timer gets expired when the wheel wraps around again, which
   takes between 63 and 630ms depending on the HZ setting.

Address both problems by invoking forward_timer_base() for the control CPUs
timer base. All other places, which might run into a similar problem
(mod_timer()/add_timer_on()) already invoke forward_timer_base() to avoid
that.

[ tglx: Massaged comment and changelog ]

Fixes: a683f390b93f ("timers: Forward the wheel clock whenever possible")
Co-developed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180118115022.6368-1-clingutla@codeaurora.org
---
 kernel/time/timer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 48150ab42de9..4a4fd567fb26 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1894,6 +1894,12 @@ int timers_dead_cpu(unsigned int cpu)
 		raw_spin_lock_irq(&new_base->lock);
 		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
+		/*
+		 * The current CPUs base clock might be stale. Update it
+		 * before moving the timers over.
+		 */
+		forward_timer_base(new_base);
+
 		BUG_ON(old_base->running_timer);
 
 		for (i = 0; i < WHEEL_SIZE; i++)
