Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAFCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8EE20824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8EE20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeKXN54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:57:56 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56698 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeKXN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:57:55 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id AA14228F76; Fri, 23 Nov 2018 22:11:08 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>
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
Message-Id: <f425c999a5aa10984a7a3daee84b41719c5a8ac1.1543028943.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543028943.git.fthain@telegraphics.com.au>
References: <cover.1543028943.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v3 08/14] m68k: hp300: Convert to clocksource API
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
 arch/m68k/hp300/time.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/hp300/time.c b/arch/m68k/hp300/time.c
index d30b03ea93a2..90982803a629 100644
--- a/arch/m68k/hp300/time.c
+++ b/arch/m68k/hp300/time.c
@@ -8,6 +8,7 @@
  */
 
 #include <asm/ptrace.h>
+#include <linux/clocksource.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/sched.h>
@@ -19,6 +20,18 @@
 #include <asm/traps.h>
 #include <asm/blinken.h>
 
+static u64 hp300_read_clk(struct clocksource *cs);
+
+static struct clocksource hp300_clk = {
+	.name   = "timer",
+	.rating = 250,
+	.read   = hp300_read_clk,
+	.mask   = CLOCKSOURCE_MASK(32),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u32 clk_total;
+
 /* Clock hardware definitions */
 
 #define CLOCKBASE	0xf05f8000
@@ -32,9 +45,10 @@
 #define	CLKMSB3		0xD
 
 /* This is for machines which generate the exact clock. */
-#define USECS_PER_JIFFY (1000000/HZ)
 
-#define INTVAL ((10000 / 4) - 1)
+#define HP300_TIMER_CLOCK_FREQ 250000
+#define HP300_TIMER_CYCLES     (HP300_TIMER_CLOCK_FREQ / HZ)
+#define INTVAL                 (HP300_TIMER_CYCLES - 1)
 
 static irqreturn_t hp300_tick(int irq, void *dev_id)
 {
@@ -45,6 +59,7 @@ static irqreturn_t hp300_tick(int irq, void *dev_id)
 	local_irq_save(flags);
 	in_8(CLOCKBASE + CLKSR);
 	asm volatile ("movpw %1@(5),%0" : "=d" (tmp) : "a" (CLOCKBASE));
+	clk_total += INTVAL;
 	timer_routine(0, NULL);
 	local_irq_restore(flags);
 
@@ -53,20 +68,26 @@ static irqreturn_t hp300_tick(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-u32 hp300_gettimeoffset(void)
+static u64 hp300_read_clk(struct clocksource *cs)
 {
-  /* Read current timer 1 value */
+  unsigned long flags;
   unsigned char lsb, msb1, msb2;
-  unsigned short ticks;
+  u32 ticks;
 
+  local_irq_save(flags);
+  /* Read current timer 1 value */
   msb1 = in_8(CLOCKBASE + 5);
   lsb = in_8(CLOCKBASE + 7);
   msb2 = in_8(CLOCKBASE + 5);
   if (msb1 != msb2)
     /* A carry happened while we were reading.  Read it again */
     lsb = in_8(CLOCKBASE + 7);
+
   ticks = INTVAL - ((msb2 << 8) | lsb);
-  return ((USECS_PER_JIFFY * ticks) / INTVAL) * 1000;
+  ticks += clk_total;
+  local_irq_restore(flags);
+
+  return ticks;
 }
 
 void __init hp300_sched_init(irq_handler_t vector)
@@ -76,9 +97,11 @@ void __init hp300_sched_init(irq_handler_t vector)
 
   asm volatile(" movpw %0,%1@(5)" : : "d" (INTVAL), "a" (CLOCKBASE));
 
-  if (request_irq(IRQ_AUTO_6, hp300_tick, 0, "timer tick", vector))
+  if (request_irq(IRQ_AUTO_6, hp300_tick, IRQF_TIMER, "timer tick", vector))
     pr_err("Couldn't register timer interrupt\n");
 
   out_8(CLOCKBASE + CLKCR2, 0x1);		/* select CR1 */
   out_8(CLOCKBASE + CLKCR1, 0x40);		/* enable irq */
+
+  clocksource_register_hz(&hp300_clk, HP300_TIMER_CLOCK_FREQ);
 }
-- 
2.18.1

