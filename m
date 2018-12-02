Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0526C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C4F20881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CZK8Mhs7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l0y44bQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C4F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbeLBDze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:55:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLBDzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:55:33 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B6D460C64; Sun,  2 Dec 2018 03:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543722929;
        bh=ZK0ogZ3iAgxn33xRyYiQCCzTISCWcXwmjxmYLE/fKd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZK8Mhs7M/onKIJvgksKg2Bhu1jSjMW+IQtcfM11CFVpAS8HoAg8GLA1ifDXHQv6U
         HVZxfJ9Ug+ZvmtotJlaMESHvBBE22bUg9sACg0Sa4EZRbRN3W3D6oOpazkAgubsQ+S
         7vnZA9m45l8e6mX2ZFrk4d417xkr4MaGxjd9EAT0=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9469560B7F;
        Sun,  2 Dec 2018 03:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543722927;
        bh=ZK0ogZ3iAgxn33xRyYiQCCzTISCWcXwmjxmYLE/fKd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0y44bQb1XKAUBzU1Pt5NgUdvcA9YJcDDYQRHMGZRqY2z/QfrQV+ganCdesVilb+Z
         SHWvj0mthS70X63D+qkGjSUTI29kqdmYS9VvPy2ClOAJd0wyAU88FtEnpaMsl3MQIF
         KQnFXyCQnJ33ZDtm4L5veku7IZC9lVB1Vl+iaWrI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9469560B7F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Sun,  2 Dec 2018 09:25:03 +0530
Message-Id: <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
for changing the frequency of CPUs. The driver implements the cpufreq
driver interface for this hardware engine.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/cpufreq/Kconfig.arm       |  11 ++
 drivers/cpufreq/Makefile          |   1 +
 drivers/cpufreq/qcom-cpufreq-hw.c | 334 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4e1131e..688f102 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -114,6 +114,17 @@ config ARM_QCOM_CPUFREQ_KRYO

 	  If in doubt, say N.

+config ARM_QCOM_CPUFREQ_HW
+	tristate "QCOM CPUFreq HW driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  Support for the CPUFreq HW driver.
+	  Some QCOM chipsets have a HW engine to offload the steps
+	  necessary for changing the frequency of the CPUs. Firmware loaded
+	  in this engine exposes a programming interface to the OS.
+	  The driver implements the cpufreq interface for this HW engine.
+	  Say Y if you want to support CPUFreq HW.
+
 config ARM_S3C_CPUFREQ
 	bool
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index d5ee456..08c071b 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
+obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
 obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
 obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
 obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
