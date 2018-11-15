Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D327CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A559B223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A559B223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbeKOVc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:32:26 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:50524 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbeKOVcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:32:25 -0500
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 0BQu1z00J3XaVaC01BQuVJ; Thu, 15 Nov 2018 12:24:57 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gNFlW-00087u-RG; Thu, 15 Nov 2018 12:24:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gNEY9-0004lB-88; Thu, 15 Nov 2018 11:07:01 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: smp_twd: Remove legacy TWD registration
Date:   Thu, 15 Nov 2018 11:06:59 +0100
Message-Id: <20181115100659.18256-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 7484c727b636a838 ("ARM: realview: delete the RealView board
files"), the ARM Timer and Watchdog Unit is instantiated from DT only.
Moreover, the driver is selected from ARCH_MULTIPLATFORM platforms only,
which implies OF, TIMER_OF, and COMMON_CLK.

Hence remove all unused legacy infrastructure from the driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
As of commit 6e63a3a294fdf91e ("watchdog: delete mpcore_wdt driver"),
the TWD_WDOG_* definitions are unused, but I think it's good to keep
them for documentation.
---
 arch/arm/Kconfig               |  1 -
 arch/arm/include/asm/smp_twd.h | 16 ---------
 arch/arm/kernel/smp_twd.c      | 66 ----------------------------------
 3 files changed, 83 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1b7c73facaed9849..77fe160bfcdd07af 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1359,7 +1359,6 @@ config HAVE_ARM_ARCH_TIMER
 
 config HAVE_ARM_TWD
 	bool
-	select TIMER_OF if OF
 	help
 	  This options enables support for the ARM timer and watchdog unit
 
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 312784ee9936ae4f..c729d2113a2457e3 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -19,20 +19,4 @@
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
-#include <linux/ioport.h>
-
-struct twd_local_timer {
-	struct resource	res[2];
-};
-
-#define DEFINE_TWD_LOCAL_TIMER(name,base,irq)	\
-struct twd_local_timer name __initdata = {	\
-	.res	= {				\
-		DEFINE_RES_MEM(base, 0x10),	\
-		DEFINE_RES_IRQ(irq),		\
-	},					\
-};
-
-int twd_local_timer_register(struct twd_local_timer *);
-
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index b30eafeef09633d2..3cdc399b9fc32064 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -100,8 +100,6 @@ static void twd_timer_stop(void)
 	disable_percpu_irq(clk->irq);
 }
 
-#ifdef CONFIG_COMMON_CLK
-
 /*
  * Updates clockevent frequency when the cpu frequency changes.
  * Called on the cpu that is changing frequency with interrupts disabled.
@@ -143,54 +141,6 @@ static int twd_clk_init(void)
 }
 core_initcall(twd_clk_init);
 
-#elif defined (CONFIG_CPU_FREQ)
-
-#include <linux/cpufreq.h>
-
-/*
- * Updates clockevent frequency when the cpu frequency changes.
- * Called on the cpu that is changing frequency with interrupts disabled.
- */
-static void twd_update_frequency(void *data)
-{
-	twd_timer_rate = clk_get_rate(twd_clk);
-
-	clockevents_update_freq(raw_cpu_ptr(twd_evt), twd_timer_rate);
-}
-
-static int twd_cpufreq_transition(struct notifier_block *nb,
-	unsigned long state, void *data)
-{
-	struct cpufreq_freqs *freqs = data;
-
-	/*
-	 * The twd clock events must be reprogrammed to account for the new
-	 * frequency.  The timer is local to a cpu, so cross-call to the
-	 * changing cpu.
-	 */
-	if (state == CPUFREQ_POSTCHANGE)
-		smp_call_function_single(freqs->cpu, twd_update_frequency,
-			NULL, 1);
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block twd_cpufreq_nb = {
-	.notifier_call = twd_cpufreq_transition,
-};
-
-static int twd_cpufreq_init(void)
-{
-	if (twd_evt && raw_cpu_ptr(twd_evt) && !IS_ERR(twd_clk))
-		return cpufreq_register_notifier(&twd_cpufreq_nb,
-			CPUFREQ_TRANSITION_NOTIFIER);
-
-	return 0;
-}
-core_initcall(twd_cpufreq_init);
-
-#endif
-
 static void twd_calibrate_rate(void)
 {
 	unsigned long count;
@@ -366,21 +316,6 @@ static int __init twd_local_timer_common_register(struct device_node *np)
 	return err;
 }
 
-int __init twd_local_timer_register(struct twd_local_timer *tlt)
-{
-	if (twd_base || twd_evt)
-		return -EBUSY;
-
-	twd_ppi	= tlt->res[1].start;
-
-	twd_base = ioremap(tlt->res[0].start, resource_size(&tlt->res[0]));
-	if (!twd_base)
-		return -ENOMEM;
-
-	return twd_local_timer_common_register(NULL);
-}
-
-#ifdef CONFIG_OF
 static int __init twd_local_timer_of_register(struct device_node *np)
 {
 	int err;
@@ -406,4 +341,3 @@ static int __init twd_local_timer_of_register(struct device_node *np)
 TIMER_OF_DECLARE(arm_twd_a9, "arm,cortex-a9-twd-timer", twd_local_timer_of_register);
 TIMER_OF_DECLARE(arm_twd_a5, "arm,cortex-a5-twd-timer", twd_local_timer_of_register);
 TIMER_OF_DECLARE(arm_twd_11mp, "arm,arm11mp-twd-timer", twd_local_timer_of_register);
-#endif
-- 
2.17.1

