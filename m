Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936088AbeCBGif (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 01:38:35 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43746 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422701AbeCBGiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 01:38:15 -0500
X-Google-Smtp-Source: AG47ELsZlNoVrt5jCMNY1catgtH561DSY9bwMeMAuPfN4/9kwtyQumzw3ZLkhPdvR1/IJnqpYgRYBA==
From: Joel Stanley <joel@jms.id.au>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH 2/2] watchdog: Add Nuvoton NPCM watchdog driver
Date: Fri,  2 Mar 2018 17:07:46 +1030
Message-Id: <20180302063746.10993-3-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180302063746.10993-1-joel@jms.id.au>
References: <20180302063746.10993-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nuvoton NPCM750 has a watchdog implemented as a single register
inside the timer peripheral.

This driver exposes that watchdog as a standard watchdog device with
coarse timeout intervals, limited by the combination of prescaler and
counter that is provided by the hardware. The calculation is taken from
the Nuvoton vendor tree.

There is a pre-timeout IRQ that is wired up. This timeout always occurs
1024 clocks before the timeout.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/watchdog/Kconfig    |  11 +++
 drivers/watchdog/Makefile   |   1 +
 drivers/watchdog/npcm_wdt.c | 223 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+)
 create mode 100644 drivers/watchdog/npcm_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index aff773bcebdb..0c1cc68894e6 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -513,6 +513,17 @@ config COH901327_WATCHDOG
 	  This watchdog is used to reset the system and thus cannot be
 	  compiled as a module.
 
+config NPCM7XX_WATCHDOG
+	bool "NPCM750 watchdog"
+	depends on ARCH_NPCM || COMPILE_TEST
+	default y if ARCH_NPCM750
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include Watchdog timer support for the
+	  watchdog embedded into the NPCM7xx.
+	  This watchdog is used to reset the system and thus cannot be
+	  compiled as a module.
+
 config TWL4030_WATCHDOG
 	tristate "TWL4030 Watchdog"
 	depends on TWL4030_CORE
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 0474d38aa854..97a5afb5cad2 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_ORION_WATCHDOG) += orion_wdt.o
 obj-$(CONFIG_SUNXI_WATCHDOG) += sunxi_wdt.o
 obj-$(CONFIG_RN5T618_WATCHDOG) += rn5t618_wdt.o
 obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
+obj-$(CONFIG_NPCM7XX_WATCHDOG) += npcm_wdt.o
 obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
 obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
 obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
