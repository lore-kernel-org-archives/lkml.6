Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D60C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12D9214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12D9214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbeKLOiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:38:23 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48572 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeKLOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:22 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 87D87297DB; Sun, 11 Nov 2018 23:46:55 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Philip Blundell <philb@gnu.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Joshua Thompson <funaho@jurai.org>
Message-Id: <6ba103c7e24d316e4bee7f713d5a8485a548c4e7.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 02/13] m68k: Fix mutual exclusion in arch_gettimeoffset
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementations of arch_gettimeoffset are generally not re-entrant
and assume that interrupts have been disabled. Unfortunately this
pre-condition got broken in v2.6.32.

Cc: Philip Blundell <philb@gnu.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Joshua Thompson <funaho@jurai.org>
Fixes: 4ad4c76b7afb ("m68k: convert to use arch_gettimeoffset()")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/amiga/config.c    |  6 +++++-
 arch/m68k/atari/time.c      |  6 +++++-
 arch/m68k/bvme6000/config.c | 10 +++++++---
 arch/m68k/hp300/time.c      |  8 +++++++-
 arch/m68k/mac/via.c         |  5 +++++
 arch/m68k/mvme147/config.c  |  6 +++++-
 arch/m68k/mvme16x/config.c  |  1 -
 7 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 65f63a457130..5ec3687984a9 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -492,12 +492,14 @@ static void __init amiga_sched_init(irq_handler_t timer_routine)
 
 #define TICK_SIZE 10000
 
