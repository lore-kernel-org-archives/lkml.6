Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91211C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D2D2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D2D2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeI1HNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:13:49 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57183 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728744AbeI1HNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:13:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07438648|-1;CH=blue;FP=11969785473526400248|1|1|12|0|-1|-1|-1;HT=e02c03299;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.CwkiGSY_1538095947;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwkiGSY_1538095947)
          by smtp.aliyun-inc.com(10.147.40.26);
          Fri, 28 Sep 2018 08:52:27 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 30/33] clocksource: add gx6605s SOC system timer
Date:   Fri, 28 Sep 2018 08:51:27 +0800
Message-Id: <8f77e77744276b0cbdf1d6c9ba6daed49f9452a7.1538058840.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
References: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
 - Add License and Copyright
 - Use timer-of framework
 - Change name with upstream feedback
 - Use clksource_mmio framework

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/clocksource/Kconfig         |   8 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-gx6605s.c | 150 ++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/clocksource/timer-gx6605s.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a28043f..0f38acc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -628,4 +628,12 @@ config CSKY_MPTIMER
 	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
 	  system.
 
+config GX6605S_TIMER
+	bool "Gx6605s SOC system timer driver"
+	depends on CSKY
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  This option enables support for gx6605s SOC's timer.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 848c676..7a1b0f4 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -80,3 +80,4 @@ obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
 obj-$(CONFIG_CSKY_MPTIMER)		+= csky_mptimer.o
+obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
diff --git a/drivers/clocksource/timer-gx6605s.c b/drivers/clocksource/timer-gx6605s.c
new file mode 100644
index 0000000..10194c9
--- /dev/null
+++ b/drivers/clocksource/timer-gx6605s.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/sched_clock.h>
+
+#include "timer-of.h"
+
+#define CLKSRC_OFFSET	0x40
+
+#define TIMER_STATUS	0x00
+#define TIMER_VALUE	0x04
+#define TIMER_CONTRL	0x10
+#define TIMER_CONFIG	0x20
+#define TIMER_DIV	0x24
+#define TIMER_INI	0x28
+
+#define GX6605S_STATUS_CLR	BIT(0)
+#define GX6605S_CONTRL_RST	BIT(0)
+#define GX6605S_CONTRL_START	BIT(1)
+#define GX6605S_CONFIG_EN	BIT(0)
+#define GX6605S_CONFIG_IRQ_EN	BIT(1)
+
+static irqreturn_t gx6605s_timer_interrupt(int irq, void *dev)
+{
+	struct clock_event_device *ce = (struct clock_event_device *) dev;
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	writel_relaxed(GX6605S_STATUS_CLR, base + TIMER_STATUS);
+
+	ce->event_handler(ce);
+
+	return IRQ_HANDLED;
+}
+
+static int gx6605s_timer_set_oneshot(struct clock_event_device *ce)
+{
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	/* reset and stop counter */
+	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
+
+	/* enable with irq and start */
+	writel_relaxed(GX6605S_CONFIG_EN | GX6605S_CONFIG_IRQ_EN, base + TIMER_CONFIG);
+
+	return 0;
+}
+
+static int gx6605s_timer_set_next_event(unsigned long delta, struct clock_event_device *ce)
+{
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	/* use reset to pause timer */
+	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
+
+	/* config next timeout value */
+	writel_relaxed(ULONG_MAX - delta, base + TIMER_INI);
+	writel_relaxed(GX6605S_CONTRL_START, base + TIMER_CONTRL);
+
+	return 0;
+}
+
+static int gx6605s_timer_shutdown(struct clock_event_device *ce)
+{
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	writel_relaxed(0, base + TIMER_CONTRL);
+	writel_relaxed(0, base + TIMER_CONFIG);
+
+	return 0;
+}
+
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.clkevt = {
+		.rating			= 300,
+		.features		= CLOCK_EVT_FEAT_DYNIRQ |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown	= gx6605s_timer_shutdown,
+		.set_state_oneshot	= gx6605s_timer_set_oneshot,
+		.set_next_event		= gx6605s_timer_set_next_event,
+		.cpumask		= cpu_possible_mask,
+	},
+	.of_irq = {
+		.handler		= gx6605s_timer_interrupt,
+		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
+	},
+};
+
+static u64 notrace gx6605s_sched_clock_read(void)
+{
+	void __iomem *base;
+
+	base = timer_of_base(&to) + CLKSRC_OFFSET;
+
+	return (u64) readl_relaxed(base + TIMER_VALUE);
+}
+
+static void gx6605s_clkevt_init(void __iomem *base)
+{
+	writel_relaxed(0, base + TIMER_DIV);
+	writel_relaxed(0, base + TIMER_CONFIG);
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 2, ULONG_MAX);
+}
+
+static int gx6605s_clksrc_init(void __iomem *base)
+{
+	writel_relaxed(0, base + TIMER_DIV);
+	writel_relaxed(0, base + TIMER_INI);
+
+	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
+
+	writel_relaxed(GX6605S_CONFIG_EN, base + TIMER_CONFIG);
+
+	writel_relaxed(GX6605S_CONTRL_START, base + TIMER_CONTRL);
+
+	sched_clock_register(gx6605s_sched_clock_read, 32, timer_of_rate(&to));
+
+	return clocksource_mmio_init(base + TIMER_VALUE, "gx6605s", timer_of_rate(&to),
+				     200, 32, clocksource_mmio_readl_up);
+}
+
+static int __init gx6605s_timer_init(struct device_node *np)
+{
+	int ret;
+
+	/*
+	 * The timer driver is for nationalchip gx6605s SOC and there are two same timer
+	 * in gx6605s. We use one for clkevt and another for clksrc.
+	 *
+	 * The timer is mmio map to access, so we need give mmio addres in dts.
+	 *
+	 * It provides a 32bit countup timer and interrupt will be caused by count-overflow.
+	 * So we need set-next-event by ULONG_MAX - delta in TIMER_INI reg.
+	 *
+	 * The counter at 0x0  offset is clock event.
+	 * The counter at 0x40 offset is clock source.
+	 * They are the same in hardware, just different used by driver.
+	 */
+	ret = timer_of_init(np, &to);
+	if (ret)
+		return ret;
+
+	gx6605s_clkevt_init(timer_of_base(&to));
+
+	return gx6605s_clksrc_init(timer_of_base(&to) + CLKSRC_OFFSET);
+}
+TIMER_OF_DECLARE(csky_gx6605s_timer, "csky,gx6605s-timer", gx6605s_timer_init);
-- 
2.7.4

