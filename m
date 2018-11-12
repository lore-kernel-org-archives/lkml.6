Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E94C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEF0214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEF0214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbeKLOi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:38:56 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48670 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbeKLOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:23 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 06E53297EB; Sun, 11 Nov 2018 23:46:56 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>
Message-Id: <efdb35ee790bac91293d222ea66559853276b6de.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 08/13] m68k: atari: Convert to clocksource API
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform clocksource by adapting the existing arch_gettimeoffset
implementation.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/atari/time.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
index 4765e9a58293..d066599fcc54 100644
--- a/arch/m68k/atari/time.c
+++ b/arch/m68k/atari/time.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/clocksource.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 
@@ -24,6 +25,30 @@
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL_GPL(rtc_lock);
 
+static u64 atari_read_clk(struct clocksource *cs);
+
+static struct clocksource atari_clk = {
+	.name   = "mfp",
+	.rating = 250,
+	.read   = atari_read_clk,
+	.mask   = CLOCKSOURCE_MASK(32),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u32 clk_total;
+
+static irqreturn_t mfp_timer_handler(int irq, void *data)
+{
+	irq_handler_t func = data;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	clk_total += INT_TICKS;
+	local_irq_restore(flags);
+
+	return func(irq, data);
+}
+
 void __init
 atari_sched_init(irq_handler_t timer_routine)
 {
@@ -32,15 +57,16 @@ atari_sched_init(irq_handler_t timer_routine)
     /* start timer C, div = 1:100 */
     st_mfp.tim_ct_cd = (st_mfp.tim_ct_cd & 15) | 0x60;
     /* install interrupt service routine for MFP Timer C */
-    if (request_irq(IRQ_MFP_TIMC, timer_routine, 0, "timer", timer_routine))
+    if (request_irq(IRQ_MFP_TIMC, mfp_timer_handler, IRQF_TIMER, "timer",
+                    timer_routine))
 	pr_err("Couldn't register timer interrupt\n");
+
+    clocksource_register_hz(&atari_clk, INT_CLK);
 }
 
 /* ++andreas: gettimeoffset fixed to check for pending interrupt */
 
-#define TICK_SIZE 10000
-
-u32 atari_gettimeoffset(void)
+static u64 atari_read_clk(struct clocksource *cs)
 {
   unsigned long flags;
   u32 ticks, offset = 0;
@@ -53,14 +79,13 @@ u32 atari_gettimeoffset(void)
   if (ticks > INT_TICKS - INT_TICKS / 50)
     /* Check for pending timer interrupt */
     if (st_mfp.int_pn_b & (1 << 5))
-      offset = TICK_SIZE;
+      offset = INT_TICKS;
 
   local_irq_restore(flags);
 
   ticks = INT_TICKS - ticks;
-  ticks = ticks * 10000L / INT_TICKS;
 
-  return (ticks + offset) * 1000;
+  return clk_total + ticks + offset;
 }
 
 
-- 
2.18.1

