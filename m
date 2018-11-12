Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D82CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E318F214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E318F214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbeKLOiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:38:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48716 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730982AbeKLOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:24 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 5D4AF297EF; Sun, 11 Nov 2018 23:46:56 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <2f4015ba435f6f06b874295d2a47319875474c7f.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 13/13] m68k: mvme16x: Convert to clocksource API
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform clocksource by adapting the existing arch_gettimeoffset
implementation.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mvme16x/config.c | 45 +++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index f1ed52331df3..7bd3a25b2d75 100644
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
@@ -49,12 +50,6 @@ extern void mvme16x_reset (void);
 
 int bcd2int (unsigned char b);
 
-/* Save tick handler routine pointer, will point to xtime_update() in
- * kernel/time/timekeeping.c, called via mvme16x_process_int() */
-
-static irq_handler_t tick_handler;
-
-
 unsigned short mvme16x_config;
 EXPORT_SYMBOL(mvme16x_config);
 
@@ -348,9 +343,31 @@ static irqreturn_t mvme16x_abort_int (int irq, void *dev_id)
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
+    irq_handler_t tick_handler = dev_id;
+    unsigned long flags;
+
+    local_irq_save(flags);
     *(volatile unsigned char *)0xfff4201b |= 8;
+    clk_total += PCC_TIMER_CYCLES;
+    local_irq_restore(flags);
+
     return tick_handler(irq, dev_id);
 }
 
@@ -359,16 +376,17 @@ void mvme16x_sched_init (irq_handler_t timer_routine)
     uint16_t brdno = be16_to_cpu(mvme_bdid.brdno);
     int irq;
 
-    tick_handler = timer_routine;
     /* Using PCCchip2 or MC2 chip tick timer 1 */
     *(volatile unsigned long *)0xfff42008 = 0;
-    *(volatile unsigned long *)0xfff42004 = 10000;	/* 10ms */
+    *(volatile unsigned long *)0xfff42004 = PCC_TIMER_CYCLES;
     *(volatile unsigned char *)0xfff42017 |= 3;
     *(volatile unsigned char *)0xfff4201b = 0x16;
-    if (request_irq(MVME16x_IRQ_TIMER, mvme16x_timer_int, 0,
-				"timer", mvme16x_timer_int))
+    if (request_irq(MVME16x_IRQ_TIMER, mvme16x_timer_int, IRQF_TIMER,
+				"timer", timer_routine))
 	panic ("Couldn't register timer int");
 
+    clocksource_register_hz(&mvme16x_clk, PCC_TIMER_CLOCK_FREQ);
+
     if (brdno == 0x0162 || brdno == 0x172)
 	irq = MVME162_IRQ_ABORT;
     else
@@ -378,10 +396,11 @@ void mvme16x_sched_init (irq_handler_t timer_routine)
 	panic ("Couldn't register abort int");
 }
 
-
-u32 mvme16x_gettimeoffset(void)
+static u64 mvme16x_read_clk(struct clocksource *cs)
 {
-    return (*(volatile u32 *)0xfff42008) * 1000;
+    u32 count = *(volatile u32 *)0xfff42008;
+
+    return clk_total + count;
 }
 
 int bcd2int (unsigned char b)
-- 
2.18.1

