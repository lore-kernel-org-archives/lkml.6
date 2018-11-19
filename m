Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F3DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863A2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D863A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeKSLoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:44:34 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49278 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbeKSLoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:44:18 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id E069F29DFD; Sun, 18 Nov 2018 20:22:17 -0500 (EST)
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
Message-Id: <6597648024f9005bc763222c557f90a73f79e225.1542589838.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1542589838.git.fthain@telegraphics.com.au>
References: <cover.1542589838.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v2 08/14] m68k: bvme6000: Convert to clocksource API
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
 arch/m68k/bvme6000/config.c | 52 +++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index c27c104ac7e7..9691d741e9dc 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
+#include <linux/clocksource.h>
 #include <linux/console.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
@@ -147,6 +148,21 @@ irqreturn_t bvme6000_abort_int (int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static u64 bvme6000_read_clk(struct clocksource *cs);
+
+static struct clocksource bvme6000_clk = {
+	.name   = "rtc",
+	.rating = 250,
+	.read   = bvme6000_read_clk,
+	.mask   = CLOCKSOURCE_MASK(32),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u32 clk_total;
+
+#define RTC_TIMER_CLOCK_FREQ 8000000
+#define RTC_TIMER_CYCLES     (RTC_TIMER_CLOCK_FREQ / HZ)
+#define RTC_TIMER_COUNT      ((RTC_TIMER_CYCLES / 2) - 1)
 
 static irqreturn_t bvme6000_timer_int (int irq, void *dev_id)
 {
@@ -158,6 +174,7 @@ static irqreturn_t bvme6000_timer_int (int irq, void *dev_id)
     local_irq_save(flags);
     msr = rtc->msr & 0xc0;
     rtc->msr = msr | 0x20;		/* Ack the interrupt */
+    clk_total += RTC_TIMER_CYCLES;
     timer_routine(0, NULL);
     local_irq_restore(flags);
 
@@ -180,13 +197,13 @@ void bvme6000_sched_init (irq_handler_t timer_routine)
 
     rtc->msr = 0;	/* Ensure timer registers accessible */
 
-    if (request_irq(BVME_IRQ_RTC, bvme6000_timer_int, 0,
-				"timer", timer_routine))
+    if (request_irq(BVME_IRQ_RTC, bvme6000_timer_int, IRQF_TIMER, "timer",
+                    timer_routine))
 	panic ("Couldn't register timer int");
 
     rtc->t1cr_omr = 0x04;	/* Mode 2, ext clk */
-    rtc->t1msb = 39999 >> 8;
-    rtc->t1lsb = 39999 & 0xff;
+    rtc->t1msb = RTC_TIMER_COUNT >> 8;
+    rtc->t1lsb = RTC_TIMER_COUNT & 0xff;
     rtc->irr_icr1 &= 0xef;	/* Route timer 1 to INTR pin */
     rtc->msr = 0x40;		/* Access int.cntrl, etc */
     rtc->pfr_icr0 = 0x80;	/* Just timer 1 ints enabled */
@@ -198,14 +215,14 @@ void bvme6000_sched_init (irq_handler_t timer_routine)
 
     rtc->msr = msr;
 
+    clocksource_register_hz(&bvme6000_clk, RTC_TIMER_CLOCK_FREQ);
+
     if (request_irq(BVME_IRQ_ABORT, bvme6000_abort_int, 0,
 				"abort", bvme6000_abort_int))
 	panic ("Couldn't register abort int");
 }
 
 
-/* This is always executed with interrupts disabled.  */
-
 /*
  * NOTE:  Don't accept any readings within 5us of rollover, as
  * the T1INT bit may be a little slow getting set.  There is also
@@ -213,14 +230,18 @@ void bvme6000_sched_init (irq_handler_t timer_routine)
  * results...
  */
 
-u32 bvme6000_gettimeoffset(void)
+static u64 bvme6000_read_clk(struct clocksource *cs)
 {
+    unsigned long flags;
     volatile RtcPtr_t rtc = (RtcPtr_t)BVME_RTC_BASE;
     volatile PitRegsPtr pit = (PitRegsPtr)BVME_PIT_BASE;
-    unsigned char msr = rtc->msr & 0xc0;
+    unsigned char msr;
     unsigned char t1int, t1op;
     u32 v = 800000, ov;
 
+    local_irq_save(flags);
+
+    msr = rtc->msr & 0xc0;
     rtc->msr = 0;	/* Ensure timer registers accessible */
 
     do {
@@ -233,17 +254,20 @@ u32 bvme6000_gettimeoffset(void)
     } while (t1int != (rtc->msr & 0x20) ||
 		t1op != (pit->pcdr & 0x04) ||
 			abs(ov-v) > 80 ||
-				v > 39960);
+				v > RTC_TIMER_COUNT - (RTC_TIMER_COUNT / 100));
 
-    v = 39999 - v;
+    v = RTC_TIMER_COUNT - v;
     if (!t1op)				/* If in second half cycle.. */
-	v += 40000;
-    v /= 8;				/* Convert ticks to microseconds */
+	v += RTC_TIMER_CYCLES / 2;
     if (t1int)
-	v += 10000;			/* Int pending, + 10ms */
+	v += RTC_TIMER_CYCLES;
     rtc->msr = msr;
 
-    return v * 1000;
+    v += clk_total;
+
+    local_irq_restore(flags);
+
+    return v;
 }
 
 /*
-- 
2.18.1

