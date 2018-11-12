Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D0FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B01214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B01214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbeKLOjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:39:03 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48682 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730827AbeKLOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:23 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 293A8297ED; Sun, 11 Nov 2018 23:46:56 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Philip Blundell <philb@gnu.org>
Message-Id: <6fd1919c60b88c0383be6d3555190a6411ebe2d4.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 10/13] m68k: hp300: Convert to clocksource API
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform clocksource by adapting the existing arch_gettimeoffset
implementation.

Cc: Philip Blundell <philb@gnu.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/hp300/time.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/hp300/time.c b/arch/m68k/hp300/time.c
index 5cf711fd0858..ff2fc65bc5e7 100644
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
@@ -32,22 +45,29 @@
 #define	CLKMSB3		0xD
 
 /* This is for machines which generate the exact clock. */
-#define USECS_PER_JIFFY (1000000/HZ)
 
-#define INTVAL ((10000 / 4) - 1)
+#define HP300_TIMER_CLOCK_FREQ 250000
+#define HP300_TIMER_CYCLES     (HP300_TIMER_CLOCK_FREQ / HZ)
+#define INTVAL                 (HP300_TIMER_CYCLES - 1)
 
 static irqreturn_t hp300_tick(int irq, void *dev_id)
 {
+	unsigned long flags;
 	unsigned long tmp;
 	irq_handler_t vector = dev_id;
+
+	local_irq_save(flags);
 	in_8(CLOCKBASE + CLKSR);
 	asm volatile ("movpw %1@(5),%0" : "=d" (tmp) : "a" (CLOCKBASE));
+	clk_total += INTVAL;
+	local_irq_restore(flags);
+
 	/* Turn off the network and SCSI leds */
 	blinken_leds(0, 0xe0);
 	return vector(irq, NULL);
 }
 
-u32 hp300_gettimeoffset(void)
+static u64 hp300_read_clk(struct clocksource *cs)
 {
   unsigned long flags;
   unsigned char lsb, msb1, msb2;
@@ -66,7 +86,8 @@ u32 hp300_gettimeoffset(void)
   local_irq_restore(flags);
 
   ticks = INTVAL - ((msb2 << 8) | lsb);
-  return ((USECS_PER_JIFFY * ticks) / INTVAL) * 1000;
+
+  return clk_total + ticks;
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

