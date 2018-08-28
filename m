Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4EAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C66208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C66208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeH1FnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:43:09 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41010 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeH1FmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:23 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so1738503oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cH0OYll1V4YFprZONAUEbO1bPnBQDYGpl7TDjKB86+A=;
        b=Meh9ydJt/A4jHCONuylhMvXQ/2HrQW2+vRedaiqf6TUy1kN5JFUssDqfEWPjfin19c
         d4fUQ8/zEbNzzuel2CnOuDso44KJUtTboa9tllWQDj0x6eFtED9iAn9wHf9+2cMbJktY
         EvHetSgK2NVtpDytvclMDVKdAE+rz/Ls/u+vzYEaLAfCNX0QQ01VzYK8Fn2qbgDHeinT
         OijdiurxN0hc8KcDyRiNIYmFspVE7ykAR2D4WfAzcZp6931fFT0hSdc3/CJYDM+boyyk
         PfvKv+H8Xa8oBx8Cv7OnsSqicrNS4/FBCPD5ZJmI9rAA0JgznxYBQPxMI82HBSZKoHrM
         7TcQ==
X-Gm-Message-State: APzg51Dx2ExvfFa9dLFjd3zIpzgNse5IZlzQRZKat69WxRzyTTVWGd84
        mRVOd2oMqELyJgyOyrP7GfbfUyY=
X-Google-Smtp-Source: ANB0VdbYrvyttlJ8+LKYwSJxACeBTShewV6xq4hs6CczJjPX/LlHDzYouQ/M3tuK6sgoZuSy4gQRyQ==
X-Received: by 2002:aca:5cd4:: with SMTP id q203-v6mr964836oib.217.1535421186687;
        Mon, 27 Aug 2018 18:53:06 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clocksource: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:14 -0500
Message-Id: <20180828015252.28511-13-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clocksource/asm9260_timer.c       | 2 +-
 drivers/clocksource/cadence_ttc_timer.c   | 2 +-
 drivers/clocksource/dw_apb_timer_of.c     | 8 ++++----
 drivers/clocksource/pxa_timer.c           | 6 +++---
 drivers/clocksource/time-orion.c          | 8 ++++----
 drivers/clocksource/timer-integrator-ap.c | 2 +-
 drivers/clocksource/timer-sp804.c         | 2 +-
 drivers/clocksource/zevio-timer.c         | 8 ++++----
 8 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index 38cd2feb87c4..fbaee04fd1d9 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -193,7 +193,7 @@ static int __init asm9260_timer_init(struct device_node *np)
 
 	priv.base = of_io_request_and_map(np, 0, np->name);
 	if (IS_ERR(priv.base)) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return PTR_ERR(priv.base);
 	}
 
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 29d51755e18b..b33402980b6f 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -535,7 +535,7 @@ static int __init ttc_timer_init(struct device_node *timer)
 	if (ret)
 		return ret;
 
-	pr_info("%s #0 at %p, irq=%d\n", timer->name, timer_baseaddr, irq);
+	pr_info("%pOFn #0 at %p, irq=%d\n", timer, timer_baseaddr, irq);
 
 	return 0;
 }
diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 69866cd8f4bb..fabaa29cc3a4 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -33,7 +33,7 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 	*base = of_iomap(np, 0);
 
 	if (!*base)
-		panic("Unable to map regs for %s", np->name);
+		panic("Unable to map regs for %pOFn", np);
 
 	/*
 	 * Not all implementations use a periphal clock, so don't panic
@@ -42,8 +42,8 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 	pclk = of_clk_get_by_name(np, "pclk");
 	if (!IS_ERR(pclk))
 		if (clk_prepare_enable(pclk))
-			pr_warn("pclk for %s is present, but could not be activated\n",
-				np->name);
+			pr_warn("pclk for %pOFn is present, but could not be activated\n",
+				np);
 
 	timer_clk = of_clk_get_by_name(np, "timer");
 	if (IS_ERR(timer_clk))
@@ -57,7 +57,7 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 try_clock_freq:
 	if (of_property_read_u32(np, "clock-freq", rate) &&
 	    of_property_read_u32(np, "clock-frequency", rate))
-		panic("No clock nor clock-frequency property for %s", np->name);
+		panic("No clock nor clock-frequency property for %pOFn", np);
 }
 
 static void __init add_clockevent(struct device_node *event_timer)
diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index 08cd6eaf3795..395837938301 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -191,13 +191,13 @@ static int __init pxa_timer_dt_init(struct device_node *np)
 	/* timer registers are shared with watchdog timer */
 	timer_base = of_iomap(np, 0);
 	if (!timer_base) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return -ENXIO;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_crit("%s: unable to get clk\n", np->name);
