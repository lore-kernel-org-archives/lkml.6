Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeERHw6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:52:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56918 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeERHwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:52:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46C1F6085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
From: Saravana Kannan <skannan@codeaurora.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Saravana Kannan <skannan@codeaurora.org>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM / devfreq: Add support for QCOM devfreq firmware
Date: Fri, 18 May 2018 00:52:40 -0700
Message-Id: <1526629965-28729-1-git-send-email-skannan@codeaurora.org>
X-Mailer: git-send-email 1.8.2.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware present in some QCOM chipsets offloads the steps necessary for
changing the frequency of some devices (Eg: L3). This driver implements the
devfreq interface for this firmware so that various governors could be used
to scale the frequency of these devices.

Each client (say cluster 0 and cluster 1) that wants to vote for a
particular device's frequency (say, L3 frequency) is represented as a
separate voter device (qcom,devfreq-fw-voter) that's a child of the
firmware device (qcom,devfreq-fw).

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 .../bindings/devfreq/devfreq-qcom-fw.txt           |  41 +++
 drivers/devfreq/Kconfig                            |  14 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/devfreq_qcom_fw.c                  | 330 +++++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
 create mode 100644 drivers/devfreq/devfreq_qcom_fw.c

diff --git a/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
new file mode 100644
index 0000000..f882a0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
@@ -0,0 +1,41 @@
+QCOM Devfreq firmware device
+
+Some Qualcomm Technologies, Inc. (QTI) chipsets have a firmware that
+offloads the steps for frequency switching. It provides a table of
+supported frequencies and a register to request one of the supported
+freqencies.
+
+The qcom,devfreq-fw represents this firmware as a device. Sometimes,
+multiple entities want to vote on the frequency request that is sent to the
+firmware. The qcom,devfreq-fw-voter represents these voters as child
+devices of the corresponding qcom,devfreq-fw device.
+
+Required properties:
+- compatible:		Must be "qcom,devfreq-fw" or "qcom,devfreq-fw-voter"
+Only for qcom,devfreq-fw:
+- reg:			Pairs of physical base addresses and region sizes of
+			memory mapped registers.
+- reg-names:		Names of the bases for the above registers.
+			Required register regions are:
+			- "en-base": address of register to check if the
+			  firmware is enabled.
+			- "ftbl-base": address region for the frequency
+			  table.
+			- "perf-base": address of register to request a
+			  frequency.
+
+Example:
+
+	qcom,devfreq-l3 {
+		compatible = "qcom,devfreq-fw";
+		reg-names = "en-base", "ftbl-base", "perf-base";
+		reg = <0x18321000 0x4>, <0x18321110 0x600>, <0x18321920 0x4>;
+
+		qcom,cpu0-l3 {
+			compatible = "qcom,devfreq-fw-voter";
+		};
+
+		qcom,cpu4-l3 {
+			compatible = "qcom,devfreq-fw-voter";
+		};
+	};
diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 49fd170..5eeb33f 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -121,6 +121,20 @@ config ARM_RK3399_DMC_DEVFREQ
           It sets the frequency for the memory controller and reads the usage counts
           from hardware.
 
