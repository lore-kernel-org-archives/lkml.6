Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A4021871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xuuc6c3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeLRVbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:31:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39039 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeLRV3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so4262104wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AThSIIFr1MNxei6GzfPPmaTqIlS3Gkxg7bofXJUPBLQ=;
        b=Xuuc6c3Am0E7BW1mAxndCishUpk7F/3ellKRyWJ60Hqb0Ilw8EspLunAVKiphs7Ilt
         rfYUSl/KTHJf1K8nYbJQsRT5yKW7+EpXirivoVidQ+KaybG+awYy6FtANxiJJzioXvxd
         yDqbD+dFdDgdbak1lon3SwCvI1hBGlX82lFWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AThSIIFr1MNxei6GzfPPmaTqIlS3Gkxg7bofXJUPBLQ=;
        b=IdkTDC1lkTaFXn6MCsNpdYYaTzCJNLGNXBjIMFacQ00xnR2aBLisvTelxdYwmD86C1
         YOG3qeZkalSWKHLBc+ewp17BHRlSIK5WAwsNCz94Q/vxC+gFsYhbbemWgtgvo5ijObY3
         PkDIMfICeSszMRyQpGpjkRNiiVzSZctvbkzNv+4EteicRlGR+Fq2xp+uytYc6QzHbFEJ
         mCzr5yscjSQsejSpZg3Au2zxsnsqJv8UZfiPFIaW4ZNUt5MO+5/NnIW7Z6u3Gb2OmnL8
         x0XycjZ7XM+DyGCgoOXe4/S15ojWSp+yr3NJ/abw/FxL90Ook3t2fEdexd8g58iOXQF8
         B9KQ==
X-Gm-Message-State: AA+aEWZtYiKzrLamwG8EsQ1IFthJPM9Q67G4rzHxTRIhmdkjOZGvhtbL
        NsYb78EakT25LBzm2X9Wyy/7HuhWL4g=
X-Google-Smtp-Source: AFSGD/XlJFMb8pCOldKf4yp8Gv1pJSXtxZVgStptL9MrboBXq1sRY+Vndrz6294rueUwqD5NzS6udQ==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr4863537wmc.116.1545168558247;
        Tue, 18 Dec 2018 13:29:18 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support)
Subject: [PATCH 06/25] clocksource/drivers/meson6_timer: Use register names from the datasheet
Date:   Tue, 18 Dec 2018 22:28:24 +0100
Message-Id: <20181218212844.30445-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This makes the driver use the names from S805 datasheet for the
preprocessor #defines. This makes it easier to spot that the driver
currently only supports Timer A (as clockevent with interrupt support)
and Timer E (as clocksource without interrupts). Timer B, C and D (which
are similar to Timer A) are currently not supported by the driver.

While here, this also removes the internal "CED_ID" and "CSD_ID" defines
which are used to identify the timer. These IDs are not described in the
datasheet and thus make it harder to compare the code to what's written
in the datasheet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/meson6_timer.c | 108 +++++++++++++++++------------
 1 file changed, 64 insertions(+), 44 deletions(-)

diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
index 92f20991a937..23c7638e2bb3 100644
--- a/drivers/clocksource/meson6_timer.c
+++ b/drivers/clocksource/meson6_timer.c
@@ -10,6 +10,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -20,80 +22,96 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
-#define CED_ID			0
-#define CSD_ID			4
-
-#define TIMER_ISA_MUX		0
-#define TIMER_ISA_VAL(t)	(((t) + 1) << 2)
-
-#define TIMER_INPUT_BIT(t)	(2 * (t))
-#define TIMER_ENABLE_BIT(t)	(16 + (t))
-#define TIMER_PERIODIC_BIT(t)	(12 + (t))
-
-#define TIMER_CED_INPUT_MASK	(3UL << TIMER_INPUT_BIT(CED_ID))
-#define TIMER_CSD_INPUT_MASK	(7UL << TIMER_INPUT_BIT(CSD_ID))
-
-#define TIMER_CED_UNIT_1US	0
-#define TIMER_CSD_UNIT_1US	1
+#define MESON_ISA_TIMER_MUX					0x00
+#define MESON_ISA_TIMER_MUX_TIMERD_EN				BIT(19)
+#define MESON_ISA_TIMER_MUX_TIMERC_EN				BIT(18)
+#define MESON_ISA_TIMER_MUX_TIMERB_EN				BIT(17)
+#define MESON_ISA_TIMER_MUX_TIMERA_EN				BIT(16)
+#define MESON_ISA_TIMER_MUX_TIMERD_MODE				BIT(15)
+#define MESON_ISA_TIMER_MUX_TIMERC_MODE				BIT(14)
+#define MESON_ISA_TIMER_MUX_TIMERB_MODE				BIT(13)
+#define MESON_ISA_TIMER_MUX_TIMERA_MODE				BIT(12)
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_MASK		GENMASK(10, 8)
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_SYSTEM_CLOCK	0x0
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_1US		0x1
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_10US		0x2
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_100US		0x3
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_1MS		0x4
+#define MESON_ISA_TIMER_MUX_TIMERD_INPUT_CLOCK_MASK		GENMASK(7, 6)
+#define MESON_ISA_TIMER_MUX_TIMERC_INPUT_CLOCK_MASK		GENMASK(5, 4)
+#define MESON_ISA_TIMER_MUX_TIMERB_INPUT_CLOCK_MASK		GENMASK(3, 2)
+#define MESON_ISA_TIMER_MUX_TIMERA_INPUT_CLOCK_MASK		GENMASK(1, 0)
+#define MESON_ISA_TIMER_MUX_TIMERABCD_INPUT_CLOCK_1US		0x0
+#define MESON_ISA_TIMER_MUX_TIMERABCD_INPUT_CLOCK_10US		0x1
+#define MESON_ISA_TIMER_MUX_TIMERABCD_INPUT_CLOCK_100US		0x0
+#define MESON_ISA_TIMER_MUX_TIMERABCD_INPUT_CLOCK_1MS		0x3
+
+#define MESON_ISA_TIMERA					0x04
+#define MESON_ISA_TIMERB					0x08
+#define MESON_ISA_TIMERC					0x0c
+#define MESON_ISA_TIMERD					0x10
+#define MESON_ISA_TIMERE					0x14
 
 static void __iomem *timer_base;
 
 static u64 notrace meson6_timer_sched_read(void)
 {
-	return (u64)readl(timer_base + TIMER_ISA_VAL(CSD_ID));
+	return (u64)readl(timer_base + MESON_ISA_TIMERE);
 }
 
-static void meson6_clkevt_time_stop(unsigned char timer)
+static void meson6_clkevt_time_stop(void)
 {
-	u32 val = readl(timer_base + TIMER_ISA_MUX);
+	u32 val = readl(timer_base + MESON_ISA_TIMER_MUX);
 
-	writel(val & ~TIMER_ENABLE_BIT(timer), timer_base + TIMER_ISA_MUX);
+	writel(val & ~MESON_ISA_TIMER_MUX_TIMERA_EN,
+	       timer_base + MESON_ISA_TIMER_MUX);
 }
 
-static void meson6_clkevt_time_setup(unsigned char timer, unsigned long delay)
+static void meson6_clkevt_time_setup(unsigned long delay)
 {
-	writel(delay, timer_base + TIMER_ISA_VAL(timer));
+	writel(delay, timer_base + MESON_ISA_TIMERA);
 }
 
