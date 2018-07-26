Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9639EECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4389E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzQ4Hh00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4389E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbeGZLcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:32:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36094 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbeGZLci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:32:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so1150401wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GkrEodfqJJ8aTUmNgXy4dk77JThB9rdS+3bHfRD7mVo=;
        b=DzQ4Hh001XPzoeCUk+CQceEsyAYL5j0ou1m/1yNPw9UpF73LRVq7yxbFjtmH67D3g7
         vWDP0Y754GJV6ouq5V25e/9cBhCVSD56X9Nf4fIo8KEm/t80SOMEVtbqUHhWAiB6PP/l
         DqbNQWui2jGizvLiGXVq3f+JehzIF0QFdclY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GkrEodfqJJ8aTUmNgXy4dk77JThB9rdS+3bHfRD7mVo=;
        b=lEszjOb10j2FJ0AIxO8AGIhAcpQP9dnHiLRdOZzKsNDD+2LSiLtifKYO4MR+QBp4VA
         VysDU+2r6cZbe7nYui5WWPTn5Ze1pvrC7+x+ZAkSl9xDlzQxqXPbSelVTi5jL1sJlY+a
         BLNohC5gTQFRG51BsJ5n1/w/w3m73PRxHzl1ArP1CV9HJmIjKrrMMZ2w4hDfSQF+p1Db
         jFeVpJ4r69pjcLxJQ5DBQu6rAouKV70H7F20hpu2BTbKpJABIXRc3nlMdnKcRQXzGSX9
         95KZybmGQUYpIucv530gkViD0xj0WAv6Vjy2NjhfLhXuNkr9id6d4JIvtDwhz1m3GJoF
         zxwg==
X-Gm-Message-State: AOUpUlG0HvEOLVGMQArABau/YtNuFuoOBGR7C45uwqQRpS2bzZMbC5gd
        JZKQgk0ZVDu3io8dfpZTuDJRtw==
X-Google-Smtp-Source: AAOMgpfshqSVB+yt4B8TZBBkfRdnYb6qhzaljQui7ONDrjPQb1OApyF/BxrFIJiq6wjIdJ8UQ2Z2uw==
X-Received: by 2002:adf:e584:: with SMTP id l4-v6mr1024964wrm.190.1532600186925;
        Thu, 26 Jul 2018 03:16:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:879a:6cd0:35bd:fbdf:74b5:3f51])
        by smtp.gmail.com with ESMTPSA id f6-v6sm957303wrp.30.2018.07.26.03.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 03:16:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, stanley.chu@mediatek.com,
        baolin.wang@linaro.org, Sudeep.Holla@arm.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 6/7] clocksource/drivers/timer-mediatek: Add support for system timer
Date:   Thu, 26 Jul 2018 12:15:29 +0200
Message-Id: <1532600131-28168-6-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
References: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
 <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

This patch adds a new "System Timer" on the Mediatek SoCs.

The System Timer is introduced as an always-on timer being
clockevent device for tick-broadcasting.

For clock, it is driven by 13 MHz system clock.
The implementation uses the system clock with no clock
source divider.

For interrupt, the clock event timer can be used by all cores.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-mediatek.c | 104 ++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index e57c4d7..eb10321 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -56,8 +56,86 @@
 #define GPT_CNT_REG(val)        (0x08 + (0x10 * (val)))
 #define GPT_CMP_REG(val)        (0x0C + (0x10 * (val)))
 
+/* system timer */
+#define SYST_BASE               (0x40)
+
+#define SYST_CON                (SYST_BASE + 0x0)
+#define SYST_VAL                (SYST_BASE + 0x4)
+
+#define SYST_CON_REG(to)        (timer_of_base(to) + SYST_CON)
+#define SYST_VAL_REG(to)        (timer_of_base(to) + SYST_VAL)
+
+/*
+ * SYST_CON_EN: Clock enable. Shall be set to
+ *   - Start timer countdown.
+ *   - Allow timeout ticks being updated.
+ *   - Allow changing interrupt functions.
+ *
+ * SYST_CON_IRQ_EN: Set to allow interrupt.
+ *
+ * SYST_CON_IRQ_CLR: Set to clear interrupt.
+ */
+#define SYST_CON_EN              BIT(0)
+#define SYST_CON_IRQ_EN          BIT(1)
+#define SYST_CON_IRQ_CLR         BIT(4)
+
 static void __iomem *gpt_sched_reg __read_mostly;
 
+static void mtk_syst_ack_irq(struct timer_of *to)
+{
+	/* Clear and disable interrupt */
+	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
+}
+
+static irqreturn_t mtk_syst_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *clkevt = dev_id;
+	struct timer_of *to = to_timer_of(clkevt);
+
+	mtk_syst_ack_irq(to);
+	clkevt->event_handler(clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_syst_clkevt_next_event(unsigned long ticks,
+				      struct clock_event_device *clkevt)
+{
+	struct timer_of *to = to_timer_of(clkevt);
+
+	/* Enable clock to allow timeout tick update later */
+	writel(SYST_CON_EN, SYST_CON_REG(to));
+
+	/*
+	 * Write new timeout ticks. Timer shall start countdown
+	 * after timeout ticks are updated.
+	 */
+	writel(ticks, SYST_VAL_REG(to));
+
+	/* Enable interrupt */
+	writel(SYST_CON_EN | SYST_CON_IRQ_EN, SYST_CON_REG(to));
+
+	return 0;
+}
+
+static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
+{
+	/* Disable timer */
+	writel(0, SYST_CON_REG(to_timer_of(clkevt)));
+
+	return 0;
+}
+
+static int mtk_syst_clkevt_resume(struct clock_event_device *clkevt)
+{
+	return mtk_syst_clkevt_shutdown(clkevt);
+}
+
+static int mtk_syst_clkevt_oneshot(struct clock_event_device *clkevt)
+{
+	return 0;
+}
+
 static u64 notrace mtk_gpt_read_sched_clock(void)
 {
 	return readl_relaxed(gpt_sched_reg);
@@ -186,6 +264,30 @@ static struct timer_of to = {
 	},
 };
 
+static int __init mtk_syst_init(struct device_node *node)
+{
+	int ret;
+
+	to.clkevt.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT;
+	to.clkevt.set_state_shutdown = mtk_syst_clkevt_shutdown;
+	to.clkevt.set_state_oneshot = mtk_syst_clkevt_oneshot;
+	to.clkevt.tick_resume = mtk_syst_clkevt_resume;
+	to.clkevt.set_next_event = mtk_syst_clkevt_next_event;
+	to.of_irq.handler = mtk_syst_handler;
+
+	ret = timer_of_init(node, &to);
+	if (ret)
+		goto err;
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
+					TIMER_SYNC_TICKS, 0xffffffff);
+
+	return 0;
+err:
+	timer_of_cleanup(&to);
+	return ret;
+}
+
 static int __init mtk_gpt_init(struct device_node *node)
 {
 	int ret;
@@ -218,9 +320,9 @@ static int __init mtk_gpt_init(struct device_node *node)
 	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
 
 	return 0;
-
 err:
 	timer_of_cleanup(&to);
 	return ret;
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
+TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
-- 
2.7.4

