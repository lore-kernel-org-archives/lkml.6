Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ECCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7A9218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8xi3QZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeLRV3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36410 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeLRV3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so3997048wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iaiZ9pwBG9RzbrqUHumu/RuV9tuwyb5+Fue+unC0Ghw=;
        b=h8xi3QZlSex41tQ20HEYt+p86wMNb9HEQl+zO+yLHGftq3q9/opn6x7ORwQiJseyD8
         L7WnwombGJYDc8q7vI8rJrYhfcfrcO4wnESNeSDBskOxnu5Jw/oNKd74l5tuUSloyrgf
         H4RnYitTnmGxjHibCIctUEZQcB5Y9Eg5/OflQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iaiZ9pwBG9RzbrqUHumu/RuV9tuwyb5+Fue+unC0Ghw=;
        b=TNPh9rA8NQzux0dsdAr7EqvzUlKQM5TIYYYMNHltC/ZPXWz7grcpWK0MmEYb8vl5Qh
         Wd+fK4D2R6xaQcZhh4uNfcPPikcqZ1XeenBvx7tVouQfy5Z9Jdi3Rsi7SVDUE+ak7oYT
         DK2WdZ5sM9aJW2QLf4TX6LQKnsT2aSUltdcHlcCKQ1+wHI6yFAex0toU4/JpyVozSLzD
         K77f1euBbZvi/osIhb4TMJioGZcKiPNihjRAFHOoVkNKmI7cjnsMpd5uiIVurzlMCy9a
         kLuyLtTbMLO475Rc1mU+lKeuxmBi4jvzu79D5K6e2hS6TCtiO0O4YT2pSl0LJSWazosp
         HCFw==
X-Gm-Message-State: AA+aEWbtoIw/nGIgK/6uWM1tyVQSMJqug35iNC2ZCOL0eZlo5d8/kAIM
        KORxk79lVj4z0VITsNcr+z/h2w==
X-Google-Smtp-Source: AFSGD/WYj7juu9nSbyRQHTjgoS6tLIAs8mfgbbSoPhU38qIZVC/vEtiL90MoFE6xwcQKqOEobvAcQA==
X-Received: by 2002:a1c:8b09:: with SMTP id n9mr4687124wmd.38.1545168569415;
        Tue, 18 Dec 2018 13:29:29 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:28 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 13/25] clocksource/drivers/timer-imx-tpm: Convert the driver to timer-of
Date:   Tue, 18 Dec 2018 22:28:31 +0100
Message-Id: <20181218212844.30445-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

Convert the driver to use the timer_of helpers.  This allows to handle
timer base, clock and irq using common timer_of driver and it
simplifies the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 136 +++++++++++-----------------
 1 file changed, 55 insertions(+), 81 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index b7aa2b817078..c3dd4d2f2a6e 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -12,6 +12,8 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
+#include "timer-of.h"
+
 #define TPM_PARAM			0x4
 #define TPM_PARAM_WIDTH_SHIFT		16
 #define TPM_PARAM_WIDTH_MASK		(0xff << 16)
@@ -33,9 +35,7 @@
 #define TPM_C0V				0x24
 
 static int counter_width;
-static int rating;
 static void __iomem *timer_base;
-static struct clock_event_device clockevent_tpm;
 
 static inline void tpm_timer_disable(void)
 {
@@ -80,19 +80,6 @@ static u64 notrace tpm_read_sched_clock(void)
 	return tpm_read_counter();
 }
 
-static int __init tpm_clocksource_init(unsigned long rate)
-{
-	tpm_delay_timer.read_current_timer = &tpm_read_current_timer;
-	tpm_delay_timer.freq = rate;
-	register_current_timer_delay(&tpm_delay_timer);
-
-	sched_clock_register(tpm_read_sched_clock, counter_width, rate);
-
-	return clocksource_mmio_init(timer_base + TPM_CNT, "imx-tpm",
-				     rate, rating, counter_width,
-				     clocksource_mmio_readl_up);
-}
-
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
@@ -137,74 +124,77 @@ static irqreturn_t tpm_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct clock_event_device clockevent_tpm = {
-	.name			= "i.MX7ULP TPM Timer",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_oneshot	= tpm_set_state_oneshot,
-	.set_next_event		= tpm_set_next_event,
-	.set_state_shutdown	= tpm_set_state_shutdown,
+static struct timer_of to_tpm = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.clkevt = {
+		.name			= "i.MX7ULP TPM Timer",
+		.rating			= 200,
+		.features		= CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown	= tpm_set_state_shutdown,
+		.set_state_oneshot	= tpm_set_state_oneshot,
+		.set_next_event		= tpm_set_next_event,
+		.cpumask		= cpu_possible_mask,
+	},
+	.of_irq = {
+		.handler		= tpm_timer_interrupt,
+		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
+	},
 };
 
