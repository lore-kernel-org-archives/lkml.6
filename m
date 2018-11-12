Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D58F214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D58F214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbeKLOiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:38:50 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48684 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbeKLOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:23 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 16745297EC; Sun, 11 Nov 2018 23:46:56 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <6bb4fe390a5b45685f6a6a9a51f151f15d98a235.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 09/13] m68k: bvme6000: Convert to clocksource API
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform clocksource by adapting the existing arch_gettimeoffset
implementation.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/bvme6000/config.c | 54 ++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 3bd56bd04690..099cc6edebc8 100644
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
@@ -43,12 +44,6 @@ extern int bvme6000_hwclk (int, struct rtc_time *);
 extern void bvme6000_reset (void);
 void bvme6000_set_vectors (void);
 
-/* Save tick handler routine pointer, will point to xtime_update() in
- * kernel/timer/timekeeping.c, called via bvme6000_process_int() */
-
-static irq_handler_t tick_handler;
-
-
 int __init bvme6000_parse_bootinfo(const struct bi_record *bi)
 {
 	if (be16_to_cpu(bi->tag) == BI_VME_TYPE)
@@ -152,13 +147,34 @@ irqreturn_t bvme6000_abort_int (int irq, void *dev_id)
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
+    irq_handler_t tick_handler = dev_id;
     volatile RtcPtr_t rtc = (RtcPtr_t)BVME_RTC_BASE;
-    unsigned char msr = rtc->msr & 0xc0;
+    unsigned char msr;
+    unsigned long flags;
 
+    local_irq_save(flags);
+    msr = rtc->msr & 0xc0;
     rtc->msr = msr | 0x20;		/* Ack the interrupt */
+    clk_total += RTC_TIMER_CYCLES;
+    local_irq_restore(flags);
 
     return tick_handler(irq, dev_id);
 }
@@ -179,14 +195,13 @@ void bvme6000_sched_init (irq_handler_t timer_routine)
 
     rtc->msr = 0;	/* Ensure timer registers accessible */
 
-    tick_handler = timer_routine;
-    if (request_irq(BVME_IRQ_RTC, bvme6000_timer_int, 0,
-				"timer", bvme6000_timer_int))
+    if (request_irq(BVME_IRQ_RTC, bvme6000_timer_int, IRQF_TIMER,
+				"timer", timer_routine))
 	panic ("Couldn't register timer int");
 
     rtc->t1cr_omr = 0x04;	/* Mode 2, ext clk */
-    rtc->t1msb = 39999 >> 8;
-    rtc->t1lsb = 39999 & 0xff;
+    rtc->t1msb = RTC_TIMER_COUNT >> 8;
+    rtc->t1lsb = RTC_TIMER_COUNT & 0xff;
     rtc->irr_icr1 &= 0xef;	/* Route timer 1 to INTR pin */
     rtc->msr = 0x40;		/* Access int.cntrl, etc */
     rtc->pfr_icr0 = 0x80;	/* Just timer 1 ints enabled */
@@ -198,6 +213,8 @@ void bvme6000_sched_init (irq_handler_t timer_routine)
 
     rtc->msr = msr;
 
+    clocksource_register_hz(&bvme6000_clk, RTC_TIMER_CLOCK_FREQ);
+
     if (request_irq(BVME_IRQ_ABORT, bvme6000_abort_int, 0,
 				"abort", bvme6000_abort_int))
 	panic ("Couldn't register abort int");
@@ -211,7 +228,7 @@ void bvme6000_sched_init (irq_handler_t timer_routine)
  * results...
  */
 
-u32 bvme6000_gettimeoffset(void)
+static u64 bvme6000_read_clk(struct clocksource *cs)
 {
     unsigned long flags;
     volatile RtcPtr_t rtc = (RtcPtr_t)BVME_RTC_BASE;
@@ -235,19 +252,18 @@ u32 bvme6000_gettimeoffset(void)
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
 
     local_irq_restore(flags);
 
-    return v * 1000;
+    return clk_total + v;
 }
 
 /*
-- 
2.18.1

