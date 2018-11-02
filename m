Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331B4C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB6C20833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdZeDslg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB6C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeKCERf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:17:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37142 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeKCERd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:17:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id z3-v6so3032521wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DTGYor+aDoY+YYD6WunsmjKGozWWt6wj8+L/EBCu/QY=;
        b=JdZeDslg1NcvtvSbCV5f/2STVqO82V6hl3mZLUxfXdZPyuT7kkpoW/WD2xtsyAk5Pz
         f1w6kcWdYaUdyURUlZupD/Y0JA7D7SGXdh4HDLdCoTY8zcciRELOxdjlHGwPNscy3k1a
         eCgbrcyg0F1WhthAEYpWajLNXijaBgtwH5aKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DTGYor+aDoY+YYD6WunsmjKGozWWt6wj8+L/EBCu/QY=;
        b=Nl5YMvIX/0x6qzv+g+dOzhkexO7FPlH51vt/IzLbLxnTvK9s18j6o7ruwn1z1ky7Ih
         IUxXJrgIWj7XJZeAec2IMDCQ67CQ6156V7qEywSSMMOpVyMDbW3ueSd36FMrSiZf3msc
         zsGeAJtBLtzLbLuUYg8+w4BoU6lDeRSMJIGpfJS5L+woI/PqTUNeuCX1IYouAkNOQJiJ
         5kqXsYRIt1dtu0gAutvlK+0TEb3ywJ36UALTVzFkDA/tHs/fL22fYM7FicAMssfUSNTd
         OnEd3CIt/P4ieh74bw0jDxWQGmHORif4or4SierlB+dsPYPHFf3SjlVnj67xrK+xoyo2
         Nj7A==
X-Gm-Message-State: AGRZ1gJAjduDM5Zx7UCaWe+OOatQpp55TwU0zXDycbNdbcP3LfqTe/UR
        ymphYLSmWLnieTNjFSA4ewwaO+JFDr4=
X-Google-Smtp-Source: AJdET5cF1PR+jbvwnAaZ3Uw44VsHbzqn0HQPliVMjU31ipFrs/40RA/R1VqY+Vp/70SOIpv8q1KaEw==
X-Received: by 2002:adf:ecc5:: with SMTP id s5-v6mr1726370wro.208.1541185751317;
        Fri, 02 Nov 2018 12:09:11 -0700 (PDT)
Received: from localhost.localdomain ([80.125.186.228])
        by smtp.gmail.com with ESMTPSA id s195-v6sm3899337wmd.39.2018.11.02.12.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 12:09:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ren_guo@c-sky.com
Subject: [PATCH 3/4] clocksource/drivers/c-sky: Add gx6605s SOC system timer
Date:   Fri,  2 Nov 2018 20:08:57 +0100
Message-Id: <1541185738-8208-3-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541185738-8208-1-git-send-email-daniel.lezcano@linaro.org>
References: <d99ed466-b11a-b931-fc7a-a555cae80a53@linaro.org>
 <1541185738-8208-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The driver is for gx6605s SOC system timer and there are two
same timers in gx6605s. We use one for clkevt and another one for
clksrc.

The timer is mmio map to access, so we need give mmio address in dts.

The counter at 0x0  offset is clock event.
The counter at 0x40 offset is clock source.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig         |   8 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-gx6605s.c | 154 ++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/clocksource/timer-gx6605s.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 591c9a8..55c77e4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -630,4 +630,12 @@ config CSKY_MP_TIMER
 	  csky,mptimer is not only used in SMP system, it also could be used
 	  single core system. It's not a mmio reg and it use mtcr/mfcr instruction.
 
+config GX6605S_TIMER
+	bool "Gx6605s SOC system timer driver" if COMPILE_TEST
+	depends on CSKY
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  This option enables support for gx6605s SOC's timer.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5ce82d3..9196331 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -80,3 +80,4 @@ obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
+obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
diff --git a/drivers/clocksource/timer-gx6605s.c b/drivers/clocksource/timer-gx6605s.c
new file mode 100644
index 0000000..80d0939
--- /dev/null
+++ b/drivers/clocksource/timer-gx6605s.c
@@ -0,0 +1,154 @@
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
+	struct clock_event_device *ce = dev;
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
+	writel_relaxed(GX6605S_CONFIG_EN | GX6605S_CONFIG_IRQ_EN,
+		       base + TIMER_CONFIG);
+
+	return 0;
+}
+
+static int gx6605s_timer_set_next_event(unsigned long delta,
+					struct clock_event_device *ce)
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
+	return (u64)readl_relaxed(base + TIMER_VALUE);
+}
+
+static void gx6605s_clkevt_init(void __iomem *base)
+{
+	writel_relaxed(0, base + TIMER_DIV);
+	writel_relaxed(0, base + TIMER_CONFIG);
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 2,
+					ULONG_MAX);
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
+	return clocksource_mmio_init(base + TIMER_VALUE, "gx6605s",
+			timer_of_rate(&to), 200, 32, clocksource_mmio_readl_up);
+}
+
+static int __init gx6605s_timer_init(struct device_node *np)
+{
+	int ret;
+
+	/*
+	 * The timer driver is for nationalchip gx6605s SOC and there are two
+	 * same timer in gx6605s. We use one for clkevt and another for clksrc.
+	 *
+	 * The timer is mmio map to access, so we need give mmio address in dts.
+	 *
+	 * It provides a 32bit countup timer and interrupt will be caused by
+	 * count-overflow.
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

