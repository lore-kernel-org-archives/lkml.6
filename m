Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830C2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA1A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ay5NXzLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA1A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406974AbeKTDgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:36:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39109 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406280AbeKTDgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:36:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so1846986pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLrla1sylzw8LCOsFt1CrI+2VOlTOfZdNLUHwh/WN8I=;
        b=ay5NXzLI6iKzNK/liQu7rXLcPQhUO7jEaKsc0lOKOxVa4hvmwr7/aTBQsNHLq1tbH1
         GqJWXv65jtPrqYKF51cR0VAWehWohZzCe1G06tyYrMWy6a9gLEuhQyRwrY5m0D2A3COa
         mULbOVIo/k4EvVFj7hG4wEao9jvEiXQuvl5cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLrla1sylzw8LCOsFt1CrI+2VOlTOfZdNLUHwh/WN8I=;
        b=neHHRSN04/mBahoAoQb/fk9qRxKPutVu7U3ZT6lCWq2loo3XCFJ9YVVmtPEFtGnxFw
         w7eYOb7//xeP17EvEzy1WMl3lp8u+NZKp6wZj8ehD8vkMLWFfxB2edIgnx1tSVOtdBAr
         gK3J0smIphlgh6U7U2UDRHv9j1AbASDSRAOHgyXl1gfwp0O+6XRVF9oruwEZgoAiHfcL
         V5jKg/Gq6lKlMj4C96ldLSrvZE1+nAYicU7nNojZgMMFurjLhAvD0PAAfgBupSVsN/ZU
         HPVdeAgh1ZQxDER3WJAxkJQeS7KF1HVtodVgl91/WRE/8niJE5+0Q3rTlet3FdlyVNAf
         S9MQ==
X-Gm-Message-State: AGRZ1gKpmUCU+IdWh/KB5aKvZibHxZrySD/jtKBLdoutbtNzNB73SeSW
        sywfTIzOM41op28f27n4Bzm5
X-Google-Smtp-Source: AJdET5cPkAND+fXBVOU293D4MH/nCneHofhFH+5vJ08raVHPv6swNW24fScGuJYRJfN4t2AEVI/uZw==
X-Received: by 2002:a63:eb0e:: with SMTP id t14mr21050602pgh.445.1542647546849;
        Mon, 19 Nov 2018 09:12:26 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:12:25 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 12/16] clocksource: Add clock driver for RDA8810PL SoC
Date:   Mon, 19 Nov 2018 22:39:35 +0530
Message-Id: <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
and HWTIMER.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/mach-rda/Kconfig       |   1 +
 drivers/clocksource/Kconfig     |   7 ++
 drivers/clocksource/Makefile    |   1 +
 drivers/clocksource/timer-rda.c | 187 ++++++++++++++++++++++++++++++++
 4 files changed, 196 insertions(+)
 create mode 100644 drivers/clocksource/timer-rda.c

diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
index 29012bc68ca4..1ea753f57b2d 100644
--- a/arch/arm/mach-rda/Kconfig
+++ b/arch/arm/mach-rda/Kconfig
@@ -4,5 +4,6 @@ menuconfig ARCH_RDA
 	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
 	select RDA_INTC
+	select RDA_TIMER
 	help
 	  This enables support for the RDA Micro 8810PL SoC family.
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 55c77e44bb2d..f51eee3a72ea 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -105,6 +105,13 @@ config OWL_TIMER
 	help
 	  Enables the support for the Actions Semi Owl timer driver.
 
+config RDA_TIMER
+	bool "RDA timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	help
+	  Enables the support for the RDA Micro timer driver.
+
 config SUN4I_TIMER
 	bool "Sun4i timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index dd9138104568..150020a90707 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
 obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
+obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
 
 obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
