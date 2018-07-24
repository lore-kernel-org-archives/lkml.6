Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F62C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFDE20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="JdbKeVNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFDE20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389067AbeGYA3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:29:10 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39322 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389005AbeGYA3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:29:07 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH v5 06/21] clocksource: Add driver for the Ingenic JZ47xx OST
Date:   Wed, 25 Jul 2018 01:19:43 +0200
Message-Id: <20180724231958.20659-7-paul@crapouillou.net>
In-Reply-To: <20180724231958.20659-1-paul@crapouillou.net>
References: <20180724231958.20659-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532474418; bh=ip/16CcDtLzhuK729hY4nmw3s7kXi22NuEGFHa9cE1U=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JdbKeVNPOoyyTJObXmr7g/rvntAMWyqDKgkpVAoGhPHTIp2zzk9R0ncpXb0NKfZSlbbwyqrl1+GYu/xTRwpVp5tmtvHNb3o0LvjGVM+LuHiTNi57XFAxaDlHvUESsfS2RlZFS1UsYgqfchvOMFt4KEkMlOObNbBXhUEyWRlCy9k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten ter Huurne <maarten@treewalker.org>

OST is the OS Timer, a 64-bit timer/counter with buffered reading.

SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
JZ4780 have a 64-bit OST.

This driver will register both a clocksource and a sched_clock to the
system.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clocksource/Kconfig       |   8 ++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/ingenic-ost.c | 199 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 drivers/clocksource/ingenic-ost.c

 v5: New patch

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 98f708208a8d..e855938c69f1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -619,4 +619,12 @@ config INGENIC_TIMER
 	help
 	  Support for the timer/counter unit of the Ingenic JZ SoCs.
 
+config INGENIC_OST
+	bool "Ingenic JZ47xx Operating System Timer"
+	depends on MIPS || COMPILE_TEST
+	depends on COMMON_CLK
+	select INGENIC_TIMER
+	help
+	  Support for the OS Timer of the Ingenic JZ4770 or similar SoC.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 26877505d400..56ce37252944 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
+obj-$(CONFIG_INGENIC_OST)		+= ingenic-ost.o
 obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
