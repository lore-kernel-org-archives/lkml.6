Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47DEC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C7B21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFN0pwhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeLRV3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50843 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeLRV3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so4108478wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k16PQBXt9q9uOtxHm8JlnMyaHL4qmIeiuhgTg+Wmsps=;
        b=bFN0pwhgVoisqzacsFhkJN8g7BZgkN9KH4xzTnlstaQMbmXuwRfc4MUUkThKE3r4Tg
         wihPRjc0bigikrC/9GKAfBdRQdqELZ/FjgRCfpC5RgvsmOeVj/atwmSDBcROsYt5F7/X
         0a6L6PuDt9QxHuSrPhTgPYh1q56yryfmNHKx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k16PQBXt9q9uOtxHm8JlnMyaHL4qmIeiuhgTg+Wmsps=;
        b=tLlaSDE7pIviocP/B8GVq8rvVYvUdMo/AyDoPd3EFE3TPfMI+UE5mjFvQLQcwI3N6y
         A4feho5wMCEg3weg8O0UXg5+MlcxQ5iPkEiiwLvKhw3M6KV64Zg+MzrFul/XtHxU6wbc
         sqvs9fFy9sWp9KhuNp0DPDPbHrzVKud4GEONcVJCQKVJ2K1c2+jFt8kpE+vMyUTmpsuV
         AxXRdwtvM63XHmHbtoMdCv8UHT+TmNFZBTDXiJqy7D5vmhD/g9xeeTselqEm1uXRCcaQ
         lpjIF9GDUIjCKgtosmdijjShXu/2TVOYz4XYQ2xs8NmWa6Tx49O1ZQ2ot642taOepJjI
         RzGQ==
X-Gm-Message-State: AA+aEWZc+lRXiTb99rpg5yTj+i63Vzo0RJkMAEGiw9EN051ofpsaIgFP
        /xAEpQTeG7xny6b3wtIMR1eICA==
X-Google-Smtp-Source: AFSGD/XuB5wCNxMgG4EYAtZAXdgMHzUuGeiG4wntnWO0wIY02cz9be7ziF70szBpkuwkvV7htFyi3A==
X-Received: by 2002:a1c:5746:: with SMTP id l67mr4779558wmb.118.1545168575476;
        Tue, 18 Dec 2018 13:29:35 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:34 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Tao Ren <taoren@fb.com>
Subject: [PATCH 17/25] clocksource/drivers/fttmr010: Fix invalid interrupt register access
Date:   Tue, 18 Dec 2018 22:28:35 +0100
Message-Id: <20181218212844.30445-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <taoren@fb.com>

TIMER_INTR_MASK register (Base Address of Timer + 0x38) is not designed
for masking interrupts on ast2500 chips, and it's not even listed in
ast2400 datasheet, so it's not safe to access TIMER_INTR_MASK on aspeed
chips.

Similarly, TIMER_INTR_STATE register (Base Address of Timer + 0x34) is
not interrupt status register on ast2400 and ast2500 chips. Although
there is no side effect to reset the register in fttmr010_common_init(),
it's just misleading to do so.

Besides, "count_down" is renamed to "is_aspeed" in "fttmr010" structure,
and more comments are added so the code is more readble.

Signed-off-by: Tao Ren <taoren@fb.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-fttmr010.c | 73 ++++++++++++++++------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index cf93f6419b51..fadff7915dd9 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -21,7 +21,7 @@
 #include <linux/delay.h>
 
 /*
- * Register definitions for the timers
+ * Register definitions common for all the timer variants.
  */
 #define TIMER1_COUNT		(0x00)
 #define TIMER1_LOAD		(0x04)
@@ -36,9 +36,10 @@
 #define TIMER3_MATCH1		(0x28)
 #define TIMER3_MATCH2		(0x2c)
 #define TIMER_CR		(0x30)
-#define TIMER_INTR_STATE	(0x34)
-#define TIMER_INTR_MASK		(0x38)
 
+/*
+ * Control register (TMC30) bit fields for fttmr010/gemini/moxart timers.
+ */
 #define TIMER_1_CR_ENABLE	BIT(0)
 #define TIMER_1_CR_CLOCK	BIT(1)
 #define TIMER_1_CR_INT		BIT(2)
@@ -53,8 +54,9 @@
 #define TIMER_3_CR_UPDOWN	BIT(11)
 
 /*
- * The Aspeed AST2400 moves bits around in the control register
- * and lacks bits for setting the timer to count upwards.
+ * Control register (TMC30) bit fields for aspeed ast2400/ast2500 timers.
+ * The aspeed timers move bits around in the control register and lacks
+ * bits for setting the timer to count upwards.
  */
 #define TIMER_1_CR_ASPEED_ENABLE	BIT(0)
 #define TIMER_1_CR_ASPEED_CLOCK		BIT(1)
@@ -66,6 +68,18 @@
 #define TIMER_3_CR_ASPEED_CLOCK		BIT(9)
 #define TIMER_3_CR_ASPEED_INT		BIT(10)
 
+/*
+ * Interrupt status/mask register definitions for fttmr010/gemini/moxart
+ * timers.
+ * The registers don't exist and they are not needed on aspeed timers
+ * because:
+ *   - aspeed timer overflow interrupt is controlled by bits in Control
+ *     Register (TMC30).
+ *   - aspeed timers always generate interrupt when either one of the
+ *     Match registers equals to Status register.
+ */
+#define TIMER_INTR_STATE	(0x34)
+#define TIMER_INTR_MASK		(0x38)
 #define TIMER_1_INT_MATCH1	BIT(0)
 #define TIMER_1_INT_MATCH2	BIT(1)
 #define TIMER_1_INT_OVERFLOW	BIT(2)