diff --git a/drivers/clocksource/timer-rda.c b/drivers/clocksource/timer-rda.c
new file mode 100644
index 000000000000..3aa684d92c5d
--- /dev/null
+++ b/drivers/clocksource/timer-rda.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RDA8810PL SoC timer driver
+ *
+ * Copyright RDA Microelectronics Company Limited
+ * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ */
+
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define RDA_OSTIMER_LOADVAL_L	0x000
+#define RDA_OSTIMER_CTRL	0x004
+#define RDA_HWTIMER_LOCKVAL_L	0x024
+#define RDA_HWTIMER_LOCKVAL_H	0x028
+#define RDA_TIMER_IRQ_MASK_SET	0x02c
+#define RDA_TIMER_IRQ_CLR	0x034
+
+#define RDA_OSTIMER_CTRL_ENABLE		BIT(24)
+#define RDA_OSTIMER_CTRL_REPEAT		BIT(28)
+#define RDA_OSTIMER_CTRL_LOAD		BIT(30)
+
+#define RDA_TIMER_IRQ_MASK_SET_OSTIMER	BIT(0)
+
+#define RDA_TIMER_IRQ_CLR_OSTIMER	BIT(0)
+
+static void __iomem *rda_timer_base;
+
+static u64 rda_hwtimer_read(struct clocksource *cs)
+{
+	u32 lo, hi;
+
+	/* Always read low 32 bits first */
+	lo = readl(rda_timer_base + RDA_HWTIMER_LOCKVAL_L);
+	hi = readl(rda_timer_base + RDA_HWTIMER_LOCKVAL_H);
+
+	return ((u64)hi << 32) | lo;
+}
+
+static struct clocksource rda_clocksource = {
+	.name           = "rda-timer",
+	.rating         = 400,
+	.read           = rda_hwtimer_read,
+	.mask           = CLOCKSOURCE_MASK(64),
+	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int rda_ostimer_start(bool periodic, u64 cycles)
+{
+	u32 ctrl, load_l;
+
+	load_l = (u32)cycles;
+	ctrl = ((cycles >> 32) & 0xffffff);
+	ctrl |= RDA_OSTIMER_CTRL_LOAD | RDA_OSTIMER_CTRL_ENABLE;
+	if (periodic)
+		ctrl |= RDA_OSTIMER_CTRL_REPEAT;
+
+	/* Enable ostimer interrupt first */
+	writel(RDA_TIMER_IRQ_MASK_SET_OSTIMER,
+	       rda_timer_base + RDA_TIMER_IRQ_MASK_SET);
+
+	/* Write low 32 bits first, high 24 bits are with ctrl */
+	writel(load_l, rda_timer_base + RDA_OSTIMER_LOADVAL_L);
+	writel(ctrl, rda_timer_base + RDA_OSTIMER_CTRL);
+
+	return 0;
+}
+
+static int rda_ostimer_stop(void)
+{
+	/* Disable ostimer interrupt first */
+	writel(0, rda_timer_base + RDA_TIMER_IRQ_MASK_SET);
+
+	writel(0, rda_timer_base + RDA_OSTIMER_CTRL);
+
+	return 0;
+}
+
+static int rda_ostimer_set_state_shutdown(struct clock_event_device *evt)
+{
+	rda_ostimer_stop();
+
+	return 0;
+}
+
+static int rda_ostimer_set_state_oneshot(struct clock_event_device *evt)
+{
+	rda_ostimer_stop();
+
+	return 0;
+}
+
+static int rda_ostimer_set_state_periodic(struct clock_event_device *evt)
+{
+	unsigned long cycles_per_jiffy;
+
+	rda_ostimer_stop();
+
+	cycles_per_jiffy = ((unsigned long long)NSEC_PER_SEC / HZ *
+			     evt->mult) >> evt->shift;
+	rda_ostimer_start(true, cycles_per_jiffy);
+
+	return 0;
+}
+
+static int rda_ostimer_tick_resume(struct clock_event_device *evt)
+{
+	return 0;
+}
+
+static int rda_ostimer_set_next_event(unsigned long evt,
+				      struct clock_event_device *ev)
+{
+	rda_ostimer_start(false, evt);
+
+	return 0;
+}
+
+static struct clock_event_device rda_clockevent = {
+	.name			= "rda-ostimer",
+	.rating			= 250,
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_DYNIRQ,
+	.set_state_shutdown	= rda_ostimer_set_state_shutdown,
+	.set_state_oneshot	= rda_ostimer_set_state_oneshot,
+	.set_state_periodic	= rda_ostimer_set_state_periodic,
+	.tick_resume		= rda_ostimer_tick_resume,
+	.set_next_event		= rda_ostimer_set_next_event,
+};
+
+static irqreturn_t rda_ostimer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	/* clear timer int */
+	writel(RDA_TIMER_IRQ_CLR_OSTIMER, rda_timer_base + RDA_TIMER_IRQ_CLR);
+
+	if (evt->event_handler)
+		evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init rda_timer_init(struct device_node *node)
+{
+	unsigned long rate = 2000000;
+	int ostimer_irq, ret;
+
+	rda_timer_base = of_io_request_and_map(node, 0, "rda-timer");
+	if (IS_ERR(rda_timer_base)) {
+		pr_err("Can't map timer registers");
+		return PTR_ERR(rda_timer_base);
+	}
+
+	ostimer_irq = of_irq_get_byname(node, "ostimer");
+	if (ostimer_irq <= 0) {
+		pr_err("Can't parse ostimer IRQ");
+		return -EINVAL;
+	}
+
+	clocksource_register_hz(&rda_clocksource, rate);
+
+	ret = request_irq(ostimer_irq, rda_ostimer_interrupt, IRQF_TIMER,
+			  "rda-ostimer", &rda_clockevent);
+	if (ret) {
+		pr_err("failed to request irq %d\n", ostimer_irq);
+		return ret;
+	}
+
+	irq_force_affinity(ostimer_irq, cpumask_of(0));
+
+	rda_clockevent.cpumask = cpumask_of(0);
+	rda_clockevent.irq = ostimer_irq;
+	clockevents_config_and_register(&rda_clockevent, rate,
+					0x2, 0xffffffff);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(rda8810pl, "rda,8810pl-timer", rda_timer_init);
-- 
2.17.1

