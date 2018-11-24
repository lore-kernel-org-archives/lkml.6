Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49813C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1638A20824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1638A20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbeKXN54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:57:56 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56764 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbeKXN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:57:55 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id D671428F80; Fri, 23 Nov 2018 22:11:08 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kars de Jong <jongk@linux-m68k.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <ea1700fb0b160cbfa5296ab6e83568d29ad4dede.1543028943.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543028943.git.fthain@telegraphics.com.au>
References: <cover.1543028943.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v3 11/14] m68k: mvme147: Convert to clocksource API
Date:   Sat, 24 Nov 2018 14:09:03 +1100
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
 - Use type u32 for tick counter.
---
 arch/m68k/include/asm/mvme147hw.h |  1 -
 arch/m68k/mvme147/config.c        | 36 +++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/include/asm/mvme147hw.h b/arch/m68k/include/asm/mvme147hw.h
index 9c7ff67c5ffd..7c3dd513128e 100644
--- a/arch/m68k/include/asm/mvme147hw.h
+++ b/arch/m68k/include/asm/mvme147hw.h
@@ -66,7 +66,6 @@ struct pcc_regs {
 #define PCC_INT_ENAB		0x08
 
 #define PCC_TIMER_INT_CLR	0x80
-#define PCC_TIMER_PRELOAD	63936l
 
 #define PCC_LEVEL_ABORT		0x07
 #define PCC_LEVEL_SERIAL	0x04
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 4ef4faa5ed8b..c44a254e8a8c 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
+#include <linux/clocksource.h>
 #include <linux/console.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
@@ -92,6 +93,21 @@ void __init config_mvme147(void)
 		vme_brdtype = VME_TYPE_MVME147;
 }
 
+static u64 mvme147_read_clk(struct clocksource *cs);
+
+static struct clocksource mvme147_clk = {
+	.name   = "pcc",
+	.rating = 250,
+	.read   = mvme147_read_clk,
+	.mask   = CLOCKSOURCE_MASK(32),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u32 clk_total;
+
+#define PCC_TIMER_CLOCK_FREQ 160000
+#define PCC_TIMER_CYCLES     (PCC_TIMER_CLOCK_FREQ / HZ)
+#define PCC_TIMER_PRELOAD    (0x10000 - PCC_TIMER_CYCLES)
 
 /* Using pcc tick timer 1 */
 
@@ -103,6 +119,7 @@ static irqreturn_t mvme147_timer_int (int irq, void *dev_id)
 	local_irq_save(flags);
 	m147_pcc->t1_int_cntrl = PCC_TIMER_INT_CLR;
 	m147_pcc->t1_int_cntrl = PCC_INT_ENAB|PCC_LEVEL_TIMER1;
+	clk_total += PCC_TIMER_CYCLES;
 	timer_routine(0, NULL);
 	local_irq_restore(flags);
 
@@ -112,32 +129,39 @@ static irqreturn_t mvme147_timer_int (int irq, void *dev_id)
 
 void mvme147_sched_init (irq_handler_t timer_routine)
 {
-	if (request_irq(PCC_IRQ_TIMER1, mvme147_timer_int, 0, "timer 1",
-			timer_routine))
+	if (request_irq(PCC_IRQ_TIMER1, mvme147_timer_int, IRQF_TIMER,
+			"timer 1", timer_routine))
 		pr_err("Couldn't register timer interrupt\n");
 
 	/* Init the clock with a value */
-	/* our clock goes off every 6.25us */
+	/* The clock counter increments until 0xFFFF then reloads */
 	m147_pcc->t1_preload = PCC_TIMER_PRELOAD;
 	m147_pcc->t1_cntrl = 0x0;	/* clear timer */
 	m147_pcc->t1_cntrl = 0x3;	/* start timer */
 	m147_pcc->t1_int_cntrl = PCC_TIMER_INT_CLR;  /* clear pending ints */
 	m147_pcc->t1_int_cntrl = PCC_INT_ENAB|PCC_LEVEL_TIMER1;
+
+	clocksource_register_hz(&mvme147_clk, PCC_TIMER_CLOCK_FREQ);
 }
 
-/* This is always executed with interrupts disabled.  */
 /* XXX There are race hazards in this code XXX */
-u32 mvme147_gettimeoffset(void)
+static u64 mvme147_read_clk(struct clocksource *cs)
 {
+	unsigned long flags;
 	volatile unsigned short *cp = (volatile unsigned short *)0xfffe1012;
 	unsigned short n;
+	u32 ticks;
 
+	local_irq_save(flags);
 	n = *cp;
 	while (n != *cp)
 		n = *cp;
 
 	n -= PCC_TIMER_PRELOAD;
-	return ((unsigned long)n * 25 / 4) * 1000;
+	ticks = clk_total + n;
+	local_irq_restore(flags);
+
+	return ticks;
 }
 
 static int bcd2int (unsigned char b)
-- 
2.18.1

