Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8343FC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC7320673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC7320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeLAMMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:12:17 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38158 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeLAMLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:11:31 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 6DACE28201; Fri, 30 Nov 2018 20:00:15 -0500 (EST)
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
Message-Id: <da2c77a4a2e6cf8e821f2b21c8b4c38b414d0ae7.1543625590.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543625590.git.fthain@telegraphics.com.au>
References: <cover.1543625590.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 12/14] m68k: mvme147: Handle timer counter overflow
Date:   Sat, 01 Dec 2018 11:53:10 +1100
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
 arch/m68k/include/asm/mvme147hw.h |  1 +
 arch/m68k/mvme147/config.c        | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/include/asm/mvme147hw.h b/arch/m68k/include/asm/mvme147hw.h
index 7c3dd513128e..257b29184af9 100644
--- a/arch/m68k/include/asm/mvme147hw.h
+++ b/arch/m68k/include/asm/mvme147hw.h
@@ -66,6 +66,7 @@ struct pcc_regs {
 #define PCC_INT_ENAB		0x08
 
 #define PCC_TIMER_INT_CLR	0x80
+#define PCC_TIMER_CLR_OVF	0x04
 
 #define PCC_LEVEL_ABORT		0x07
 #define PCC_LEVEL_SERIAL	0x04
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index c44a254e8a8c..545a1fe0e119 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -118,7 +118,7 @@ static irqreturn_t mvme147_timer_int (int irq, void *dev_id)
 
 	local_irq_save(flags);
 	m147_pcc->t1_int_cntrl = PCC_TIMER_INT_CLR;
-	m147_pcc->t1_int_cntrl = PCC_INT_ENAB|PCC_LEVEL_TIMER1;
+	m147_pcc->t1_cntrl = PCC_TIMER_CLR_OVF;
 	clk_total += PCC_TIMER_CYCLES;
 	timer_routine(0, NULL);
 	local_irq_restore(flags);
@@ -144,21 +144,22 @@ void mvme147_sched_init (irq_handler_t timer_routine)
 	clocksource_register_hz(&mvme147_clk, PCC_TIMER_CLOCK_FREQ);
 }
 
-/* XXX There are race hazards in this code XXX */
 static u64 mvme147_read_clk(struct clocksource *cs)
 {
 	unsigned long flags;
-	volatile unsigned short *cp = (volatile unsigned short *)0xfffe1012;
-	unsigned short n;
+	u8 overflow, tmp;
+	u16 count;
 	u32 ticks;
 
 	local_irq_save(flags);
-	n = *cp;
-	while (n != *cp)
-		n = *cp;
-
-	n -= PCC_TIMER_PRELOAD;
-	ticks = clk_total + n;
+	tmp = m147_pcc->t1_cntrl >> 4;
+	count = m147_pcc->t1_count;
+	overflow = m147_pcc->t1_cntrl >> 4;
+	if (overflow != tmp)
+		count = m147_pcc->t1_count;
+	count -= PCC_TIMER_PRELOAD;
+	ticks = count + overflow * PCC_TIMER_CYCLES;
+	ticks += clk_total;
 	local_irq_restore(flags);
 
 	return ticks;
-- 
2.18.1

