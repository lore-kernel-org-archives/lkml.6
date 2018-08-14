Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97512C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD152170D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fBdqMtKm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QMvMzJP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD152170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbeHNPBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:01:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbeHNPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:01:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 05FA660BE3; Tue, 14 Aug 2018 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248887;
        bh=VVxwKf1cco6x8XK+5qP5LarmbCM4HrE/QtHzh5v3a54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBdqMtKmPvKrTVCcDLv8p2l+zL9IVY14vmAEVcZEQeO9M9/2ozVfc89FfXbBTGzly
         s7JEymtE7U/1tyAq6FZGarf+T27HX1TAV+B+jpzq/vPvu+/0LwQCNOBfHPu2mb4cO1
         xB3xgUpnSTy2aC8U+agbzJ6J3VX/h8hc/8j37RKs=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1733860F78;
        Tue, 14 Aug 2018 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248870;
        bh=VVxwKf1cco6x8XK+5qP5LarmbCM4HrE/QtHzh5v3a54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMvMzJP1e25pK8J7km2dfWmpdJNulxEwgBPT2u/Ec2nvmU1NdW1BU3X48rWg3XNL4
         1orqXv+ZpBD4XDbrN3XVapZWLVeqD2IvNRTKijJOk9jjBU5FwY8cMg30xnJYHNDnyf
         ig7Y3ZMVKTLmPLGra9g2iGU2TLFRSrMVmcB02+a0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1733860F78
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH v12 14/14] cpufreq: qcom: Add support for krait based socs
Date:   Tue, 14 Aug 2018 17:42:33 +0530
Message-Id: <1534248753-2440-15-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
that has KRAIT processors the voltage/current value of each OPP
varies based on the silicon variant in use.

The required OPP related data is determined based on
the efuse value. This is similar to the existing code for
kryo cores. So adding support for krait cores here.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../devicetree/bindings/opp/qcom-nvmem-cpufreq.txt |   3 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c               | 151 +++++++++++++++++++--
 4 files changed, 149 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index 6dcdfcd..7bc0f1a 100644
--- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
@@ -19,7 +19,8 @@ In 'cpus' nodes:
 
 In 'operating-points-v2' table:
 - compatible: Should be
-	- 'operating-points-v2-qcom-cpu' for apq8096 and msm8996.
+	- 'operating-points-v2-qcom-cpu' for apq8096, msm8996, msm8974,
+					     apq8064, msm8960 and ipq8074.
 - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
 		efuse registers that has information about the
 		speedbin that is used to select the right frequency/voltage
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 13fbd97..497ae89 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -126,7 +126,7 @@ config ARM_OMAP2PLUS_CPUFREQ
 
 config ARM_QCOM_CPUFREQ_NVMEM
 	tristate "Qualcomm nvmem based CPUFreq"
-	depends on ARM64
+	depends on ARCH_QCOM
 	depends on QCOM_QFPROM
 	depends on QCOM_SMEM
 	select PM_OPP
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index fe14c57..917cdc2 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -128,6 +128,11 @@
 	{ .compatible = "ti,am43", },
 	{ .compatible = "ti,dra7", },
 
+	{ .compatible = "qcom,ipq8064", },
+	{ .compatible = "qcom,apq8064", },
+	{ .compatible = "qcom,msm8974", },
+	{ .compatible = "qcom,msm8960", },
+
 	{ }
 };
 
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 0ad8e5b..5f2add0 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -45,6 +45,82 @@ enum _msm8996_version {
 
 static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
+static void __init get_krait_bin_format_a(int *speed, int *pvs, int *pvs_ver,
+					  struct nvmem_cell *pvs_nvmem, u8 *buf)
+{
+	u32 pte_efuse;
+
+	pte_efuse = *((u32 *)buf);
+
+	*speed = pte_efuse & 0xf;
+	if (*speed == 0xf)
+		*speed = (pte_efuse >> 4) & 0xf;
+
+	if (*speed == 0xf) {
+		*speed = 0;
+		pr_warn("Speed bin: Defaulting to %d\n", *speed);
+	} else {
+		pr_info("Speed bin: %d\n", *speed);
+	}
+
+	*pvs = (pte_efuse >> 10) & 0x7;
+	if (*pvs == 0x7)
+		*pvs = (pte_efuse >> 13) & 0x7;
+
+	if (*pvs == 0x7) {
+		*pvs = 0;
+		pr_warn("PVS bin: Defaulting to %d\n", *pvs);
+	} else {
+		pr_info("PVS bin: %d\n", *pvs);
+	}
+
+	kfree(buf);
+}
+
+static void __init get_krait_bin_format_b(int *speed, int *pvs, int *pvs_ver,
+					  struct nvmem_cell *pvs_nvmem, u8 *buf)
+{
+	u32 pte_efuse, redundant_sel;
+
+	pte_efuse = *((u32 *)buf);
+	redundant_sel = (pte_efuse >> 24) & 0x7;
+	*speed = pte_efuse & 0x7;
+
+	/* 4 bits of PVS are in efuse register bits 31, 8-6. */
+	*pvs = ((pte_efuse >> 28) & 0x8) | ((pte_efuse >> 6) & 0x7);
+	*pvs_ver = (pte_efuse >> 4) & 0x3;
+
+	switch (redundant_sel) {
+	case 1:
+		*speed = (pte_efuse >> 27) & 0xf;
+		break;
+	case 2:
+		*pvs = (pte_efuse >> 27) & 0xf;
+		break;
+	}
+
+	/* Check SPEED_BIN_BLOW_STATUS */
+	if (pte_efuse & BIT(3)) {
+		pr_info("Speed bin: %d\n", *speed);
+	} else {
+		pr_warn("Speed bin not set. Defaulting to 0!\n");
+		*speed = 0;
+	}
+
+	/* Check PVS_BLOW_STATUS */
+	pte_efuse = *(((u32 *)buf) + 4);
+	pte_efuse &= BIT(21);
+	if (pte_efuse) {
+		pr_info("PVS bin: %d\n", *pvs);
+	} else {
+		pr_warn("PVS bin not set. Defaulting to 0!\n");
+		*pvs = 0;
+	}
+
+	pr_info("PVS version: %d\n", *pvs_ver);
+	kfree(buf);
+}
+
 static enum _msm8996_version __init qcom_cpufreq_get_msm_id(void)
 {
 	size_t len;
@@ -74,6 +150,35 @@ static enum _msm8996_version __init qcom_cpufreq_get_msm_id(void)
 	return version;
 }
 
+static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
+					   struct nvmem_cell *speedbin_nvmem,
+					   char **name,
+					   u32 *versions)
+{
+	int speed = 0, pvs = 0, pvs_ver = 0;
+	u8 *buf;
+	size_t len;
+
+	buf = nvmem_cell_read(speedbin_nvmem, &len);
+	if (len == 4) {
+		get_krait_bin_format_a(&speed, &pvs, &pvs_ver,
+				       speedbin_nvmem, buf);
+	} else if (len == 8) {
+		get_krait_bin_format_b(&speed, &pvs, &pvs_ver,
+				       speedbin_nvmem, buf);
+	} else {
+		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
+		return -ENODEV;
+	}
+
+	snprintf(*name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
+		 speed, pvs, pvs_ver);
+
+	*versions = (1 << speed);
+
+	return 0;
+}
+
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct nvmem_cell *speedbin_nvmem,
 					  char **pvs_name,
