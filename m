Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E57C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD67524148
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD67524148
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeGEBKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 21:10:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49139 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753207AbeGEBJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 21:09:42 -0400
X-UUID: 5e801cd6481b465c89927b3f582f9e72-20180705
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1502230746; Thu, 05 Jul 2018 09:09:36 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 5 Jul 2018 09:09:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 5 Jul 2018 09:09:34 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v7 2/5] clocksource/drivers/timer-mediatek: Rename mtk_timer to timer-mediatek
Date:   Thu, 5 Jul 2018 09:09:29 +0800
Message-ID: <1530752972-833-3-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1530752972-833-1-git-send-email-stanley.chu@mediatek.com>
References: <1530752972-833-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename mtk_timer to timer-mediatek to apply new naming convention
in clocksource folder.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/clocksource/Makefile         |    2 +-
 drivers/clocksource/mtk_timer.c      |  268 ----------------------------------
 drivers/clocksource/timer-mediatek.c |  268 ++++++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+), 269 deletions(-)
 delete mode 100644 drivers/clocksource/mtk_timer.c
 create mode 100644 drivers/clocksource/timer-mediatek.c

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 00caf37..c070cc7 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -49,7 +49,7 @@ obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
 obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
 obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
 obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
-obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o
+obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
 obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
