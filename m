Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932114AbeBSUWz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:22:55 -0500
Received: from vern.gendns.com ([206.190.152.46]:58483 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753909AbeBSUWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:22:52 -0500
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v7 10/42] clk: davinci: New driver for davinci PSC clocks
Date: Mon, 19 Feb 2018 14:21:31 -0600
Message-Id: <1519071723-31790-11-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519071723-31790-1-git-send-email-david@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new driver for mach-davinci PSC clocks. This is porting the
code from arch/arm/mach-davinci/psc.c to the common clock framework and
is converting it to use regmap to simplify the code. Additionally, it
adds device tree support for these clocks.

Note: although there are similar clocks for TI Keystone we are not able
to share the code for a few reasons. The keystone clocks are device tree
only and use legacy one-node-per-clock bindings. Also the keystone
driver makes the assumption that there is only one PSC per SoC and uses
global variables, but here we have two controllers per SoC.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- convert to platform device
- rename lpsc field to md
- rename PSC to LPSC where appropriate
- rename LPSC_ARM_RATE to LPSC_SET_RATE_PARENT
- add genpd provider
- add reset provider

v6 changes:
- use GENMASK
- add quirk flag for FORCE bit
- add quirk flag for propagating set_rate
- fix writing to PDSTAT instead of PDCTL
- remove unused doc comment parameter
- change davinci_psc_register_clocks() to handle registering clkdev entries


 drivers/clk/davinci/Makefile |   2 +
 drivers/clk/davinci/psc.c    | 495 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/psc.h    |  89 ++++++++
 3 files changed, 586 insertions(+)
 create mode 100644 drivers/clk/davinci/psc.c
 create mode 100644 drivers/clk/davinci/psc.h

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index d471386..cd1bf2c 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -8,4 +8,6 @@ obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= pll-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= pll-dm365.o
 obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= pll-dm644x.o
 obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= pll-dm646x.o
