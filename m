Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE83C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F69F2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F69F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeKSLol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:44:41 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49280 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeKSLoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:44:18 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id CF73729DFC; Sun, 18 Nov 2018 20:22:17 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1542589838.git.fthain@telegraphics.com.au>
References: <cover.1542589838.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v2 07/14] m68k: atari: Convert to clocksource API
Date:   Mon, 19 Nov 2018 12:10:38 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform clocksource by adapting the existing arch_gettimeoffset
implementation.

Normally the MFP timer C interrupt flag would be used to check for
timer counter wrap-around. Unfortunately, that flag gets cleared by the
MFP itself (due to automatic EOI mode). This means that
mfp_timer_c_handler() and atari_read_clk() must race when accounting
for counter wrap-around.

That problem is avoided here by effectively stopping the clock when it
might otherwise jump backwards. This harms clock accuracy; the result
is not much better than the jiffies clocksource. Also, clock error is
no longer uniformly distributed.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
TODO: find a spare counter for the clocksource, rather than hanging
it off the HZ timer.

It would be simpler to adopt the 'jiffies' clocksource here
(c.f. patch for the hp300 platform in this series).

Changed since v1:
 - Moved clk_total access to within the irq lock.
 - Renamed mfp_timer_handler and mfptimer_handler.
 - Avoid accessing the timer interrupt flag in atari_read_clk(). To
get monotonicity, keep track of the previous timer counter value.
---
 arch/m68k/atari/time.c | 48 +++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
index fafa20f75ab9..914832e55ec5 100644
--- a/arch/m68k/atari/time.c
+++ b/arch/m68k/atari/time.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/clocksource.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 
@@ -24,12 +25,27 @@
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL_GPL(rtc_lock);
 
+static u64 atari_read_clk(struct clocksource *cs);
+
+static struct clocksource atari_clk = {
+	.name   = "mfp",
+	.rating = 100,
+	.read   = atari_read_clk,
+	.mask   = CLOCKSOURCE_MASK(32),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u32 clk_total;
+static u32 last_timer_count;
+
 static irqreturn_t mfp_timer_c_handler(int irq, void *dev_id)
 {
 	irq_handler_t timer_routine = dev_id;
 	unsigned long flags;
 
 	local_irq_save(flags);
+	last_timer_count = st_mfp.tim_dt_c;
+	clk_total += INT_TICKS;
 	timer_routine(0, NULL);
 	local_irq_restore(flags);
 
@@ -44,32 +60,30 @@ atari_sched_init(irq_handler_t timer_routine)
     /* start timer C, div = 1:100 */
     st_mfp.tim_ct_cd = (st_mfp.tim_ct_cd & 15) | 0x60;
     /* install interrupt service routine for MFP Timer C */
-    if (request_irq(IRQ_MFP_TIMC, mfp_timer_c_handler, 0, "timer",
+    if (request_irq(IRQ_MFP_TIMC, mfp_timer_c_handler, IRQF_TIMER, "timer",
                     timer_routine))
 	pr_err("Couldn't register timer interrupt\n");
+
+    clocksource_register_hz(&atari_clk, INT_CLK);
 }
 
 /* ++andreas: gettimeoffset fixed to check for pending interrupt */
 
-#define TICK_SIZE 10000
-
-/* This is always executed with interrupts disabled.  */
-u32 atari_gettimeoffset(void)
+static u64 atari_read_clk(struct clocksource *cs)
 {
-  u32 ticks, offset = 0;
-
-  /* read MFP timer C current value */
-  ticks = st_mfp.tim_dt_c;
-  /* The probability of underflow is less than 2% */
-  if (ticks > INT_TICKS - INT_TICKS / 50)
-    /* Check for pending timer interrupt */
-    if (st_mfp.int_pn_b & (1 << 5))
-      offset = TICK_SIZE;
+	unsigned long flags;
+	u32 ticks;
 
-  ticks = INT_TICKS - ticks;
-  ticks = ticks * 10000L / INT_TICKS;
+	local_irq_save(flags);
+	ticks = st_mfp.tim_dt_c;
+	if (ticks > last_timer_count) /* timer wrapped since last interrupt */
+		ticks = last_timer_count;
+	last_timer_count = ticks;
+	ticks = INT_TICKS - ticks;
+	ticks += clk_total;
+	local_irq_restore(flags);
 
-  return (ticks + offset) * 1000;
+	return ticks;
 }
 
 
-- 
2.18.1

