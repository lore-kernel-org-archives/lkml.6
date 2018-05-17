Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeEQLBL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:01:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51376 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeEQLBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:01:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D725609D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver
Date: Thu, 17 May 2018 16:30:47 +0530
Message-Id: <1526554847-6976-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526554847-6976-1-git-send-email-tdas@codeaurora.org>
References: <1526554847-6976-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
for changing the frequency of CPUs. The driver implements the cpufreq
driver interface for this firmware.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/cpufreq/Kconfig.arm       |   9 ++
 drivers/cpufreq/Makefile          |   1 +
 drivers/cpufreq/qcom-cpufreq-fw.c | 319 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 329 insertions(+)
 create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 96b35b8..a50aa6e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -301,3 +301,12 @@ config ARM_PXA2xx_CPUFREQ
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.

 	  If in doubt, say N.
+
+config ARM_QCOM_CPUFREQ_FW
+	tristate "QCOM CPUFreq FW driver"
+	help
+	 Support for the CPUFreq FW driver.
+	 The CPUfreq FW preset in some QCOM chipsets offloads the steps
+	 necessary for changing the frequency of CPUs. The driver
+	 implements the cpufreq driver interface for this firmware.
+	 Say Y if you want to support CPUFreq FW.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8d24ade..a3edbce 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
 obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
+obj-$(CONFIG_ARM_QCOM_CPUFREQ_FW)	+= qcom-cpufreq-fw.o


 ##################################################################################