new file mode 100644
index 000000000000..71e3d4916514
--- /dev/null
+++ b/drivers/watchdog/npcm_wdt.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Nuvoton Technology corporation.
+// Copyright (c) 2018 IBM Corp.
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/watchdog.h>
+#include <asm/fiq.h>
+#include <linux/of_irq.h>
+
+#define NPCM_WTCR	0x1C
+
+#define NPCM_WTCLK	(BIT(10) | BIT(11))	/* Clock divider */
+#define NPCM_WTE	BIT(7)			/* Enable */
+#define NPCM_WTIE	BIT(6)			/* Enable irq */
+#define NPCM_WTIS	(BIT(4) | BIT(5))	/* Interval selection */
+#define NPCM_WTIF	BIT(3)			/* Interrupt flag*/
+#define NPCM_WTRF	BIT(2)			/* Reset flag */
+#define NPCM_WTRE	BIT(1)			/* Reset enable */
+#define NPCM_WTR	BIT(0)			/* Reset counter */
+
+/*
+ * Watchdog timeouts
+ *
+ * 170     msec:    WTCLK=01 WTIS=00     VAL= 0x400
+ * 670     msec:    WTCLK=01 WTIS=01     VAL= 0x410
+ * 1360    msec:    WTCLK=10 WTIS=00     VAL= 0x800
+ * 2700    msec:    WTCLK=01 WTIS=10     VAL= 0x420
+ * 5360    msec:    WTCLK=10 WTIS=01     VAL= 0x810
+ * 10700   msec:    WTCLK=01 WTIS=11     VAL= 0x430
+ * 21600   msec:    WTCLK=10 WTIS=10     VAL= 0x820
+ * 43000   msec:    WTCLK=11 WTIS=00     VAL= 0xC00
+ * 85600   msec:    WTCLK=10 WTIS=11     VAL= 0x830
+ * 172000  msec:    WTCLK=11 WTIS=01     VAL= 0xC10
+ * 687000  msec:    WTCLK=11 WTIS=10     VAL= 0xC20
+ * 2750000 msec:    WTCLK=11 WTIS=11     VAL= 0xC30
+ */
+
+struct npcm_wdt {
+	struct watchdog_device  wdd;
+	struct device		*dev;
+	void __iomem		*reg;
+};
+
+static inline struct npcm_wdt *to_npcm_wdt(struct watchdog_device *wdd)
+{
+	return container_of(wdd, struct npcm_wdt, wdd);
+}
+
+static int npcm_wdt_ping(struct watchdog_device *wdd)
+{
+	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
+	u32 val;
+
+	val = readl(wdt->reg);
+	writel(val | NPCM_WTR, wdt->reg);
+
+	return 0;
+}
+
+static int npcm_wdt_start(struct watchdog_device *wdd)
+{
+	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
+	u32 val;
+
+	val = NPCM_WTRE | NPCM_WTE | NPCM_WTR | NPCM_WTIE;
+
+	if (wdd->timeout < 2)
+		val |= 0x800;
+	else if (wdd->timeout < 3)
+		val |= 0x420;
+	else if (wdd->timeout < 6)
+		val |= 0x810;
+	else if (wdd->timeout < 11)
+		val |= 0x430;
+	else if (wdd->timeout < 22)
+		val |= 0x820;
+	else if (wdd->timeout < 44)
+		val |= 0xC00;
+	else if (wdd->timeout < 87)
+		val |= 0x830;
+	else if (wdd->timeout < 173)
+		val |= 0xC10;
+	else if (wdd->timeout < 688)
+		val |= 0xC20;
+	else if (wdd->timeout < 2751)
+		val |= 0xC30;
+	else
+		val |= 0x830;
+
+	writel(val, wdt->reg);
+
+	return 0;
+}
+
+static int npcm_wdt_stop(struct watchdog_device *wdd)
+{
+	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
+
+	writel(0, wdt->reg);
+
+	return 0;
+}
+
+
+static int npcm_wdt_set_timeout(struct watchdog_device *wdd,
+				unsigned int timeout)
+{
+	wdd->timeout = timeout;     /* New timeout */
+	if (watchdog_active(wdd))
+		npcm_wdt_start(wdd);
+
+	return 0;
+}
+
+static irqreturn_t npcm_wdt_interrupt(int irq, void *data)
+{
+	struct npcm_wdt *wdt = data;
+
+	watchdog_notify_pretimeout(&wdt->wdd);
+
+	return IRQ_HANDLED;
+}
+
+static int npcm_wdt_restart(struct watchdog_device *wdd,
+			    unsigned long action, void *data)
+{
+	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
+
+	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
+	udelay(1000);
+
+	return 0;
+}
+
+static const struct watchdog_info npcm_wdt_info = {
+	.identity	= KBUILD_MODNAME,
+	.options	= WDIOF_SETTIMEOUT
+			| WDIOF_KEEPALIVEPING
+			| WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops npcm_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = npcm_wdt_start,
+	.stop = npcm_wdt_stop,
+	.ping = npcm_wdt_ping,
+	.set_timeout = npcm_wdt_set_timeout,
+	.restart = npcm_wdt_restart,
+};
+
+static int npcm_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct npcm_wdt *wdt;
+	struct resource *res;
+	int irq;
+	int ret;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(wdt->reg))
+		return PTR_ERR(wdt->reg);
+
+	irq = platform_get_irq(pdev, 0);
+	if (!irq)
+		return -EINVAL;
+
+	wdt->dev = dev;
+	wdt->wdd.info = &npcm_wdt_info;
+	wdt->wdd.ops = &npcm_wdt_ops;
+	wdt->wdd.min_timeout = 1;
+	wdt->wdd.max_timeout = 2751;
+	wdt->wdd.parent = dev;
+
+	wdt->wdd.timeout = 86;
+	watchdog_init_timeout(&wdt->wdd, 0, dev);
+
+	ret = devm_request_irq(dev, irq, npcm_wdt_interrupt, 0,
+			"watchdog", wdt);
+	if (ret)
+		return ret;
+
+	ret = devm_watchdog_register_device(dev, &wdt->wdd);
+	if (ret) {
+		dev_err(dev, "failed to register watchdog\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, wdt);
+	dev_info(dev, "NPCM watchdog driver enabled\n");
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id npcm_wdt_match[] = {
+	{.compatible = "nuvoton,npcm750-wdt"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, npcm_wdt_match);
+#endif
+
+static struct platform_driver npcm_wdt_driver = {
+	.probe		= npcm_wdt_probe,
+	.driver		= {
+		.name	= "npcm-wdt",
+		.of_match_table = of_match_ptr(npcm_wdt_match),
+	},
+};
+module_platform_driver(npcm_wdt_driver);
+
+MODULE_AUTHOR("Joel Stanley");
+MODULE_DESCRIPTION("Watchdog driver for NPCM");
+MODULE_LICENSE("GPL");
-- 
2.15.1
