Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BAC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC1C2650A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC1C2650A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933113AbeF0HyR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:54:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25722 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753232AbeF0HyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:54:12 -0400
X-UUID: 22ee79b4a54948d6a69ed8633d1f02bc-20180627
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1079281503; Wed, 27 Jun 2018 15:54:05 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 27 Jun 2018 15:54:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 15:54:03 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v2 2/2] clocksource/drivers/mtk_systimer: Add support for Mediatek SoCs
Date:   Wed, 27 Jun 2018 15:53:59 +0800
Message-ID: <1530086039-3763-3-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
References: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new clock event for the timer
found on the Mediatek SoCs.

The Mediatek System Timer has several 32-bit timers.
Only one timer is used by this driver as a clock event
supporting oneshot events.

The System Timer can be run with two clocks. A 13 MHz system
clock and the RTC clock running at 32 KHz. This implementation
uses the system clock with no clock source divider.

The interrupts are shared between the different timers.
We just enable one interrupt for the clock event. The clock
event timer is used by all cores.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/clocksource/Kconfig        |   13 +++-
 drivers/clocksource/Makefile       |    1 +
 drivers/clocksource/mtk_systimer.c |  132 ++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clocksource/mtk_systimer.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dec0dd8..362c110 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -442,12 +442,21 @@ config SYS_SUPPORTS_SH_CMT
         bool
 
 config MTK_TIMER
-	bool "Mediatek timer driver" if COMPILE_TEST
+	bool "Mediatek general purpose timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
 	select TIMER_OF
 	select CLKSRC_MMIO
 	help
-	  Support for Mediatek timer driver.
+	  Support for Mediatek General Purpose Timer (GPT) driver.
+
+config MTK_TIMER_SYSTIMER
+	bool "Mediatek system timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  Support for Mediatek System Timer (sys_timer) driver used as
+	  a clock event supporting oneshot events.
 
 config SPRD_TIMER
 	bool "Spreadtrum timer driver" if EXPERT
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 00caf37..cdd34b2 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
 obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
 obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
 obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o
+obj-$(CONFIG_MTK_TIMER_SYSTIMER)	+= mtk_systimer.o
 obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
diff --git a/drivers/clocksource/mtk_systimer.c b/drivers/clocksource/mtk_systimer.c
new file mode 100644
index 0000000..77161bb
--- /dev/null
+++ b/drivers/clocksource/mtk_systimer.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+//  Copyright (C) 2018 MediaTek Inc.
+
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/io.h>
+#include "timer-of.h"
+
+/* registers */
+#define STMR_CON                  (0x0)
+#define STMR_VAL                  (0x4)
+
+#define TIMER_REG_CON(to)         (timer_of_base(to) + STMR_CON)
+#define TIMER_REG_VAL(to)         (timer_of_base(to) + STMR_VAL)
+
+/* STMR_CON */
+#define STMR_CON_EN               BIT(0)
+#define STMR_CON_IRQ_EN           BIT(1)
+#define STMR_CON_IRQ_CLR          BIT(4)
+
+#define TIMER_SYNC_TICKS          3
+
+static void mtk_stmr_reset(struct timer_of *to)
+{
+	/* Clear IRQ */
+	writel(STMR_CON_IRQ_CLR | STMR_CON_EN, TIMER_REG_CON(to));
+
+	/* Reset counter */
+	writel(0, TIMER_REG_VAL(to));
+
+	/* Disable timer */
+	writel(0, TIMER_REG_CON(to));
+}
+
+static void mtk_stmr_ack_irq(struct timer_of *to)
+{
+	mtk_stmr_reset(to);
+}
+
+static irqreturn_t mtk_stmr_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *clkevt = (struct clock_event_device *)dev_id;
+	struct timer_of *to = to_timer_of(clkevt);
+
+	mtk_stmr_ack_irq(to);
+	clkevt->event_handler(clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_stmr_clkevt_next_event(unsigned long ticks,
+				      struct clock_event_device *clkevt)
+{
+	struct timer_of *to = to_timer_of(clkevt);
+
+	/*
+	 * reset timer first because we do not expect interrupt is triggered
+	 * by old compare value.
+	 */
+	mtk_stmr_reset(to);
+
+	writel(STMR_CON_EN, TIMER_REG_CON(to));
+
+	writel(ticks, TIMER_REG_VAL(to));
+
+	writel(STMR_CON_EN | STMR_CON_IRQ_EN, TIMER_REG_CON(to));
+
+	return 0;
+}
+
+static int mtk_stmr_clkevt_shutdown(struct clock_event_device *clkevt)
+{
+	mtk_stmr_reset(to_timer_of(clkevt));
+
+	return 0;
+}
+
+static int mtk_stmr_clkevt_resume(struct clock_event_device *clkevt)
+{
+	return mtk_stmr_clkevt_shutdown(clkevt);
+}
+
+static int mtk_stmr_clkevt_oneshot(struct clock_event_device *clkevt)
+{
+	return 0;
+}
+
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+
+	.clkevt = {
+		.name = "mtk-clkevt",
+		.rating = 300,
+		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown = mtk_stmr_clkevt_shutdown,
+		.set_state_oneshot = mtk_stmr_clkevt_oneshot,
+		.tick_resume = mtk_stmr_clkevt_resume,
+		.set_next_event = mtk_stmr_clkevt_next_event,
+		.cpumask = cpu_possible_mask,
+	},
+
+	.of_irq = {
+		.handler = mtk_stmr_handler,
+		.flags = IRQF_TIMER | IRQF_IRQPOLL | IRQF_TRIGGER_HIGH |
+			 IRQF_PERCPU,
+	},
+};
+
+static int __init mtk_stmr_init(struct device_node *node)
+{
+	int ret;
+
+	ret = timer_of_init(node, &to);
+	if (ret)
+		return ret;
+
+	mtk_stmr_reset(&to);
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
+					TIMER_SYNC_TICKS, 0xffffffff);
+
+	pr_info("mtk_stmr: irq=%d, rate=%lu, max_ns: %llu, min_ns: %llu\n",
+		timer_of_irq(&to), timer_of_rate(&to),
+		to.clkevt.max_delta_ns, to.clkevt.min_delta_ns);
+
+	return ret;
+}
+
+TIMER_OF_DECLARE(mtk_systimer, "mediatek,sys_timer", mtk_stmr_init);
-- 
1.7.9.5