diff --git a/drivers/cpufreq/qcom-cpufreq-fw.c b/drivers/cpufreq/qcom-cpufreq-fw.c
new file mode 100644
index 0000000..2ac7210
--- /dev/null
+++ b/drivers/cpufreq/qcom-cpufreq-fw.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#define INIT_RATE			300000000UL
+#define XO_RATE				19200000UL
+#define LUT_MAX_ENTRIES			40U
+#define CORE_COUNT_VAL(val)		((val & GENMASK(18, 16)) >> 16)
+#define LUT_ROW_SIZE			32
+
+struct cpufreq_qcom {
+	struct cpufreq_frequency_table *table;
+	struct device *dev;
+	void __iomem *perf_base;
+	void __iomem *lut_base;
+	cpumask_t related_cpus;
+	unsigned int max_cores;
+};
+
+static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
+
+static int
+qcom_cpufreq_fw_target_index(struct cpufreq_policy *policy, unsigned int index)
+{
+	struct cpufreq_qcom *c = policy->driver_data;
+
+	if (index >= LUT_MAX_ENTRIES) {
+		dev_err(c->dev,
+		"Passing an index (%u) that's greater than max (%d)\n",
+					index, LUT_MAX_ENTRIES - 1);
+		return -EINVAL;
+	}
+
+	writel_relaxed(index, c->perf_base);
+
+	/* Make sure the write goes through before proceeding */
+	mb();
+	return 0;
+}
+
+static unsigned int qcom_cpufreq_fw_get(unsigned int cpu)
+{
+	struct cpufreq_qcom *c;
+	unsigned int index;
+
+	c = qcom_freq_domain_map[cpu];
+	if (!c)
+		return -ENODEV;
+
+	index = readl_relaxed(c->perf_base);
+	index = min(index, LUT_MAX_ENTRIES - 1);
+
+	return c->table[index].frequency;
+}
+
+static int qcom_cpufreq_fw_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cpufreq_qcom *c;
+	int ret;
+
+	c = qcom_freq_domain_map[policy->cpu];
+	if (!c) {
+		pr_err("No scaling support for CPU%d\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	cpumask_copy(policy->cpus, &c->related_cpus);
+
+	policy->freq_table = c->table;
+	policy->driver_data = c;
+
+	return ret;
+}
+
+static struct freq_attr *qcom_cpufreq_fw_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	&cpufreq_freq_attr_scaling_boost_freqs,
+	NULL
+};
+
+static struct cpufreq_driver cpufreq_qcom_fw_driver = {
+	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= qcom_cpufreq_fw_target_index,
+	.get		= qcom_cpufreq_fw_get,
+	.init		= qcom_cpufreq_fw_cpu_init,
+	.name		= "qcom-cpufreq-fw",
+	.attr		= qcom_cpufreq_fw_attr,
+	.boost_enabled	= true,
+};
+
+static int qcom_read_lut(struct platform_device *pdev,
+			struct cpufreq_qcom *c)
+{
+	struct device *dev = &pdev->dev;
+	u32 data, src, lval, i, core_count, prev_cc = 0;
+
+	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
+				sizeof(*c->table), GFP_KERNEL);
+	if (!c->table)
+		return -ENOMEM;
+
+	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
+		data = readl_relaxed(c->lut_base + i * LUT_ROW_SIZE);
+		src = ((data & GENMASK(31, 30)) >> 30);
+		lval = (data & GENMASK(7, 0));
+		core_count = CORE_COUNT_VAL(data);
+
+		if (!src)
+			c->table[i].frequency = INIT_RATE / 1000;
+		else
+			c->table[i].frequency = XO_RATE * lval / 1000;
+
+		c->table[i].driver_data = c->table[i].frequency;
+
+		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
+				i, c->table[i].frequency, core_count);
+
+		if (core_count != c->max_cores)
+			c->table[i].frequency = CPUFREQ_ENTRY_INVALID;
+
+		/*
+		 * Two of the same frequencies with the same core counts means
+		 * end of table.
+		 */
+		if (i > 0 && c->table[i - 1].driver_data ==
+					c->table[i].driver_data
+					&& prev_cc == core_count) {
+			struct cpufreq_frequency_table *prev = &c->table[i - 1];
+
+			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
+				prev->flags = CPUFREQ_BOOST_FREQ;
+				prev->frequency = prev->driver_data;
+			}
+
+			break;
+		}
+		prev_cc = core_count;
+	}
+	c->table[i].frequency = CPUFREQ_TABLE_END;
+
+	return 0;
+}
+
+static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
+{
+	struct device_node *dev_phandle;
+	struct device *cpu_dev;
+	int cpu, i = 0, ret = -ENOENT;
+
+	dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
+	while (dev_phandle) {
+		for_each_possible_cpu(cpu) {
+			cpu_dev = get_cpu_device(cpu);
+			if (cpu_dev && cpu_dev->of_node == dev_phandle) {
+				cpumask_set_cpu(cpu, m);
+				ret = 0;
+				break;
+			}
+		}
+		dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
+	}
+
+	return ret;
+}
+
+static int qcom_cpu_resources_init(struct platform_device *pdev,
+						struct device_node *np)
+{
+	struct cpufreq_qcom *c;
+	struct resource res;
+	struct device *dev = &pdev->dev;
+	void __iomem *en_base;
+	int cpu, index = 0, ret;
+
+	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
+
+	index = of_property_match_string(np, "reg-names", "en_base");
+	if (index < 0)
+		return index;
+
+	if (of_address_to_resource(np, index, &res))
+		return -ENOMEM;
+
+	en_base = devm_ioremap(dev, res.start, resource_size(&res));
+	if (!en_base) {
+		dev_err(dev, "Unable to map %s en-base\n", np->name);
+		return -ENOMEM;
+	}
+
+	/* FW should be enabled state to proceed */
+	if (!(readl_relaxed(en_base) & 0x1)) {
+		dev_err(dev, "%s firmware not enabled\n", np->name);
+		return -ENODEV;
+	}
+
+	devm_iounmap(&pdev->dev, en_base);
+
+	index = of_property_match_string(np, "reg-names", "perf_base");
+	if (index < 0)
+		return index;
+
+	if (of_address_to_resource(np, index, &res))
+		return -ENOMEM;
+
+	c->perf_base = devm_ioremap(dev, res.start, resource_size(&res));
+	if (!c->perf_base) {
+		dev_err(dev, "Unable to map %s perf-base\n", np->name);
+		return -ENOMEM;
+	}
+
+	index = of_property_match_string(np, "reg-names", "lut_base");
+	if (index < 0)
+		return index;
+
+	if (of_address_to_resource(np, index, &res))
+		return -ENOMEM;
+
+	c->lut_base = devm_ioremap(dev, res.start, resource_size(&res));
+	if (!c->lut_base) {
+		dev_err(dev, "Unable to map %s lut-base\n", np->name);
+		return -ENOMEM;
+	}
+
+	ret = qcom_get_related_cpus(np, &c->related_cpus);
+	if (ret) {
+		dev_err(dev, "%s failed to get core phandles\n", np->name);
+		return ret;
+	}
+
+	c->max_cores = cpumask_weight(&c->related_cpus);
+
+	ret = qcom_read_lut(pdev, c);
+	if (ret) {
+		dev_err(dev, "%s failed to read LUT\n", np->name);
+		return ret;
+	}
+
+	for_each_cpu(cpu, &c->related_cpus)
+		qcom_freq_domain_map[cpu] = c;
+
+	return 0;
+}
+
+static int qcom_resources_init(struct platform_device *pdev)
+{
+	struct device_node *np;
+	int ret = -ENODEV;
+
+	for_each_available_child_of_node(pdev->dev.of_node, np) {
+		if (of_device_is_compatible(np, "cpufreq")) {
+			ret = qcom_cpu_resources_init(pdev, np);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int qcom_cpufreq_fw_driver_probe(struct platform_device *pdev)
+{
+	int rc = 0;
+
+	/* Get the bases of cpufreq for domains */
+	rc = qcom_resources_init(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "CPUFreq resource init failed\n");
+		return rc;
+	}
+
+	rc = cpufreq_register_driver(&cpufreq_qcom_fw_driver);
+	if (rc) {
+		dev_err(&pdev->dev, "CPUFreq FW driver failed to register\n");
+		return rc;
+	}
+
+	dev_info(&pdev->dev, "QCOM CPUFreq FW driver inited\n");
+
+	return 0;
+}
+
+static const struct of_device_id match_table[] = {
+	{ .compatible = "qcom,cpufreq-fw" },
+	{}
+};
+
+static struct platform_driver qcom_cpufreq_fw_driver = {
+	.probe = qcom_cpufreq_fw_driver_probe,
+	.driver = {
+		.name = "qcom-cpufreq-fw",
+		.of_match_table = match_table,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init qcom_cpufreq_fw_init(void)
+{
+	return platform_driver_register(&qcom_cpufreq_fw_driver);
+}
+subsys_initcall(qcom_cpufreq_fw_init);
+
+static void __exit qcom_cpufreq_fw_exit(void)
+{
+	platform_driver_unregister(&qcom_cpufreq_fw_driver);
+}
+module_exit(qcom_cpufreq_fw_exit);
+
+MODULE_DESCRIPTION("QCOM CPU Frequency FW");
+MODULE_LICENSE("GPL v2");
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
