Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CA8218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/DFQRJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeLRV3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36706 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeLRV3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so16445432wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9na8wrimAOJy2qcVvWt2fiFxxnkVPKFvxqnrSeY6pZQ=;
        b=i/DFQRJYiWRPqBpBsp9vecxnwDpC7/4hmCHx3jN5+8HFbm1wh3eWHEPkBpf4J7m/sV
         VWsrV6z9NssZHw0tNL4i70goP/zwHERlZAAbj0r7g9K978vgpd/N9l/1amnxHWyXwDnx
         q2yolA3EXODE+xQ22IsAvcv0Y4G1448UKKRqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9na8wrimAOJy2qcVvWt2fiFxxnkVPKFvxqnrSeY6pZQ=;
        b=aOq1siVcEqN/rKxhdGeB5OoV5sJTfHUjrP+QcZuMvZHWzHabus5QwzZrGYem02yUSa
         NZW/6PvN0k7buF6dOFGqQWG+Ck907TjtQGKpTkmafrTh2jeOb7xKYh+xzFzW7KzfOjmY
         jN3zH++qOospxVFf3y1R7RM79kaVJBqLiroZAfHuvXl4FPnHPlVNJmWdgGwuTzYMxsAg
         KtdMeFCoN9D3Fs/WmEO2DdyesOEJVUsvDVPsh8n4Dt1Ptthl76cVH1TFog5azwW887QL
         PH3qm8Btwty676c0sr8LKsjIvggMfQqarXm0vBnZzk5sedw061D+t+n1Yj9fEWE8A074
         0Fig==
X-Gm-Message-State: AA+aEWaitem70BK88kciwFqG/NmKPSLRe3Ijsj6fZtB2uTsXBR644XVu
        Ldybx9O0hR9V33equx8fcA1L8gpb5dA=
X-Google-Smtp-Source: AFSGD/XFJwcaj/Mu/wuXxwgUgHnEo2N/PLhvXezXVJ0od+8TPgwSxHTqIt3W/zSJfzvPTa7bcOUUXA==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr16453198wrr.253.1545168590687;
        Tue, 18 Dec 2018 13:29:50 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:50 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 25/25] clocksource/drivers/rda: Add clock driver for RDA8810PL SoC
Date:   Tue, 18 Dec 2018 22:28:43 +0100
Message-Id: <20181218212844.30445-25-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
and HWTIMER.

RDA8810PL has two independent timers: OSTIMER (56 bit) and HWTIMER
(64 bit). Each timer provides optional interrupt support. In this
driver, OSTIMER is used for clockevents and HWTIMER is used for
clocksource.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig     |   8 ++
 drivers/clocksource/Makefile    |   1 +
 drivers/clocksource/timer-rda.c | 195 ++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 drivers/clocksource/timer-rda.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a4ae339e0101..a9e26f6a81a1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -105,6 +105,14 @@ config OWL_TIMER
 	help
 	  Enables the support for the Actions Semi Owl timer driver.
 
