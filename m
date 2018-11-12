Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E61C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C54216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C54216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbeKLOjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:39:11 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48672 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730706AbeKLOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:23 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id E7075297EA; Sun, 11 Nov 2018 23:46:55 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <cbfa6a4e8a1a36e22969e63b703015007abe8593.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 07/13] m68k: amiga: Convert to clocksource API
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform clocksource by adapting the existing arch_gettimeoffset
implementation.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/amiga/config.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index a575ad419b23..40ebd471cc3c 100644
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
@@ -461,7 +462,30 @@ void __init config_amiga(void)
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
+static irqreturn_t ciab_timer_handler(int irq, void *data)
+{
+	irq_handler_t timer_routine = data;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	clk_total += jiffy_ticks;
+	local_irq_restore(flags);
+
+	return timer_routine(irq, data);
+}
 
 static void __init amiga_sched_init(irq_handler_t timer_routine)
 {
@@ -481,15 +505,16 @@ static void __init amiga_sched_init(irq_handler_t timer_routine)
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
 
-static u32 amiga_gettimeoffset(void)
+static u64 amiga_read_clk(struct clocksource *cs)
 {
 	unsigned long flags;
 	unsigned short hi, lo, hi2;
@@ -512,14 +537,13 @@ static u32 amiga_gettimeoffset(void)
 	if (ticks > jiffy_ticks / 2)
 		/* check for pending interrupt */
 		if (cia_set_irq(&ciab_base, 0) & CIA_ICR_TA)
-			offset = 10000;
+			offset = jiffy_ticks;
 
 	local_irq_restore(flags);
 
 	ticks = jiffy_ticks - ticks;
-	ticks = (10000 * ticks) / jiffy_ticks;
 
-	return (ticks + offset) * 1000;
+	return clk_total + ticks + offset;
 }
 
 static void amiga_reset(void)  __noreturn;
-- 
2.18.1

