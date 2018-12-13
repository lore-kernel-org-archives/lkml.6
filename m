Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB1C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E0520870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zu44zFH9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k6PTWNkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E0520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeLMHu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:50:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeLMHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:50:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1288C6071B; Thu, 13 Dec 2018 07:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544687424;
        bh=OSlMld2btEsj689zYb1wBA7s3ifqBnLtWM25x5itfkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zu44zFH9KHJc5/B0NFV90vaMYUz1QxF923Cq2wfWaJO8kCftuEjXO4qF7OIrguRIb
         4uHmFsrHQmPMPvmODKeWhiU347MQqh6lB93X3cKCIhbc6B/6Cov6+Xfwd0ICSWlZbr
         aP/IlilC5XUMlx/ZR+K8BI5kxTIEWRZMEap8F0j8=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76390602F5;
        Thu, 13 Dec 2018 07:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544687421;
        bh=OSlMld2btEsj689zYb1wBA7s3ifqBnLtWM25x5itfkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6PTWNkt+q/4hH8t3cHHFXAHwdEipiZJcFn9f07MTj3pLHmsn4R7ZvL7pVrK3WRTL
         KlV4nSce+bgafHCuX7hoYjLsLLnGhQL/sHKHIeLlaTvSfY1o4oeNws85gAhb2cbBrf
         POfVxjq2KshzHrAsJgBI4CyCA77l5FpZnujDYEYk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76390602F5
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
        Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Thu, 13 Dec 2018 13:19:54 +0530
Message-Id: <1544687394-331-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
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
 drivers/cpufreq/qcom-cpufreq-hw.c | 305 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 317 insertions(+)
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
index 0000000..a65d0ae
--- /dev/null
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -0,0 +1,305 @@
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
+#include <linux/slab.h>
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
+static unsigned long cpu_hw_rate, xo_rate;
+static struct platform_device *global_pdev;
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
+static int qcom_cpufreq_hw_read_lut(struct device *dev,
+				    struct cpufreq_policy *policy,
+				    void __iomem *base)
+{
+	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
+	unsigned int max_cores = cpumask_weight(policy->cpus);
+	struct cpufreq_frequency_table	*table;
+
+	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
+	if (!table)
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
+			table[i].frequency = CPUFREQ_ENTRY_INVALID;
+		} else {
+			table[i].frequency = freq;
+			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
+				freq, core_count);
+		}
+
+		/*
+		 * Two of the same frequencies with the same core counts means
+		 * end of table
+		 */
+		if (i > 0 && prev_freq == freq && prev_cc == core_count) {
+			struct cpufreq_frequency_table *prev = &table[i - 1];
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
+	table[i].frequency = CPUFREQ_TABLE_END;
+	policy->freq_table = table;
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
+						 &args);
+		of_node_put(cpu_np);
+		if (ret < 0)
+			continue;
+
+		if (index == args.args[0])
+			cpumask_set_cpu(cpu, m);
+	}
+}
+
+static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
+{
+	struct device *dev = &global_pdev->dev;
+	struct of_phandle_args args;
+	struct device_node *cpu_np;
+	struct resource *res;
+	void __iomem *base;
+	int ret, index;
+
+	cpu_np = of_cpu_device_node_get(policy->cpu);
+	if (!cpu_np)
+		return -EINVAL;
+
+	ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
+					 "#freq-domain-cells", 0, &args);
+	of_node_put(cpu_np);
+	if (ret)
+		return ret;
+
+	index = args.args[0];
+
+	res = platform_get_resource(global_pdev, IORESOURCE_MEM, index);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	/* HW should be in enabled state to proceed */
+	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
+		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
+		ret = -ENODEV;
+		goto error;
+	}
+
+	qcom_get_related_cpus(index, policy->cpus);
+	if (!cpumask_weight(policy->cpus)) {
+		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
+		ret = -ENOENT;
+		goto error;
+	}
+
+	policy->driver_data = base + REG_PERF_STATE;
+
+	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
+	if (ret) {
+		dev_err(dev, "Domain-%d failed to read LUT\n", index);
+		goto error;
+	}
+
+	policy->fast_switch_possible = true;
+
+	return 0;
+error:
+	devm_iounmap(dev, base);
+	return ret;
+}
+
+static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
+{
+	void __iomem *base = policy->driver_data - REG_PERF_STATE;
+
+	kfree(policy->freq_table);
+	devm_iounmap(&global_pdev->dev, base);
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
+	.exit		= qcom_cpufreq_hw_cpu_exit,
+	.fast_switch    = qcom_cpufreq_hw_fast_switch,
+	.name		= "qcom-cpufreq-hw",
+	.attr		= qcom_cpufreq_hw_attr,
+};
+
+static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
+{
+	struct clk *clk;
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
+	global_pdev = pdev;
+
+	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
+	if (ret)
+		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
+	else
+		dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
+
+	return ret;
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

