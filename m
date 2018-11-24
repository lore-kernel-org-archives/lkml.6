Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F57C04EBA
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6556520824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6556520824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbeKXN54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:57:56 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56744 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbeKXN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:57:55 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id C7BC428F78; Fri, 23 Nov 2018 22:11:08 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>
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
Message-Id: <0d0dd9db0030d249ab014c58abb904b241b5b6c9.1543028943.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543028943.git.fthain@telegraphics.com.au>
References: <cover.1543028943.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v3 10/14] m68k: mac: Convert to clocksource API
Date:   Sat, 24 Nov 2018 14:09:03 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform clocksource by adapting the existing arch_gettimeoffset
implementation.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
Changed since v2:
 - Drop unneeded 'clk_offset' variable.

Changed since v1:
 - Moved clk_total access to within the irq lock.
 - Use type u32 for tick counter.
---
 arch/m68k/mac/via.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index f1f39ecf84c2..c226ca7eae84 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include <linux/clocksource.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -573,16 +574,38 @@ EXPORT_SYMBOL(via2_scsi_drq_pending);
 /* timer and clock source */
 
 #define VIA_CLOCK_FREQ     783360                /* VIA "phase 2" clock in Hz */
-#define VIA_TIMER_INTERVAL (1000000 / HZ)        /* microseconds per jiffy */
 #define VIA_TIMER_CYCLES   (VIA_CLOCK_FREQ / HZ) /* clock cycles per jiffy */
 
 #define VIA_TC             (VIA_TIMER_CYCLES - 2) /* including 0 and -1 */
 #define VIA_TC_LOW         (VIA_TC & 0xFF)
 #define VIA_TC_HIGH        (VIA_TC >> 8)
 
+static u64 mac_read_clk(struct clocksource *cs);
+
+static struct clocksource mac_clk = {
+	.name   = "via1",
+	.rating = 250,
+	.read   = mac_read_clk,
+	.mask   = CLOCKSOURCE_MASK(32),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u32 clk_total;
+
+static irqreturn_t via_timer_handler(int irq, void *dev_id)
+{
+	irq_handler_t timer_routine = dev_id;
+
+	clk_total += VIA_TIMER_CYCLES;
+	timer_routine(0, NULL);
+
+	return IRQ_HANDLED;
+}
+
 void __init via_init_clock(irq_handler_t timer_routine)
 {
-	if (request_irq(IRQ_MAC_TIMER_1, timer_routine, 0, "timer", NULL)) {
+	if (request_irq(IRQ_MAC_TIMER_1, via_timer_handler, IRQF_TIMER, "timer",
+			timer_routine)) {
 		pr_err("Couldn't register %s interrupt\n", "timer");
 		return;
 	}
@@ -592,13 +615,16 @@ void __init via_init_clock(irq_handler_t timer_routine)
 	via1[vT1CL] = VIA_TC_LOW;
 	via1[vT1CH] = VIA_TC_HIGH;
 	via1[vACR] |= 0x40;
+
+	clocksource_register_hz(&mac_clk, VIA_CLOCK_FREQ);
 }
 
-u32 mac_gettimeoffset(void)
+static u64 mac_read_clk(struct clocksource *cs)
 {
 	unsigned long flags;
 	u8 count_high;
 	u16 count, offset = 0;
+	u32 ticks;
 
 	/*
 	 * Timer counter wrap-around is detected with the timer interrupt flag
@@ -615,10 +641,10 @@ u32 mac_gettimeoffset(void)
 		count_high = 0;
 	else if (via1[vIFR] & VIA_TIMER_1_INT)
 		offset = VIA_TIMER_CYCLES;
-	local_irq_restore(flags);
-
 	count = count_high << 8;
-	count = VIA_TIMER_CYCLES - count + offset;
+	ticks = VIA_TIMER_CYCLES - count;
+	ticks += offset + clk_total;
+	local_irq_restore(flags);
 
-	return ((count * VIA_TIMER_INTERVAL) / VIA_TIMER_CYCLES) * 1000;
+	return ticks;
 }
-- 
2.18.1

