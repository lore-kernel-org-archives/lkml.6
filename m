Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548D6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2798120872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BtzkJ6/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbfAKRWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50652 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbfAKRWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:22:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so3142029wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZYvMu846/Z0QmqxG01Wn3LSRT0rTSPDCgRe4LniEGE=;
        b=BtzkJ6/3A0SwgnbjCDhZ3G4MwbbOWQv6JowuXcDm5hO4UFAKWGed2bXqBxeEi9sIRf
         8eAnM0syaKXM/9ZhjU6IrR6RRHDcYndV6VXrGcbPQC0taQqlu3grD3OZdgfKtpFKDYp9
         bzUcup8bnppVjRHu5ysIZCXHVVf8lkawCSAm5MNetfFG1m0CpB/Cq1titbNNTmQGxaYm
         rlG/W0jb40s1Ycu9G8upS8rN02B+l47aN6E1X3LhKRdw4/qW7tvOvTiJ5eph04UjKBrE
         Y6iE1Ou+kLgGf37c+RPtAXNLLCiY55X6RrM92maDg3hhNMddQMt5uwtpngrPfb5gufk0
         FheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZYvMu846/Z0QmqxG01Wn3LSRT0rTSPDCgRe4LniEGE=;
        b=En/ZJ7DL41QNWHQ+hdamb3kEWGaa1i1cejDtMydYkrXi385cvgQ+BvmeKy694Z5qxb
         cDLvhsCNLzwK2l/No+NOKdrD71QwJ5Un3U07QxHM+ebmDny/KczF3AR1zpG4FL8ebLnJ
         XDunvj8Tr+eAPDNDyZl4uQkB65f4kNsk8b+F9ibAhFNbuWHtHHScwr+nGvngBWGbmMl5
         aXmk1n8uPnMe7ZyaaHqKf4Sl0SeOrH2TPxLY3peuISB4rg46b1Snta5CYFhSLA3qu8/K
         Me9hN9JOSgZTWuPpehx/DN3C3JBOlFgK7SsFhUi8vMotsHFcixY9T5lGEGE+aJmXxr9b
         JrQw==
X-Gm-Message-State: AJcUukcKfT/2miDjRF2JPtTuqRBU8EAmn9c/qqenBAIrZbFk6ifpvD+v
        6LqPnyllttf1fCejNMtD5dDVhw==
X-Google-Smtp-Source: ALg8bN6amoytBObZvtBC50bXhCBvxij4ANwDjVqO5hxeMFk9O+OrNCd3yeoLA4M/NqLtD+iliNzO4g==
X-Received: by 2002:a1c:e1d5:: with SMTP id y204mr3058300wmg.65.1547227323828;
        Fri, 11 Jan 2019 09:22:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:22:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 11/17] ARM: davinci: da830: switch to using the clocksource driver
Date:   Fri, 11 Jan 2019 18:21:28 +0100
Message-Id: <20190111172134.30147-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/da830.c | 56 ++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index ceb0417f10f6..0d81a8fdd9e6 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -20,7 +20,8 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "mux.h"
 
@@ -769,32 +770,32 @@ int __init da830_register_gpio(void)
 	return da8xx_register_gpio(&da830_gpio_platform_data);
 }
 
-static struct davinci_timer_instance da830_timer_instance[2] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_0,
-		.top_irq	= IRQ_DA8XX_TINT34_0,
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= IRQ_DA830_T12CMPINT0_0,
+static const struct davinci_timer_cfg da830_timer_cfg = {
+	.reg = {
+		.start		= DA8XX_TIMER64P0_BASE,
+		.end		= DA8XX_TIMER64P0_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
 	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_1,
-		.top_irq	= IRQ_DA8XX_TINT34_1,
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= IRQ_DA830_T12CMPINT0_1,
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
+		},
 	},
-};
-
-/*
- * T0_BOT: Timer 0, bottom		: Used for clock_event & clocksource
- * T0_TOP: Timer 0, top			: Used by DSP
- * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
- */
-static struct davinci_timer_info da830_timer_info = {
-	.timers		= da830_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_BOT,
+	.cmp = {
+		.irq = {
+			.start	= IRQ_DA830_T12CMPINT0_0,
+			.end	= IRQ_DA830_T12CMPINT0_0,
+			.flags	= IORESOURCE_IRQ,
+		},
+		.offset		= DA830_CMP12_0,
+	}
 };
 
 static const struct davinci_soc_info davinci_soc_info_da830 = {
@@ -810,7 +811,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
 	.intc_irq_prios		= da830_default_priorities,
 	.intc_irq_num		= DA830_N_CP_INTC_IRQ,
-	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
@@ -826,6 +826,7 @@ void __init da830_init_time(void)
 {
 	void __iomem *pll;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
 
@@ -836,7 +837,8 @@ void __init da830_init_time(void)
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da830_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da830_psc0_resources[] = {
-- 
2.19.1

