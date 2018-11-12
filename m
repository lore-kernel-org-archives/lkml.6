Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CD4C0044B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FC7216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FC7216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbeKLOiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:38:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48708 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbeKLOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:23 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 3598E297DA; Sun, 11 Nov 2018 23:46:56 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Joshua Thompson <funaho@jurai.org>
Message-Id: <075df60595c7b84cd5de197fb2e7cc83efa44b59.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 11/13] m68k: mac: Convert to clocksource API
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform clocksource by adapting the existing arch_gettimeoffset
implementation.

Cc: Joshua Thompson <funaho@jurai.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/via.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index 7130abec0b77..c4c304470fae 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include <linux/clocksource.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -556,13 +557,23 @@ EXPORT_SYMBOL(via2_scsi_drq_pending);
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
 static bool lost_timer_intr;
 
 static irqreturn_t via_timer_handler(int irq, void *data)
@@ -573,16 +584,18 @@ static irqreturn_t via_timer_handler(int irq, void *data)
 	local_irq_save(flags);
 	if (lost_timer_intr) {
 		lost_timer_intr = false;
-		local_irq_restore(flags);
-		func(irq, data);
-	} else
-		local_irq_restore(flags);
+		clk_total += VIA_TIMER_CYCLES;
+	}
+	clk_total += VIA_TIMER_CYCLES;
+	local_irq_restore(flags);
+
 	return func(irq, data);
 }
 
 void __init via_init_clock(irq_handler_t func)
 {
-	if (request_irq(IRQ_MAC_TIMER_1, via_timer_handler, 0, "timer", func)) {
+	if (request_irq(IRQ_MAC_TIMER_1, via_timer_handler, IRQF_TIMER,
+			"timer", func)) {
 		pr_err("Couldn't register %s interrupt\n", "timer");
 		return;
 	}
@@ -592,11 +605,13 @@ void __init via_init_clock(irq_handler_t func)
 	via1[vT1CL] = VIA_TC_LOW;
 	via1[vT1CH] = VIA_TC_HIGH;
 	via1[vACR] |= 0x40;
+
+	clocksource_register_hz(&mac_clk, VIA_CLOCK_FREQ);
 }
 
 #define VIA_T1_INT_FLAG BIT(6)
 
-u32 mac_gettimeoffset(void)
+static u64 mac_read_clk(struct clocksource *cs)
 {
 	unsigned long flags;
 	u8 count_high, count_high_new, count_low;
@@ -631,5 +646,5 @@ u32 mac_gettimeoffset(void)
 	count = ((count_high << 8) | count_low) + 1;
 	count = VIA_TIMER_CYCLES - count + offset;
 
-	return ((count * VIA_TIMER_INTERVAL) / VIA_TIMER_CYCLES) * 1000;
+	return clk_total + count;
 }
-- 
2.18.1

