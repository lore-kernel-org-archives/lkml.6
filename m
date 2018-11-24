Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7186C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA4720824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA4720824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbeKXN6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:58:55 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56742 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbeKXN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:57:54 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id B912D28F77; Fri, 23 Nov 2018 22:11:08 -0500 (EST)
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
Message-Id: <50bce2c03535a8a789d75664214ffbd9c1da15b3.1543028943.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543028943.git.fthain@telegraphics.com.au>
References: <cover.1543028943.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v3 09/14] m68k: hp300: Handle timer counter overflow
Date:   Sat, 24 Nov 2018 14:09:03 +1100
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
---
 arch/m68k/hp300/time.c | 44 +++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/m68k/hp300/time.c b/arch/m68k/hp300/time.c
index 90982803a629..ce6b5fc8d4a9 100644
--- a/arch/m68k/hp300/time.c
+++ b/arch/m68k/hp300/time.c
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
@@ -70,24 +73,29 @@ static irqreturn_t hp300_tick(int irq, void *dev_id)
 
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
+	u16 offset = 0;
+	u32 ticks;
+
+	local_irq_save(flags);
+	/* Read current timer 1 value */
+	msb = in_8(CLOCKBASE + CLKMSB1);
+again:
+	if ((in_8(CLOCKBASE + CLKSR) & CLKSR_INT1) && msb > 0)
+		offset = INTVAL;
+	lsb = in_8(CLOCKBASE + CLKLSB1);
+	msb_new = in_8(CLOCKBASE + CLKMSB1);
+	if (msb_new != msb) {
+		msb = msb_new;
+		goto again;
+	}
+
+	ticks = INTVAL - ((msb << 8) | lsb);
+	ticks += offset + clk_total;
+	local_irq_restore(flags);
+
+	return ticks;
 }
 
 void __init hp300_sched_init(irq_handler_t vector)
-- 
2.18.1

