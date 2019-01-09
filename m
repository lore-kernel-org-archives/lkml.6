Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DECDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ECA2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TfocXJWk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MGPGlAIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfAIIHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:07:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59418 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAIIHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:07:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A1B3F60132; Wed,  9 Jan 2019 08:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547021267;
        bh=V4Wz4OQyPpiISLfLWellpEZTF9jlSm1ctWwTN6P9j/M=;
        h=From:To:Cc:Subject:Date:From;
        b=TfocXJWkFu9ktFtahd6m+lsdHqQsDbQULja+Fz/yIfyo8H35c3ojPzvpArDaFzDWo
         KePGxvG9K3Rd7UGg/zoJ9j/gYtcyZ/7Iq0LY6zDUu/pkj5re2HtF71Pu9s3rRJsMjl
         tFDIFSVXQi1F6+hPMG3Xueq932sXD3TwNfk62IS4=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2EA4760132;
        Wed,  9 Jan 2019 08:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547021266;
        bh=V4Wz4OQyPpiISLfLWellpEZTF9jlSm1ctWwTN6P9j/M=;
        h=From:To:Cc:Subject:Date:From;
        b=MGPGlAIp5RvcpnIi1NfVAcOnJGOmz53xEq1XWTqJ9rUkN43Rw/DAexbLDCb+bK512
         +l8kpSz9luh8XFsvRn1gyhFD2k7mDkxsO5KDi4yQuxZWKsl/37P595Pd4/m7mh2fH7
         imRvvwGujXnnmXQ5oBb2ut4b/icK1RGqv01TBwyw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EA4760132
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
Subject: [PATCH v2] cpufreq: qcom: Read voltage LUT and populate OPP
Date:   Wed,  9 Jan 2019 13:37:28 +0530
Message-Id: <1547021248-27258-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read the voltage look up table and populate OPP for all
corresponding CPUS for consumers like the energy model could use the
frequency and voltage from the OPP tables.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a..18f90bb 100644
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
@@ -75,6 +78,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 				    void __iomem *base)
 {
 	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
+	u32 volt;
 	unsigned int max_cores = cpumask_weight(policy->cpus);
 	struct cpufreq_frequency_table	*table;

@@ -83,11 +87,16 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
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
@@ -98,6 +107,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 			table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		} else {
 			table[i].frequency = freq;
+			dev_pm_opp_add(get_cpu_device(policy->cpu),
+					freq * 1000, volt);
 			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
 				freq, core_count);
 		}
@@ -116,6 +127,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 			if (prev_cc != max_cores) {
 				prev->frequency = prev_freq;
 				prev->flags = CPUFREQ_BOOST_FREQ;
+				dev_pm_opp_add(get_cpu_device(policy->cpu),
+						prev_freq * 1000, volt);
 			}

 			break;
@@ -127,6 +140,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,

 	table[i].frequency = CPUFREQ_TABLE_END;
 	policy->freq_table = table;
+	dev_pm_opp_set_sharing_cpus(get_cpu_device(policy->cpu), policy->cpus);

 	return 0;
 }
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
@@ -217,6 +245,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
 	void __iomem *base = policy->driver_data - REG_PERF_STATE;

+	dev_pm_opp_remove_all_dynamic(&global_pdev->dev);
 	kfree(policy->freq_table);
 	devm_iounmap(&global_pdev->dev, base);

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