+config RDA_TIMER
+	bool "RDA timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  Enables the support for the RDA Micro timer driver.
+
 config SUN4I_TIMER
 	bool "Sun4i timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index f475927d5140..cdd210ff89ea 100644
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
index 000000000000..fd1199c189bf
--- /dev/null
+++ b/drivers/clocksource/timer-rda.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RDA8810PL SoC timer driver
+ *
+ * Copyright RDA Microelectronics Company Limited
+ * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ *
+ * RDA8810PL has two independent timers: OSTIMER (56 bit) and HWTIMER (64 bit).
+ * Each timer provides optional interrupt support. In this driver, OSTIMER is
+ * used for clockevents and HWTIMER is used for clocksource.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+
+#include "timer-of.h"
+
+#define RDA_OSTIMER_LOADVAL_L	0x000
+#define RDA_OSTIMER_CTRL	0x004
+#define RDA_HWTIMER_LOCKVAL_L	0x024
+#define RDA_HWTIMER_LOCKVAL_H	0x028
+#define RDA_TIMER_IRQ_MASK_SET	0x02c
+#define RDA_TIMER_IRQ_MASK_CLR	0x030
+#define RDA_TIMER_IRQ_CLR	0x034
+
+#define RDA_OSTIMER_CTRL_ENABLE		BIT(24)
+#define RDA_OSTIMER_CTRL_REPEAT		BIT(28)
+#define RDA_OSTIMER_CTRL_LOAD		BIT(30)
+
+#define RDA_TIMER_IRQ_MASK_OSTIMER	BIT(0)
+
+#define RDA_TIMER_IRQ_CLR_OSTIMER	BIT(0)
+
+static int rda_ostimer_start(void __iomem *base, bool periodic, u64 cycles)
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
+	writel_relaxed(RDA_TIMER_IRQ_MASK_OSTIMER,
+		       base + RDA_TIMER_IRQ_MASK_SET);
+
+	/* Write low 32 bits first, high 24 bits are with ctrl */
+	writel_relaxed(load_l, base + RDA_OSTIMER_LOADVAL_L);
+	writel_relaxed(ctrl, base + RDA_OSTIMER_CTRL);
+
+	return 0;
+}
+
+static int rda_ostimer_stop(void __iomem *base)
+{
+	/* Disable ostimer interrupt first */
+	writel_relaxed(RDA_TIMER_IRQ_MASK_OSTIMER,
+		       base + RDA_TIMER_IRQ_MASK_CLR);
+
+	writel_relaxed(0, base + RDA_OSTIMER_CTRL);
+
+	return 0;
+}
+
+static int rda_ostimer_set_state_shutdown(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+
+	rda_ostimer_stop(timer_of_base(to));
+
+	return 0;
+}
+
+static int rda_ostimer_set_state_oneshot(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+
+	rda_ostimer_stop(timer_of_base(to));
+
+	return 0;
+}
+
+static int rda_ostimer_set_state_periodic(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+	unsigned long cycles_per_jiffy;
+
+	rda_ostimer_stop(timer_of_base(to));
+
+	cycles_per_jiffy = ((unsigned long long)NSEC_PER_SEC / HZ *
+			     evt->mult) >> evt->shift;
+	rda_ostimer_start(timer_of_base(to), true, cycles_per_jiffy);
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
+	struct timer_of *to = to_timer_of(ev);
+
+	rda_ostimer_start(timer_of_base(to), false, evt);
+
+	return 0;
+}
+
+static irqreturn_t rda_ostimer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct timer_of *to = to_timer_of(evt);
+
+	/* clear timer int */
+	writel_relaxed(RDA_TIMER_IRQ_CLR_OSTIMER,
+		       timer_of_base(to) + RDA_TIMER_IRQ_CLR);
+
+	if (evt->event_handler)
+		evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct timer_of rda_ostimer_of = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE,
+
+	.clkevt = {
+		.name = "rda-ostimer",
+		.rating = 250,
+		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+			    CLOCK_EVT_FEAT_DYNIRQ,
+		.set_state_shutdown = rda_ostimer_set_state_shutdown,
+		.set_state_oneshot = rda_ostimer_set_state_oneshot,
+		.set_state_periodic = rda_ostimer_set_state_periodic,
+		.tick_resume = rda_ostimer_tick_resume,
+		.set_next_event	= rda_ostimer_set_next_event,
+	},
+
+	.of_base = {
+		.name = "rda-timer",
+		.index = 0,
+	},
+
+	.of_irq = {
+		.name = "ostimer",
+		.handler = rda_ostimer_interrupt,
+		.flags = IRQF_TIMER,
+	},
+};
+
+static u64 rda_hwtimer_read(struct clocksource *cs)
+{
+	void __iomem *base = timer_of_base(&rda_ostimer_of);
+	u32 lo, hi;
+
+	/* Always read low 32 bits first */
+	do {
+		lo = readl_relaxed(base + RDA_HWTIMER_LOCKVAL_L);
+		hi = readl_relaxed(base + RDA_HWTIMER_LOCKVAL_H);
+	} while (hi != readl_relaxed(base + RDA_HWTIMER_LOCKVAL_H));
+
+	return ((u64)hi << 32) | lo;
+}
+
+static struct clocksource rda_hwtimer_clocksource = {
+	.name           = "rda-timer",
+	.rating         = 400,
+	.read           = rda_hwtimer_read,
+	.mask           = CLOCKSOURCE_MASK(64),
+	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int __init rda_timer_init(struct device_node *np)
+{
+	unsigned long rate = 2000000;
+	int ret;
+
+	ret = timer_of_init(np, &rda_ostimer_of);
+	if (ret)
+		return ret;
+
+	clocksource_register_hz(&rda_hwtimer_clocksource, rate);
+
+	clockevents_config_and_register(&rda_ostimer_of.clkevt, rate,
+					0x2, UINT_MAX);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(rda8810pl, "rda,8810pl-timer", rda_timer_init);
-- 
2.17.1

