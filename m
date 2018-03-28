Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753972AbeC1POa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:14:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42804 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbeC1POT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:14:19 -0400
X-Google-Smtp-Source: AIpwx49vM4rUg3/aCsNoZNkzNuB9hvdnBLsXKMxdULzb+EP6hnJH9Is4RkdVvKu/cp7iDBEjtxbUZg==
From: Tim Harvey <tharvey@gateworks.com>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 4/4] watchdog: add Gateworks System Controller support
Date: Wed, 28 Mar 2018 08:14:03 -0700
Message-Id: <1522250043-8065-5-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
References: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/watchdog/Kconfig   |  10 ++++
 drivers/watchdog/Makefile  |   1 +
 drivers/watchdog/gsc_wdt.c | 146 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 drivers/watchdog/gsc_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ca200d1..c9d4b2e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -150,6 +150,16 @@ config GPIO_WATCHDOG_ARCH_INITCALL
 	  arch_initcall.
 	  If in doubt, say N.
 
+config GSC_WATCHDOG
+	tristate "Gateworks System Controller (GSC) Watchdog support"
+	depends on MFD_GATEWORKS_GSC
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the GSC Watchdog.
+
+	  This driver can also be built as a module. If so the module
+	  will be called gsc_wdt.
+
 config MENF21BMC_WATCHDOG
 	tristate "MEN 14F021P00 BMC Watchdog"
 	depends on MFD_MENF21BMC || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 715a210..499327e 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -215,6 +215,7 @@ obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
 obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
 obj-$(CONFIG_DA9063_WATCHDOG) += da9063_wdt.o
 obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
+obj-$(CONFIG_GSC_WATCHDOG)	+= gsc_wdt.o
 obj-$(CONFIG_TANGOX_WATCHDOG) += tangox_wdt.o
 obj-$(CONFIG_WDAT_WDT) += wdat_wdt.o
 obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
diff --git a/drivers/watchdog/gsc_wdt.c b/drivers/watchdog/gsc_wdt.c
new file mode 100644
index 0000000..b43d083
--- /dev/null
+++ b/drivers/watchdog/gsc_wdt.c
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2018 Gateworks Corporation
+ *
+ * This driver registers a Linux Watchdog for the GSC
+ */
+#include <linux/mfd/gsc.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+#define WDT_DEFAULT_TIMEOUT	60
+
+struct gsc_wdt {
+	struct watchdog_device wdt_dev;
+	struct gsc_dev *gsc;
+};
+
+static int gsc_wdt_start(struct watchdog_device *wdd)
+{
+	struct gsc_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned int reg = (1 << GSC_CTRL_1_WDT_ENABLE);
+	int ret;
+
+	dev_dbg(wdd->parent, "%s timeout=%d\n", __func__, wdd->timeout);
+
+	/* clear first as regmap_update_bits will not write if no change */
+	ret = regmap_update_bits(wdt->gsc->regmap, GSC_CTRL_1, reg, 0);
+	if (ret)
+		return ret;
+	return regmap_update_bits(wdt->gsc->regmap, GSC_CTRL_1, reg, reg);
+}
+
+static int gsc_wdt_stop(struct watchdog_device *wdd)
+{
+	struct gsc_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned int reg = (1 << GSC_CTRL_1_WDT_ENABLE);
+
+	dev_dbg(wdd->parent, "%s\n", __func__);
+
+	return regmap_update_bits(wdt->gsc->regmap, GSC_CTRL_1, reg, 0);
+}
+
+static int gsc_wdt_set_timeout(struct watchdog_device *wdd,
+			       unsigned int timeout)
+{
+	struct gsc_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned int long_sel = 0;
+
+	dev_dbg(wdd->parent, "%s: %d\n", __func__, timeout);
+
+	switch (timeout) {
+	case 60:
+		long_sel = (1 << GSC_CTRL_1_WDT_TIME);
+	case 30:
+		regmap_update_bits(wdt->gsc->regmap, GSC_CTRL_1,
+				   (1 << GSC_CTRL_1_WDT_TIME),
+				   (long_sel << GSC_CTRL_1_WDT_TIME));
+		wdd->timeout = timeout;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static const struct watchdog_info gsc_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "GSC Watchdog"
+};
+
+static const struct watchdog_ops gsc_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= gsc_wdt_start,
+	.stop		= gsc_wdt_stop,
+	.set_timeout	= gsc_wdt_set_timeout,
+};
+
+static int gsc_wdt_probe(struct platform_device *pdev)
+{
+	struct gsc_dev *gsc = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct gsc_wdt *wdt;
+	int ret;
+	unsigned int reg;
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	/* ensure GSC fw supports WD functionality */
+	if (gsc->fwver < 44) {
+		dev_err(dev, "fw v44 or newer required for wdt function\n");
+		return -EINVAL;
+	}
+
+	/* ensure WD bit enabled */
+	if (regmap_read(gsc->regmap, GSC_CTRL_1, &reg))
+		return -EIO;
+	if (!(reg & (1 << GSC_CTRL_1_WDT_ENABLE))) {
+		dev_err(dev, "not enabled - must be manually enabled\n");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, wdt);
+
+	wdt->gsc = gsc;
+	wdt->wdt_dev.info = &gsc_wdt_info;
+	wdt->wdt_dev.ops = &gsc_wdt_ops;
+	wdt->wdt_dev.status = 0;
+	wdt->wdt_dev.min_timeout = 30;
+	wdt->wdt_dev.max_timeout = 60;
+	wdt->wdt_dev.parent = dev;
+
+	watchdog_set_nowayout(&wdt->wdt_dev, 1);
+	watchdog_init_timeout(&wdt->wdt_dev, WDT_DEFAULT_TIMEOUT, dev);
+
+	watchdog_set_drvdata(&wdt->wdt_dev, wdt);
+	ret = devm_watchdog_register_device(dev, &wdt->wdt_dev);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "watchdog driver (timeout=%d sec)\n",
+		 wdt->wdt_dev.timeout);
+
+	return 0;
+}
+
+static const struct of_device_id gsc_wdt_dt_ids[] = {
+	{ .compatible = "gw,gsc-watchdog", },
+	{}
+};
+
+static struct platform_driver gsc_wdt_driver = {
+	.probe		= gsc_wdt_probe,
+	.driver		= {
+		.name	= "gsc-wdt",
+		.of_match_table = gsc_wdt_dt_ids,
+	},
+};
+
+module_platform_driver(gsc_wdt_driver);
+
+MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
+MODULE_DESCRIPTION("Gateworks System Controller Watchdog driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
