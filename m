Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB24920824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB24920824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbeKXN5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:57:55 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56604 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeKXN5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:57:53 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 2F25D28F67; Fri, 23 Nov 2018 22:11:08 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>
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
Message-Id: <f305ca6e1a904fec7666c782db2ad16cce1150c9.1543028943.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1543028943.git.fthain@telegraphics.com.au>
References: <cover.1543028943.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v3 03/14] m68k: apollo, q40, sun3, sun3x: Remove
 arch_gettimeoffset implementations
Date:   Sat, 24 Nov 2018 14:09:03 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These dummy implementations are no better than
default_arch_gettimeoffset() so remove them.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/apollo/config.c | 7 -------
 arch/m68k/q40/config.c    | 9 ---------
 arch/m68k/sun3/config.c   | 2 --
 arch/m68k/sun3/intersil.c | 7 -------
 arch/m68k/sun3x/config.c  | 1 -
 arch/m68k/sun3x/time.c    | 5 -----
 arch/m68k/sun3x/time.h    | 1 -
 7 files changed, 32 deletions(-)

diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index aef8d42e078d..7d168e6dfb01 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -29,7 +29,6 @@ u_long apollo_model;
 
 extern void dn_sched_init(irq_handler_t handler);
 extern void dn_init_IRQ(void);
-extern u32 dn_gettimeoffset(void);
 extern int dn_dummy_hwclk(int, struct rtc_time *);
 extern void dn_dummy_reset(void);
 #ifdef CONFIG_HEARTBEAT
@@ -152,7 +151,6 @@ void __init config_apollo(void)
 
 	mach_sched_init=dn_sched_init; /* */
 	mach_init_IRQ=dn_init_IRQ;
-	arch_gettimeoffset   = dn_gettimeoffset;
 	mach_max_dma_address = 0xffffffff;
 	mach_hwclk           = dn_dummy_hwclk; /* */
 	mach_reset	     = dn_dummy_reset;  /* */
@@ -205,11 +203,6 @@ void dn_sched_init(irq_handler_t timer_routine)
 		pr_err("Couldn't register timer interrupt\n");
 }
 
-u32 dn_gettimeoffset(void)
-{
-	return 0xdeadbeef;
-}
-
 int dn_dummy_hwclk(int op, struct rtc_time *t) {
 
 
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 96810d91da2b..e63eb5f06999 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -40,7 +40,6 @@ extern void q40_init_IRQ(void);
 static void q40_get_model(char *model);
 extern void q40_sched_init(irq_handler_t handler);
 
-static u32 q40_gettimeoffset(void);
 static int q40_hwclk(int, struct rtc_time *);
 static unsigned int q40_get_ss(void);
 static int q40_get_rtc_pll(struct rtc_pll_info *pll);
@@ -169,7 +168,6 @@ void __init config_q40(void)
 	mach_sched_init = q40_sched_init;
 
 	mach_init_IRQ = q40_init_IRQ;
-	arch_gettimeoffset = q40_gettimeoffset;
 	mach_hwclk = q40_hwclk;
 	mach_get_ss = q40_get_ss;
 	mach_get_rtc_pll = q40_get_rtc_pll;
@@ -201,13 +199,6 @@ int __init q40_parse_bootinfo(const struct bi_record *rec)
 	return 1;
 }
 
-
-static u32 q40_gettimeoffset(void)
-{
-	return 5000 * (ql_ticks != 0) * 1000;
-}
-
-
 /*
  * Looks like op is non-zero for setting the clock, and zero for
  * reading the clock.
diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index 79a2bb857906..867e68d92c71 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -37,7 +37,6 @@
 
 char sun3_reserved_pmeg[SUN3_PMEGS_NUM];
 
-extern u32 sun3_gettimeoffset(void);
 static void sun3_sched_init(irq_handler_t handler);
 extern void sun3_get_model (char* model);
 extern int sun3_hwclk(int set, struct rtc_time *t);
@@ -138,7 +137,6 @@ void __init config_sun3(void)
         mach_sched_init      =  sun3_sched_init;
         mach_init_IRQ        =  sun3_init_IRQ;
         mach_reset           =  sun3_reboot;
-	arch_gettimeoffset   =  sun3_gettimeoffset;
 	mach_get_model	     =  sun3_get_model;
 	mach_hwclk           =  sun3_hwclk;
 	mach_halt	     =  sun3_halt;
diff --git a/arch/m68k/sun3/intersil.c b/arch/m68k/sun3/intersil.c
index d911070af02a..8fc74864de81 100644
--- a/arch/m68k/sun3/intersil.c
+++ b/arch/m68k/sun3/intersil.c
@@ -22,13 +22,6 @@
 #define STOP_VAL (INTERSIL_STOP | INTERSIL_INT_ENABLE | INTERSIL_24H_MODE)
 #define START_VAL (INTERSIL_RUN | INTERSIL_INT_ENABLE | INTERSIL_24H_MODE)
 
-/* does this need to be implemented? */
-u32 sun3_gettimeoffset(void)
-{
-  return 1000;
-}
-
-
 /* get/set hwclock */
 
 int sun3_hwclk(int set, struct rtc_time *t)
diff --git a/arch/m68k/sun3x/config.c b/arch/m68k/sun3x/config.c
index 33d3a1c6fba0..03ce7f9facfe 100644
--- a/arch/m68k/sun3x/config.c
+++ b/arch/m68k/sun3x/config.c
@@ -49,7 +49,6 @@ void __init config_sun3x(void)
 	mach_sched_init      = sun3x_sched_init;
 	mach_init_IRQ        = sun3_init_IRQ;
 
-	arch_gettimeoffset   = sun3x_gettimeoffset;
 	mach_reset           = sun3x_reboot;
 
 	mach_hwclk           = sun3x_hwclk;
diff --git a/arch/m68k/sun3x/time.c b/arch/m68k/sun3x/time.c
index 3c8a86d08508..9163294b0fb6 100644
--- a/arch/m68k/sun3x/time.c
+++ b/arch/m68k/sun3x/time.c
@@ -73,11 +73,6 @@ int sun3x_hwclk(int set, struct rtc_time *t)
 
 	return 0;
 }
-/* Not much we can do here */
-u32 sun3x_gettimeoffset(void)
-{
-    return 0L;
-}
 
 #if 0
 static irqreturn_t sun3x_timer_tick(int irq, void *dev_id)
diff --git a/arch/m68k/sun3x/time.h b/arch/m68k/sun3x/time.h
index 496f406412ad..86ce78bb3c28 100644
--- a/arch/m68k/sun3x/time.h
+++ b/arch/m68k/sun3x/time.h
@@ -3,7 +3,6 @@
 #define SUN3X_TIME_H
 
 extern int sun3x_hwclk(int set, struct rtc_time *t);
-u32 sun3x_gettimeoffset(void);
 void sun3x_sched_init(irq_handler_t vector);
 
 struct mostek_dt {
-- 
2.18.1

