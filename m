Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeDYKO6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:14:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56370 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbeDYKOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:14:55 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] clocksource/drivers/timer-atmel-pit: properly handle error cases
Date: Wed, 25 Apr 2018 12:14:39 +0200
Message-Id: <20180425101439.28908-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch now reports a possible leak:

smatch warnings:
drivers/clocksource/timer-atmel-pit.c:183 at91sam926x_pit_dt_init() warn: possible memory leak of 'data'

Ensure data is freed before exiting with an error.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/timer-atmel-pit.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

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
-- 
2.17.0
