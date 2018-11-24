Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C760C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14D220824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14D220824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbeKXN6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:58:14 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56768 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbeKXN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:57:56 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 0B8A628F8D; Fri, 23 Nov 2018 22:11:09 -0500 (EST)
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
Message-Id: <7f45799963d916f2a273647c392c14925720a86d.1543028943.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543028943.git.fthain@telegraphics.com.au>
References: <cover.1543028943.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v3 14/14] m68k: mvme16x: Handle timer counter overflow
Date:   Sat, 24 Nov 2018 14:09:03 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the timer counter races with timer overflow (and the
corresponding interrupt). This is resolved by reading the overflow
register and taking this value into account. The interrupt handler
must clear the overflow register when it eventually executes.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
TODO: find a spare counter for the clocksource, rather than hanging
it off the HZ timer.
---
 arch/m68k/mvme16x/config.c | 45 +++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index 2c109ee2a1a5..9bc2da69f80c 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -115,11 +115,11 @@ static void __init mvme16x_init_IRQ (void)
 	m68k_setup_user_interrupt(VEC_USER, 192);
 }
 
-#define pcc2chip	((volatile u_char *)0xfff42000)
-#define PccSCCMICR	0x1d
-#define PccSCCTICR	0x1e
-#define PccSCCRICR	0x1f
-#define PccTPIACKR	0x25
+#define PCC2CHIP   (0xfff42000)
+#define PCCSCCMICR (PCC2CHIP + 0x1d)
+#define PCCSCCTICR (PCC2CHIP + 0x1e)
+#define PCCSCCRICR (PCC2CHIP + 0x1f)
+#define PCCTPIACKR (PCC2CHIP + 0x25)
 
 #ifdef CONFIG_EARLY_PRINTK
 
@@ -227,10 +227,10 @@ void mvme16x_cons_write(struct console *co, const char *str, unsigned count)
 	base_addr[CyIER] = CyTxMpty;
 
 	while (1) {
-		if (pcc2chip[PccSCCTICR] & 0x20)
+		if (in_8(PCCSCCTICR) & 0x20)
 		{
 			/* We have a Tx int. Acknowledge it */
-			sink = pcc2chip[PccTPIACKR];
+			sink = in_8(PCCTPIACKR);
 			if ((base_addr[CyLICR] >> 2) == port) {
 				if (i == count) {
 					/* Last char of string is now output */
@@ -359,13 +359,26 @@ static u32 clk_total;
 #define PCC_TIMER_CLOCK_FREQ 1000000
 #define PCC_TIMER_CYCLES     (PCC_TIMER_CLOCK_FREQ / HZ)
 
+#define PCCTCMP1             (PCC2CHIP + 0x04)
+#define PCCTCNT1             (PCC2CHIP + 0x08)
+#define PCCTOVR1             (PCC2CHIP + 0x17)
+#define PCCTIC1              (PCC2CHIP + 0x1b)
+
+#define PCCTOVR1_TIC_EN      0x01
+#define PCCTOVR1_COC_EN      0x02
+#define PCCTOVR1_OVR_CLR     0x04
+
+#define PCCTIC1_INT_CLR      0x08
+#define PCCTIC1_INT_EN       0x10
+
 static irqreturn_t mvme16x_timer_int (int irq, void *dev_id)
 {
 	irq_handler_t timer_routine = dev_id;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	*(volatile unsigned char *)0xfff4201b |= 8;
+	out_8(PCCTIC1, in_8(PCCTIC1) | PCCTIC1_INT_CLR);
+	out_8(PCCTOVR1, PCCTOVR1_OVR_CLR);
 	clk_total += PCC_TIMER_CYCLES;
 	timer_routine(0, NULL);
 	local_irq_restore(flags);
@@ -379,10 +392,10 @@ void mvme16x_sched_init (irq_handler_t timer_routine)
     int irq;
 
     /* Using PCCchip2 or MC2 chip tick timer 1 */
-    *(volatile unsigned long *)0xfff42008 = 0;
-    *(volatile unsigned long *)0xfff42004 = PCC_TIMER_CYCLES;
-    *(volatile unsigned char *)0xfff42017 |= 3;
-    *(volatile unsigned char *)0xfff4201b = 0x16;
+    out_be32(PCCTCNT1, 0);
+    out_be32(PCCTCMP1, PCC_TIMER_CYCLES);
+    out_8(PCCTOVR1, in_8(PCCTOVR1) | PCCTOVR1_TIC_EN | PCCTOVR1_COC_EN);
+    out_8(PCCTIC1, PCCTIC1_INT_EN | 6);
     if (request_irq(MVME16x_IRQ_TIMER, mvme16x_timer_int, IRQF_TIMER, "timer",
                     timer_routine))
 	panic ("Couldn't register timer int");
@@ -401,10 +414,16 @@ void mvme16x_sched_init (irq_handler_t timer_routine)
 static u64 mvme16x_read_clk(struct clocksource *cs)
 {
 	unsigned long flags;
+	u8 overflow, tmp;
 	u32 ticks;
 
 	local_irq_save(flags);
-	ticks = *(volatile u32 *)0xfff42008;
+	tmp = in_8(PCCTOVR1) >> 4;
+	ticks = in_be32(PCCTCNT1);
+	overflow = in_8(PCCTOVR1) >> 4;
+	if (overflow != tmp)
+		ticks = in_be32(PCCTCNT1);
+	ticks += overflow * PCC_TIMER_CYCLES;
 	ticks += clk_total;
 	local_irq_restore(flags);
 
-- 
2.18.1

