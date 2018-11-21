Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5F6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476C82146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBjWOn2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476C82146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeKUOLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:11:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44843 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbeKUOLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:11:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so3373940plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Efya42UCb3BE2KNWrnRhdK5xhCoBC05T+KCgnOfUqgk=;
        b=DBjWOn2VoMfoIN9pF3xPMNPtOWvhXofwx127pFmwjYJKNebwgLp4nRjDZ3EQN/LxsJ
         InYuRgfVReM/jM/vsa3XPMPP32FoaW2okD1hd5G9s4GyJ3E6X/+seo+/mAFAlv5tJYWW
         6iQKBwJZeciqzZhW6fA24RTH68lef40c7O434=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Efya42UCb3BE2KNWrnRhdK5xhCoBC05T+KCgnOfUqgk=;
        b=REQvMCmK7SuPB/SADnX7m/Au2wVTxUazBVcRxGTEiK2j2nJSpi2bJtpSywLEwhP5Na
         OsO8kZzkB4pzwp5IN+R7c2ryHsjcp7aquIdLpdJegKZseLS+uQQAmRkD0m52ydonqRU9
         TU2gxRYvSPVycLPnk7fs5FNCfb++opRKQEviSCk4w+FL2pZr/CeQ7yGN09DsxN28o+KY
         V/TasJLZZI/Ce5wXxmFegNcjX2YugMIlMgqavHeCTpuzQgDWZZeirqGDm6WHpC827jx9
         fhQsjbcS29GoxPXChCWwAraPWDO8XUwROpEDpGOOPPjGSs3xznmP3LCBh1w0qSy3SRC5
         xzvA==
X-Gm-Message-State: AA+aEWZ9BUx236dG9q6iQLhVLJKtkkOqslEXJ0dIAmz5H6xCHTqsjkuG
        2seOltRhlj/6w8IP77cr54V/
X-Google-Smtp-Source: AFSGD/Uq5QN6wGa9Mkm6/PCZy7yjiA+giRI3hfr1uaB/9jWgsb5C+fN4JT14Fhno70AUm6AHEC/agA==
X-Received: by 2002:a63:20e:: with SMTP id 14mr4397233pgc.161.1542771544621;
        Tue, 20 Nov 2018 19:39:04 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:39:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 11/15] clocksource: Add clock driver for RDA8810PL SoC
Date:   Wed, 21 Nov 2018 09:06:48 +0530
Message-Id: <20181121033652.12247-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
and HWTIMER.

RDA8810PL has two independent timers: OSTIMER (56 bit) and HWTIMER (64 bit).
Each timer provides optional interrupt support. In this driver, OSTIMER is
used for clockevents and HWTIMER is used for clocksource.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/mach-rda/Kconfig       |   1 +
 drivers/clocksource/Kconfig     |   8 ++
 drivers/clocksource/Makefile    |   1 +
 drivers/clocksource/timer-rda.c | 195 ++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+)
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
index 55c77e44bb2d..598b592e03d7 100644
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

