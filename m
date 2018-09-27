Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B46C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2130821580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9Q61Zw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2130821580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeI0VK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:10:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32854 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeI0VK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:10:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id f10-v6so2986025wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LqqPzQb5rQKmQSK7Lm4nztokxHt2+EweWXTUlu6+fsA=;
        b=G9Q61Zw7AvfgvRicmMgoe0AStVH40izkd7SM/8qLl8TRaLFgDpRHnjAPlSV1DMdCKg
         lSJ4gx/mqrNoVFTQ+unVTgrjq1rf0j1F6byP6YE0jMN/w8ngEny4i40cJT+GSsO3snO5
         PPx/gZucA4Du4MaqnS8RLiF/t2AgbcyPHIMD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LqqPzQb5rQKmQSK7Lm4nztokxHt2+EweWXTUlu6+fsA=;
        b=BHRNDykXriWsQYpgSCAr7Z6Pj3S4RdzQ+2EaNG2p8GXHSKulney4dYWgV6KaObVmma
         dh3ZwrK0RvHavg6LfMkGQnkjlYR194k0xB8DvpT65HHBr5qNaV8krQU1IKjz7b3E4+YU
         QaKPrmiNnmoBFqI4O4Gebz+18PYKqIC43qiFxPq/JzVOUKUC3G7xsI+Xj7uwVZ3wAdsm
         e0vObkKXG3L9G1JQCA3bRtT3YosVIUd03p/5rX9Uri14kLw8RzDV2dnfMcFiHlgMaShN
         WV41GPOfP8zJPTAOI+Zg0mfiJbwPy+ZsTtgYZPtb0KV3g54DjxeXkwQLFsPQrH/jgwjV
         y0gA==
X-Gm-Message-State: ABuFfoipSgJ74pVfroxStzvFyiMmVgXFZCTbITT+PiszePLhO4stpX0Z
        Kz+ctJonAPS0nmXCgjAh5zuUBg==
X-Google-Smtp-Source: ACcGV61nkJsXQrtq+1tFBSBPJQu8hmPkaDLT7xWt8w1vX1rgs4BCKfblKTcOYXCIrpRWk+v8yQnFog==
X-Received: by 2002:adf:ef0a:: with SMTP id e10-v6mr948078wro.292.1538059909962;
        Thu, 27 Sep 2018 07:51:49 -0700 (PDT)
Received: from localhost.localdomain (30.216.136.77.rev.sfr.net. [77.136.216.30])
        by smtp.gmail.com with ESMTPSA id p11-v6sm2398023wrd.74.2018.09.27.07.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 07:51:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     mingo@kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH] clocksource/drivers/timer-atmel-pit: Properly handle error cases
Date:   Thu, 27 Sep 2018 16:51:35 +0200
Message-Id: <1538059895-10049-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <ea561d6f-22f8-b1f7-a063-d559900a9004@linaro.org>
References: <ea561d6f-22f8-b1f7-a063-d559900a9004@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The smatch utility reports a possible leak:

smatch warnings:
drivers/clocksource/timer-atmel-pit.c:183 at91sam926x_pit_dt_init() warn: possible memory leak of 'data'

Ensure data is freed before exiting with an error.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-atmel-pit.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index ec8a437..2fab18f 100644
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
2.7.4