@@ -83,6 +188,7 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	u8 *speedbin;
 	enum _msm8996_version msm8996_version;
 
+	*pvs_name = NULL;
 	msm8996_version = qcom_cpufreq_get_msm_id();
 	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
 		dev_err(cpu_dev, "Not Snapdragon 820/821!");
@@ -111,7 +217,7 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
-	struct opp_table *opp_tables[NR_CPUS] = { NULL };
+	struct opp_table *tbl1[NR_CPUS] = { NULL }, *tbl2[NR_CPUS] = { NULL };
 	int (*get_version)(struct device *cpu_dev,
 			   struct nvmem_cell *speedbin_nvmem,
 			   char **name, int *versions);
@@ -120,8 +226,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	struct device *cpu_dev;
 	unsigned cpu;
 	u32 versions;
-	char *pvs_name = NULL;
 	const struct of_device_id *match;
+	char *pvs_name = "speedXX-pvsXX-vXX";
 	int ret;
 
 	cpu_dev = get_cpu_device(0);
@@ -163,10 +269,19 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			goto free_opp;
 		}
 
-		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
-							      &versions, 1);
-		if (IS_ERR(opp_tables[cpu])) {
-			ret = PTR_ERR(opp_tables[cpu]);
+		if (pvs_name) {
+			tbl1[cpu] = dev_pm_opp_set_prop_name(cpu_dev, pvs_name);
+			if (IS_ERR(tbl1[cpu])) {
+				ret = PTR_ERR(tbl1[cpu]);
+				dev_err(cpu_dev, "Failed to add OPP name %s\n",
+					pvs_name);
+				goto free_opp;
+			}
+		}
+
+		tbl2[cpu] = dev_pm_opp_set_supported_hw(cpu_dev, &versions, 1);
+		if (IS_ERR(tbl2[cpu])) {
+			ret = PTR_ERR(tbl2[cpu]);
 			dev_err(cpu_dev, "Failed to set supported hardware\n");
 			goto free_opp;
 		}
@@ -182,9 +297,15 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 free_opp:
 	for_each_possible_cpu(cpu) {
-		if (IS_ERR_OR_NULL(opp_tables[cpu]))
+		if (IS_ERR_OR_NULL(tbl1[cpu]))
+			break;
+		dev_pm_opp_put_prop_name(tbl1[cpu]);
+	}
+
+	for_each_possible_cpu(cpu) {
+		if (IS_ERR_OR_NULL(tbl2[cpu]))
 			break;
-		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+		dev_pm_opp_put_supported_hw(tbl2[cpu]);
 	}
 
 	return ret;
@@ -205,8 +326,18 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
 };
 
 static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
-	{ .compatible = "qcom,apq8096", .data = qcom_cpufreq_kryo_name_version},
-	{ .compatible = "qcom,msm8996", .data = qcom_cpufreq_kryo_name_version},
+	{ .compatible = "qcom,apq8096",
+	  .data = qcom_cpufreq_kryo_name_version},
+	{ .compatible = "qcom,msm8996",
+	  .data = qcom_cpufreq_kryo_name_version},
+	{ .compatible = "qcom,ipq8064",
+	  .data = qcom_cpufreq_krait_name_version },
+	{ .compatible = "qcom,apq8064",
+	  .data = qcom_cpufreq_krait_name_version },
+	{ .compatible = "qcom,msm8974",
+	  .data = qcom_cpufreq_krait_name_version },
+	{ .compatible = "qcom,msm8960",
+	  .data = qcom_cpufreq_krait_name_version },
 	{},
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