+config ARM_QCOM_DEVFREQ_FW
+	bool "Qualcomm Technologies Inc. DEVFREQ FW driver"
+	depends on ARCH_QCOM
+	select DEVFREQ_GOV_PERFORMANCE
+	select DEVFREQ_GOV_POWERSAVE
+	select DEVFREQ_GOV_USERSPACE
+	default n
+	help
+	  The firmware present in some QCOM chipsets offloads the steps
+	  necessary for changing the frequency of some devices (Eg: L3). This
+	  driver implements the devfreq interface for this firmware so that
+	  various governors could be used to scale the frequency of these
+	  devices.
+
 source "drivers/devfreq/event/Kconfig"
 
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 905f341..cafe7c2 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_DEVFREQ_GOV_CPUFREQ)	+= governor_cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
+obj-$(CONFIG_ARM_QCOM_DEVFREQ_FW)	+= devfreq_qcom_fw.o
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/devfreq_qcom_fw.c b/drivers/devfreq/devfreq_qcom_fw.c
new file mode 100644
index 0000000..511758a
--- /dev/null
+++ b/drivers/devfreq/devfreq_qcom_fw.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/devfreq.h>
+#include <linux/pm_opp.h>
+
+#define INIT_HZ				300000000UL
+#define XO_HZ				19200000UL
+#define FTBL_MAX_ENTRIES		40U
+#define FTBL_ROW_SIZE			32
+
+#define SRC_MASK	GENMASK(31, 30)
+#define SRC_SHIFT	30
+#define MULT_MASK	GENMASK(7, 0)
+
+struct devfreq_qcom_fw {
+	void __iomem *perf_base;
+	struct devfreq_dev_profile dp;
+	struct list_head voters;
+	struct list_head voter;
+	unsigned int index;
+};
+
+static DEFINE_SPINLOCK(voter_lock);
+
+static int devfreq_qcom_fw_target(struct device *dev, unsigned long *freq,
+				  u32 flags)
+{
+	struct devfreq_qcom_fw *d = dev_get_drvdata(dev), *pd, *v;
+	struct devfreq_dev_profile *p = &d->dp;
+	unsigned int index;
+	unsigned long lflags;
+	struct dev_pm_opp *opp;
+	void __iomem *perf_base = d->perf_base;
+
+	opp = devfreq_recommended_opp(dev, freq, flags);
+	if (!IS_ERR(opp))
+		dev_pm_opp_put(opp);
+	else
+		return PTR_ERR(opp);
+
+	for (index = 0; index < p->max_state; index++)
+		if (p->freq_table[index] == *freq)
+			break;
+
+	if (index >= p->max_state) {
+		dev_err(dev, "Unable to find index for freq (%lu)!\n", *freq);
+		return -EINVAL;
+	}
+
+	d->index = index;
+
+	spin_lock_irqsave(&voter_lock, lflags);
+	/* Voter */
+	if (!perf_base) {
+		pd = dev_get_drvdata(dev->parent);
+		list_for_each_entry(v, &pd->voters, voter)
+			index = max(index, v->index);
+		perf_base = pd->perf_base;
+	}
+
+	writel_relaxed(index, perf_base);
+	spin_unlock_irqrestore(&voter_lock, lflags);
+
+	return 0;
+}
+
+static int devfreq_qcom_fw_get_cur_freq(struct device *dev,
+						 unsigned long *freq)
+{
+	struct devfreq_qcom_fw *d = dev_get_drvdata(dev);
+	struct devfreq_dev_profile *p = &d->dp;
+	unsigned int index;
+
+	/* Voter */
+	if (!d->perf_base) {
+		index = d->index;
+	} else {
+		index = readl_relaxed(d->perf_base);
+		index = min(index, p->max_state - 1);
+	}
+	*freq = p->freq_table[index];
+
+	return 0;
+}
+
+static int devfreq_qcom_populate_opp(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	u32 data, src, mult, i;
+	unsigned long freq, prev_freq;
+	struct resource *res;
+	void __iomem *lut_base;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lut-base");
+	if (!res) {
+		dev_err(dev, "Unable to find lut-base!\n");
+		return -EINVAL;
+	}
+
+	lut_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!lut_base) {
+		dev_err(dev, "Unable to map lut-base\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < FTBL_MAX_ENTRIES; i++) {
+		data = readl_relaxed(lut_base + i * FTBL_ROW_SIZE);
+		src = ((data & SRC_MASK) >> SRC_SHIFT);
+		mult = (data & MULT_MASK);
+		freq = src ? XO_HZ * mult : INIT_HZ;
+
+		/*
+		 * Two of the same frequencies with the same core counts means
+		 * end of table.
+		 */
+		if (i > 0 && prev_freq == freq)
+			break;
+
+		dev_pm_opp_add(&pdev->dev, freq, 0);
+
+		prev_freq = freq;
+	}
+
+	devm_iounmap(dev, lut_base);
+
+	return 0;
+}
+
+static int devfreq_qcom_init_hw(struct platform_device *pdev)
+{
+	struct devfreq_qcom_fw *d;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	int ret = 0;
+	void __iomem *en_base;
+
+	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "en-base");
+	if (!res) {
+		dev_err(dev, "Unable to find en-base!\n");
+		return -EINVAL;
+	}
+
+	en_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!en_base) {
+		dev_err(dev, "Unable to map en-base\n");
+		return -ENOMEM;
+	}
+
+	/* Firmware should be enabled state to proceed */
+	if (!(readl_relaxed(en_base) & 1)) {
+		dev_err(dev, "Firmware not enabled\n");
+		return -ENODEV;
+	}
+
+	devm_iounmap(dev, en_base);
+
+	ret = devfreq_qcom_populate_opp(pdev);
+	if (ret) {
+		dev_err(dev, "Failed to read FTBL\n");
+		return ret;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "perf-base");
+	if (!res) {
+		dev_err(dev, "Unable to find perf-base!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	d->perf_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!d->perf_base) {
+		dev_err(dev, "Unable to map perf-base\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&d->voters);
+	dev_set_drvdata(dev, d);
+
+out:
+	if (ret)
+		dev_pm_opp_remove_table(dev);
+	return ret;
+}
+
+static int devfreq_qcom_copy_opp(struct device *src_dev, struct device *dst_dev)
+{
+	unsigned long freq;
+	int i, cnt, ret = 0;
+	struct dev_pm_opp *opp;
+
+	if (!src_dev)
+		return -ENODEV;
+
+	cnt = dev_pm_opp_get_opp_count(src_dev);
+	if (!cnt)
+		return -EINVAL;
+
+	for (i = 0, freq = 0; i < cnt; i++, freq++) {
+		opp = dev_pm_opp_find_freq_ceil(src_dev, &freq);
+		if (IS_ERR(opp)) {
+			ret = -EINVAL;
+			break;
+		}
+		dev_pm_opp_put(opp);
+
+		ret = dev_pm_opp_add(dst_dev, freq, 0);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		dev_pm_opp_remove_table(dst_dev);
+	return ret;
+}
+
+static int devfreq_qcom_init_voter(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *par_dev = dev->parent;
+	struct devfreq_qcom_fw *d, *pd = dev_get_drvdata(par_dev);
+	int ret = 0;
+
+	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	ret = devfreq_qcom_copy_opp(dev->parent, dev);
+	if (ret) {
+		dev_err(dev, "Failed to copy parent OPPs\n");
+		return ret;
+	}
+
+	list_add(&d->voter, &pd->voters);
+	dev_set_drvdata(dev, d);
+
+	return 0;
+}
+
+static int devfreq_qcom_fw_driver_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret = 0;
+	struct devfreq_qcom_fw *d;
+	struct devfreq_dev_profile *p;
+	struct devfreq *df;
+
+	if (!of_device_get_match_data(dev))
+		ret = devfreq_qcom_init_voter(pdev);
+	else
+		ret = devfreq_qcom_init_hw(pdev);
+	if (ret) {
+		dev_err(dev, "Unable to probe device!\n");
+		return ret;
+	}
+
+	/*
+	 * If device has voter children, do no register directly with devfreq
+	 */
+	if (of_get_available_child_count(dev->of_node)) {
+		of_platform_populate(dev->of_node, NULL, NULL, dev);
+		dev_info(dev, "Devfreq QCOM Firmware parent dev inited.\n");
+		return 0;
+	}
+
+	d = dev_get_drvdata(dev);
+	p = &d->dp;
+	p->polling_ms = 50;
+	p->target = devfreq_qcom_fw_target;
+	p->get_cur_freq = devfreq_qcom_fw_get_cur_freq;
+
+	df = devm_devfreq_add_device(dev, p, "performance", NULL);
+	if (IS_ERR(df)) {
+		dev_err(dev, "Unable to register Devfreq QCOM Firmware dev!\n");
+		return PTR_ERR(df);
+	}
+
+	dev_info(dev, "Devfreq QCOM Firmware dev registered.\n");
+
+	return 0;
+}
+
+static const struct of_device_id match_table[] = {
+	{ .compatible = "qcom,devfreq-fw", .data = (void *) 1 },
+	{ .compatible = "qcom,devfreq-fw-voter", .data = (void *) 0 },
+	{}
+};
+
+static struct platform_driver devfreq_qcom_fw_driver = {
+	.probe = devfreq_qcom_fw_driver_probe,
+	.driver = {
+		.name = "devfreq-qcom-fw",
+		.of_match_table = match_table,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init devfreq_qcom_fw_init(void)
+{
+	return platform_driver_register(&devfreq_qcom_fw_driver);
+}
+subsys_initcall(devfreq_qcom_fw_init);
+
+static void __exit devfreq_qcom_fw_exit(void)
+{
+	platform_driver_unregister(&devfreq_qcom_fw_driver);
+}
+module_exit(devfreq_qcom_fw_exit);
+
+MODULE_DESCRIPTION("Devfreq QCOM Firmware");
+MODULE_LICENSE("GPL v2");
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
