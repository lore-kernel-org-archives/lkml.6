Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE11C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6AF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6AF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeKSLpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:45:30 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49254 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeKSLoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:44:17 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id C0E1529DFB; Sun, 18 Nov 2018 20:22:17 -0500 (EST)
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
Message-Id: <8454b0ecaf5be60ab602e795eac4bed69f0102d0.1542589838.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1542589838.git.fthain@telegraphics.com.au>
References: <cover.1542589838.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v2 06/14] m68k: amiga: Convert to clocksource API
Date:   Mon, 19 Nov 2018 12:10:38 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform clocksource by adapting the existing arch_gettimeoffset
implementation.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
Changed since v1:
 - Moved clk_total access to within the irq lock.
---
 arch/m68k/amiga/config.c | 43 ++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index d4976c1aa0cc..c498f8419c87 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/seq_file.h>
 #include <linux/tty.h>
+#include <linux/clocksource.h>
 #include <linux/console.h>
 #include <linux/rtc.h>
 #include <linux/init.h>
@@ -461,7 +462,28 @@ void __init config_amiga(void)
 		*(unsigned char *)ZTWO_VADDR(0xde0002) |= 0x80;
 }
 
+static u64 amiga_read_clk(struct clocksource *cs);
+
+static struct clocksource amiga_clk = {
+	.name   = "ciab",
+	.rating = 250,
+	.read   = amiga_read_clk,
+	.mask   = CLOCKSOURCE_MASK(32),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 static unsigned short jiffy_ticks;
+static u32 clk_total;
+
+static irqreturn_t ciab_timer_handler(int irq, void *dev_id)
+{
+	irq_handler_t timer_routine = dev_id;
+
+	clk_total += jiffy_ticks;
+	timer_routine(0, NULL);
+
+	return IRQ_HANDLED;
+}
 
 static void __init amiga_sched_init(irq_handler_t timer_routine)
 {
@@ -481,20 +503,23 @@ static void __init amiga_sched_init(irq_handler_t timer_routine)
 	 * Please don't change this to use ciaa, as it interferes with the
 	 * SCSI code. We'll have to take a look at this later
 	 */
-	if (request_irq(IRQ_AMIGA_CIAB_TA, timer_routine, 0, "timer", NULL))
+	if (request_irq(IRQ_AMIGA_CIAB_TA, ciab_timer_handler, IRQF_TIMER,
+			"timer", timer_routine))
 		pr_err("Couldn't register timer interrupt\n");
 	/* start timer */
 	ciab.cra |= 0x11;
-}
 
-#define TICK_SIZE 10000
+	clocksource_register_hz(&amiga_clk, amiga_eclock);
+}
 
-/* This is always executed with interrupts disabled.  */
-static u32 amiga_gettimeoffset(void)
+static u64 amiga_read_clk(struct clocksource *cs)
 {
+	unsigned long flags;
 	unsigned short hi, lo, hi2;
 	u32 ticks, offset = 0;
 
+	local_irq_save(flags);
+
 	/* read CIA B timer A current value */
 	hi  = ciab.tahi;
 	lo  = ciab.talo;
@@ -510,12 +535,14 @@ static u32 amiga_gettimeoffset(void)
 	if (ticks > jiffy_ticks / 2)
 		/* check for pending interrupt */
 		if (cia_set_irq(&ciab_base, 0) & CIA_ICR_TA)
-			offset = 10000;
+			offset = jiffy_ticks;
 
 	ticks = jiffy_ticks - ticks;
-	ticks = (10000 * ticks) / jiffy_ticks;
+	ticks += offset + clk_total;
+
+	local_irq_restore(flags);
 
-	return (ticks + offset) * 1000;
+	return ticks;
 }
 
 static void amiga_reset(void)  __noreturn;
-- 
2.18.1