-static void meson6_clkevt_time_start(unsigned char timer, bool periodic)
+static void meson6_clkevt_time_start(bool periodic)
 {
-	u32 val = readl(timer_base + TIMER_ISA_MUX);
+	u32 val = readl(timer_base + MESON_ISA_TIMER_MUX);
 
 	if (periodic)
-		val |= TIMER_PERIODIC_BIT(timer);
+		val |= MESON_ISA_TIMER_MUX_TIMERA_MODE;
 	else
-		val &= ~TIMER_PERIODIC_BIT(timer);
+		val &= ~MESON_ISA_TIMER_MUX_TIMERA_MODE;
 
-	writel(val | TIMER_ENABLE_BIT(timer), timer_base + TIMER_ISA_MUX);
+	writel(val | MESON_ISA_TIMER_MUX_TIMERA_EN,
+	       timer_base + MESON_ISA_TIMER_MUX);
 }
 
 static int meson6_shutdown(struct clock_event_device *evt)
 {
-	meson6_clkevt_time_stop(CED_ID);
+	meson6_clkevt_time_stop();
 	return 0;
 }
 
 static int meson6_set_oneshot(struct clock_event_device *evt)
 {
-	meson6_clkevt_time_stop(CED_ID);
-	meson6_clkevt_time_start(CED_ID, false);
+	meson6_clkevt_time_stop();
+	meson6_clkevt_time_start(false);
 	return 0;
 }
 
 static int meson6_set_periodic(struct clock_event_device *evt)
 {
-	meson6_clkevt_time_stop(CED_ID);
-	meson6_clkevt_time_setup(CED_ID, USEC_PER_SEC / HZ - 1);
-	meson6_clkevt_time_start(CED_ID, true);
+	meson6_clkevt_time_stop();
+	meson6_clkevt_time_setup(USEC_PER_SEC / HZ - 1);
+	meson6_clkevt_time_start(true);
 	return 0;
 }
 
 static int meson6_clkevt_next_event(unsigned long evt,
 				    struct clock_event_device *unused)
 {
-	meson6_clkevt_time_stop(CED_ID);
-	meson6_clkevt_time_setup(CED_ID, evt);
-	meson6_clkevt_time_start(CED_ID, false);
+	meson6_clkevt_time_stop();
+	meson6_clkevt_time_setup(evt);
+	meson6_clkevt_time_start(false);
 
 	return 0;
 }
@@ -144,22 +162,24 @@ static int __init meson6_timer_init(struct device_node *node)
 	}
 
 	/* Set 1us for timer E */
-	val = readl(timer_base + TIMER_ISA_MUX);
-	val &= ~TIMER_CSD_INPUT_MASK;
-	val |= TIMER_CSD_UNIT_1US << TIMER_INPUT_BIT(CSD_ID);
-	writel(val, timer_base + TIMER_ISA_MUX);
+	val = readl(timer_base + MESON_ISA_TIMER_MUX);
+	val &= ~MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_MASK;
+	val |= FIELD_PREP(MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_MASK,
+			  MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_1US);
+	writel(val, timer_base + MESON_ISA_TIMER_MUX);
 
 	sched_clock_register(meson6_timer_sched_read, 32, USEC_PER_SEC);
-	clocksource_mmio_init(timer_base + TIMER_ISA_VAL(CSD_ID), node->name,
+	clocksource_mmio_init(timer_base + MESON_ISA_TIMERE, node->name,
 			      1000 * 1000, 300, 32, clocksource_mmio_readl_up);
 
 	/* Timer A base 1us */
-	val &= ~TIMER_CED_INPUT_MASK;
-	val |= TIMER_CED_UNIT_1US << TIMER_INPUT_BIT(CED_ID);
-	writel(val, timer_base + TIMER_ISA_MUX);
+	val &= ~MESON_ISA_TIMER_MUX_TIMERA_INPUT_CLOCK_MASK;
+	val |= FIELD_PREP(MESON_ISA_TIMER_MUX_TIMERA_INPUT_CLOCK_MASK,
+			  MESON_ISA_TIMER_MUX_TIMERABCD_INPUT_CLOCK_1US);
+	writel(val, timer_base + MESON_ISA_TIMER_MUX);
 
 	/* Stop the timer A */
-	meson6_clkevt_time_stop(CED_ID);
+	meson6_clkevt_time_stop();
 
 	ret = setup_irq(irq, &meson6_timer_irq);
 	if (ret) {
-- 
2.17.1

