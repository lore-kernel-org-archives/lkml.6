Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965936AbeE2S1Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:27:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52148 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966078AbeE2S1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:27:02 -0400
X-Google-Smtp-Source: ADUXVKLaI/8uD6x6YuH0okmB03ZYqLJNaZTdSyJXfG0kc4uTbxUxWHEfb7tWxazDK7XKQNVgyzPVog==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH 2/7] clocksource/drivers/mips-gic-timer: Add pr_fmt and reword pr_* messages
Date: Tue, 29 May 2018 20:26:37 +0200
Message-Id: <1527618402-31974-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527618402-31974-1-git-send-email-daniel.lezcano@linaro.org>
References: <1274a543-02dd-bbf0-c690-b08c788d9e91@linaro.org>
 <1527618402-31974-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Redfearn <matt.redfearn@mips.com>

Several messages from the MIPS GIC driver include the text "GIC", "GIC
timer", etc, but the format is not standard. Add a pr_fmt of
"mips-gic-timer: " and reword the messages now that they will be
prefixed with the driver name.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/mips-gic-timer.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 986b679..54f8a33 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -5,6 +5,9 @@
  *
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
+
+#define pr_fmt(fmt) "mips-gic-timer: " fmt
+
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -136,8 +139,7 @@ static int gic_clockevent_init(void)
 
 	ret = setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
 	if (ret < 0) {
-		pr_err("GIC timer IRQ %d setup failed: %d\n",
-		       gic_timer_irq, ret);
+		pr_err("IRQ %d setup failed (%d)\n", gic_timer_irq, ret);
 		return ret;
 	}
 
@@ -176,7 +178,7 @@ static int __init __gic_clocksource_init(void)
 
 	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
 	if (ret < 0)
-		pr_warn("GIC: Unable to register clocksource\n");
+		pr_warn("Unable to register clocksource\n");
 
 	return ret;
 }
@@ -188,7 +190,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 
 	if (!mips_gic_present() || !node->parent ||
 	    !of_device_is_compatible(node->parent, "mti,gic")) {
-		pr_warn("No DT definition for the mips gic driver\n");
+		pr_warn("No DT definition\n");
 		return -ENXIO;
 	}
 
@@ -196,7 +198,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	if (!IS_ERR(clk)) {
 		ret = clk_prepare_enable(clk);
 		if (ret < 0) {
-			pr_err("GIC failed to enable clock\n");
+			pr_err("Failed to enable clock\n");
 			clk_put(clk);
 			return ret;
 		}
@@ -204,12 +206,12 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 		gic_frequency = clk_get_rate(clk);
 	} else if (of_property_read_u32(node, "clock-frequency",
 					&gic_frequency)) {
-		pr_err("GIC frequency not specified.\n");
+		pr_err("Frequency not specified\n");
 		return -EINVAL;
 	}
 	gic_timer_irq = irq_of_parse_and_map(node, 0);
 	if (!gic_timer_irq) {
-		pr_err("GIC timer IRQ not specified.\n");
+		pr_err("IRQ not specified\n");
 		return -EINVAL;
 	}
 
@@ -220,7 +222,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	ret = gic_clockevent_init();
 	if (!ret && !IS_ERR(clk)) {
 		if (clk_notifier_register(clk, &gic_clk_nb) < 0)
-			pr_warn("GIC: Unable to register clock notifier\n");
+			pr_warn("Unable to register clock notifier\n");
 	}
 
 	/* And finally start the counter */
-- 
2.7.4
