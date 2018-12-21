Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B11C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F361521920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zz0PT6+0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VqQC4ESs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391375AbeLUSHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:07:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbeLUSHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:07:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3672C60854; Fri, 21 Dec 2018 18:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545415626;
        bh=/WA6Q5gKp/7qzvJSlDhMrcTXoB4k8h+TTmoeHc9B2j4=;
        h=From:To:Cc:Subject:Date:From;
        b=Zz0PT6+04scAawpMsvQkQa53tKyLq8oN74nCkE8MU8enP5N77LQPiM3+A9aJC6mEG
         m2OXMPO/4LN6C1mmzXq26sI9JSrZOn3rHq76VE9ZPw8DKIUgYGofvt77EcWMvlZUeU
         UQCqMGPzylYcMTtRG6vbifEdR5odpHRf3Ee/HL8c=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0CA1E6053B;
        Fri, 21 Dec 2018 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545415622;
        bh=/WA6Q5gKp/7qzvJSlDhMrcTXoB4k8h+TTmoeHc9B2j4=;
        h=From:To:Cc:Subject:Date:From;
        b=VqQC4ESs/wYyt3m8silEJSJDN6M0K9lXCzpixmsNWyAKuyoqVb/nRDmEFJ1+OegG2
         hnpOsCGCCh3wqQfEKiM42lVHqq5CtB6Skzoek14nfJqsCMNWy1IdrTnFbBPdC064vr
         aocBAWCsMxGxSH88gHJISwuGdPgZ458zxFn9sggA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CA1E6053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] cpufreq: qcom: Read voltage LUT and populate OPP
Date:   Fri, 21 Dec 2018 23:36:48 +0530
Message-Id: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read the voltage look up table and populate OPP for all
corresponding CPUS.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a..7559b87 100644
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
+#define REG_FREQ_LUT_TABLE		0x110
+#define REG_VOLT_LUT_TABLE		0x114
 #define REG_PERF_STATE			0x920

 static unsigned long cpu_hw_rate, xo_rate;
@@ -75,19 +78,26 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 				    void __iomem *base)
 {
 	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
+	u32 volt;
 	unsigned int max_cores = cpumask_weight(policy->cpus);
 	struct cpufreq_frequency_table	*table;
+	unsigned long cpu_r;

 	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;

 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
-		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
+		data = readl_relaxed(base + REG_FREQ_LUT_TABLE +
+				      i * LUT_ROW_SIZE);
 		src = FIELD_GET(LUT_SRC, data);
 		lval = FIELD_GET(LUT_L_VAL, data);
 		core_count = FIELD_GET(LUT_CORE_COUNT, data);

+		data = readl_relaxed(base + REG_VOLT_LUT_TABLE +
+				      i * LUT_ROW_SIZE);
+		volt = FIELD_GET(LUT_VOLT, data) * 1000;
+
 		if (src)
 			freq = xo_rate * lval / 1000;
 		else
@@ -123,6 +133,10 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,

 		prev_cc = core_count;
 		prev_freq = freq;
+
+		freq *= 1000;
+		for_each_cpu(cpu_r, policy->cpus)
+			dev_pm_opp_add(get_cpu_device(cpu_r), freq, volt);
 	}

 	table[i].frequency = CPUFREQ_TABLE_END;
@@ -159,10 +173,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
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
@@ -205,6 +227,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}

+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		dev_err(cpu_dev, "OPP table is not ready\n");
+		goto error;
+	}
+
 	policy->fast_switch_possible = true;

 	return 0;
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

