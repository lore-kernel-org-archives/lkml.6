Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeCDO6x (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 09:58:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57580 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeCDO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 09:58:51 -0500
Date: Sun, 4 Mar 2018 15:58:49 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] timer fixes for 4.16
Message-ID: <alpine.DEB.2.21.1803041552500.2394@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

A small set of fixes from the timer departement:

 - Add a missing timer wheel clock forward when migrating timers off a
   unplugged CPU to prevent operating on a stale clock base and missing
   timer deadlines.

 - Use the proper shift count to extract data from a register value to
   prevent evaluating unrelated bits

 - Make the error return check in the FSL timer driver work
   correctly. Checking an unsigned variable for less than zero does not
   really work well.

 - Clarify the confusing comments in the ARC timer code.

Thanks,

	tglx

------------------>
Colin Ian King (1):
      clocksource/drivers/fsl_ftm_timer: Fix error return checking

Felix Fietkau (1):
      clocksource/drivers/mips-gic-timer: Use correct shift count to extract data

Lingutla Chandrasekhar (1):
      timers: Forward timer base before migrating timers

Vineet Gupta (1):
      clocksource/drivers/arc_timer: Update some comments


 drivers/clocksource/arc_timer.c      | 11 ++++++++---
 drivers/clocksource/fsl_ftm_timer.c  |  2 +-
 drivers/clocksource/mips-gic-timer.c |  2 +-
 kernel/time/timer.c                  |  6 ++++++
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index 4927355f9cbe..471b428d8034 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -251,9 +251,14 @@ static irqreturn_t timer_irq_handler(int irq, void *dev_id)
 	int irq_reenable = clockevent_state_periodic(evt);
 
 	/*
-	 * Any write to CTRL reg ACks the interrupt, we rewrite the
-	 * Count when [N]ot [H]alted bit.
-	 * And re-arm it if perioid by [I]nterrupt [E]nable bit
+	 * 1. ACK the interrupt
+	 *    - For ARC700, any write to CTRL reg ACKs it, so just rewrite
+	 *      Count when [N]ot [H]alted bit.
+	 *    - For HS3x, it is a bit subtle. On taken count-down interrupt,
+	 *      IP bit [3] is set, which needs to be cleared for ACK'ing.
+	 *      The write below can only update the other two bits, hence
+	 *      explicitly clears IP bit
+	 * 2. Re-arm interrupt if periodic by writing to IE bit [0]
 	 */
 	write_aux_reg(ARC_REG_TIMER0_CTRL, irq_reenable | TIMER_CTRL_NH);
 
diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/fsl_ftm_timer.c
index 3ee7e6fea621..846d18daf893 100644
--- a/drivers/clocksource/fsl_ftm_timer.c
+++ b/drivers/clocksource/fsl_ftm_timer.c
@@ -281,7 +281,7 @@ static int __init __ftm_clk_init(struct device_node *np, char *cnt_name,
 
 static unsigned long __init ftm_clk_init(struct device_node *np)
 {
-	unsigned long freq;
+	long freq;
 
 	freq = __ftm_clk_init(np, "ftm-evt-counter-en", "ftm-evt");
 	if (freq <= 0)
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 65e18c86d9b9..986b6796b631 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -166,7 +166,7 @@ static int __init __gic_clocksource_init(void)
 
 	/* Set clocksource mask. */
 	count_width = read_gic_config() & GIC_CONFIG_COUNTBITS;
-	count_width >>= __fls(GIC_CONFIG_COUNTBITS);
+	count_width >>= __ffs(GIC_CONFIG_COUNTBITS);
 	count_width *= 4;
 	count_width += 32;
 	gic_clocksource.mask = CLOCKSOURCE_MASK(count_width);
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