-/* This is always executed with interrupts disabled.  */
 static u32 amiga_gettimeoffset(void)
 {
+	unsigned long flags;
 	unsigned short hi, lo, hi2;
 	u32 ticks, offset = 0;
 
+	local_irq_save(flags);
+
 	/* read CIA B timer A current value */
 	hi  = ciab.tahi;
 	lo  = ciab.talo;
@@ -515,6 +517,8 @@ static u32 amiga_gettimeoffset(void)
 		if (cia_set_irq(&ciab_base, 0) & CIA_ICR_TA)
 			offset = 10000;
 
+	local_irq_restore(flags);
+
 	ticks = jiffy_ticks - ticks;
 	ticks = (10000 * ticks) / jiffy_ticks;
 
diff --git a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
index 9cca64286464..4765e9a58293 100644
--- a/arch/m68k/atari/time.c
+++ b/arch/m68k/atari/time.c
@@ -40,11 +40,13 @@ atari_sched_init(irq_handler_t timer_routine)
 
 #define TICK_SIZE 10000
 
-/* This is always executed with interrupts disabled.  */
 u32 atari_gettimeoffset(void)
 {
+  unsigned long flags;
   u32 ticks, offset = 0;
 
+  local_irq_save(flags);
+
   /* read MFP timer C current value */
   ticks = st_mfp.tim_dt_c;
   /* The probability of underflow is less than 2% */
@@ -53,6 +55,8 @@ u32 atari_gettimeoffset(void)
     if (st_mfp.int_pn_b & (1 << 5))
       offset = TICK_SIZE;
 
+  local_irq_restore(flags);
+
   ticks = INT_TICKS - ticks;
   ticks = ticks * 10000L / INT_TICKS;
 
diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 143ee9fa3893..0afdef10a5a4 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -206,8 +206,6 @@ void bvme6000_sched_init (irq_handler_t timer_routine)
 }
 
 
-/* This is always executed with interrupts disabled.  */
-
 /*
  * NOTE:  Don't accept any readings within 5us of rollover, as
  * the T1INT bit may be a little slow getting set.  There is also
@@ -217,12 +215,16 @@ void bvme6000_sched_init (irq_handler_t timer_routine)
 
 u32 bvme6000_gettimeoffset(void)
 {
+    unsigned long flags;
     volatile RtcPtr_t rtc = (RtcPtr_t)BVME_RTC_BASE;
     volatile PitRegsPtr pit = (PitRegsPtr)BVME_PIT_BASE;
-    unsigned char msr = rtc->msr & 0xc0;
+    unsigned char msr;
     unsigned char t1int, t1op;
     u32 v = 800000, ov;
 
+    local_irq_save(flags);
+
+    msr = rtc->msr & 0xc0;
     rtc->msr = 0;	/* Ensure timer registers accessible */
 
     do {
@@ -245,6 +247,8 @@ u32 bvme6000_gettimeoffset(void)
 	v += 10000;			/* Int pending, + 10ms */
     rtc->msr = msr;
 
+    local_irq_restore(flags);
+
     return v * 1000;
 }
 
diff --git a/arch/m68k/hp300/time.c b/arch/m68k/hp300/time.c
index 289d928a46cb..5cf711fd0858 100644
--- a/arch/m68k/hp300/time.c
+++ b/arch/m68k/hp300/time.c
@@ -49,16 +49,22 @@ static irqreturn_t hp300_tick(int irq, void *dev_id)
 
 u32 hp300_gettimeoffset(void)
 {
-  /* Read current timer 1 value */
+  unsigned long flags;
   unsigned char lsb, msb1, msb2;
   unsigned short ticks;
 
+  local_irq_save(flags);
+
+  /* Read current timer 1 value */
   msb1 = in_8(CLOCKBASE + 5);
   lsb = in_8(CLOCKBASE + 7);
   msb2 = in_8(CLOCKBASE + 5);
   if (msb1 != msb2)
     /* A carry happened while we were reading.  Read it again */
     lsb = in_8(CLOCKBASE + 7);
+
+  local_irq_restore(flags);
+
   ticks = INTVAL - ((msb2 << 8) | lsb);
   return ((USECS_PER_JIFFY * ticks) / INTVAL) * 1000;
 }
diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index e4facff0c1f3..e5dff74f59b3 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -318,8 +318,11 @@ void via_debug_dump(void)
 
 u32 mac_gettimeoffset(void)
 {
+	unsigned long flags;
 	unsigned long ticks, offset = 0;
 
+	local_irq_save(flags);
+
 	/* read VIA1 timer 2 current value */
 	ticks = via1[vT1CL] | (via1[vT1CH] << 8);
 	/* The probability of underflow is less than 2% */
@@ -327,6 +330,8 @@ u32 mac_gettimeoffset(void)
 		/* Check for pending timer interrupt in VIA1 IFR */
 		if (via1[vIFR] & 0x40) offset = TICK_SIZE;
 
+	local_irq_restore(flags);
+
 	ticks = MAC_CLOCK_TICK - ticks;
 	ticks = ticks * 10000L / MAC_CLOCK_TICK;
 
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index adea549d240e..8074940b0aa1 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -125,17 +125,21 @@ void mvme147_sched_init (irq_handler_t timer_routine)
 	m147_pcc->t1_int_cntrl = PCC_INT_ENAB|PCC_LEVEL_TIMER1;
 }
 
-/* This is always executed with interrupts disabled.  */
 /* XXX There are race hazards in this code XXX */
 u32 mvme147_gettimeoffset(void)
 {
+	unsigned long flags;
 	volatile unsigned short *cp = (volatile unsigned short *)0xfffe1012;
 	unsigned short n;
 
+	local_irq_save(flags);
+
 	n = *cp;
 	while (n != *cp)
 		n = *cp;
 
+	local_irq_restore(flags);
+
 	n -= PCC_TIMER_PRELOAD;
 	return ((unsigned long)n * 25 / 4) * 1000;
 }
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index 6ee36a5b528d..d4aec717e688 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -381,7 +381,6 @@ void mvme16x_sched_init (irq_handler_t timer_routine)
 }
 
 
-/* This is always executed with interrupts disabled.  */
 u32 mvme16x_gettimeoffset(void)
 {
     return (*(volatile u32 *)0xfff42008) * 1000;
-- 
2.18.1

