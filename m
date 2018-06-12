Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2C289C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCF7208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zljl0JJj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cbg9IG4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCF7208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933507AbeFLLC7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:02:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42566 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933408AbeFLLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:02:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 179E4607BB; Tue, 12 Jun 2018 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528801375;
        bh=fz7/UDdv5gDDDrB16CXV74WeHziOfwv78udz6UQ2dTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zljl0JJjGPTPoi504XV50PUGQzbEGsApRx5yOjO4yym+b3x0Nr6/fmrgB4oD4UgX8
         bA8jtqevT7GfQLt9IiMqcnZDW8TX6TWl9Zwa4jUaYGYlWZ7yt9Ixo+Bx1FlF03LY0W
         QfMDMZilL7P7Re2pLDD4VvI6yxzKg1yoEdBnF+w0=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 909EC60791;
        Tue, 12 Jun 2018 11:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528801374;
        bh=fz7/UDdv5gDDDrB16CXV74WeHziOfwv78udz6UQ2dTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cbg9IG4lx21psQu4ZRMzQrTsvqDif/stFay8VxuJ2NlUVvRgo7YAaDQK74cVzvrr/
         i5qK9UD8zHEH0iOonocLos8LthupJN+wyTa43ds5jw/Ot6RBC7GD7ghyfmIYgiwK8S
         z23pm4HENwMK+cp8H1Q3XQondkMxHwd4SYgk5phs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 909EC60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v4 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver
Date:   Tue, 12 Jun 2018 16:32:35 +0530
Message-Id: <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
for changing the frequency of CPUs. The driver implements the cpufreq
driver interface for this firmware.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/cpufreq/Kconfig.arm       |   9 +
 drivers/cpufreq/Makefile          |   1 +
 drivers/cpufreq/qcom-cpufreq-fw.c | 336 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 52f5f1a..2683716 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -312,3 +312,12 @@ config ARM_PXA2xx_CPUFREQ
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.

 	  If in doubt, say N.
+
+config ARM_QCOM_CPUFREQ_FW
+	bool "QCOM CPUFreq FW driver"
+	help
+	 Support for the CPUFreq FW driver.
+	 The CPUfreq FW preset in some QCOM chipsets offloads the steps
+	 necessary for changing the frequency of CPUs. The driver
+	 implements the cpufreq driver interface for this firmware.
+	 Say Y if you want to support CPUFreq FW.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index fb4a2ec..34691a2 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
 obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
+obj-$(CONFIG_ARM_QCOM_CPUFREQ_FW)	+= qcom-cpufreq-fw.o


 ##################################################################################
diff --git a/drivers/cpufreq/qcom-cpufreq-fw.c b/drivers/cpufreq/qcom-cpufreq-fw.c
new file mode 100644
index 0000000..62f4452
--- /dev/null
+++ b/drivers/cpufreq/qcom-cpufreq-fw.c
@@ -0,0 +1,336 @@
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
+#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
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
+qcom_cpufreq_fw_target_index(struct cpufreq_policy *policy,
+			     unsigned int index)
+{
+	struct cpufreq_qcom *c = policy->driver_data;
+
+	writel_relaxed(index, c->perf_base);
+
+	return 0;
+}
+
+static unsigned int qcom_cpufreq_fw_get(unsigned int cpu)
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
+	index = readl_relaxed(c->perf_base);
+	index = min(index, LUT_MAX_ENTRIES - 1);
+
+	return policy->freq_table[index].frequency;
+}
+
+static unsigned int
+qcom_cpufreq_fw_fast_switch(struct cpufreq_policy *policy,
+			    unsigned int target_freq)
+{
+	struct cpufreq_qcom *c = policy->driver_data;
+	int index;
+
+	index = cpufreq_table_find_index_l(policy, target_freq);
+	if (index < 0)
+		return 0;
+
+	writel_relaxed(index, c->perf_base);
+
+	return policy->freq_table[index].frequency;
+}
+
+static int qcom_cpufreq_fw_cpu_init(struct cpufreq_policy *policy)
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
+	.fast_switch    = qcom_cpufreq_fw_fast_switch,
+	.name		= "qcom-cpufreq-fw",
+	.attr		= qcom_cpufreq_fw_attr,
+	.boost_enabled	= true,
+};
+
+static int qcom_read_lut(struct platform_device *pdev,
+			 struct cpufreq_qcom *c)
+{
+	struct device *dev = &pdev->dev;
+	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
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
+		if (!freq_np)
+			continue;
+		if (freq_np == np)
+			cpumask_set_cpu(cpu, m);
+	}
+
+	return 0;
+}
+
+static int qcom_cpu_resources_init(struct platform_device *pdev,
+				   struct device_node *np, unsigned int cpu)
+{
+	struct cpufreq_qcom *c;
+	struct resource res;
+	struct device *dev = &pdev->dev;
+	void __iomem *en_base;
+	int index, ret;
+
+	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	index = of_property_match_string(np, "reg-names", "enable");
+	if (index < 0)
+		return index;
+
+	if (of_address_to_resource(np, index, &res))
+		return -ENOMEM;
+
+	en_base = devm_ioremap(dev, res.start, resource_size(&res));
+	if (!en_base) {
+		dev_err(dev, "Unable to map %s enable-base\n", np->name);
+		return -ENOMEM;
+	}
+
+	/* FW should be in enabled state to proceed */
+	if (!(readl_relaxed(en_base) & 0x1)) {
+		dev_err(dev, "%s firmware not enabled\n", np->name);
+		return -ENODEV;
+	}
+	devm_iounmap(&pdev->dev, en_base);
+
+	index = of_property_match_string(np, "reg-names", "perf");
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
+	index = of_property_match_string(np, "reg-names", "lut");
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
+		dev_err(dev, "%s failed to get related CPUs\n", np->name);
+		return ret;
+	}
+
+	c->max_cores = cpumask_weight(&c->related_cpus);
+	if (!c->max_cores)
+		return -ENOENT;
+
+	ret = qcom_read_lut(pdev, c);
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
+	unsigned int cpu;
+	int ret;
+
+	for_each_possible_cpu(cpu) {
+		cpu_np = of_cpu_device_node_get(cpu);
+		if (!cpu_np) {
+			dev_err(&pdev->dev, "Failed to get cpu %d device\n",
+				cpu);
+			continue;
+		}
+
+		np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
+		if (!np) {
+			dev_err(&pdev->dev, "Failed to get freq-domain device\n");
+			return -EINVAL;
+		}
+
+		of_node_put(cpu_np);
+
+		ret = qcom_cpu_resources_init(pdev, np, cpu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_cpufreq_fw_driver_probe(struct platform_device *pdev)
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
+	rc = cpufreq_register_driver(&cpufreq_qcom_fw_driver);
+	if (rc) {
+		dev_err(&pdev->dev, "CPUFreq FW driver failed to register\n");
+		return rc;
+	}
+
+	dev_info(&pdev->dev, "QCOM CPUFreq FW driver initialized\n");
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
+MODULE_DESCRIPTION("QCOM CPU Frequency FW");
+MODULE_LICENSE("GPL v2");
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