new file mode 100644
index 0000000..8dc6b73
--- /dev/null
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#define LUT_MAX_ENTRIES			40U
+#define LUT_SRC				GENMASK(31, 30)
+#define LUT_L_VAL			GENMASK(7, 0)
+#define LUT_CORE_COUNT			GENMASK(18, 16)
+#define LUT_ROW_SIZE			32
+#define CLK_HW_DIV			2
+
+/* Register offsets */
+#define REG_ENABLE			0x0
+#define REG_LUT_TABLE			0x110
+#define REG_PERF_STATE			0x920
+
+struct cpufreq_qcom {
+	struct cpufreq_frequency_table *table;
+	void __iomem *perf_state_reg;
+	cpumask_t related_cpus;
+};
+
+static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
+
+static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
+					unsigned int index)
+{
+	void __iomem *perf_state_reg = policy->driver_data;
+
+	writel_relaxed(index, perf_state_reg);
+
+	return 0;
+}
+
+static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
+{
+	void __iomem *perf_state_reg;
+	struct cpufreq_policy *policy;
+	unsigned int index;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (!policy)
+		return 0;
+
+	perf_state_reg = policy->driver_data;
+
+	index = readl_relaxed(perf_state_reg);
+	index = min(index, LUT_MAX_ENTRIES - 1);
+
+	return policy->freq_table[index].frequency;
+}
+
+static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
+						unsigned int target_freq)
+{
+	void __iomem *perf_state_reg = policy->driver_data;
+	int index;
+
+	index = policy->cached_resolved_idx;
+	if (index < 0)
+		return 0;
+
+	writel_relaxed(index, perf_state_reg);
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
+	policy->driver_data = c->perf_state_reg;
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
+};
+
+static int qcom_cpufreq_hw_read_lut(struct device *dev, struct cpufreq_qcom *c,
+				    void __iomem *base, unsigned long xo_rate,
+				    unsigned long cpu_hw_rate)
+{
+	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
+	unsigned int max_cores = cpumask_weight(&c->related_cpus);
+
+	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
+				sizeof(*c->table), GFP_KERNEL);
+	if (!c->table)
+		return -ENOMEM;
+
+	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
+		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
+		src = FIELD_GET(LUT_SRC, data);
+		lval = FIELD_GET(LUT_L_VAL, data);
+		core_count = FIELD_GET(LUT_CORE_COUNT, data);
+
+		if (src)
+			freq = xo_rate * lval / 1000;
+		else
+			freq = cpu_hw_rate / 1000;
+
+		/* Ignore boosts in the middle of the table */
+		if (core_count != max_cores) {
+			c->table[i].frequency = CPUFREQ_ENTRY_INVALID;
+		} else {
+			c->table[i].frequency = freq;
+			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
+				freq, core_count);
+		}
+
+		/*
+		 * Two of the same frequencies with the same core counts means
+		 * end of table
+		 */
+		if (i > 0 && prev_freq == freq && prev_cc == core_count) {
+			struct cpufreq_frequency_table *prev = &c->table[i - 1];
+
+			/*
+			 * Only treat the last frequency that might be a boost
+			 * as the boost frequency
+			 */
+			if (prev_cc != max_cores) {
+				prev->frequency = prev_freq;
+				prev->flags = CPUFREQ_BOOST_FREQ;
+			}
+
+			break;
+		}
+
+		prev_cc = core_count;
+		prev_freq = freq;
+	}
+
+	c->table[i].frequency = CPUFREQ_TABLE_END;
+
+	return 0;
+}
+
+static void qcom_get_related_cpus(int index, struct cpumask *m)
+{
+	struct device_node *cpu_np;
+	struct of_phandle_args args;
+	int cpu, ret;
+
+	for_each_possible_cpu(cpu) {
+		cpu_np = of_cpu_device_node_get(cpu);
+		if (!cpu_np)
+			continue;
+
+		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
+						 "#freq-domain-cells", 0,
+						  &args);
+		of_node_put(cpu_np);
+		if (ret < 0)
+			continue;
+
+		if (index == args.args[0])
+			cpumask_set_cpu(cpu, m);
+	}
+}
+
+static int qcom_cpu_resources_init(struct platform_device *pdev,
+				   unsigned int cpu, int index,
+				   unsigned long xo_rate,
+				   unsigned long cpu_hw_rate)
+{
+	struct cpufreq_qcom *c;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	int ret, cpu_r;
+
+	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	/* HW should be in enabled state to proceed */
+	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
+		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
+		return -ENODEV;
+	}
+
+	qcom_get_related_cpus(index, &c->related_cpus);
+	if (!cpumask_weight(&c->related_cpus)) {
+		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
+		return -ENOENT;
+	}
+
+	c->perf_state_reg = base + REG_PERF_STATE;
+
+	ret = qcom_cpufreq_hw_read_lut(dev, c, base, xo_rate, cpu_hw_rate);
+	if (ret) {
+		dev_err(dev, "Domain-%d failed to read LUT\n", index);
+		return ret;
+	}
+
+	for_each_cpu(cpu_r, &c->related_cpus)
+		qcom_freq_domain_map[cpu_r] = c;
+
+	return 0;
+}
+
+static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
+{
+	struct device_node *cpu_np;
+	struct of_phandle_args args;
+	struct clk *clk;
+	unsigned int cpu;
+	unsigned long xo_rate, cpu_hw_rate;
+	int ret;
+
+	clk = clk_get(&pdev->dev, "xo");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	xo_rate = clk_get_rate(clk);
+	clk_put(clk);
+
+	clk = clk_get(&pdev->dev, "alternate");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
+	clk_put(clk);
+
+	for_each_possible_cpu(cpu) {
+		cpu_np = of_cpu_device_node_get(cpu);
+		if (!cpu_np) {
+			dev_dbg(&pdev->dev, "Failed to get cpu %d device\n",
+				cpu);
+			continue;
+		}
+
+		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
+						 "#freq-domain-cells", 0,
+						  &args);
+		of_node_put(cpu_np);
+		if (ret)
+			return ret;
+
+		if (qcom_freq_domain_map[cpu])
+			continue;
+
+		ret = qcom_cpu_resources_init(pdev, cpu, args.args[0],
+					      xo_rate, cpu_hw_rate);
+		if (ret)
+			return ret;
+	}
+
+	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
+	if (ret) {
+		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
+		return ret;
+	}
+
+	dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
+
+	return 0;
+}
+
+static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
+{
+	return cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
+}
+
+static const struct of_device_id qcom_cpufreq_hw_match[] = {
+	{ .compatible = "qcom,cpufreq-hw" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
+
+static struct platform_driver qcom_cpufreq_hw_driver = {
+	.probe = qcom_cpufreq_hw_driver_probe,
+	.remove = qcom_cpufreq_hw_driver_remove,
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
+static void __exit qcom_cpufreq_hw_exit(void)
+{
+	platform_driver_unregister(&qcom_cpufreq_hw_driver);
+}
+module_exit(qcom_cpufreq_hw_exit);
+
+MODULE_DESCRIPTION("QCOM CPUFREQ HW Driver");
+MODULE_LICENSE("GPL v2");
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

