Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645A2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C529214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C529214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbeKLOjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:39:21 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48600 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbeKLOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:22 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 9D7DF297DC; Sun, 11 Nov 2018 23:46:55 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Joshua Thompson <funaho@jurai.org>
Message-Id: <44ec2361b438c63fc276ade5352da3e4bc4e6022.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 03/13] m68k: mac: Fix VIA timer counter accesses
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This resolves some bugs that affect VIA timer counter accesses.
Firstly, keep track of lost interrupts caused by reading the counter.
Secondly, check for inconsistent results when reading the counter.
Finally, make allowance for the fact that the counter will be
decremented to 0xFFFF before being reloaded.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: Joshua Thompson <funaho@jurai.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/config.c |   7 +--
 arch/m68k/mac/via.c    | 135 ++++++++++++++++++++++++-----------------
 2 files changed, 82 insertions(+), 60 deletions(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index cd9317d53276..2367c3792dc7 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -72,11 +72,6 @@ static void mac_get_model(char *str);
 static void mac_identify(void);
 static void mac_report_hardware(void);
 
-static void __init mac_sched_init(irq_handler_t vector)
-{
-	via_init_clock(vector);
-}
-
 /*
  * Parse a Macintosh-specific record in the bootinfo
  */
@@ -152,7 +147,7 @@ void __init config_mac(void)
 	if (!MACH_IS_MAC)
 		pr_err("ERROR: no Mac, but config_mac() called!!\n");
 
-	mach_sched_init = mac_sched_init;
+	mach_sched_init = via_init_clock;
 	mach_init_IRQ = mac_init_IRQ;
 	mach_get_model = mac_get_model;
 	arch_gettimeoffset = mac_gettimeoffset;
diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index e5dff74f59b3..7130abec0b77 100644
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
@@ -310,34 +284,6 @@ void via_debug_dump(void)
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
-	unsigned long flags;
-	unsigned long ticks, offset = 0;
-
-	local_irq_save(flags);
-
-	/* read VIA1 timer 2 current value */
-	ticks = via1[vT1CL] | (via1[vT1CH] << 8);
-	/* The probability of underflow is less than 2% */
-	if (ticks > MAC_CLOCK_TICK - MAC_CLOCK_TICK / 50)
-		/* Check for pending timer interrupt in VIA1 IFR */
-		if (via1[vIFR] & 0x40) offset = TICK_SIZE;
-
-	local_irq_restore(flags);
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
@@ -606,3 +552,84 @@ int via2_scsi_drq_pending(void)
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
+static bool lost_timer_intr;
+
+static irqreturn_t via_timer_handler(int irq, void *data)
+{
+	irq_handler_t func = data;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (lost_timer_intr) {
+		lost_timer_intr = false;
+		local_irq_restore(flags);
+		func(irq, data);
+	} else
+		local_irq_restore(flags);
+	return func(irq, data);
+}
+
+void __init via_init_clock(irq_handler_t func)
+{
+	if (request_irq(IRQ_MAC_TIMER_1, via_timer_handler, 0, "timer", func)) {
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
+#define VIA_T1_INT_FLAG BIT(6)
+
+u32 mac_gettimeoffset(void)
+{
+	unsigned long flags;
+	u8 count_high, count_high_new, count_low;
+	u16 count, offset = 0;
+
+	/*
+	 * Timer counter wrap-around is detected with the timer interrupt flag
+	 * but the flag gets reset when the counter low byte (vT1CL) is read.
+	 * Also, accessing both counter registers is an unavoidable data race.
+	 * To avoid these problems we could ignore the LSB. Clock accuracy
+	 * would get 256 times worse (error could reach 0.327 ms) but CPU
+	 * overhead would decrease (because VIA register accesses are so slow).
+	 */
+
+	local_irq_save(flags);
+
+	count_high = via1[vT1CH];
+again:
+	if (count_high == 0xFF && (via1[vIFR] & VIA_T1_INT_FLAG))
+		lost_timer_intr = true;
+	count_low = via1[vT1CL];
+	count_high_new = via1[vT1CH];
+	if (count_high_new != count_high) {
+		count_high = count_high_new;
+		goto again;
+	}
+	if (lost_timer_intr)
+		offset = VIA_TIMER_CYCLES;
+
+	local_irq_restore(flags);
+
+	count = ((count_high << 8) | count_low) + 1;
+	count = VIA_TIMER_CYCLES - count + offset;
+
+	return ((count * VIA_TIMER_INTERVAL) / VIA_TIMER_CYCLES) * 1000;
+}
-- 
2.18.1