+
+obj-y += psc.o
 endif
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
new file mode 100644
index 0000000..8e08ac8
--- /dev/null
+++ b/drivers/clk/davinci/psc.c
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock driver for TI Davinci PSC controllers
+ *
+ * Copyright (C) 2017 David Lechner <david@lechnology.com>
+ *
+ * Based on: drivers/clk/keystone/gate.c
+ * Copyright (C) 2013 Texas Instruments.
+ *	Murali Karicheri <m-karicheri2@ti.com>
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * And: arch/arm/mach-davinci/psc.c
+ * Copyright (C) 2006 Texas Instruments.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/err.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "psc.h"
+
+/* PSC register offsets */
+#define EPCPR			0x070
+#define PTCMD			0x120
+#define PTSTAT			0x128
+#define PDSTAT(n)		(0x200 + 4 * (n))
+#define PDCTL(n)		(0x300 + 4 * (n))
+#define MDSTAT(n)		(0x800 + 4 * (n))
+#define MDCTL(n)		(0xa00 + 4 * (n))
+
+/* PSC module states */
+enum davinci_lpsc_state {
+	LPSC_STATE_SWRSTDISABLE	= 0,
+	LPSC_STATE_SYNCRST	= 1,
+	LPSC_STATE_DISABLE	= 2,
+	LPSC_STATE_ENABLE	= 3,
+};
+
+#define MDSTAT_STATE_MASK	GENMASK(5, 0)
+#define MDSTAT_MCKOUT		BIT(12)
+#define PDSTAT_STATE_MASK	GENMASK(4, 0)
+#define MDCTL_FORCE		BIT(31)
+#define MDCTL_LRESET		BIT(8)
+#define PDCTL_EPCGOOD		BIT(8)
+#define PDCTL_NEXT		BIT(0)
+
+struct davinci_psc_data {
+	struct clk_onecell_data clk_data;
+	struct genpd_onecell_data pm_data;
+	struct reset_controller_dev rcdev;
+};
+
+/**
+ * struct davinci_lpsc_clk - LPSC clock structure
+ * @hw: clk_hw for the LPSC
+ * @pm_domain: power domain for the LPSC
+ * @regmap: PSC MMIO region
+ * @md: Module domain (LPSC module id)
+ * @pd: Power domain
+ * @flags: LPSC_* quirk flags
+ */
+struct davinci_lpsc_clk {
+	struct clk_hw hw;
+	struct generic_pm_domain pm_domain;
+	struct regmap *regmap;
+	u32 md;
+	u32 pd;
+	u32 flags;
+};
+
+#define to_davinci_psc_data(x) container_of(x, struct davinci_psc_data, x)
+#define to_davinci_lpsc_clk(x) container_of(x, struct davinci_lpsc_clk, x)
+
+static void davinci_lpsc_config(struct davinci_lpsc_clk *lpsc,
+				enum davinci_lpsc_state next_state)
+{
+	u32 epcpr, pdstat, mdstat, ptstat;
+
+	regmap_write_bits(lpsc->regmap, MDCTL(lpsc->md), MDSTAT_STATE_MASK,
+			  next_state);
+
+	if (lpsc->flags & LPSC_FORCE)
+		regmap_write_bits(lpsc->regmap, MDCTL(lpsc->md), MDCTL_FORCE,
+				  MDCTL_FORCE);
+
+	regmap_read(lpsc->regmap, PDSTAT(lpsc->pd), &pdstat);
+	if ((pdstat & PDSTAT_STATE_MASK) == 0) {
+		regmap_write_bits(lpsc->regmap, PDCTL(lpsc->pd), PDCTL_NEXT,
+				  PDCTL_NEXT);
+
+		regmap_write(lpsc->regmap, PTCMD, BIT(lpsc->pd));
+
+		regmap_read_poll_timeout(lpsc->regmap, EPCPR, epcpr,
+					 epcpr & BIT(lpsc->pd), 0, 0);
+
+		regmap_write_bits(lpsc->regmap, PDCTL(lpsc->pd), PDCTL_EPCGOOD,
+				  PDCTL_EPCGOOD);
+	} else {
+		regmap_write(lpsc->regmap, PTCMD, BIT(lpsc->pd));
+	}
+
+	regmap_read_poll_timeout(lpsc->regmap, PTSTAT, ptstat,
+				 !(ptstat & BIT(lpsc->pd)), 0, 0);
+
+	regmap_read_poll_timeout(lpsc->regmap, MDSTAT(lpsc->md), mdstat,
+				 (mdstat & MDSTAT_STATE_MASK) == next_state,
+				 0, 0);
+}
+
+static int davinci_lpsc_clk_enable(struct clk_hw *hw)
+{
+	struct davinci_lpsc_clk *lpsc = to_davinci_lpsc_clk(hw);
+
+	davinci_lpsc_config(lpsc, LPSC_STATE_ENABLE);
+
+	return 0;
+}
+
+static void davinci_lpsc_clk_disable(struct clk_hw *hw)
+{
+	struct davinci_lpsc_clk *lpsc = to_davinci_lpsc_clk(hw);
+
+	davinci_lpsc_config(lpsc, LPSC_STATE_DISABLE);
+}
+
+static int davinci_lpsc_clk_is_enabled(struct clk_hw *hw)
+{
+	struct davinci_lpsc_clk *lpsc = to_davinci_lpsc_clk(hw);
+	u32 mdstat;
+
+	regmap_read(lpsc->regmap, MDSTAT(lpsc->md), &mdstat);
+
+	return (mdstat & MDSTAT_MCKOUT) ? 1 : 0;
+}
+
+static const struct clk_ops davinci_lpsc_clk_ops = {
+	.enable		= davinci_lpsc_clk_enable,
+	.disable	= davinci_lpsc_clk_disable,
+	.is_enabled	= davinci_lpsc_clk_is_enabled,
+};
+
+static int davinci_psc_genpd_attach_dev(struct generic_pm_domain *pm_domain,
+					struct device *dev)
+{
+	struct davinci_lpsc_clk *lpsc = to_davinci_lpsc_clk(pm_domain);
+	struct clk *clk = lpsc->hw.clk;
+	int ret;
+
+	ret = pm_clk_create(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = pm_clk_add_clk(dev, clk);
+	if (ret < 0) {
+		pm_clk_destroy(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void davinci_psc_genpd_detach_dev(struct generic_pm_domain *pm_domain,
+					 struct device *dev)
+{
+	struct davinci_lpsc_clk *lpsc = to_davinci_lpsc_clk(pm_domain);
+	struct clk *clk = lpsc->hw.clk;
+
+	pm_clk_remove_clk(dev, clk);
+	pm_clk_destroy(dev);
+}
+
+/**
+ * davinci_lpsc_clk_register - register LPSC clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @regmap: PSC MMIO region
+ * @md: local PSC number
+ * @pd: power domain
+ * @flags: LPSC_* flags
+ */
+static struct davinci_lpsc_clk *
+davinci_lpsc_clk_register(struct device *dev, const char *name,
+			  const char *parent_name, struct regmap *regmap,
+			  u32 md, u32 pd, u32 flags)
+{
+	struct clk_init_data init;
+	struct davinci_lpsc_clk *lpsc;
+	int ret;
+	bool is_on;
+
+	lpsc = devm_kzalloc(dev, sizeof(*lpsc), GFP_KERNEL);
+	if (!lpsc)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &davinci_lpsc_clk_ops;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+	init.flags = 0;
+
+	if (flags & LPSC_ALWAYS_ENABLED)
+		init.flags |= CLK_IS_CRITICAL;
+
+	if (flags & LPSC_SET_RATE_PARENT)
+		init.flags |= CLK_SET_RATE_PARENT;
+
+	lpsc->regmap = regmap;
+	lpsc->hw.init = &init;
+	lpsc->md = md;
+	lpsc->pd = pd;
+	lpsc->flags = flags;
+
+	ret = devm_clk_hw_register(dev, &lpsc->hw);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	lpsc->pm_domain.name = devm_kasprintf(dev, GFP_KERNEL, "%s: %s",
+					      dev_name(dev), name);
+	lpsc->pm_domain.attach_dev = davinci_psc_genpd_attach_dev;
+	lpsc->pm_domain.detach_dev = davinci_psc_genpd_detach_dev;
+	lpsc->pm_domain.flags = GENPD_FLAG_PM_CLK;
+
+	is_on = davinci_lpsc_clk_is_enabled(&lpsc->hw);
+	pm_genpd_init(&lpsc->pm_domain, NULL, is_on);
+
+	return lpsc;
+}
+
+static int davinci_lpsc_clk_reset(struct clk *clk, bool reset)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+	struct davinci_lpsc_clk *lpsc = to_davinci_lpsc_clk(hw);
+	u32 mdctl;
+
+	if (IS_ERR_OR_NULL(lpsc))
+		return -EINVAL;
+
+	mdctl = reset ? 0 : MDCTL_LRESET;
+	regmap_write_bits(lpsc->regmap, MDCTL(lpsc->md), MDCTL_LRESET, mdctl);
+
+	return 0;
+}
+
+/*
+ * REVISIT: These exported functions can be removed after a non-DT lookup is
+ * added to the reset controller framework and the davinci-rproc driver is
+ * updated to use the generic reset controller framework.
+ */
+
+int davinci_clk_reset_assert(struct clk *clk)
+{
+	return davinci_lpsc_clk_reset(clk, true);
+}
+EXPORT_SYMBOL(davinci_clk_reset_assert);
+
+int davinci_clk_reset_deassert(struct clk *clk)
+{
+	return davinci_lpsc_clk_reset(clk, false);
+}
+EXPORT_SYMBOL(davinci_clk_reset_deassert);
+
+static int davinci_psc_reset_assert(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	struct davinci_psc_data *psc = to_davinci_psc_data(rcdev);
+	struct clk *clk = psc->clk_data.clks[id];
+
+	return davinci_lpsc_clk_reset(clk, true);
+}
+
+static int davinci_psc_reset_deassert(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	struct davinci_psc_data *psc = to_davinci_psc_data(rcdev);
+	struct clk *clk = psc->clk_data.clks[id];
+
+	return davinci_lpsc_clk_reset(clk, false);
+}
+
+static const struct reset_control_ops davinci_psc_reset_ops = {
+	.assert		= davinci_psc_reset_assert,
+	.deassert	= davinci_psc_reset_deassert,
+};
+
+static int davinci_psc_reset_of_xlate(struct reset_controller_dev *rcdev,
+				      const struct of_phandle_args *reset_spec)
+{
+	struct of_phandle_args clkspec = *reset_spec; /* discard const qualifier */
+	struct clk *clk;
+	struct clk_hw *hw;
+	struct davinci_lpsc_clk *lpsc;
+
+	/* the clock node is the same as the reset node */
+	clk = of_clk_get_from_provider(&clkspec);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	hw = __clk_get_hw(clk);
+	lpsc = to_davinci_lpsc_clk(hw);
+	clk_put(clk);
+
+	/* not all modules support local reset */
+	if (!(lpsc->flags & LPSC_LOCAL_RESET))
+		return -EINVAL;
+
+	return lpsc->md;
+}
+
+static const struct regmap_config davinci_psc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+};
+
+static struct davinci_psc_data *
+__davinci_psc_register_clocks(struct device *dev,
+			      const struct davinci_lpsc_clk_info *info,
+			      int num_clks,
+			      void __iomem *base)
+{
+	struct davinci_psc_data *psc;
+	struct clk **clks;
+	struct generic_pm_domain **pm_domains;
+	struct regmap *regmap;
+	int i, ret;
+
+	psc = devm_kzalloc(dev, sizeof(*psc), GFP_KERNEL);
+	if (!psc)
+		return ERR_PTR(-ENOMEM);
+
+	clks = devm_kmalloc_array(dev, num_clks, sizeof(*clks), GFP_KERNEL);
+	if (!clks)
+		return ERR_PTR(-ENOMEM);
+
+	psc->clk_data.clks = clks;
+	psc->clk_data.clk_num = num_clks;
+
+	/*
+	 * init array with error so that of_clk_src_onecell_get() doesn't
+	 * return NULL for gaps in the sparse array
+	 */
+	for (i = 0; i < num_clks; i++)
+		clks[i] = ERR_PTR(-ENOENT);
+
+	pm_domains = devm_kcalloc(dev, num_clks, sizeof(*pm_domains), GFP_KERNEL);
+	if (!pm_domains)
+		return ERR_PTR(-ENOMEM);
+
+	psc->pm_data.domains = pm_domains;
+	psc->pm_data.num_domains = num_clks;
+
+	regmap = devm_regmap_init_mmio(dev, base, &davinci_psc_regmap_config);
+	if (IS_ERR(regmap))
+		return ERR_CAST(regmap);
+
+	for (; info->name; info++) {
+		struct davinci_lpsc_clk *lpsc;
+
+		lpsc = davinci_lpsc_clk_register(dev, info->name, info->parent,
+						 regmap, info->md, info->pd,
+						 info->flags);
+		if (IS_ERR(lpsc)) {
+			dev_warn(dev, "Failed to register %s (%ld)\n",
+				 info->name, PTR_ERR(lpsc));
+			continue;
+		}
+
+		clks[info->md] = lpsc->hw.clk;
+		pm_domains[info->md] = &lpsc->pm_domain;
+	}
+
+	psc->rcdev.ops = &davinci_psc_reset_ops;
+	psc->rcdev.owner = THIS_MODULE;
+	psc->rcdev.of_node = dev->of_node;
+	psc->rcdev.of_reset_n_cells = 1;
+	psc->rcdev.of_xlate = davinci_psc_reset_of_xlate;
+	psc->rcdev.nr_resets = num_clks;
+
+	ret = devm_reset_controller_register(dev, &psc->rcdev);
+	if (ret < 0)
+		dev_warn(dev, "Failed to register reset controller (%d)\n", ret);
+
+	return psc;
+}
+
+int davinci_psc_register_clocks(struct device *dev,
+				const struct davinci_lpsc_clk_info *info,
+				u8 num_clks,
+				void __iomem *base)
+{
+	struct davinci_psc_data *psc;
+
+	psc = __davinci_psc_register_clocks(dev, info, num_clks, base);
+	if (IS_ERR(psc))
+		return PTR_ERR(psc);
+
+	for (; info->name; info++) {
+		const struct davinci_lpsc_clkdev_info *cdevs = info->cdevs;
+		struct clk *clk = psc->clk_data.clks[info->md];
+
+		if (!cdevs || IS_ERR_OR_NULL(clk))
+			continue;
+
+		for (; cdevs->con_id || cdevs->dev_id; cdevs++)
+			clk_register_clkdev(clk, cdevs->con_id, cdevs->dev_id);
+	}
+
+	return 0;
+}
+
+int of_davinci_psc_clk_init(struct device *dev,
+			    const struct davinci_lpsc_clk_info *info,
+			    u8 num_clks,
+			    void __iomem *base)
+{
+	struct device_node *node = dev->of_node;
+	struct davinci_psc_data *psc;
+
+	psc = __davinci_psc_register_clocks(dev, info, num_clks, base);
+	if (IS_ERR(psc))
+		return PTR_ERR(psc);
+
+	of_genpd_add_provider_onecell(node, &psc->pm_data);
+
+	of_clk_add_provider(node, of_clk_src_onecell_get, &psc->clk_data);
+
+	return 0;
+}
+
+static const struct of_device_id davinci_psc_of_match[] = {
+	{ }
+};
+
+static const struct platform_device_id davinci_psc_id_table[] = {
+	{ }
+};
+
+typedef int (*davinci_psc_init)(struct device *dev, void __iomem *base);
+
+static int davinci_psc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id;
+	davinci_psc_init psc_init = NULL;
+	struct resource *res;
+	void __iomem *base;
+
+	of_id = of_match_device(davinci_psc_of_match, dev);
+	if (of_id)
+		psc_init = of_id->data;
+	else if (pdev->id_entry)
+		psc_init = (void *)pdev->id_entry->driver_data;
+
+	if (!psc_init) {
+		dev_err(dev, "unable to find driver data\n");
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base)) {
+		dev_err(dev, "ioremap failed\n");
+		return PTR_ERR(base);
+	}
+
+	return psc_init(dev, base);
+}
+
+static struct platform_driver davinci_psc_driver = {
+	.probe		= davinci_psc_probe,
+	.driver		= {
+		.name		= "davinci-psc-clk",
+		.of_match_table	= davinci_psc_of_match,
+	},
+	.id_table	= davinci_psc_id_table,
+};
+
+static int __init davinci_psc_driver_init(void)
+{
+	return platform_driver_register(&davinci_psc_driver);
+}
+
+/* has to be postcore_initcall because davinci_gpio depend on PSC clocks */
+postcore_initcall(davinci_psc_driver_init);
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
new file mode 100644
index 0000000..c342d54
--- /dev/null
+++ b/drivers/clk/davinci/psc.h
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock driver for TI Davinci PSC controllers
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#ifndef __CLK_DAVINCI_PSC_H__
+#define __CLK_DAVINCI_PSC_H__
+
+#include <linux/clk-provider.h>
+#include <linux/types.h>
+
+/* PSC quirk flags */
+#define LPSC_ALWAYS_ENABLED	BIT(0) /* never disable this clock */
+#define LPSC_SET_RATE_PARENT	BIT(1) /* propagate set_rate to parent clock */
+#define LPSC_FORCE		BIT(2) /* requires MDCTL FORCE bit */
+#define LPSC_LOCAL_RESET	BIT(3) /* acts as reset provider */
+
+struct davinci_lpsc_clkdev_info {
+	const char *con_id;
+	const char *dev_id;
+};
+
+#define LPSC_CLKDEV(c, d) {	\
+	.con_id = (c),		\
+	.dev_id = (d)		\
+}
+
+#define LPSC_CLKDEV1(n, c, d) \
+static const struct davinci_lpsc_clkdev_info n[] __initconst = {	\
+	LPSC_CLKDEV((c), (d)),						\
+	{ }								\
+}
+
+#define LPSC_CLKDEV2(n, c1, d1, c2, d2) \
+static const struct davinci_lpsc_clkdev_info n[] __initconst = {	\
+	LPSC_CLKDEV((c1), (d1)),					\
+	LPSC_CLKDEV((c2), (d2)),					\
+	{ }								\
+}
+
+#define LPSC_CLKDEV3(n, c1, d1, c2, d2, c3, d3) \
+static const struct davinci_lpsc_clkdev_info n[] __initconst = {	\
+	LPSC_CLKDEV((c1), (d1)),					\
+	LPSC_CLKDEV((c2), (d2)),					\
+	LPSC_CLKDEV((c3), (d3)),					\
+	{ }								\
+}
+
+/**
+ * davinci_lpsc_clk_info - LPSC module-specific clock information
+ * @name: the clock name
+ * @parent: the parent clock name
+ * @cdevs: optional array of clkdev lookup table info
+ * @md: the local module domain (LPSC id)
+ * @pd: the power domain id
+ * @flags: bitmask of LPSC_* flags
+ */
+struct davinci_lpsc_clk_info {
+	const char *name;
+	const char *parent;
+	const struct davinci_lpsc_clkdev_info *cdevs;
+	u32 md;
+	u32 pd;
+	unsigned long flags;
+};
+
+#define LPSC(m, d, n, p, c, f)	\
+{				\
+	.name	= #n,		\
+	.parent	= #p,		\
+	.cdevs	= (c),		\
+	.md	= (m),		\
+	.pd	= (d),		\
+	.flags	= (f),		\
+}
+
+int davinci_psc_register_clocks(struct device *dev,
+				const struct davinci_lpsc_clk_info *info,
+				u8 num_clks,
+				void __iomem *base);
+
+int of_davinci_psc_clk_init(struct device *dev,
+			    const struct davinci_lpsc_clk_info *info,
+			    u8 num_clks,
+			    void __iomem *base);
+
+#endif /* __CLK_DAVINCI_PSC_H__ */
-- 
2.7.4
