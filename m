Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA23CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B970206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/Hn6xi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B970206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeJEVfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54092 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbeJEVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so2096288wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=42gVI9Mul9ZEo4P6uwAWXvqZv3TicHp4jJ2fdAWvaR8=;
        b=b/Hn6xi4EP41ktrUUrRLsE58MRtnV4kp/wTTzkZKVCxLz49zcjn4kTexLJwVJWhNcu
         w4he9SUsxG/TLqoXKLyJ1mhZSxGjcoVHI9X2uO5LLXWQva4hZLrzDWy+2FrDuTtRwpbP
         CbI6hO78umXhX6YlyXQGkr8FAJ+qKkW91gjVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=42gVI9Mul9ZEo4P6uwAWXvqZv3TicHp4jJ2fdAWvaR8=;
        b=MJlBfqDOAuAOBuYz4sE/1S5F5MjIfpa8rqxPsBAt6PkdFy7s5aEMP8YusbfxF7m659
         9+XxIiS6oZw4XxNTWuy5uCYfzKHUSQtCjErDahaj3seEiJLTVmJwO93gSpz+JJQXg7EU
         hNKSCXA3cyTAlHth+9qWgu3Brb5KBfr/vxB47WXTa93poZfRk7GUW7nSHVyWf2qwwmJR
         ObTP1aPqip5EWHnxPMfGv4PRCQlK9p/7WmsZAGhk1aU6+MQcBj2n3TK+qF2B2xtwio2/
         DQdgZKN9ViXZcpST7SQSwn1pPEs7KJwcTPVszjfWT/ALeAb/rrCcyudZ8lH+5MDUdk+G
         +pBw==
X-Gm-Message-State: ABuFfois6WSl3ObvXCa1W9UIqPAPPg2nwrBPW3jn5VTkfrfa7pKb1X3s
        LJa/P0YmtK/SjvkXeLBAnofHIg==
X-Google-Smtp-Source: ACcGV62t0adWdzUIlBVcETzfkYD3w9ILVa+WlL4XFpjYuu5WUj+rcbTCpM/OSoR+13BeqcAMrOkG6g==
X-Received: by 2002:a1c:8414:: with SMTP id g20-v6mr2418089wmd.123.1538750164842;
        Fri, 05 Oct 2018 07:36:04 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/13] clocksource: Convert to using %pOFn instead of device_node.name
Date:   Fri,  5 Oct 2018 16:35:30 +0200
Message-Id: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20181005143253.GE1881@mai>
References: <20181005143253.GE1881@mai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
index 38cd2fe..fbaee04 100644
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
index 29d5175..b334029 100644
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
index 69866cd..fabaa29 100644
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
index 08cd6eaf..3958379 100644
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
index 1220206..7d487107 100644
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
index 62d2469..76e526f 100644
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
index e01222e..052b230 100644
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
index f746893..6127e80 100644
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
2.7.4

