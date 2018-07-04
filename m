Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4476C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8022064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8022064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeGDOu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:50:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64802 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753034AbeGDOul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:50:41 -0400
X-UUID: 9f726b09acb14334bc97cb77ff888140-20180704
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2068433798; Wed, 04 Jul 2018 22:50:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 4 Jul 2018 22:50:32 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 4 Jul 2018 22:50:32 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v6 4/5] clocksource/drivers/timer-mediatek: Convert the driver to timer-of
Date:   Wed, 4 Jul 2018 22:50:19 +0800
Message-ID: <1530715820-3406-5-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1530715820-3406-1-git-send-email-stanley.chu@mediatek.com>
References: <1530715820-3406-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to use the timer_of helpers.
This allows to remove custom proprietary structure,
factors out and simplifies the code.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/clocksource/timer-mediatek.c |  205 +++++++++++++---------------------
 1 file changed, 80 insertions(+), 125 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index e3657d2..e57c4d7 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -18,16 +18,13 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
-#include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/clocksource.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/irqreturn.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
+#include "timer-of.h"
 
 #define TIMER_CLK_EVT           (1)
 #define TIMER_CLK_SRC           (2)
@@ -59,12 +56,6 @@
 #define GPT_CNT_REG(val)        (0x08 + (0x10 * (val)))
 #define GPT_CMP_REG(val)        (0x0C + (0x10 * (val)))
 
-struct mtk_clock_event_device {
-	void __iomem *gpt_base;
-	u32 ticks_per_jiffy;
-	struct clock_event_device dev;
-};
-
 static void __iomem *gpt_sched_reg __read_mostly;
 
 static u64 notrace mtk_gpt_read_sched_clock(void)
@@ -72,36 +63,30 @@ static u64 notrace mtk_gpt_read_sched_clock(void)
 	return readl_relaxed(gpt_sched_reg);
 }
 
-static inline struct mtk_clock_event_device *to_mtk_clk(
-				struct clock_event_device *c)
-{
-	return container_of(c, struct mtk_clock_event_device, dev);
-}
-
-static void mtk_gpt_clkevt_time_stop(struct mtk_clock_event_device *evt, u8 timer)
+static void mtk_gpt_clkevt_time_stop(struct timer_of *to, u8 timer)
 {
 	u32 val;
 
-	val = readl(evt->gpt_base + GPT_CTRL_REG(timer));
-	writel(val & ~GPT_CTRL_ENABLE, evt->gpt_base +
-			GPT_CTRL_REG(timer));
+	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
+	writel(val & ~GPT_CTRL_ENABLE, timer_of_base(to) +
+	       GPT_CTRL_REG(timer));
 }
 
-static void mtk_gpt_clkevt_time_setup(struct mtk_clock_event_device *evt,
-				unsigned long delay, u8 timer)
+static void mtk_gpt_clkevt_time_setup(struct timer_of *to,
+				      unsigned long delay, u8 timer)
 {
-	writel(delay, evt->gpt_base + GPT_CMP_REG(timer));
+	writel(delay, timer_of_base(to) + GPT_CMP_REG(timer));
 }
 
