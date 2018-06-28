Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D5CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B442724E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B442724E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965389AbeF1Kqv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:46:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34119 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933849AbeF1Kpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:45:53 -0400
X-UUID: a8303c6bed49475fa22401ac048ca7a7-20180628
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1322785286; Thu, 28 Jun 2018 18:45:49 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 28 Jun 2018 18:45:48 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 18:45:48 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v3 5/5] clocksource/drivers/timer-mediatek: Add support for system timer
Date:   Thu, 28 Jun 2018 18:45:44 +0800
Message-ID: <1530182744-10731-6-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1530182744-10731-1-git-send-email-stanley.chu@mediatek.com>
References: <1530182744-10731-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new "System Timer" on the Mediatek SoCs.

The System Timer is introduced as an always-on timer being
clockevent device for tick-broadcasting.

For clock, it is driven by 13 MHz system clock.
The implementation uses the system clock with no clock
source divider.

For interrupt, the clock event timer can be used by all cores.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/clocksource/timer-mediatek.c |  225 +++++++++++++++++++++++++---------
 1 file changed, 167 insertions(+), 58 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index d94d8e1..6878736 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -26,32 +26,46 @@
 #include <linux/slab.h>
 #include "timer-of.h"
 
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
+#define TIMER_CLK_EVT           (1)
+#define TIMER_CLK_SRC           (2)
+
+#define TIMER_SYNC_TICKS        (3)
+
+/* gpt */
+#define GPT_IRQ_EN_REG          0x00
+#define GPT_IRQ_ENABLE(val)     BIT((val) - 1)
+#define GPT_IRQ_ACK_REG	        0x08
+#define GPT_IRQ_ACK(val)        BIT((val) - 1)
+
+#define GPT_CTRL_REG(val)       (0x10 * (val))
+#define GPT_CTRL_OP(val)        (((val) & 0x3) << 4)
+#define GPT_CTRL_OP_ONESHOT     (0)
+#define GPT_CTRL_OP_REPEAT      (1)
+#define GPT_CTRL_OP_FREERUN     (3)
+#define GPT_CTRL_CLEAR          (2)
+#define GPT_CTRL_ENABLE         (1)
+#define GPT_CTRL_DISABLE        (0)
+
+#define GPT_CLK_REG(val)        (0x04 + (0x10 * (val)))
+#define GPT_CLK_SRC(val)        (((val) & 0x1) << 4)
+#define GPT_CLK_SRC_SYS13M      (0)
+#define GPT_CLK_SRC_RTC32K      (1)
+#define GPT_CLK_DIV1            (0x0)
+#define GPT_CLK_DIV2            (0x1)
+
+#define GPT_CNT_REG(val)        (0x08 + (0x10 * (val)))
+#define GPT_CMP_REG(val)        (0x0C + (0x10 * (val)))
+
+/* system timer */
+#define SYST_CON                (0x0)
+#define SYST_VAL                (0x4)
+
+#define SYST_CON_REG(to)        (timer_of_base(to) + SYST_CON)
+#define SYST_VAL_REG(to)        (timer_of_base(to) + SYST_VAL)
+
+#define SYST_CON_EN              BIT(0)
+#define SYST_CON_IRQ_EN          BIT(1)
+#define SYST_CON_IRQ_CLR         BIT(4)
 
 struct mtk_timer_private {
 	unsigned long ticks_per_jiffy;
@@ -75,6 +89,71 @@ static void mtk_timer_of_priv_get(struct timer_of *to,
 		*ticks_per_jiffy = pd->ticks_per_jiffy;
 }
 
+static void mtk_syst_reset(struct timer_of *to)
+{
+	/* clear and disable interrupt */
+	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
+
+	/* reset counter */
+	writel(0, SYST_VAL_REG(to));
+
+	/* disable timer */
+	writel(0, SYST_CON_REG(to));
+}
+
+static void mtk_syst_ack_irq(struct timer_of *to)
+{
+	mtk_syst_reset(to);
+}
+
+static irqreturn_t mtk_syst_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *clkevt = (struct clock_event_device *)dev_id;
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
+	/*
+	 * reset timer first because we do not expect interrupt is triggered
+	 * by old compare value.
+	 */
+	mtk_syst_reset(to);
+
+	writel(SYST_CON_EN, SYST_CON_REG(to));
+
+	writel(ticks, SYST_VAL_REG(to));
+
+	writel(SYST_CON_EN | SYST_CON_IRQ_EN, SYST_CON_REG(to));
+
+	return 0;
+}
+
+static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
+{
+	mtk_syst_reset(to_timer_of(clkevt));
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
@@ -84,15 +163,15 @@ static void mtk_gpt_clkevt_time_stop(struct timer_of *to, u8 timer)
 {
 	u32 val;
 
-	val = readl(timer_of_base(to) + TIMER_CTRL_REG(timer));
-	writel(val & ~TIMER_CTRL_ENABLE, timer_of_base(to) +
-	       TIMER_CTRL_REG(timer));
+	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
+	writel(val & ~GPT_CTRL_ENABLE, timer_of_base(to) +
+	       GPT_CTRL_REG(timer));
 }
 
 static void mtk_gpt_clkevt_time_setup(struct timer_of *to,
 				      unsigned long delay, u8 timer)
 {
-	writel(delay, timer_of_base(to) + TIMER_CMP_REG(timer));
+	writel(delay, timer_of_base(to) + GPT_CMP_REG(timer));
 }
 
 static void mtk_gpt_clkevt_time_start(struct timer_of *to,
@@ -103,23 +182,23 @@ static void mtk_gpt_clkevt_time_start(struct timer_of *to,
 	/* Acknowledge interrupt */
 	writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
 
-	val = readl(timer_of_base(to) + TIMER_CTRL_REG(timer));
+	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
 
 	/* Clear 2 bit timer operation mode field */
-	val &= ~TIMER_CTRL_OP(0x3);
+	val &= ~GPT_CTRL_OP(0x3);
 
 	if (periodic)
-		val |= TIMER_CTRL_OP(TIMER_CTRL_OP_REPEAT);
+		val |= GPT_CTRL_OP(GPT_CTRL_OP_REPEAT);
 	else
-		val |= TIMER_CTRL_OP(TIMER_CTRL_OP_ONESHOT);
+		val |= GPT_CTRL_OP(GPT_CTRL_OP_ONESHOT);
 
-	writel(val | TIMER_CTRL_ENABLE | TIMER_CTRL_CLEAR,
-	       timer_of_base(to) + TIMER_CTRL_REG(timer));
+	writel(val | GPT_CTRL_ENABLE | GPT_CTRL_CLEAR,
+	       timer_of_base(to) + GPT_CTRL_REG(timer));
 }
 
 static int mtk_gpt_clkevt_shutdown(struct clock_event_device *clk)
 {
-	mtk_gpt_clkevt_time_stop(to_timer_of(clk), GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(to_timer_of(clk), TIMER_CLK_EVT);
 	return 0;
 }
 
@@ -128,10 +207,10 @@ static int mtk_gpt_clkevt_set_periodic(struct clock_event_device *clk)
 	struct timer_of *to = to_timer_of(clk);
 	unsigned long ticks_per_jiffy;
 
-	mtk_gpt_clkevt_time_stop(to, GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(to, TIMER_CLK_EVT);
 	mtk_timer_of_priv_get(to, &ticks_per_jiffy);
-	mtk_gpt_clkevt_time_setup(to, ticks_per_jiffy, GPT_CLK_EVT);
-	mtk_gpt_clkevt_time_start(to, true, GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_setup(to, ticks_per_jiffy, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_start(to, true, TIMER_CLK_EVT);
 	return 0;
 }
 
@@ -140,9 +219,9 @@ static int mtk_gpt_clkevt_next_event(unsigned long event,
 {
 	struct timer_of *to = to_timer_of(clk);
 
-	mtk_gpt_clkevt_time_stop(to, GPT_CLK_EVT);
-	mtk_gpt_clkevt_time_setup(to, event, GPT_CLK_EVT);
-	mtk_gpt_clkevt_time_start(to, false, GPT_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(to, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_setup(to, event, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_start(to, false, TIMER_CLK_EVT);
 
 	return 0;
 }
@@ -153,7 +232,7 @@ static irqreturn_t mtk_gpt_interrupt(int irq, void *dev_id)
 	struct timer_of *to = to_timer_of(clkevt);
 
 	/* Acknowledge timer0 irq */
-	writel(GPT_IRQ_ACK(GPT_CLK_EVT), timer_of_base(to) + GPT_IRQ_ACK_REG);
+	writel(GPT_IRQ_ACK(TIMER_CLK_EVT), timer_of_base(to) + GPT_IRQ_ACK_REG);
 	clkevt->event_handler(clkevt);
 
 	return IRQ_HANDLED;
@@ -162,16 +241,16 @@ static irqreturn_t mtk_gpt_interrupt(int irq, void *dev_id)
 static void
 __init mtk_gpt_setup(struct timer_of *to, u8 timer, u8 option)
 {
-	writel(TIMER_CTRL_CLEAR | TIMER_CTRL_DISABLE,
-		timer_of_base(to) + TIMER_CTRL_REG(timer));
+	writel(GPT_CTRL_CLEAR | GPT_CTRL_DISABLE,
+	       timer_of_base(to) + GPT_CTRL_REG(timer));
 
-	writel(TIMER_CLK_SRC(TIMER_CLK_SRC_SYS13M) | TIMER_CLK_DIV1,
-			timer_of_base(to) + TIMER_CLK_REG(timer));
+	writel(GPT_CLK_SRC(GPT_CLK_SRC_SYS13M) | GPT_CLK_DIV1,
+	       timer_of_base(to) + GPT_CLK_REG(timer));
 
-	writel(0x0, timer_of_base(to) + TIMER_CMP_REG(timer));
+	writel(0x0, timer_of_base(to) + GPT_CMP_REG(timer));
 
-	writel(TIMER_CTRL_OP(option) | TIMER_CTRL_ENABLE,
-			timer_of_base(to) + TIMER_CTRL_REG(timer));
+	writel(GPT_CTRL_OP(option) | GPT_CTRL_ENABLE,
+	       timer_of_base(to) + GPT_CTRL_REG(timer));
 }
 
 static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
@@ -186,7 +265,7 @@ static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
 
 	val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
 	writel(val | GPT_IRQ_ENABLE(timer),
-			timer_of_base(to) + GPT_IRQ_EN_REG);
+	       timer_of_base(to) + GPT_IRQ_EN_REG);
 }
 
 static struct timer_of to = {
@@ -203,6 +282,35 @@ static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
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
+	mtk_syst_reset(&to);
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
+					TIMER_SYNC_TICKS, 0xffffffff);
+
+	pr_info("irq=%d, rate=%lu, max_ns: %llu, min_ns: %llu\n",
+		timer_of_irq(&to), timer_of_rate(&to),
+		to.clkevt.max_delta_ns, to.clkevt.min_delta_ns);
+
+	return 0;
+err:
+	return ret;
+}
+
 static int __init mtk_gpt_init(struct device_node *node)
 {
 	int ret;
@@ -230,25 +338,26 @@ static int __init mtk_gpt_init(struct device_node *node)
 	mtk_timer_of_priv_set(&to, DIV_ROUND_UP(timer_of_rate(&to), HZ));
 
 	/* Configure clock source */
-	mtk_gpt_setup(&to, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN);
-	clocksource_mmio_init(timer_of_base(&to) + TIMER_CNT_REG(GPT_CLK_SRC),
+	mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
+	clocksource_mmio_init(timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_SRC),
 			      node->name, timer_of_rate(&to), 300, 32,
 			      clocksource_mmio_readl_up);
-	gpt_sched_reg = timer_of_base(&to) + TIMER_CNT_REG(GPT_CLK_SRC);
+	gpt_sched_reg = timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_SRC);
 	sched_clock_register(mtk_gpt_read_sched_clock, 32, timer_of_rate(&to));
 
 	/* Configure clock event */
-	mtk_gpt_setup(&to, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT);
+	mtk_gpt_setup(&to, TIMER_CLK_EVT, GPT_CTRL_OP_REPEAT);
 	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 0x3,
 					0xffffffff);
 
-	mtk_gpt_enable_irq(&to, GPT_CLK_EVT);
+	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
 
 	return 0;
-
 deinit:
 	timer_of_cleanup(&to);
 err:
 	return ret;
 }
+
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
+TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-systimer", mtk_syst_init);
-- 
1.7.9.5