@@ -80,7 +94,7 @@
 struct fttmr010 {
 	void __iomem *base;
 	unsigned int tick_rate;
-	bool count_down;
+	bool is_aspeed;
 	u32 t1_enable_val;
 	struct clock_event_device clkevt;
 #ifdef CONFIG_ARM
@@ -130,7 +144,7 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	cr &= ~fttmr010->t1_enable_val;
 	writel(cr, fttmr010->base + TIMER_CR);
 
-	if (fttmr010->count_down) {
+	if (fttmr010->is_aspeed) {
 		/*
 		 * ASPEED Timer Controller will load TIMER1_LOAD register
 		 * into TIMER1_COUNT register when the timer is re-enabled.
@@ -175,16 +189,17 @@ static int fttmr010_timer_set_oneshot(struct clock_event_device *evt)
 
 	/* Setup counter start from 0 or ~0 */
 	writel(0, fttmr010->base + TIMER1_COUNT);
-	if (fttmr010->count_down)
+	if (fttmr010->is_aspeed) {
 		writel(~0, fttmr010->base + TIMER1_LOAD);
-	else
+	} else {
 		writel(0, fttmr010->base + TIMER1_LOAD);
 
-	/* Enable interrupt */
-	cr = readl(fttmr010->base + TIMER_INTR_MASK);
-	cr &= ~(TIMER_1_INT_OVERFLOW | TIMER_1_INT_MATCH2);
-	cr |= TIMER_1_INT_MATCH1;
-	writel(cr, fttmr010->base + TIMER_INTR_MASK);
+		/* Enable interrupt */
+		cr = readl(fttmr010->base + TIMER_INTR_MASK);
+		cr &= ~(TIMER_1_INT_OVERFLOW | TIMER_1_INT_MATCH2);
+		cr |= TIMER_1_INT_MATCH1;
+		writel(cr, fttmr010->base + TIMER_INTR_MASK);
+	}
 
 	return 0;
 }
@@ -201,9 +216,8 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
 	writel(cr, fttmr010->base + TIMER_CR);
 
 	/* Setup timer to fire at 1/HZ intervals. */
-	if (fttmr010->count_down) {
+	if (fttmr010->is_aspeed) {
 		writel(period, fttmr010->base + TIMER1_LOAD);
-		writel(0, fttmr010->base + TIMER1_MATCH1);
 	} else {
 		cr = 0xffffffff - (period - 1);
 		writel(cr, fttmr010->base + TIMER1_COUNT);
@@ -281,23 +295,21 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	}
 
 	/*
-	 * The Aspeed AST2400 moves bits around in the control register,
-	 * otherwise it works the same.
+	 * The Aspeed timers move bits around in the control register.
 	 */
 	if (is_aspeed) {
 		fttmr010->t1_enable_val = TIMER_1_CR_ASPEED_ENABLE |
 			TIMER_1_CR_ASPEED_INT;
-		/* Downward not available */
-		fttmr010->count_down = true;
+		fttmr010->is_aspeed = true;
 	} else {
 		fttmr010->t1_enable_val = TIMER_1_CR_ENABLE | TIMER_1_CR_INT;
-	}
 
-	/*
-	 * Reset the interrupt mask and status
-	 */
-	writel(TIMER_INT_ALL_MASK, fttmr010->base + TIMER_INTR_MASK);
-	writel(0, fttmr010->base + TIMER_INTR_STATE);
+		/*
+		 * Reset the interrupt mask and status
+		 */
+		writel(TIMER_INT_ALL_MASK, fttmr010->base + TIMER_INTR_MASK);
+		writel(0, fttmr010->base + TIMER_INTR_STATE);
+	}
 
 	/*
 	 * Enable timer 1 count up, timer 2 count up, except on Aspeed,
@@ -306,9 +318,8 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	if (is_aspeed)
 		val = TIMER_2_CR_ASPEED_ENABLE;
 	else {
-		val = TIMER_2_CR_ENABLE;
-		if (!fttmr010->count_down)
-			val |= TIMER_1_CR_UPDOWN | TIMER_2_CR_UPDOWN;
+		val = TIMER_2_CR_ENABLE | TIMER_1_CR_UPDOWN |
+			TIMER_2_CR_UPDOWN;
 	}
 	writel(val, fttmr010->base + TIMER_CR);
 
@@ -321,7 +332,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	writel(0, fttmr010->base + TIMER2_MATCH1);
 	writel(0, fttmr010->base + TIMER2_MATCH2);
 
-	if (fttmr010->count_down) {
+	if (fttmr010->is_aspeed) {
 		writel(~0, fttmr010->base + TIMER2_LOAD);
 		clocksource_mmio_init(fttmr010->base + TIMER2_COUNT,
 				      "FTTMR010-TIMER2",
@@ -371,7 +382,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 
 #ifdef CONFIG_ARM
 	/* Also use this timer for delays */
-	if (fttmr010->count_down)
+	if (fttmr010->is_aspeed)
 		fttmr010->delay_timer.read_current_timer =
 			fttmr010_read_current_timer_down;
 	else
-- 
2.17.1

