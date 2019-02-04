Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68361C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A792080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UQagg1uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfBDRTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:19:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39945 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfBDRSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so727075wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBzMlLxKyj6J+r0jihNlaESKZhODSHFO165otMN1QtA=;
        b=UQagg1uZ9/j9k50lQD2u53EZ2MVxbMaTxndhGbYaeNe9qcGnR9dl/FJUOD09IiA8yT
         BOnd6pAmPw26W8svdPieHILKiru6I9XSaQ1yObux1IoADOIAmJ76X3Pw8tI7Z6CRjLjJ
         UWVLqwGsie+6bxGfBbVAQZ05834R6rEO8FVGefE8bUKpVAl69mwZ4/6v5Tcvw64JHW08
         oSOevBbIZbAquyyhcNBdwms0AGfA5vEEHURdqUYpP6s4H+d/reY2Np7bg0ov4WDVxpIO
         bDf4S8JceiHyeiLwVUV45oGEEJdk+RmCm7fL2av/u6iFglDgWubQBXMjIXkxUTuhZ9Bm
         w5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBzMlLxKyj6J+r0jihNlaESKZhODSHFO165otMN1QtA=;
        b=S6b0bOBq8pgsZy03JjOGSHjWW69aj1sgH/H3eX/cz0ije4IbgSz/qGKiMj4UHyTPhX
         maLB44KLbhuc11N3wtWuVR68lHXS7ah7mWVQteivtKLF+kyD+P9w0LDprKH8QD4Wb3v4
         2gV19oF5MW1VrxDByShkwa40oaj7f97Q6npi/chg1Bt4bQGtGFbsspEnHRwTPcNgxasc
         6sjtEYFcPScDaChmD4UIEASPcsaoALhSBTEx2v3YW1gK+RQXR4tStB0Usbb107s2APAG
         pguL48bocJe3tdTUUQjL6/HukDWoJHdLe4ILltr8HsS2si7l8Ydbn19CQxWOxgmUsZx5
         uixA==
X-Gm-Message-State: AHQUAuZrsyfAsMQ4KVBholwSaT1dpL91uwt+5iOF0A/m/OL15q7+iWDB
        bCTHOet96JB4o/q2cT9Gc19ayQ==
X-Google-Smtp-Source: AHgI3IYqJtSnQdsdM9P8LVJfp5z8YkudyPrHujmJS78IJV90O5j7bTOYVEOvwerbym02FTcQ/KKjgw==
X-Received: by 2002:a1c:e484:: with SMTP id b126mr288541wmh.119.1549300692820;
        Mon, 04 Feb 2019 09:18:12 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
        by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:18:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 05/12] ARM: davinci: da850: switch to using the clocksource driver
Date:   Mon,  4 Feb 2019 18:17:50 +0100
Message-Id: <20190204171757.32073-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a proper clocksource driver for davinci. Switch the platform
to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 56 ++++++++++++++---------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index beb34ee42e3a..66c2ffd4885b 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -34,7 +34,8 @@
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
 #include <mach/pm.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "mux.h"
 
@@ -436,38 +437,24 @@ static struct davinci_id da850_ids[] = {
 	},
 };
 
-static struct davinci_timer_instance da850_timer_instance[4] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_0,
-		.top_irq	= IRQ_DA8XX_TINT34_0,
-	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_1,
-		.top_irq	= IRQ_DA8XX_TINT34_1,
-	},
-	{
-		.base		= DA850_TIMER64P2_BASE,
-		.bottom_irq	= IRQ_DA850_TINT12_2,
-		.top_irq	= IRQ_DA850_TINT34_2,
-	},
-	{
-		.base		= DA850_TIMER64P3_BASE,
-		.bottom_irq	= IRQ_DA850_TINT12_3,
-		.top_irq	= IRQ_DA850_TINT34_3,
+static const struct davinci_timer_cfg da850_timer_cfg = {
+	.reg = {
+		.start		= DA8XX_TIMER64P0_BASE,
+		.end		= DA8XX_TIMER64P0_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
 	},
-};
-
-/*
- * T0_BOT: Timer 0, bottom		: Used for clock_event
- * T0_TOP: Timer 0, top			: Used for clocksource
- * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
- */
-static struct davinci_timer_info da850_timer_info = {
-	.timers		= da850_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+	.irq = {
+		{
+			.start	= IRQ_DA8XX_TINT12_0,
+			.end	= IRQ_DA8XX_TINT12_0,
+			.flags	= IORESOURCE_IRQ,
+		},
+		{
+			.start	= IRQ_DA8XX_TINT34_0,
+			.end	= IRQ_DA8XX_TINT34_0,
+			.flags	= IORESOURCE_IRQ,
+		}
+	}
 };
 
 #ifdef CONFIG_CPU_FREQ
@@ -742,7 +729,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
 	.intc_irq_prios		= da850_default_priorities,
 	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
-	.timer_info		= &da850_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
 	.sram_len		= SZ_128K,
@@ -765,6 +751,7 @@ void __init da850_init_time(void)
 	void __iomem *pll0;
 	struct regmap *cfgchip;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
 
@@ -779,7 +766,8 @@ void __init da850_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da850_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da850_pll1_resources[] = {
-- 
2.20.1

