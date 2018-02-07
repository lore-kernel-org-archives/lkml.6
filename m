Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754386AbeBGNr3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:47:29 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38727 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754151AbeBGNqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:46:09 -0500
X-Google-Smtp-Source: AH8x2277xdRaeQJNAlu7NdlSbV8pxeV2zJfHRmgVPL6EU3p+r19Cq0QDPu22cle25+b8MTy/W3Mo0g==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/7] soc: davinci: new genpd driver
Date: Wed,  7 Feb 2018 14:45:48 +0100
Message-Id: <20180207134553.13510-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a simple clock_pm-based driver for DaVinci SoCs. This is required
to complete the transision to using the common clock framework for this
architecture.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/soc/Kconfig                      |   1 +
 drivers/soc/Makefile                     |   1 +
 drivers/soc/davinci/Kconfig              |  16 ++++
 drivers/soc/davinci/Makefile             |   1 +
 drivers/soc/davinci/davinci_pm_domains.c | 125 +++++++++++++++++++++++++++++++
 5 files changed, 144 insertions(+)
 create mode 100644 drivers/soc/davinci/Kconfig
 create mode 100644 drivers/soc/davinci/Makefile
 create mode 100644 drivers/soc/davinci/davinci_pm_domains.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index fc9e98047421..f318899a6cf6 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -4,6 +4,7 @@ source "drivers/soc/actions/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
+source "drivers/soc/davinci/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index deecb16e7256..8e5fe23d6678 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
+obj-$(CONFIG_ARCH_DAVINCI)	+= davinci/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_MXC)		+= imx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
diff --git a/drivers/soc/davinci/Kconfig b/drivers/soc/davinci/Kconfig
new file mode 100644
index 000000000000..7ee44f4ff41e
--- /dev/null
+++ b/drivers/soc/davinci/Kconfig
@@ -0,0 +1,16 @@
+#
+# TI DaVinci SOC drivers
+#
+menuconfig SOC_DAVINCI
+	bool "TI DaVinci SOC drivers support"
+
+if SOC_DAVINCI
+
+config DAVINCI_PM_DOMAINS
+	tristate "TI DaVinci PM Domains Driver"
+	depends on ARCH_DAVINCI
+	depends on PM_GENERIC_DOMAINS
+	help
+	  Generic power domains driver for TI DaVinci family of SoCs.
+
+endif # SOC_DAVINCI
diff --git a/drivers/soc/davinci/Makefile b/drivers/soc/davinci/Makefile
new file mode 100644
index 000000000000..822b03c18260
--- /dev/null
+++ b/drivers/soc/davinci/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DAVINCI_PM_DOMAINS)        += davinci_pm_domains.o
diff --git a/drivers/soc/davinci/davinci_pm_domains.c b/drivers/soc/davinci/davinci_pm_domains.c
new file mode 100644
index 000000000000..c27d4c404d52
--- /dev/null
+++ b/drivers/soc/davinci/davinci_pm_domains.c
@@ -0,0 +1,125 @@
+/*
+ * TI DaVinci Generic Power Domain Driver
+ *
+ * Copyright (C) 2018 BayLibre SAS
+ *         Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_clock.h>
+
+struct davinci_genpd_ctx {
+	struct device *dev;
+	struct generic_pm_domain pd;
+	struct clk *pm_clk;
+};
+
+static int davinci_genpd_attach_dev(struct generic_pm_domain *domain,
+				    struct device *dev)
+{
+	struct davinci_genpd_ctx *ctx;
+	struct clk *clk;
+	int rv;
+
+	ctx = container_of(domain, struct davinci_genpd_ctx, pd);
+
+	if (dev->pm_domain)
+		return -EEXIST;
+
+	/*
+	 * DaVinci always uses a single clock for power-management. We assume
+	 * it's the first one in the clocks property.
+	 */
+	clk = of_clk_get(dev->of_node, 0);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	rv = pm_clk_create(dev);
+	if (rv) {
+		clk_put(clk);
+		return rv;
+	}
+
+	rv = pm_clk_add_clk(dev, clk);
+	if (rv) {
+		pm_clk_destroy(dev);
+		return rv;
+	}
+
+	dev_pm_domain_set(dev, &domain->domain);
+	ctx->pm_clk = clk;
+
+	return 0;
+}
+
+static void davinci_genpd_detach_dev(struct generic_pm_domain *domain,
+				     struct device *dev)
+{
+	struct davinci_genpd_ctx *ctx;
+
+	ctx = container_of(domain, struct davinci_genpd_ctx, pd);
+
+	pm_clk_remove_clk(dev, ctx->pm_clk);
+	pm_clk_destroy(dev);
+}
+
+static const struct of_device_id davinci_genpd_matches[] = {
+	{ .compatible = "ti,davinci-pm-domains", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, davinci_genpd_matches);
+
+static int davinci_genpd_probe(struct platform_device *pdev)
+{
+	struct davinci_genpd_ctx *pd;
+	struct device_node *np;
+	struct device *dev;
+
+	dev = &pdev->dev;
+	np = dev->of_node;
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->pd.name = devm_kasprintf(dev, GFP_KERNEL,
+				     "davinci_pwc_pd%d",
+				     of_alias_get_id(np, "pwc"));
+	if (!pd->pd.name)
+		return -ENOMEM;
+
+	pd->dev = dev;
+	pd->pd.attach_dev = davinci_genpd_attach_dev;
+	pd->pd.detach_dev = davinci_genpd_detach_dev;
+	pd->pd.flags |= GENPD_FLAG_PM_CLK;
+
+	pm_genpd_init(&pd->pd, NULL, true);
+
+	return of_genpd_add_provider_simple(np, &pd->pd);
+}
+
+static struct platform_driver davinci_genpd_driver = {
+	.probe = davinci_genpd_probe,
+	.driver = {
+		.name = "davinci_genpd",
+		.of_match_table = davinci_genpd_matches,
+	},
+};
+module_platform_driver(davinci_genpd_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("TI DaVinci Generic Power Domains driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
-- 
2.16.1
