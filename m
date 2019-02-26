Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337BF217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Fb/xaq3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfBZMIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:08:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40301 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfBZMHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id g20so1310088wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4MwwcJoC6iJqHSejfwwvrVbinAYeAGrLxIx5tT49LA=;
        b=Fb/xaq3TPFATCPgmRMaGH6chOU1PlhqcnG71aoFPRzlRy9WI1ymc24KnlPhYk6HX7F
         OzVtbH6keLQDI03A84ia33fpOdyIMgvIgROrYuzgS1XHvxHfy7291eDPKSzxKTzp/S6a
         bQhtWj+9BxipvU2WjJOk9uFjFbru3QvhFIffs/BYdmJFPYZ6UWV0SaAciZhBZkUMzOTp
         KDn9DAPydqrPFDRxthKx6Y2/NZU8+Y3DOIUDc+t2YvFVqJfxVpCbh2jK5RZL0LZka46W
         Ym/2o5yF+sHGUlmSMlZNrOxcEJio0ejZl81snpO7A/9WSenCuBIrIzIKwQyZUhHRWVLt
         kBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4MwwcJoC6iJqHSejfwwvrVbinAYeAGrLxIx5tT49LA=;
        b=j1TyX9GIrks6OOoeumeRWk/4wDR/IfTb7v29IaKNe+2Q5ZwS31YFLkP7T2MOL2lv39
         X9Zh3SS7WUqq1sQ/XY9GM3PAGX4lAHtbZDFNUJwiNpD/RKm70I3yUs6t8NJorP9uccor
         hBG9nefXzjEK1s7dMrnTjw+dHaGjkV9GMPqDoetpdjsk90N7lLmOt0Hk7SGRm0NH7bTD
         uAN7P+XisfYkjS35JSbWyMwfJMeD8AayPrvTQOUamdbiYNA7hw/6caelNDi6hQon/Oqf
         k/idKAhIHamkvsUCHm39a7/JD+ySF2vBOcYOo8ByyPp78ML1WpLIW+bU2lzqsMdLQpyr
         Aoiw==
X-Gm-Message-State: AHQUAuZrM+0MlrPsH8Nf9xM2RaOoalnmCbRMgF7MxwtdB32tQCM0GjC1
        Xow5FOzR0x3Ue1kGJv1yM3nzzg==
X-Google-Smtp-Source: AHgI3IbF8x7E4VTDB5BGdunskzU9A5BU66OIhDUJZ/9bjvSS62ZP2GRsmKIb1GqeHbnBP2EKbWY+CA==
X-Received: by 2002:a7b:c146:: with SMTP id z6mr2338169wmi.145.1551182862613;
        Tue, 26 Feb 2019 04:07:42 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:07:41 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 10/11] ARM: davinci: dm646x: switch to using the clocksource driver
Date:   Tue, 26 Feb 2019 13:06:32 +0100
Message-Id: <20190226120633.18200-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a proper clocksource driver for davinci. Switch the dm646x
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm646x.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 7e5af984ed9f..22c444a94e27 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -27,7 +27,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -499,16 +500,12 @@ static struct davinci_id dm646x_ids[] = {
 	},
 };
 
-/*
- * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
- * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
- * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
- * T1_TOP: Timer 1, top   :  <unused>
- */
-static struct davinci_timer_info dm646x_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm646x_timer_cfg = {
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 static struct plat_serial8250_port dm646x_serial0_platform_data[] = {
@@ -586,7 +583,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm646x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm646x_pins),
-	.timer_info		= &dm646x_timer_info,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
 	.sram_len		= SZ_32K,
@@ -651,6 +647,7 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
 	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
@@ -667,7 +664,8 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm646x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm646x_pll2_resources[] = {
-- 
2.20.1

