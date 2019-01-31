Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E687C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB02E218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TKjW8dNd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X3OdAArm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfAaRdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:33:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60718 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfAaRdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:33:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A01AA6089D; Thu, 31 Jan 2019 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548955983;
        bh=MXGWRqG/YdhKi0ytCJ9MP76VHCi0MZJz9oKpJ3M5kRE=;
        h=From:To:Cc:Subject:Date:From;
        b=TKjW8dNdDuBd4fGGo4WDmmVH2pAQ2yd8tlMX6RM7Hnj8Ysl9Ujbu9moc0scxv8moc
         T86L4KV0rhkj0yzmbgFNv5SNPvZZhy/gJLc/K/H+mN2gNIMHHDDp0YmFJNHHjgqQpz
         Ipei2N/5uoO5SCZ+jzKRMKGqeimkqfxvQdAqG1gU=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50AE56089D;
        Thu, 31 Jan 2019 17:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548955981;
        bh=MXGWRqG/YdhKi0ytCJ9MP76VHCi0MZJz9oKpJ3M5kRE=;
        h=From:To:Cc:Subject:Date:From;
        b=X3OdAArmQOou6Hvdu4IPgAdAIyx/Ye461LynuDxbfJCWgefuj70AT4OrjUhqfIVGB
         fvK/BFyUNzJ/RuXDytkwxCgOfmChRppX3mBwZii/fk5u0wZcLHRjA4SeGMdzY3DFFH
         twWpKJhtK7WhLDTOdkWMk2tThXcS4tVLwVqLOa6A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50AE56089D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v6] cpufreq: qcom: Read voltage LUT and populate OPP
Date:   Thu, 31 Jan 2019 23:02:50 +0530
Message-Id: <1548955970-2897-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read the voltage look up table and populate OPP for all
corresponding CPUS for consumers like the energy model could use the
frequency and voltage from the OPP tables. Also update the logic to not add
duplicate OPPs.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 46 +++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a..b8383fe 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -10,18 +10,21 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/pm_opp.h>
 #include <linux/slab.h>

 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
 #define LUT_L_VAL			GENMASK(7, 0)
 #define LUT_CORE_COUNT			GENMASK(18, 16)
+#define LUT_VOLT			GENMASK(11, 0)
 #define LUT_ROW_SIZE			32
 #define CLK_HW_DIV			2

 /* Register offsets */
 #define REG_ENABLE			0x0
-#define REG_LUT_TABLE			0x110
+#define REG_FREQ_LUT			0x110
+#define REG_VOLT_LUT			0x114
 #define REG_PERF_STATE			0x920

 static unsigned long cpu_hw_rate, xo_rate;
@@ -70,11 +73,12 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 	return policy->freq_table[index].frequency;
 }

-static int qcom_cpufreq_hw_read_lut(struct device *dev,
+static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 				    struct cpufreq_policy *policy,
 				    void __iomem *base)
 {
 	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
+	u32 volt;
 	unsigned int max_cores = cpumask_weight(policy->cpus);
 	struct cpufreq_frequency_table	*table;

@@ -83,23 +87,28 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 		return -ENOMEM;

 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
-		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
+		data = readl_relaxed(base + REG_FREQ_LUT +
+				      i * LUT_ROW_SIZE);
 		src = FIELD_GET(LUT_SRC, data);
 		lval = FIELD_GET(LUT_L_VAL, data);
 		core_count = FIELD_GET(LUT_CORE_COUNT, data);

+		data = readl_relaxed(base + REG_VOLT_LUT +
+				      i * LUT_ROW_SIZE);
+		volt = FIELD_GET(LUT_VOLT, data) * 1000;
+
 		if (src)
 			freq = xo_rate * lval / 1000;
 		else
 			freq = cpu_hw_rate / 1000;

-		/* Ignore boosts in the middle of the table */
-		if (core_count != max_cores) {
-			table[i].frequency = CPUFREQ_ENTRY_INVALID;
-		} else {
+		if (freq != prev_freq && core_count == max_cores) {
 			table[i].frequency = freq;
-			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
+			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
+			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
 				freq, core_count);
+		} else {
+			table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		}

 		/*
@@ -116,6 +125,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 			if (prev_cc != max_cores) {
 				prev->frequency = prev_freq;
 				prev->flags = CPUFREQ_BOOST_FREQ;
+				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
 			}

 			break;
@@ -127,6 +137,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,

 	table[i].frequency = CPUFREQ_TABLE_END;
 	policy->freq_table = table;
+	dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);

 	return 0;
 }
@@ -159,10 +170,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct device *dev = &global_pdev->dev;
 	struct of_phandle_args args;
 	struct device_node *cpu_np;
+	struct device *cpu_dev;
 	struct resource *res;
 	void __iomem *base;
 	int ret, index;

+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__,
+		       policy->cpu);
+		return -ENODEV;
+	}
+
 	cpu_np = of_cpu_device_node_get(policy->cpu);
 	if (!cpu_np)
 		return -EINVAL;
@@ -199,12 +218,19 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)

 	policy->driver_data = base + REG_PERF_STATE;

-	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
+	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy, base);
 	if (ret) {
 		dev_err(dev, "Domain-%d failed to read LUT\n", index);
 		goto error;
 	}

+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		dev_err(cpu_dev, "Failed to add OPPs\n");
+		ret = -ENODEV;
+		goto error;
+	}
+
 	policy->fast_switch_possible = true;

 	return 0;
@@ -215,8 +241,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)

 static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	void __iomem *base = policy->driver_data - REG_PERF_STATE;

+	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	kfree(policy->freq_table);
 	devm_iounmap(&global_pdev->dev, base);

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