new file mode 100644
index 000000000000..224e78926f29
--- /dev/null
+++ b/drivers/clocksource/ingenic-ost.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ47xx SoCs TCU Operating System Timer driver
+ *
+ * Copyright (C) 2016 Maarten ter Huurne <maarten@treewalker.org>
+ * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/mfd/ingenic-tcu.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/sched_clock.h>
+
+#include "ingenic-timer.h"
+
+#define TCU_OST_TCSR_MASK	0xc0
+#define TCU_OST_TCSR_CNT_MD	BIT(15)
+
+#define TCU_OST_CHANNEL		15
+
+enum jz_version {
+	ID_JZ4725B,
+	ID_JZ4770,
+};
+
+struct ingenic_ost {
+	enum jz_version version;
+
+	struct regmap *map;
+	struct clk *clk;
+
+	struct clocksource cs;
+};
+
+static u64 notrace ingenic_ost_read_cntl(void)
+{
+	/* Bypass the regmap here as we must return as soon as possible */
+	return readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
+}
+
+static u64 notrace ingenic_ost_read_cnth(void)
+{
+	/* Bypass the regmap here as we must return as soon as possible */
+	return readl(ingenic_tcu_base + TCU_REG_OST_CNTH);
+}
+
+static u64 notrace ingenic_ost_clocksource_read(struct clocksource *cs)
+{
+	u32 val1, val2;
+	u64 count, recount;
+	s64 diff;
+
+	/*
+	 * The buffering of the upper 32 bits of the timer prevents wrong
+	 * results from the bottom 32 bits overflowing due to the timer ticking
+	 * along. However, it does not prevent wrong results from simultaneous
+	 * reads of the timer, which could reset the buffer mid-read.
+	 * Since this kind of wrong read can happen only when the bottom bits
+	 * overflow, there will be minutes between wrong reads, so if we read
+	 * twice in succession, at least one of the reads will be correct.
+	 */
+
+	/* Bypass the regmap here as we must return as soon as possible */
+	val1 = readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
+	val2 = readl(ingenic_tcu_base + TCU_REG_OST_CNTHBUF);
+	count = (u64)val1 | (u64)val2 << 32;
+
+	val1 = readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
+	val2 = readl(ingenic_tcu_base + TCU_REG_OST_CNTHBUF);
+	recount = (u64)val1 | (u64)val2 << 32;
+
+	/*
+	 * A wrong read will produce a result that is 1<<32 too high: the bottom
+	 * part from before overflow and the upper part from after overflow.
+	 * Therefore, the lower value of the two reads is the correct value.
+	 */
+
+	diff = (s64)(recount - count);
+	if (unlikely(diff < 0))
+		count = recount;
+
+	return count;
+}
+
+static const struct of_device_id ingenic_ost_of_match[] = {
+	{ .compatible = "ingenic,jz4725b-ost", .data = (void *)ID_JZ4725B, },
+	{ .compatible = "ingenic,jz4770-ost",  .data = (void *)ID_JZ4770,  },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ingenic_ost_of_match);
+
+static int __init ingenic_ost_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ingenic_ost *ost;
+	struct clocksource *cs;
+	unsigned long rate, flags;
+	int err;
+
+	ost = devm_kzalloc(dev, sizeof(*ost), GFP_KERNEL);
+	if (!ost)
+		return -ENOMEM;
+
+	ost->map = dev_get_regmap(dev->parent, NULL);
+	if (IS_ERR(ost->map))
+		return PTR_ERR(ost->map);
+
+	ost->clk = devm_clk_get(dev, "ost");
+	if (IS_ERR(ost->clk))
+		return PTR_ERR(ost->clk);
+
+	ost->version = (enum jz_version)of_device_get_match_data(dev);
+
+	err = clk_prepare_enable(ost->clk);
+	if (err)
+		return err;
+
+	/* Clear counter high/low registers */
+	if (ost->version == ID_JZ4770)
+		regmap_write(ost->map, TCU_REG_OST_CNTL, 0);
+	regmap_write(ost->map, TCU_REG_OST_CNTH, 0);
+
+	/* Don't reset counter at compare value. */
+	regmap_update_bits(ost->map, TCU_REG_OST_TCSR,
+			   TCU_OST_TCSR_MASK, TCU_OST_TCSR_CNT_MD);
+
+	rate = clk_get_rate(ost->clk);
+
+	/* Enable OST TCU channel */
+	regmap_write(ost->map, TCU_REG_TESR, BIT(TCU_OST_CHANNEL));
+
+	cs = &ost->cs;
+	cs->name	= "ingenic-ost";
+	cs->rating	= 320;
+	cs->flags	= CLOCK_SOURCE_IS_CONTINUOUS;
+
+	if (ost->version == ID_JZ4770) {
+		cs->mask = CLOCKSOURCE_MASK(64);
+		cs->read = ingenic_ost_clocksource_read;
+	} else {
+		cs->mask = CLOCKSOURCE_MASK(32);
+		cs->read = (u64 (*)(struct clocksource *))ingenic_ost_read_cnth;
+	}
+
+	err = clocksource_register_hz(cs, rate);
+	if (err) {
+		dev_err(dev, "clocksource registration failed: %d\n", err);
+		clk_disable_unprepare(ost->clk);
+		return err;
+	}
+
+	/* Cannot register a sched_clock with interrupts on */
+	local_irq_save(flags);
+	if (ost->version == ID_JZ4770)
+		sched_clock_register(ingenic_ost_read_cntl, 32, rate);
+	else
+		sched_clock_register(ingenic_ost_read_cnth, 32, rate);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ingenic_ost_suspend(struct device *dev)
+{
+	struct ingenic_ost *ost = dev_get_drvdata(dev);
+
+	clk_disable(ost->clk);
+	return 0;
+}
+
+static int ingenic_ost_resume(struct device *dev)
+{
+	struct ingenic_ost *ost = dev_get_drvdata(dev);
+
+	return clk_enable(ost->clk);
+}
+
+static SIMPLE_DEV_PM_OPS(ingenic_ost_pm_ops, ingenic_ost_suspend,
+			 ingenic_ost_resume);
+#define INGENIC_OST_PM_OPS (&ingenic_ost_pm_ops)
+#else
+#define INGENIC_OST_PM_OPS NULL
+#endif /* CONFIG_PM_SUSPEND */
+
+static struct platform_driver ingenic_ost_driver = {
+	.probe = ingenic_ost_probe,
+	.driver = {
+		.name	= "ingenic-ost",
+		.pm	= INGENIC_OST_PM_OPS,
+		.of_match_table = ingenic_ost_of_match,
+	},
+};
+module_platform_driver(ingenic_ost_driver);
-- 
2.11.0

