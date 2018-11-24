Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4151EC43610
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110D620824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110D620824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeKXN54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:57:56 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56794 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbeKXN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:57:55 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 02F1B28FAB; Fri, 23 Nov 2018 22:11:08 -0500 (EST)
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
Message-Id: <999f099c31ecaa3a3712d310f760576316fadcba.1543028943.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543028943.git.fthain@telegraphics.com.au>
References: <cover.1543028943.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v3 13/14] m68k: mvme16x: Convert to clocksource API
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
---
 arch/m68k/mvme16x/config.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index 3a3129e6f0bc..2c109ee2a1a5 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/seq_file.h>
 #include <linux/tty.h>
+#include <linux/clocksource.h>
 #include <linux/console.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
@@ -343,6 +344,21 @@ static irqreturn_t mvme16x_abort_int (int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static u64 mvme16x_read_clk(struct clocksource *cs);
+
+static struct clocksource mvme16x_clk = {
+	.name   = "pcc",
+	.rating = 250,
+	.read   = mvme16x_read_clk,
+	.mask   = CLOCKSOURCE_MASK(32),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u32 clk_total;
+
+#define PCC_TIMER_CLOCK_FREQ 1000000
+#define PCC_TIMER_CYCLES     (PCC_TIMER_CLOCK_FREQ / HZ)
+
 static irqreturn_t mvme16x_timer_int (int irq, void *dev_id)
 {
 	irq_handler_t timer_routine = dev_id;
@@ -350,6 +366,7 @@ static irqreturn_t mvme16x_timer_int (int irq, void *dev_id)
 
 	local_irq_save(flags);
 	*(volatile unsigned char *)0xfff4201b |= 8;
+	clk_total += PCC_TIMER_CYCLES;
 	timer_routine(0, NULL);
 	local_irq_restore(flags);
 
@@ -363,13 +380,15 @@ void mvme16x_sched_init (irq_handler_t timer_routine)
 
     /* Using PCCchip2 or MC2 chip tick timer 1 */
     *(volatile unsigned long *)0xfff42008 = 0;
-    *(volatile unsigned long *)0xfff42004 = 10000;	/* 10ms */
+    *(volatile unsigned long *)0xfff42004 = PCC_TIMER_CYCLES;
     *(volatile unsigned char *)0xfff42017 |= 3;
     *(volatile unsigned char *)0xfff4201b = 0x16;
-    if (request_irq(MVME16x_IRQ_TIMER, mvme16x_timer_int, 0, "timer",
+    if (request_irq(MVME16x_IRQ_TIMER, mvme16x_timer_int, IRQF_TIMER, "timer",
                     timer_routine))
 	panic ("Couldn't register timer int");
 
+    clocksource_register_hz(&mvme16x_clk, PCC_TIMER_CLOCK_FREQ);
+
     if (brdno == 0x0162 || brdno == 0x172)
 	irq = MVME162_IRQ_ABORT;
     else
@@ -379,11 +398,17 @@ void mvme16x_sched_init (irq_handler_t timer_routine)
 	panic ("Couldn't register abort int");
 }
 
-
-/* This is always executed with interrupts disabled.  */
-u32 mvme16x_gettimeoffset(void)
+static u64 mvme16x_read_clk(struct clocksource *cs)
 {
-    return (*(volatile u32 *)0xfff42008) * 1000;
+	unsigned long flags;
+	u32 ticks;
+
+	local_irq_save(flags);
+	ticks = *(volatile u32 *)0xfff42008;
+	ticks += clk_total;
+	local_irq_restore(flags);
+
+	return ticks;
 }
 
 int bcd2int (unsigned char b)
-- 
2.18.1