deleted file mode 100644
index f9b724f..0000000
--- a/drivers/clocksource/mtk_timer.c
+++ /dev/null
@@ -1,268 +0,0 @@
-/*
- * Mediatek SoCs General-Purpose Timer handling.
- *
- * Copyright (C) 2014 Matthias Brugger
- *
- * Matthias Brugger <matthias.bgg@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqreturn.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-#include <linux/slab.h>
-
-#define GPT_IRQ_EN_REG		0x00
-#define GPT_IRQ_ENABLE(val)	BIT((val) - 1)
-#define GPT_IRQ_ACK_REG		0x08
-#define GPT_IRQ_ACK(val)	BIT((val) - 1)
-
-#define TIMER_CTRL_REG(val)	(0x10 * (val))
-#define TIMER_CTRL_OP(val)	(((val) & 0x3) << 4)
-#define TIMER_CTRL_OP_ONESHOT	(0)
-#define TIMER_CTRL_OP_REPEAT	(1)
-#define TIMER_CTRL_OP_FREERUN	(3)
-#define TIMER_CTRL_CLEAR	(2)
-#define TIMER_CTRL_ENABLE	(1)
-#define TIMER_CTRL_DISABLE	(0)
-
-#define TIMER_CLK_REG(val)	(0x04 + (0x10 * (val)))
-#define TIMER_CLK_SRC(val)	(((val) & 0x1) << 4)
-#define TIMER_CLK_SRC_SYS13M	(0)
-#define TIMER_CLK_SRC_RTC32K	(1)
-#define TIMER_CLK_DIV1		(0x0)
-#define TIMER_CLK_DIV2		(0x1)
-
-#define TIMER_CNT_REG(val)	(0x08 + (0x10 * (val)))
-#define TIMER_CMP_REG(val)	(0x0C + (0x10 * (val)))
-
-#define GPT_CLK_EVT	1
-#define GPT_CLK_SRC	2
-
-struct mtk_clock_event_device {
-	void __iomem *gpt_base;
-	u32 ticks_per_jiffy;
-	struct clock_event_device dev;
-};
-
-static void __iomem *gpt_sched_reg __read_mostly;
-
-static u64 notrace mtk_read_sched_clock(void)
-{
-	return readl_relaxed(gpt_sched_reg);
-}
-
-static inline struct mtk_clock_event_device *to_mtk_clk(
-				struct clock_event_device *c)
-{
-	return container_of(c, struct mtk_clock_event_device, dev);
-}
-
-static void mtk_clkevt_time_stop(struct mtk_clock_event_device *evt, u8 timer)
-{
-	u32 val;
-
-	val = readl(evt->gpt_base + TIMER_CTRL_REG(timer));
-	writel(val & ~TIMER_CTRL_ENABLE, evt->gpt_base +
-			TIMER_CTRL_REG(timer));
-}
-
-static void mtk_clkevt_time_setup(struct mtk_clock_event_device *evt,
-				unsigned long delay, u8 timer)
-{
-	writel(delay, evt->gpt_base + TIMER_CMP_REG(timer));
-}
-
-static void mtk_clkevt_time_start(struct mtk_clock_event_device *evt,
-		bool periodic, u8 timer)
-{
-	u32 val;
-
-	/* Acknowledge interrupt */
-	writel(GPT_IRQ_ACK(timer), evt->gpt_base + GPT_IRQ_ACK_REG);
-
-	val = readl(evt->gpt_base + TIMER_CTRL_REG(timer));
-
-	/* Clear 2 bit timer operation mode field */
-	val &= ~TIMER_CTRL_OP(0x3);
-
-	if (periodic)
-		val |= TIMER_CTRL_OP(TIMER_CTRL_OP_REPEAT);
-	else
-		val |= TIMER_CTRL_OP(TIMER_CTRL_OP_ONESHOT);
-
-	writel(val | TIMER_CTRL_ENABLE | TIMER_CTRL_CLEAR,
-	       evt->gpt_base + TIMER_CTRL_REG(timer));
-}
-
-static int mtk_clkevt_shutdown(struct clock_event_device *clk)
-{
-	mtk_clkevt_time_stop(to_mtk_clk(clk), GPT_CLK_EVT);
-	return 0;
-}
-
-static int mtk_clkevt_set_periodic(struct clock_event_device *clk)
-{
-	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
-
-	mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
-	mtk_clkevt_time_setup(evt, evt->ticks_per_jiffy, GPT_CLK_EVT);
-	mtk_clkevt_time_start(evt, true, GPT_CLK_EVT);
-	return 0;
-}
-
-static int mtk_clkevt_next_event(unsigned long event,
-				   struct clock_event_device *clk)
-{
-	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
-
-	mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
-	mtk_clkevt_time_setup(evt, event, GPT_CLK_EVT);
-	mtk_clkevt_time_start(evt, false, GPT_CLK_EVT);
-
-	return 0;
-}
-
-static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
-{
-	struct mtk_clock_event_device *evt = dev_id;
-
-	/* Acknowledge timer0 irq */
-	writel(GPT_IRQ_ACK(GPT_CLK_EVT), evt->gpt_base + GPT_IRQ_ACK_REG);
-	evt->dev.event_handler(&evt->dev);
-
-	return IRQ_HANDLED;
-}
-
-static void
-__init mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
-{
-	writel(TIMER_CTRL_CLEAR | TIMER_CTRL_DISABLE,
-		evt->gpt_base + TIMER_CTRL_REG(timer));
-
-	writel(TIMER_CLK_SRC(TIMER_CLK_SRC_SYS13M) | TIMER_CLK_DIV1,
-			evt->gpt_base + TIMER_CLK_REG(timer));
-
-	writel(0x0, evt->gpt_base + TIMER_CMP_REG(timer));
-
-	writel(TIMER_CTRL_OP(option) | TIMER_CTRL_ENABLE,
-			evt->gpt_base + TIMER_CTRL_REG(timer));
-}
-
-static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
-{
-	u32 val;
-
-	/* Disable all interrupts */
-	writel(0x0, evt->gpt_base + GPT_IRQ_EN_REG);
-
-	/* Acknowledge all spurious pending interrupts */
-	writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);
-
-	val = readl(evt->gpt_base + GPT_IRQ_EN_REG);
-	writel(val | GPT_IRQ_ENABLE(timer),
-			evt->gpt_base + GPT_IRQ_EN_REG);
-}
-
-static int __init mtk_timer_init(struct device_node *node)
-{
-	struct mtk_clock_event_device *evt;
-	struct resource res;
-	unsigned long rate = 0;
-	struct clk *clk;
-
-	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
-	if (!evt)
-		return -ENOMEM;
-
-	evt->dev.name = "mtk_tick";
-	evt->dev.rating = 300;
-	evt->dev.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->dev.set_state_shutdown = mtk_clkevt_shutdown;
-	evt->dev.set_state_periodic = mtk_clkevt_set_periodic;
-	evt->dev.set_state_oneshot = mtk_clkevt_shutdown;
-	evt->dev.tick_resume = mtk_clkevt_shutdown;
-	evt->dev.set_next_event = mtk_clkevt_next_event;
-	evt->dev.cpumask = cpu_possible_mask;
-
-	evt->gpt_base = of_io_request_and_map(node, 0, "mtk-timer");
-	if (IS_ERR(evt->gpt_base)) {
-		pr_err("Can't get resource\n");
-		goto err_kzalloc;
-	}
-
-	evt->dev.irq = irq_of_parse_and_map(node, 0);
-	if (evt->dev.irq <= 0) {
-		pr_err("Can't parse IRQ\n");
-		goto err_mem;
-	}
-
-	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk)) {
-		pr_err("Can't get timer clock\n");
-		goto err_irq;
-	}
-
-	if (clk_prepare_enable(clk)) {
-		pr_err("Can't prepare clock\n");
-		goto err_clk_put;
-	}
-	rate = clk_get_rate(clk);
-
-	if (request_irq(evt->dev.irq, mtk_timer_interrupt,
-			IRQF_TIMER | IRQF_IRQPOLL, "mtk_timer", evt)) {
-		pr_err("failed to setup irq %d\n", evt->dev.irq);
-		goto err_clk_disable;
-	}
-
-	evt->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
-
-	/* Configure clock source */
-	mtk_timer_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN);
-	clocksource_mmio_init(evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC),
-			node->name, rate, 300, 32, clocksource_mmio_readl_up);
-	gpt_sched_reg = evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC);
-	sched_clock_register(mtk_read_sched_clock, 32, rate);
-
-	/* Configure clock event */
-	mtk_timer_setup(evt, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT);
-	clockevents_config_and_register(&evt->dev, rate, 0x3,
-					0xffffffff);
-
-	mtk_timer_enable_irq(evt, GPT_CLK_EVT);
-
-	return 0;
-
-err_clk_disable:
-	clk_disable_unprepare(clk);
-err_clk_put:
-	clk_put(clk);
-err_irq:
-	irq_dispose_mapping(evt->dev.irq);
-err_mem:
-	iounmap(evt->gpt_base);
-	of_address_to_resource(node, 0, &res);
-	release_mem_region(res.start, resource_size(&res));
-err_kzalloc:
-	kfree(evt);
-
-	return -EINVAL;
-}
-TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_timer_init);
diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
new file mode 100644
index 0000000..f9b724f
--- /dev/null
+++ b/drivers/clocksource/timer-mediatek.c
@@ -0,0 +1,268 @@
+/*
+ * Mediatek SoCs General-Purpose Timer handling.
+ *
+ * Copyright (C) 2014 Matthias Brugger
+ *
+ * Matthias Brugger <matthias.bgg@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+
+#define GPT_IRQ_EN_REG		0x00
+#define GPT_IRQ_ENABLE(val)	BIT((val) - 1)
+#define GPT_IRQ_ACK_REG		0x08
+#define GPT_IRQ_ACK(val)	BIT((val) - 1)
+
+#define TIMER_CTRL_REG(val)	(0x10 * (val))
+#define TIMER_CTRL_OP(val)	(((val) & 0x3) << 4)
+#define TIMER_CTRL_OP_ONESHOT	(0)
+#define TIMER_CTRL_OP_REPEAT	(1)
+#define TIMER_CTRL_OP_FREERUN	(3)
+#define TIMER_CTRL_CLEAR	(2)
+#define TIMER_CTRL_ENABLE	(1)
+#define TIMER_CTRL_DISABLE	(0)
+
+#define TIMER_CLK_REG(val)	(0x04 + (0x10 * (val)))
+#define TIMER_CLK_SRC(val)	(((val) & 0x1) << 4)
+#define TIMER_CLK_SRC_SYS13M	(0)
+#define TIMER_CLK_SRC_RTC32K	(1)
+#define TIMER_CLK_DIV1		(0x0)
+#define TIMER_CLK_DIV2		(0x1)
+
+#define TIMER_CNT_REG(val)	(0x08 + (0x10 * (val)))
+#define TIMER_CMP_REG(val)	(0x0C + (0x10 * (val)))
+
+#define GPT_CLK_EVT	1
+#define GPT_CLK_SRC	2
+
+struct mtk_clock_event_device {
+	void __iomem *gpt_base;
+	u32 ticks_per_jiffy;
+	struct clock_event_device dev;
+};
+
+static void __iomem *gpt_sched_reg __read_mostly;
+
+static u64 notrace mtk_read_sched_clock(void)
+{
+	return readl_relaxed(gpt_sched_reg);
+}
+
+static inline struct mtk_clock_event_device *to_mtk_clk(
+				struct clock_event_device *c)
+{
+	return container_of(c, struct mtk_clock_event_device, dev);
+}
+
+static void mtk_clkevt_time_stop(struct mtk_clock_event_device *evt, u8 timer)
+{
+	u32 val;
+
+	val = readl(evt->gpt_base + TIMER_CTRL_REG(timer));
+	writel(val & ~TIMER_CTRL_ENABLE, evt->gpt_base +
+			TIMER_CTRL_REG(timer));
+}
+
+static void mtk_clkevt_time_setup(struct mtk_clock_event_device *evt,
+				unsigned long delay, u8 timer)
+{
+	writel(delay, evt->gpt_base + TIMER_CMP_REG(timer));
+}
+
+static void mtk_clkevt_time_start(struct mtk_clock_event_device *evt,
+		bool periodic, u8 timer)
+{
+	u32 val;
+
+	/* Acknowledge interrupt */
+	writel(GPT_IRQ_ACK(timer), evt->gpt_base + GPT_IRQ_ACK_REG);
+
+	val = readl(evt->gpt_base + TIMER_CTRL_REG(timer));
+
+	/* Clear 2 bit timer operation mode field */
+	val &= ~TIMER_CTRL_OP(0x3);
+
+	if (periodic)
+		val |= TIMER_CTRL_OP(TIMER_CTRL_OP_REPEAT);
+	else
+		val |= TIMER_CTRL_OP(TIMER_CTRL_OP_ONESHOT);
+
+	writel(val | TIMER_CTRL_ENABLE | TIMER_CTRL_CLEAR,
+	       evt->gpt_base + TIMER_CTRL_REG(timer));
+}
+
+static int mtk_clkevt_shutdown(struct clock_event_device *clk)
+{
+	mtk_clkevt_time_stop(to_mtk_clk(clk), GPT_CLK_EVT);
+	return 0;
+}
+
+static int mtk_clkevt_set_periodic(struct clock_event_device *clk)
+{
+	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
+
+	mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
+	mtk_clkevt_time_setup(evt, evt->ticks_per_jiffy, GPT_CLK_EVT);
+	mtk_clkevt_time_start(evt, true, GPT_CLK_EVT);
+	return 0;
+}
+
+static int mtk_clkevt_next_event(unsigned long event,
+				   struct clock_event_device *clk)
+{
+	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
+
+	mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
+	mtk_clkevt_time_setup(evt, event, GPT_CLK_EVT);
+	mtk_clkevt_time_start(evt, false, GPT_CLK_EVT);
+
+	return 0;
+}
+
+static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
+{
+	struct mtk_clock_event_device *evt = dev_id;
+
+	/* Acknowledge timer0 irq */
+	writel(GPT_IRQ_ACK(GPT_CLK_EVT), evt->gpt_base + GPT_IRQ_ACK_REG);
+	evt->dev.event_handler(&evt->dev);
+
+	return IRQ_HANDLED;
+}
+
+static void
+__init mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
+{
+	writel(TIMER_CTRL_CLEAR | TIMER_CTRL_DISABLE,
+		evt->gpt_base + TIMER_CTRL_REG(timer));
+
+	writel(TIMER_CLK_SRC(TIMER_CLK_SRC_SYS13M) | TIMER_CLK_DIV1,
+			evt->gpt_base + TIMER_CLK_REG(timer));
+
+	writel(0x0, evt->gpt_base + TIMER_CMP_REG(timer));
+
+	writel(TIMER_CTRL_OP(option) | TIMER_CTRL_ENABLE,
+			evt->gpt_base + TIMER_CTRL_REG(timer));
+}
+
+static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
+{
+	u32 val;
+
+	/* Disable all interrupts */
+	writel(0x0, evt->gpt_base + GPT_IRQ_EN_REG);
+
+	/* Acknowledge all spurious pending interrupts */
+	writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);
+
+	val = readl(evt->gpt_base + GPT_IRQ_EN_REG);
+	writel(val | GPT_IRQ_ENABLE(timer),
+			evt->gpt_base + GPT_IRQ_EN_REG);
+}
+
+static int __init mtk_timer_init(struct device_node *node)
+{
+	struct mtk_clock_event_device *evt;
+	struct resource res;
+	unsigned long rate = 0;
+	struct clk *clk;
+
+	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
+	if (!evt)
+		return -ENOMEM;
+
+	evt->dev.name = "mtk_tick";
+	evt->dev.rating = 300;
+	evt->dev.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	evt->dev.set_state_shutdown = mtk_clkevt_shutdown;
+	evt->dev.set_state_periodic = mtk_clkevt_set_periodic;
+	evt->dev.set_state_oneshot = mtk_clkevt_shutdown;
+	evt->dev.tick_resume = mtk_clkevt_shutdown;
+	evt->dev.set_next_event = mtk_clkevt_next_event;
+	evt->dev.cpumask = cpu_possible_mask;
+
+	evt->gpt_base = of_io_request_and_map(node, 0, "mtk-timer");
+	if (IS_ERR(evt->gpt_base)) {
+		pr_err("Can't get resource\n");
+		goto err_kzalloc;
+	}
+
+	evt->dev.irq = irq_of_parse_and_map(node, 0);
+	if (evt->dev.irq <= 0) {
+		pr_err("Can't parse IRQ\n");
+		goto err_mem;
+	}
+
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Can't get timer clock\n");
+		goto err_irq;
+	}
+
+	if (clk_prepare_enable(clk)) {
+		pr_err("Can't prepare clock\n");
+		goto err_clk_put;
+	}
+	rate = clk_get_rate(clk);
+
+	if (request_irq(evt->dev.irq, mtk_timer_interrupt,
+			IRQF_TIMER | IRQF_IRQPOLL, "mtk_timer", evt)) {
+		pr_err("failed to setup irq %d\n", evt->dev.irq);
+		goto err_clk_disable;
+	}
+
+	evt->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
+
+	/* Configure clock source */
+	mtk_timer_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN);
+	clocksource_mmio_init(evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC),
+			node->name, rate, 300, 32, clocksource_mmio_readl_up);
+	gpt_sched_reg = evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC);
+	sched_clock_register(mtk_read_sched_clock, 32, rate);
+
+	/* Configure clock event */
+	mtk_timer_setup(evt, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT);
+	clockevents_config_and_register(&evt->dev, rate, 0x3,
+					0xffffffff);
+
+	mtk_timer_enable_irq(evt, GPT_CLK_EVT);
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(clk);
+err_clk_put:
+	clk_put(clk);
+err_irq:
+	irq_dispose_mapping(evt->dev.irq);
+err_mem:
+	iounmap(evt->gpt_base);
+	of_address_to_resource(node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
+err_kzalloc:
+	kfree(evt);
+
+	return -EINVAL;
+}
+TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_timer_init);
-- 
1.7.9.5