-static void mtk_gpt_clkevt_time_start(struct mtk_clock_event_device *evt,
-		bool periodic, u8 timer)
+static void mtk_gpt_clkevt_time_start(struct timer_of *to,
+				      bool periodic, u8 timer)
 {
 	u32 val;
 
 	/* Acknowledge interrupt */
-	writel(GPT_IRQ_ACK(timer), evt->gpt_base + GPT_IRQ_ACK_REG);
+	writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
 
-	val = readl(evt->gpt_base + GPT_CTRL_REG(timer));
+	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
 
 	/* Clear 2 bit timer operation mode field */
 	val &= ~GPT_CTRL_OP(0x3);
@@ -112,160 +97,130 @@ static void mtk_gpt_clkevt_time_start(struct mtk_clock_event_device *evt,
 		val |= GPT_CTRL_OP(GPT_CTRL_OP_ONESHOT);
 
 	writel(val | GPT_CTRL_ENABLE | GPT_CTRL_CLEAR,
-	       evt->gpt_base + GPT_CTRL_REG(timer));
+	       timer_of_base(to) + GPT_CTRL_REG(timer));
 }
 
 static int mtk_gpt_clkevt_shutdown(struct clock_event_device *clk)
 {
-	mtk_gpt_clkevt_time_stop(to_mtk_clk(clk), TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(to_timer_of(clk), TIMER_CLK_EVT);
+
 	return 0;
 }
 
 static int mtk_gpt_clkevt_set_periodic(struct clock_event_device *clk)
 {
-	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
+	struct timer_of *to = to_timer_of(clk);
+
+	mtk_gpt_clkevt_time_stop(to, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_setup(to, to->of_clk.period, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_start(to, true, TIMER_CLK_EVT);
 
-	mtk_gpt_clkevt_time_stop(evt, TIMER_CLK_EVT);
-	mtk_gpt_clkevt_time_setup(evt, evt->ticks_per_jiffy, TIMER_CLK_EVT);
-	mtk_gpt_clkevt_time_start(evt, true, TIMER_CLK_EVT);
 	return 0;
 }
 
 static int mtk_gpt_clkevt_next_event(unsigned long event,
-				   struct clock_event_device *clk)
+				     struct clock_event_device *clk)
 {
-	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
+	struct timer_of *to = to_timer_of(clk);
 
-	mtk_gpt_clkevt_time_stop(evt, TIMER_CLK_EVT);
-	mtk_gpt_clkevt_time_setup(evt, event, TIMER_CLK_EVT);
-	mtk_gpt_clkevt_time_start(evt, false, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(to, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_setup(to, event, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_start(to, false, TIMER_CLK_EVT);
 
 	return 0;
 }
 
 static irqreturn_t mtk_gpt_interrupt(int irq, void *dev_id)
 {
-	struct mtk_clock_event_device *evt = dev_id;
+	struct clock_event_device *clkevt = (struct clock_event_device *)dev_id;
+	struct timer_of *to = to_timer_of(clkevt);
 
 	/* Acknowledge timer0 irq */
-	writel(GPT_IRQ_ACK(TIMER_CLK_EVT), evt->gpt_base + GPT_IRQ_ACK_REG);
-	evt->dev.event_handler(&evt->dev);
+	writel(GPT_IRQ_ACK(TIMER_CLK_EVT), timer_of_base(to) + GPT_IRQ_ACK_REG);
+	clkevt->event_handler(clkevt);
 
 	return IRQ_HANDLED;
 }
 
 static void
-__init mtk_gpt_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
+__init mtk_gpt_setup(struct timer_of *to, u8 timer, u8 option)
 {
 	writel(GPT_CTRL_CLEAR | GPT_CTRL_DISABLE,
-		evt->gpt_base + GPT_CTRL_REG(timer));
+	       timer_of_base(to) + GPT_CTRL_REG(timer));
 
 	writel(GPT_CLK_SRC(GPT_CLK_SRC_SYS13M) | GPT_CLK_DIV1,
-			evt->gpt_base + GPT_CLK_REG(timer));
+	       timer_of_base(to) + GPT_CLK_REG(timer));
 
-	writel(0x0, evt->gpt_base + GPT_CMP_REG(timer));
+	writel(0x0, timer_of_base(to) + GPT_CMP_REG(timer));
 
 	writel(GPT_CTRL_OP(option) | GPT_CTRL_ENABLE,
-			evt->gpt_base + GPT_CTRL_REG(timer));
+	       timer_of_base(to) + GPT_CTRL_REG(timer));
 }
 
-static void mtk_gpt_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
+static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
 {
 	u32 val;
 
 	/* Disable all interrupts */
-	writel(0x0, evt->gpt_base + GPT_IRQ_EN_REG);
+	writel(0x0, timer_of_base(to) + GPT_IRQ_EN_REG);
 
 	/* Acknowledge all spurious pending interrupts */
-	writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);
+	writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
 
-	val = readl(evt->gpt_base + GPT_IRQ_EN_REG);
+	val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
 	writel(val | GPT_IRQ_ENABLE(timer),
-			evt->gpt_base + GPT_IRQ_EN_REG);
+	       timer_of_base(to) + GPT_IRQ_EN_REG);
 }
 
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+
+	.clkevt = {
+		.name = "mtk-clkevt",
+		.rating = 300,
+		.cpumask = cpu_possible_mask,
+	},
+
+	.of_irq = {
+		.flags = IRQF_TIMER | IRQF_IRQPOLL,
+	},
+};
+
 static int __init mtk_gpt_init(struct device_node *node)
 {
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
-	evt->dev.set_state_shutdown = mtk_gpt_clkevt_shutdown;
-	evt->dev.set_state_periodic = mtk_gpt_clkevt_set_periodic;
-	evt->dev.set_state_oneshot = mtk_gpt_clkevt_shutdown;
-	evt->dev.tick_resume = mtk_gpt_clkevt_shutdown;
-	evt->dev.set_next_event = mtk_gpt_clkevt_next_event;
-	evt->dev.cpumask = cpu_possible_mask;
-
-	evt->gpt_base = of_io_request_and_map(node, 0, "mtk-timer-gpt");
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
-	if (request_irq(evt->dev.irq, mtk_gpt_interrupt,
-			IRQF_TIMER | IRQF_IRQPOLL, "mtk_timer", evt)) {
-		pr_err("failed to setup irq %d\n", evt->dev.irq);
-		goto err_clk_disable;
-	}
-
-	evt->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
+	int ret;
+
+	to.clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	to.clkevt.set_state_shutdown = mtk_gpt_clkevt_shutdown;
+	to.clkevt.set_state_periodic = mtk_gpt_clkevt_set_periodic;
+	to.clkevt.set_state_oneshot = mtk_gpt_clkevt_shutdown;
+	to.clkevt.tick_resume = mtk_gpt_clkevt_shutdown;
+	to.clkevt.set_next_event = mtk_gpt_clkevt_next_event;
+	to.of_irq.handler = mtk_gpt_interrupt;
+
+	ret = timer_of_init(node, &to);
+	if (ret)
+		goto err;
 
 	/* Configure clock source */
-	mtk_gpt_setup(evt, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
-	clocksource_mmio_init(evt->gpt_base + GPT_CNT_REG(TIMER_CLK_SRC),
-			node->name, rate, 300, 32, clocksource_mmio_readl_up);
-	gpt_sched_reg = evt->gpt_base + GPT_CNT_REG(TIMER_CLK_SRC);
-	sched_clock_register(mtk_gpt_read_sched_clock, 32, rate);
+	mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
+	clocksource_mmio_init(timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_SRC),
+			      node->name, timer_of_rate(&to), 300, 32,
+			      clocksource_mmio_readl_up);
+	gpt_sched_reg = timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_SRC);
+	sched_clock_register(mtk_gpt_read_sched_clock, 32, timer_of_rate(&to));
 
 	/* Configure clock event */
-	mtk_gpt_setup(evt, TIMER_CLK_EVT, GPT_CTRL_OP_REPEAT);
-	clockevents_config_and_register(&evt->dev, rate, TIMER_SYNC_TICKS,
-					0xffffffff);
+	mtk_gpt_setup(&to, TIMER_CLK_EVT, GPT_CTRL_OP_REPEAT);
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
+					TIMER_SYNC_TICKS, 0xffffffff);
 
-	mtk_gpt_enable_irq(evt, TIMER_CLK_EVT);
+	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
 
 	return 0;
 
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
+err:
+	timer_of_cleanup(&to);
+	return ret;
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
-- 
1.7.9.5