+		pr_crit("%pOFn: unable to get clk\n", np);
 		return PTR_ERR(clk);
 	}
 
@@ -210,7 +210,7 @@ static int __init pxa_timer_dt_init(struct device_node *np)
 	/* we are only interested in OS-timer0 irq */
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0) {
-		pr_crit("%s: unable to parse OS-timer0 irq\n", np->name);
+		pr_crit("%pOFn: unable to parse OS-timer0 irq\n", np);
 		return -EINVAL;
 	}
 
diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index 12202067fe4b..7d487107e3cd 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -129,13 +129,13 @@ static int __init orion_timer_init(struct device_node *np)
 	/* timer registers are shared with watchdog timer */
 	timer_base = of_iomap(np, 0);
 	if (!timer_base) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return -ENXIO;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_err("%s: unable to get clk\n", np->name);
+		pr_err("%pOFn: unable to get clk\n", np);
 		return PTR_ERR(clk);
 	}
 
@@ -148,7 +148,7 @@ static int __init orion_timer_init(struct device_node *np)
 	/* we are only interested in timer1 irq */
 	irq = irq_of_parse_and_map(np, 1);
 	if (irq <= 0) {
-		pr_err("%s: unable to parse timer1 irq\n", np->name);
+		pr_err("%pOFn: unable to parse timer1 irq\n", np);
 		return -EINVAL;
 	}
 
@@ -174,7 +174,7 @@ static int __init orion_timer_init(struct device_node *np)
 	/* setup timer1 as clockevent timer */
 	ret = setup_irq(irq, &orion_clkevt_irq);
 	if (ret) {
-		pr_err("%s: unable to setup irq\n", np->name);
+		pr_err("%pOFn: unable to setup irq\n", np);
 		return ret;
 	}
 
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 62d24690ba02..76e526f58620 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -190,7 +190,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		pr_err("No clock for %s\n", node->name);
+		pr_err("No clock for %pOFn\n", node);
 		return PTR_ERR(clk);
 	}
 	clk_prepare_enable(clk);
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index e01222ea888f..052b230ca312 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -249,7 +249,7 @@ static int __init sp804_of_init(struct device_node *np)
 	if (of_clk_get_parent_count(np) == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
-			pr_err("sp804: %s clock not found: %d\n", np->name,
+			pr_err("sp804: %pOFn clock not found: %d\n", np,
 				(int)PTR_ERR(clk2));
 			clk2 = NULL;
 		}
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/zevio-timer.c
index f74689334f7c..6127e8062a71 100644
--- a/drivers/clocksource/zevio-timer.c
+++ b/drivers/clocksource/zevio-timer.c
@@ -148,12 +148,12 @@ static int __init zevio_timer_add(struct device_node *node)
 
 	of_address_to_resource(node, 0, &res);
 	scnprintf(timer->clocksource_name, sizeof(timer->clocksource_name),
-			"%llx.%s_clocksource",
-			(unsigned long long)res.start, node->name);
+			"%llx.%pOFn_clocksource",
+			(unsigned long long)res.start, node);
 
 	scnprintf(timer->clockevent_name, sizeof(timer->clockevent_name),
-			"%llx.%s_clockevent",
-			(unsigned long long)res.start, node->name);
+			"%llx.%pOFn_clockevent",
+			(unsigned long long)res.start, node);
 
 	if (timer->interrupt_regs && irqnr) {
 		timer->clkevt.name		= timer->clockevent_name;
-- 
2.17.1

