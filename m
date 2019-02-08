Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649622086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfBHM0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:26:11 -0500
Received: from mx.socionext.com ([202.248.49.38]:27772 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBHM0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:26:11 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Feb 2019 21:26:09 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id E2E6760062;
        Fri,  8 Feb 2019 21:26:09 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 8 Feb 2019 21:26:09 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id A4D711A04E1;
        Fri,  8 Feb 2019 21:26:09 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 922AF1202F1;
        Fri,  8 Feb 2019 21:26:09 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce timer for Milbeaut SoCs
Date:   Fri,  8 Feb 2019 21:26:52 +0900
Message-Id: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timer driver for Milbeaut SoCs series.

The timer has two 32-bit width down counters, one of which is configured
as a clockevent device and the other is configured as a clock source.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 drivers/clocksource/Kconfig          |   9 ++
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-milbeaut.c | 161 +++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/clocksource/timer-milbeaut.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a9e26f6..9101b8f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -634,4 +634,13 @@ config GX6605S_TIMER
 	help
 	  This option enables support for gx6605s SOC's timer.
 
+config MILBEAUT_TIMER
+	bool "Milbeaut timer driver" if COMPILE_TEST
+	depends on OF
+	depends on ARM
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  Enables the support for Milbeaut timer driver.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index cdd210f..6f2543b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
 obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
+obj-$(CONFIG_MILBEAUT_TIMER)	+= timer-milbeaut.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
 obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
new file mode 100644
index 0000000..f2019a8
--- /dev/null
+++ b/drivers/clocksource/timer-milbeaut.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Socionext Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include "timer-of.h"
+
+#define MLB_TMR_TMCSR_OFS	0x0
+#define MLB_TMR_TMR_OFS		0x4
+#define MLB_TMR_TMRLR1_OFS	0x8
+#define MLB_TMR_TMRLR2_OFS	0xc
+#define MLB_TMR_REGSZPCH	0x10
+
+#define MLB_TMR_TMCSR_OUTL	BIT(5)
+#define MLB_TMR_TMCSR_RELD	BIT(4)
+#define MLB_TMR_TMCSR_INTE	BIT(3)
+#define MLB_TMR_TMCSR_UF	BIT(2)
+#define MLB_TMR_TMCSR_CNTE	BIT(1)
+#define MLB_TMR_TMCSR_TRG	BIT(0)
+
+#define MLB_TMR_TMCSR_CSL_DIV2	0
+#define MLB_TMR_DIV_CNT		2
+
+#define MLB_TMR_SRC_CH  (1)
+#define MLB_TMR_EVT_CH  (0)
+
+#define MLB_TMR_SRC_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_SRC_CH)
+#define MLB_TMR_EVT_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_EVT_CH)
+
+#define MLB_TMR_SRC_TMCSR_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMCSR_OFS)
+#define MLB_TMR_SRC_TMR_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMR_OFS)
+#define MLB_TMR_SRC_TMRLR1_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMRLR1_OFS)
+#define MLB_TMR_SRC_TMRLR2_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMRLR2_OFS)
+
+#define MLB_TMR_EVT_TMCSR_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMCSR_OFS)
+#define MLB_TMR_EVT_TMR_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMR_OFS)
+#define MLB_TMR_EVT_TMRLR1_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMRLR1_OFS)
+#define MLB_TMR_EVT_TMRLR2_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMRLR2_OFS)
+
+#define MLB_TIMER_RATING	500
+
+static irqreturn_t mlb_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *clk = dev_id;
+	struct timer_of *to = to_timer_of(clk);
+	u32 val;
+
+	val = readl_relaxed(timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	val &= ~MLB_TMR_TMCSR_UF;
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+
+	clk->event_handler(clk);
+
+	return IRQ_HANDLED;
+}
+
+static int mlb_set_state_periodic(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
+
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+
+	writel_relaxed(to->of_clk.period, timer_of_base(to) +
+				MLB_TMR_EVT_TMRLR1_OFS);
+	val |= MLB_TMR_TMCSR_RELD | MLB_TMR_TMCSR_CNTE |
+		MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	return 0;
+}
+
+static int mlb_set_state_oneshot(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
+
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	return 0;
+}
+
+static int mlb_clkevt_next_event(unsigned long event,
+				   struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+
+	writel_relaxed(event, timer_of_base(to) + MLB_TMR_EVT_TMRLR1_OFS);
+	writel_relaxed(MLB_TMR_TMCSR_CSL_DIV2 |
+			MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_INTE |
+			MLB_TMR_TMCSR_TRG, timer_of_base(to) +
+			MLB_TMR_EVT_TMCSR_OFS);
+	return 0;
+}
+
+static int mlb_config_clock_source(struct timer_of *to)
+{
+	writel_relaxed(0, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
+	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMR_OFS);
+	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR1_OFS);
+	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR2_OFS);
+	writel_relaxed(BIT(4) | BIT(1) | BIT(0), timer_of_base(to) +
+		MLB_TMR_SRC_TMCSR_OFS);
+	return 0;
+}
+
+static int mlb_config_clock_event(struct timer_of *to)
+{
+	writel_relaxed(0, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	return 0;
+}
+
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+
+	.clkevt = {
+		.name = "mlb-clkevt",
+		.rating = MLB_TIMER_RATING,
+		.cpumask = cpu_possible_mask,
+		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_oneshot = mlb_set_state_oneshot,
+		.set_state_periodic = mlb_set_state_periodic,
+		.set_next_event = mlb_clkevt_next_event,
+	},
+
+	.of_irq = {
+		.flags = IRQF_TIMER | IRQF_IRQPOLL,
+		.handler = mlb_timer_interrupt,
+	},
+};
+
+static u64 notrace mlb_timer_sched_read(void)
+{
+	return ~readl_relaxed(timer_of_base(&to) + MLB_TMR_SRC_TMR_OFS);
+}
+
+static int __init mlb_timer_init(struct device_node *node)
+{
+	int ret;
+	unsigned long rate;
+
+	ret = timer_of_init(node, &to);
+	if (ret)
+		return ret;
+
+	rate = timer_of_rate(&to) / MLB_TMR_DIV_CNT;
+	mlb_config_clock_source(&to);
+	clocksource_mmio_init(timer_of_base(&to) + MLB_TMR_SRC_TMR_OFS,
+		node->name, rate, MLB_TIMER_RATING, 32,
+		clocksource_mmio_readl_down);
+	sched_clock_register(mlb_timer_sched_read, 32, rate);
+	mlb_config_clock_event(&to);
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 15,
+		0xffffffff);
+	return 0;
+}
+TIMER_OF_DECLARE(mlb_peritimer, "socionext,milbeaut-timer",
+		mlb_timer_init);
-- 
1.9.1

