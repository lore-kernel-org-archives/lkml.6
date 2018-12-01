Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B3C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7285120673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7285120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeLAMLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:11:32 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38156 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeLAMLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:11:31 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 3EB41281F5; Fri, 30 Nov 2018 20:00:15 -0500 (EST)
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
Message-Id: <2aa62fd1164340976feb6e5e58a3c960083a3d95.1543625590.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543625590.git.fthain@telegraphics.com.au>
References: <cover.1543625590.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 09/14] m68k: hp300: Handle timer counter overflow
Date:   Sat, 01 Dec 2018 11:53:10 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because hp300_read_clk() never checks the timer interrupt flag it may
fail to notice that the timer has wrapped, allowing the clock to jump
backwards. This is not a new problem.

This is resolved by checking the interrupt flag and, if need be,
taking wrap-around into account. The interrupt handler clears the flag
when it eventually executes.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
TODO: find a spare counter for the clocksource, rather than hanging
it off the HZ timer.

Changed since v3:
 - Use clk_offset variable to track the offset when the irq check is skipped.
---
 arch/m68k/hp300/time.c | 46 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/m68k/hp300/time.c b/arch/m68k/hp300/time.c
index 90982803a629..bfee13e1d0fe 100644
--- a/arch/m68k/hp300/time.c
+++ b/arch/m68k/hp300/time.c
@@ -30,7 +30,7 @@ static struct clocksource hp300_clk = {
 	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u32 clk_total;
+static u32 clk_total, clk_offset;
 
 /* Clock hardware definitions */
 
@@ -41,9 +41,12 @@ static u32 clk_total;
 #define	CLKCR3		CLKCR1
 #define	CLKSR		CLKCR2
 #define	CLKMSB1		0x5
+#define	CLKLSB1		0x7
 #define	CLKMSB2		0x9
 #define	CLKMSB3		0xD
 
+#define	CLKSR_INT1	BIT(0)
+
 /* This is for machines which generate the exact clock. */
 
 #define HP300_TIMER_CLOCK_FREQ 250000
@@ -60,6 +63,7 @@ static irqreturn_t hp300_tick(int irq, void *dev_id)
 	in_8(CLOCKBASE + CLKSR);
 	asm volatile ("movpw %1@(5),%0" : "=d" (tmp) : "a" (CLOCKBASE));
 	clk_total += INTVAL;
+	clk_offset = 0;
 	timer_routine(0, NULL);
 	local_irq_restore(flags);
 
@@ -70,24 +74,28 @@ static irqreturn_t hp300_tick(int irq, void *dev_id)
 
 static u64 hp300_read_clk(struct clocksource *cs)
 {
-  unsigned long flags;
-  unsigned char lsb, msb1, msb2;
-  u32 ticks;
-
-  local_irq_save(flags);
-  /* Read current timer 1 value */
-  msb1 = in_8(CLOCKBASE + 5);
-  lsb = in_8(CLOCKBASE + 7);
-  msb2 = in_8(CLOCKBASE + 5);
-  if (msb1 != msb2)
-    /* A carry happened while we were reading.  Read it again */
-    lsb = in_8(CLOCKBASE + 7);
-
-  ticks = INTVAL - ((msb2 << 8) | lsb);
-  ticks += clk_total;
-  local_irq_restore(flags);
-
-  return ticks;
+	unsigned long flags;
+	unsigned char lsb, msb, msb_new;
+	u32 ticks;
+
+	local_irq_save(flags);
+	/* Read current timer 1 value */
+	msb = in_8(CLOCKBASE + CLKMSB1);
+again:
+	if ((in_8(CLOCKBASE + CLKSR) & CLKSR_INT1) && msb > 0)
+		clk_offset = INTVAL;
+	lsb = in_8(CLOCKBASE + CLKLSB1);
+	msb_new = in_8(CLOCKBASE + CLKMSB1);
+	if (msb_new != msb) {
+		msb = msb_new;
+		goto again;
+	}
+
+	ticks = INTVAL - ((msb << 8) | lsb);
+	ticks += clk_offset + clk_total;
+	local_irq_restore(flags);
+
+	return ticks;
 }
 
 void __init hp300_sched_init(irq_handler_t vector)
-- 
2.18.1

