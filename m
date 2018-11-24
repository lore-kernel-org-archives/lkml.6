Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FE6C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C0020824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C0020824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbeKXN5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:57:54 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56588 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbeKXN5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:57:53 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 1525D28EA2; Fri, 23 Nov 2018 22:11:08 -0500 (EST)
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
Message-Id: <bbe621df45f9fd3efdec7ca2a7274efd508288e6.1543028943.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543028943.git.fthain@telegraphics.com.au>
References: <cover.1543028943.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v3 02/14] m68k: mac: Fix VIA timer counter accesses
Date:   Sat, 24 Nov 2018 14:09:03 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This resolves some bugs that affect VIA timer counter accesses.
Avoid lost interrupts caused by reading the counter low byte register.
Make allowance for the fact that the counter will be decremented to
0xFFFF before being reloaded.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v2:
 - Don't check for timer interrupt in mac_gettimeoffset() when the timer is
about to be reloaded.

Changed since v1:
 - Test the timer interrupt flag unconditionally.
 - Drop some extraneous clean up.
 - Don't try to recover from lost timer interrupts. Don't lose them
in the first place. That means giving up on the timer counter low byte.
The extra precision is probably not worth the extra complexity and
I couldn't make it work anyway.
---
 arch/m68k/mac/via.c | 102 +++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 49 deletions(-)

diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index f6df83ba2227..f1f39ecf84c2 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -54,16 +54,6 @@ static __u8 rbv_clear;
 
 static int gIER,gIFR,gBufA,gBufB;
 
-/*
- * Timer defs.
- */
-
-#define TICK_SIZE		10000
-#define MAC_CLOCK_TICK		(783300/HZ)		/* ticks per HZ */
-#define MAC_CLOCK_LOW		(MAC_CLOCK_TICK&0xFF)
-#define MAC_CLOCK_HIGH		(MAC_CLOCK_TICK>>8)
-
-
 /*
  * On Macs with a genuine VIA chip there is no way to mask an individual slot
  * interrupt. This limitation also seems to apply to VIA clone logic cores in
@@ -267,22 +257,6 @@ void __init via_init(void)
 	}
 }
 
-/*
- * Start the 100 Hz clock
- */
-
-void __init via_init_clock(irq_handler_t func)
-{
-	via1[vACR] |= 0x40;
-	via1[vT1LL] = MAC_CLOCK_LOW;
-	via1[vT1LH] = MAC_CLOCK_HIGH;
-	via1[vT1CL] = MAC_CLOCK_LOW;
-	via1[vT1CH] = MAC_CLOCK_HIGH;
-
-	if (request_irq(IRQ_MAC_TIMER_1, func, 0, "timer", func))
-		pr_err("Couldn't register %s interrupt\n", "timer");
-}
-
 /*
  * Debugging dump, used in various places to see what's going on.
  */
@@ -310,29 +284,6 @@ void via_debug_dump(void)
 	}
 }
 
-/*
- * This is always executed with interrupts disabled.
- *
- * TBI: get time offset between scheduling timer ticks
- */
-
-u32 mac_gettimeoffset(void)
-{
-	unsigned long ticks, offset = 0;
-
-	/* read VIA1 timer 2 current value */
-	ticks = via1[vT1CL] | (via1[vT1CH] << 8);
-	/* The probability of underflow is less than 2% */
-	if (ticks > MAC_CLOCK_TICK - MAC_CLOCK_TICK / 50)
-		/* Check for pending timer interrupt in VIA1 IFR */
-		if (via1[vIFR] & 0x40) offset = TICK_SIZE;
-
-	ticks = MAC_CLOCK_TICK - ticks;
-	ticks = ticks * 10000L / MAC_CLOCK_TICK;
-
-	return (ticks + offset) * 1000;
-}
-
 /*
  * Flush the L2 cache on Macs that have it by flipping
  * the system into 24-bit mode for an instant.
@@ -618,3 +569,56 @@ int via2_scsi_drq_pending(void)
 	return via2[gIFR] & (1 << IRQ_IDX(IRQ_MAC_SCSIDRQ));
 }
 EXPORT_SYMBOL(via2_scsi_drq_pending);
+
+/* timer and clock source */
+
+#define VIA_CLOCK_FREQ     783360                /* VIA "phase 2" clock in Hz */
+#define VIA_TIMER_INTERVAL (1000000 / HZ)        /* microseconds per jiffy */
+#define VIA_TIMER_CYCLES   (VIA_CLOCK_FREQ / HZ) /* clock cycles per jiffy */
+
+#define VIA_TC             (VIA_TIMER_CYCLES - 2) /* including 0 and -1 */
+#define VIA_TC_LOW         (VIA_TC & 0xFF)
+#define VIA_TC_HIGH        (VIA_TC >> 8)
+
+void __init via_init_clock(irq_handler_t timer_routine)
+{
+	if (request_irq(IRQ_MAC_TIMER_1, timer_routine, 0, "timer", NULL)) {
+		pr_err("Couldn't register %s interrupt\n", "timer");
+		return;
+	}
+
+	via1[vT1LL] = VIA_TC_LOW;
+	via1[vT1LH] = VIA_TC_HIGH;
+	via1[vT1CL] = VIA_TC_LOW;
+	via1[vT1CH] = VIA_TC_HIGH;
+	via1[vACR] |= 0x40;
+}
+
+u32 mac_gettimeoffset(void)
+{
+	unsigned long flags;
+	u8 count_high;
+	u16 count, offset = 0;
+
+	/*
+	 * Timer counter wrap-around is detected with the timer interrupt flag
+	 * but reading the counter low byte (vT1CL) would reset the flag.
+	 * Also, accessing both counter registers is essentially a data race.
+	 * These problems are avoided by ignoring the low byte. Clock accuracy
+	 * is 256 times worse (error can reach 0.327 ms) but CPU overhead is
+	 * reduced by avoiding slow VIA register accesses.
+	 */
+
+	local_irq_save(flags);
+	count_high = via1[vT1CH];
+	if (count_high == 0xFF)
+		count_high = 0;
+	else if (via1[vIFR] & VIA_TIMER_1_INT)
+		offset = VIA_TIMER_CYCLES;
+	local_irq_restore(flags);
+
+	count = count_high << 8;
+	count = VIA_TIMER_CYCLES - count + offset;
+
+	return ((count * VIA_TIMER_INTERVAL) / VIA_TIMER_CYCLES) * 1000;
+}
-- 
2.18.1