-static int __init tpm_clockevent_init(unsigned long rate, int irq)
+static int __init tpm_clocksource_init(void)
 {
-	int ret;
+	tpm_delay_timer.read_current_timer = &tpm_read_current_timer;
+	tpm_delay_timer.freq = timer_of_rate(&to_tpm) >> 3;
+	register_current_timer_delay(&tpm_delay_timer);
 
-	ret = request_irq(irq, tpm_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			  "i.MX7ULP TPM Timer", &clockevent_tpm);
+	sched_clock_register(tpm_read_sched_clock, counter_width,
+			     timer_of_rate(&to_tpm) >> 3);
 
-	clockevent_tpm.rating = rating;
-	clockevent_tpm.cpumask = cpumask_of(0);
-	clockevent_tpm.irq = irq;
-	clockevents_config_and_register(&clockevent_tpm, rate, 300,
-					GENMASK(counter_width - 1, 1));
+	return clocksource_mmio_init(timer_base + TPM_CNT,
+				     "imx-tpm",
+				     timer_of_rate(&to_tpm) >> 3,
+				     to_tpm.clkevt.rating,
+				     counter_width,
+				     clocksource_mmio_readl_up);
+}
 
-	return ret;
+static void __init tpm_clockevent_init(void)
+{
+	clockevents_config_and_register(&to_tpm.clkevt,
+					timer_of_rate(&to_tpm) >> 3,
+					300,
+					GENMASK(counter_width - 1,
+					1));
 }
 
 static int __init tpm_timer_init(struct device_node *np)
 {
-	struct clk *ipg, *per;
-	int irq, ret;
-	u32 rate;
-
-	timer_base = of_iomap(np, 0);
-	if (!timer_base) {
-		pr_err("tpm: failed to get base address\n");
-		return -ENXIO;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		pr_err("tpm: failed to get irq\n");
-		ret = -ENOENT;
-		goto err_iomap;
-	}
+	struct clk *ipg;
+	int ret;
 
 	ipg = of_clk_get_by_name(np, "ipg");
-	per = of_clk_get_by_name(np, "per");
-	if (IS_ERR(ipg) || IS_ERR(per)) {
-		pr_err("tpm: failed to get ipg or per clk\n");
-		ret = -ENODEV;
-		goto err_clk_get;
+	if (IS_ERR(ipg)) {
+		pr_err("tpm: failed to get ipg clk\n");
+		return -ENODEV;
 	}
-
 	/* enable clk before accessing registers */
 	ret = clk_prepare_enable(ipg);
 	if (ret) {
 		pr_err("tpm: ipg clock enable failed (%d)\n", ret);
-		goto err_clk_get;
+		clk_put(ipg);
+		return ret;
 	}
 
-	ret = clk_prepare_enable(per);
-	if (ret) {
-		pr_err("tpm: per clock enable failed (%d)\n", ret);
-		goto err_per_clk_enable;
-	}
+	ret = timer_of_init(np, &to_tpm);
+	if (ret)
+		return ret;
+
+	timer_base = timer_of_base(&to_tpm);
 
-	counter_width = (readl(timer_base + TPM_PARAM) & TPM_PARAM_WIDTH_MASK)
-		>> TPM_PARAM_WIDTH_SHIFT;
+	counter_width = (readl(timer_base + TPM_PARAM)
+		& TPM_PARAM_WIDTH_MASK) >> TPM_PARAM_WIDTH_SHIFT;
 	/* use rating 200 for 32-bit counter and 150 for 16-bit counter */
-	rating = counter_width == 0x20 ? 200 : 150;
+	to_tpm.clkevt.rating = counter_width == 0x20 ? 200 : 150;
 
 	/*
 	 * Initialize tpm module to a known state
@@ -229,29 +219,13 @@ static int __init tpm_timer_init(struct device_node *np)
 	writel(TPM_SC_CMOD_INC_PER_CNT |
 		(counter_width == 0x20 ?
 		TPM_SC_CMOD_DIV_DEFAULT : TPM_SC_CMOD_DIV_MAX),
-		     timer_base + TPM_SC);
+		timer_base + TPM_SC);
 
 	/* set MOD register to maximum for free running mode */
 	writel(GENMASK(counter_width - 1, 0), timer_base + TPM_MOD);
 
-	rate = clk_get_rate(per) >> 3;
-	ret = tpm_clocksource_init(rate);
-	if (ret)
-		goto err_per_clk_enable;
-
-	ret = tpm_clockevent_init(rate, irq);
-	if (ret)
-		goto err_per_clk_enable;
-
-	return 0;
+	tpm_clockevent_init();
 
-err_per_clk_enable:
-	clk_disable_unprepare(ipg);
-err_clk_get:
-	clk_put(per);
-	clk_put(ipg);
-err_iomap:
-	iounmap(timer_base);
-	return ret;
+	return tpm_clocksource_init();
 }
 TIMER_OF_DECLARE(imx7ulp, "fsl,imx7ulp-tpm", tpm_timer_init);
-- 
2.17.1

