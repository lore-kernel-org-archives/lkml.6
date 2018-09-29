Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B2C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFC020895
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFC020895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeI3AzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 20:55:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55847 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbeI3AzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 20:55:14 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g6Jw3-0006m5-PG; Sat, 29 Sep 2018 20:25:47 +0200
Subject: [GIT pull] timer fixes for 4.19
Message-ID: <153824547597.23234.1804316309314708658.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <153824547597.23234.11668873233247402922.tglx@nanos.tec.linutronix.de>
Date:   Sat, 29 Sep 2018 20:25:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

Three small fixes for clocksource drivers:

 - Proper error handling in the Atmel PIT driver
 
 - Add CLOCK_SOURCE_SUSPEND_NONSTOP for TI SoCs so suspend works again

 - Fix the next event function for Facebook Backpack-CMM BMC chips so
   usleep(100) doesnt sleep several milliseconds

Thanks,

	tglx

------------------>
Alexandre Belloni (1):
      clocksource/drivers/timer-atmel-pit: Properly handle error cases

Keerthy (1):
      clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for non-am43 SoCs

Tao Ren (1):
      clocksource/drivers/fttmr010: Fix set_next_event handler


 drivers/clocksource/timer-atmel-pit.c | 20 ++++++++++++++------
 drivers/clocksource/timer-fttmr010.c  | 18 +++++++++++-------
 drivers/clocksource/timer-ti-32k.c    |  3 +++
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index ec8a4376f74f..2fab18fae4fc 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -180,26 +180,29 @@ static int __init at91sam926x_pit_dt_init(struct device_node *node)
 	data->base = of_iomap(node, 0);
 	if (!data->base) {
 		pr_err("Could not map PIT address\n");
-		return -ENXIO;
+		ret = -ENXIO;
+		goto exit;
 	}
 
 	data->mck = of_clk_get(node, 0);
 	if (IS_ERR(data->mck)) {
 		pr_err("Unable to get mck clk\n");
-		return PTR_ERR(data->mck);
+		ret = PTR_ERR(data->mck);
+		goto exit;
 	}
 
 	ret = clk_prepare_enable(data->mck);
 	if (ret) {
 		pr_err("Unable to enable mck\n");
-		return ret;
+		goto exit;
 	}
 
 	/* Get the interrupts property */
 	data->irq = irq_of_parse_and_map(node, 0);
 	if (!data->irq) {
 		pr_err("Unable to get IRQ from DT\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto exit;
 	}
 
 	/*
@@ -227,7 +230,7 @@ static int __init at91sam926x_pit_dt_init(struct device_node *node)
 	ret = clocksource_register_hz(&data->clksrc, pit_rate);
 	if (ret) {
 		pr_err("Failed to register clocksource\n");
-		return ret;
+		goto exit;
 	}
 
 	/* Set up irq handler */
@@ -236,7 +239,8 @@ static int __init at91sam926x_pit_dt_init(struct device_node *node)
 			  "at91_tick", data);
 	if (ret) {
 		pr_err("Unable to setup IRQ\n");
-		return ret;
+		clocksource_unregister(&data->clksrc);
+		goto exit;
 	}
 
 	/* Set up and register clockevents */
@@ -254,6 +258,10 @@ static int __init at91sam926x_pit_dt_init(struct device_node *node)
 	clockevents_register_device(&data->clkevt);
 
 	return 0;
+
+exit:
+	kfree(data);
+	return ret;
 }
 TIMER_OF_DECLARE(at91sam926x_pit, "atmel,at91sam9260-pit",
 		       at91sam926x_pit_dt_init);
diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index c020038ebfab..cf93f6419b51 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -130,13 +130,17 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	cr &= ~fttmr010->t1_enable_val;
 	writel(cr, fttmr010->base + TIMER_CR);
 
-	/* Setup the match register forward/backward in time */
-	cr = readl(fttmr010->base + TIMER1_COUNT);
-	if (fttmr010->count_down)
-		cr -= cycles;
-	else
-		cr += cycles;
-	writel(cr, fttmr010->base + TIMER1_MATCH1);
+	if (fttmr010->count_down) {
+		/*
+		 * ASPEED Timer Controller will load TIMER1_LOAD register
+		 * into TIMER1_COUNT register when the timer is re-enabled.
+		 */
+		writel(cycles, fttmr010->base + TIMER1_LOAD);
+	} else {
+		/* Setup the match register forward in time */
+		cr = readl(fttmr010->base + TIMER1_COUNT);
+		writel(cr + cycles, fttmr010->base + TIMER1_MATCH1);
+	}
 
 	/* Start */
 	cr = readl(fttmr010->base + TIMER_CR);
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 29e2e1a78a43..6949a9113dbb 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
 		return -ENXIO;
 	}
 
+	if (!of_machine_is_compatible("ti,am43"))
+		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
+
 	ti_32k_timer.counter = ti_32k_timer.base;
 
 	/*

