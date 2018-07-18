Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5513ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657982075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M3Rs1v7Q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MnNgI5jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657982075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeGRGNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:13:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46088 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeGRGNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:13:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3726A60BE5; Wed, 18 Jul 2018 05:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531892252;
        bh=q4sYvAplqAHeGOAl3HlfD3bMMb8oMS73ncmNzLH50xM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3Rs1v7QHWtfy6F5sApz7P08zCe/MvnUYnroqnyreaLq0+1cVJzS6muwMYR+bFtxq
         zaRX5dYBwGgxso45LlebshGsFKAUwhzi6gCAmphGGxENDWEw6vD+VJJiHABvoUWlq+
         Q+VA/JVnKPVpTUTw0M3EU9bA5d6BqKXepKB/KkYQ=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 597A4606DB;
        Wed, 18 Jul 2018 05:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531892243;
        bh=q4sYvAplqAHeGOAl3HlfD3bMMb8oMS73ncmNzLH50xM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnNgI5jflzRz1zLnm34AQUnsNcQtIWJA0PUYAi6lxh+wi1c9XRRYILhTkNgg0Jnj8
         GQq5aZCw9064DiBvzAEJW7x0Q5Mo/vDKX5cpLo5HGhXUt06odNV63roWgUfPgniSKC
         +z+wGj3lXPJuQfT+646XuKTz7yE3ctmJ8pnrvAaM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 597A4606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v6 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Wed, 18 Jul 2018 11:07:00 +0530
Message-Id: <1531892220-2046-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531892220-2046-1-git-send-email-tdas@codeaurora.org>
References: <1531892220-2046-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
for changing the frequency of CPUs. The driver implements the cpufreq
driver interface for this hardware engine.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/cpufreq/Kconfig.arm       |  11 ++
 drivers/cpufreq/Makefile          |   1 +
 drivers/cpufreq/qcom-cpufreq-hw.c | 348 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 360 insertions(+)
 create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 52f5f1a..0abd0a0 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -312,3 +312,14 @@ config ARM_PXA2xx_CPUFREQ
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.

 	  If in doubt, say N.
+
+config ARM_QCOM_CPUFREQ_HW
+	bool "QCOM CPUFreq HW driver"
+	depends on ARCH_QCOM
+	help
+	 Support for the CPUFreq HW driver.
+	 Some QCOM chipsets have a HW engine to offload the steps
+	 necessary for changing the frequency of the CPUs. Firmware loaded
+	 in this engine exposes a programming interface to the OS.
+	 The driver implements the cpufreq interface for this HW engine.
+	 Say Y if you want to support CPUFreq HW.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index fb4a2ec..1226a3e 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
 obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
+obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o


 ##################################################################################
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
new file mode 100644
index 0000000..794ffc4
--- /dev/null
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -0,0 +1,348 @@
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
+#define LUT_MAX_ENTRIES			40U
+#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
+#define LUT_ROW_SIZE			32
+
+enum {
+	REG_ENABLE,
+	REG_LUT_TABLE,
+	REG_PERF_STATE,
+
+	REG_ARRAY_SIZE,
+};
+
+struct cpufreq_qcom {
+	struct cpufreq_frequency_table *table;
+	struct device *dev;
+	void __iomem *reg_bases[REG_ARRAY_SIZE];
+	cpumask_t related_cpus;
+	unsigned int max_cores;
+	unsigned long xo_rate;
+};
+
+static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] = {
+	[REG_ENABLE]		= 0x0,
+	[REG_LUT_TABLE]		= 0x110,
+	[REG_PERF_STATE]	= 0x920,
+};
+
+static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
+
+static int
+qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
+			     unsigned int index)
+{
+	struct cpufreq_qcom *c = policy->driver_data;
+
+	writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
+
+	return 0;
+}
+
+static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
+{
+	struct cpufreq_qcom *c;
+	struct cpufreq_policy *policy;
+	unsigned int index;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (!policy)
+		return 0;
+
+	c = policy->driver_data;
+
+	index = readl_relaxed(c->reg_bases[REG_PERF_STATE]);
+	index = min(index, LUT_MAX_ENTRIES - 1);
+
+	return policy->freq_table[index].frequency;
+}
+
+static unsigned int
+qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
+			    unsigned int target_freq)
+{
+	struct cpufreq_qcom *c = policy->driver_data;
+	int index;
+
+	index = policy->cached_resolved_idx;
+	if (index < 0)
+		return 0;
+
+	writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
+
+	return policy->freq_table[index].frequency;
+}
+
+static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cpufreq_qcom *c;
+
+	c = qcom_freq_domain_map[policy->cpu];
+	if (!c) {
+		pr_err("No scaling support for CPU%d\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	cpumask_copy(policy->cpus, &c->related_cpus);
+
+	policy->fast_switch_possible = true;
+	policy->freq_table = c->table;
+	policy->driver_data = c;
+
+	return 0;
+}
+
+static struct freq_attr *qcom_cpufreq_hw_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	&cpufreq_freq_attr_scaling_boost_freqs,
+	NULL
+};
+
+static struct cpufreq_driver cpufreq_qcom_hw_driver = {
+	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= qcom_cpufreq_hw_target_index,
+	.get		= qcom_cpufreq_hw_get,
+	.init		= qcom_cpufreq_hw_cpu_init,
+	.fast_switch    = qcom_cpufreq_hw_fast_switch,
+	.name		= "qcom-cpufreq-hw",
+	.attr		= qcom_cpufreq_hw_attr,
+	.boost_enabled	= true,
+};
+
+static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
+				    struct cpufreq_qcom *c)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
+
+	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
+				sizeof(*c->table), GFP_KERNEL);
+	if (!c->table)
+		return -ENOMEM;
+
+	base = c->reg_bases[REG_LUT_TABLE];
+
+	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
+		data = readl_relaxed(base + i * LUT_ROW_SIZE);
+		src = (data & GENMASK(31, 30)) >> 30;
+		lval = data & GENMASK(7, 0);
+		core_count = CORE_COUNT_VAL(data);
+
+		if (src)
+			c->table[i].frequency = c->xo_rate * lval / 1000;
+		else
+			c->table[i].frequency = INIT_RATE / 1000;
+
+		cur_freq = c->table[i].frequency;
+
+		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
+			i, c->table[i].frequency, core_count);
+
+		if (core_count != c->max_cores)
+			cur_freq = CPUFREQ_ENTRY_INVALID;
+
+		/*
+		 * Two of the same frequencies with the same core counts means
+		 * end of table.
+		 */
+		if (i > 0 && c->table[i - 1].frequency ==
+		   c->table[i].frequency && prev_cc == core_count) {
+			struct cpufreq_frequency_table *prev = &c->table[i - 1];
+
+			if (prev_freq == CPUFREQ_ENTRY_INVALID)
+				prev->flags = CPUFREQ_BOOST_FREQ;
+			break;
+		}
+		prev_cc = core_count;
+		prev_freq = cur_freq;
+	}
+
+	c->table[i].frequency = CPUFREQ_TABLE_END;
+
+	return 0;
+}
+
+static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
+{
+	struct device_node *cpu_np, *freq_np;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		cpu_np = of_cpu_device_node_get(cpu);
+		if (!cpu_np)
+			continue;
+		freq_np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
+		of_node_put(cpu_np);
+		if (!freq_np)
+			continue;
+
+		if (freq_np == np)
+			cpumask_set_cpu(cpu, m);
+	}
+
+	return 0;
+}
+
+static int qcom_cpu_resources_init(struct platform_device *pdev,
+				   struct device_node *np, unsigned int cpu,
+				   unsigned long xo_rate)
+{
+	struct cpufreq_qcom *c;
+	struct resource res;
+	struct device *dev = &pdev->dev;
+	const u16 *offsets;
+	cpumask_t cpus_related;
+	int ret, i, cpu_r;
+	void __iomem *base;
+
+	cpumask_clear(&cpus_related);
+
+	ret = qcom_get_related_cpus(np, &cpus_related);
+	if (ret) {
+		dev_err(dev, "%s failed to get related CPUs\n", np->name);
+		return ret;
+	}
+
+	/* Related CPUs */
+	cpu_r = cpumask_first(&cpus_related);
+	if (cpu != cpu_r) {
+		qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
+		return 0;
+	}
+
+	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	offsets = of_device_get_match_data(&pdev->dev);
+	if (!offsets)
+		return -EINVAL;
+
+	if (of_address_to_resource(np, 0, &res))
+		return -ENOMEM;
+
+	base = devm_ioremap_resource(dev, &res);
+	if (!base)
+		return -ENOMEM;
+
+	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
+		c->reg_bases[i] = base + offsets[i];
+
+	/* HW should be in enabled state to proceed */
+	if (!(readl_relaxed(c->reg_bases[REG_ENABLE]) & 0x1)) {
+		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
+		return -ENODEV;
+	}
+
+	cpumask_copy(&c->related_cpus, &cpus_related);
+
+	c->max_cores = cpumask_weight(&c->related_cpus);
+	if (!c->max_cores)
+		return -ENOENT;
+
+	c->xo_rate = xo_rate;
+
+	ret = qcom_cpufreq_hw_read_lut(pdev, c);
+	if (ret) {
+		dev_err(dev, "%s failed to read LUT\n", np->name);
+		return ret;
+	}
+
+	qcom_freq_domain_map[cpu] = c;
+
+	return 0;
+}
+
+static int qcom_resources_init(struct platform_device *pdev)
+{
+	struct device_node *np, *cpu_np;
+	struct clk *clk;
+	unsigned int cpu;
+	int ret;
+
+	clk = devm_clk_get(&pdev->dev, "xo");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	for_each_possible_cpu(cpu) {
+		cpu_np = of_cpu_device_node_get(cpu);
+		if (!cpu_np) {
+			dev_dbg(&pdev->dev, "Failed to get cpu %d device\n",
+				cpu);
+			continue;
+		}
+
+		np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
+		of_node_put(cpu_np);
+		if (!np) {
+			dev_err(&pdev->dev, "Failed to get freq-domain device\n");
+			return -EINVAL;
+		}
+
+		ret = qcom_cpu_resources_init(pdev, np, cpu, clk_get_rate(clk));
+		if (ret)
+			return ret;
+	}
+
+	devm_clk_put(&pdev->dev, clk);
+
+	return 0;
+}
+
+static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
+{
+	int rc;
+
+	/* Get the bases of cpufreq for domains */
+	rc = qcom_resources_init(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "CPUFreq resource init failed\n");
+		return rc;
+	}
+
+	rc = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
+	if (rc) {
+		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
+		return rc;
+	}
+
+	dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
+
+	return 0;
+}
+
+static const struct of_device_id qcom_cpufreq_hw_match[] = {
+	{ .compatible = "qcom,cpufreq-hw", .data = &cpufreq_qcom_std_offsets },
+	{}
+};
+
+static struct platform_driver qcom_cpufreq_hw_driver = {
+	.probe = qcom_cpufreq_hw_driver_probe,
+	.driver = {
+		.name = "qcom-cpufreq-hw",
+		.of_match_table = qcom_cpufreq_hw_match,
+	},
+};
+
+static int __init qcom_cpufreq_hw_init(void)
+{
+	return platform_driver_register(&qcom_cpufreq_hw_driver);
+}
+subsys_initcall(qcom_cpufreq_hw_init);
+
+MODULE_DESCRIPTION("QCOM firmware-based CPU Frequency driver");
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

