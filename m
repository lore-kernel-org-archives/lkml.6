Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB054C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A08C2170D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="airiTDvV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MJNhc+aY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A08C2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbeHNPCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:02:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46266 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbeHNPCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:02:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9890F60C4F; Tue, 14 Aug 2018 12:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248917;
        bh=f9MtOo7C8IOljmQF7Ub2Yw/yO9bfpRQZDJ0J7dQF1jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=airiTDvV0+/8QZ2+AYqzk92eHauqVg7nh42FjOcOGw6dREw1zklmSDVusJtbAE6YV
         CNBpSLmMwlApApraaa9BKiqpUTOw4L1NSu6I0asYqIUZKQzg0l0av0/7WjCKNQxR4a
         zbjAZoIAO2gZrzKOvJfAdZrhhR/yGWBwSZ5HG9Pg=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A943460D3D;
        Tue, 14 Aug 2018 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248863;
        bh=f9MtOo7C8IOljmQF7Ub2Yw/yO9bfpRQZDJ0J7dQF1jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJNhc+aY9lAdKR9rn2uBQy7af0Yp/SJIciZZ4jh4Jp8ChRzmTSwQIOuZB8mCbZQn6
         re6vJQOoDJd57S6+RvATzH53xt1/dY+34DJBbmP5rNfyAAFtkjo+IOfdGvCtucB4NJ
         GlLEQS0dP4mck1eeD5WPDpyP0clNm4SQfcZxw/Qo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A943460D3D
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
Subject: [PATCH v12 13/14] cpufreq: qcom: Re-organise kryo cpufreq to use it for other nvmem based qcom socs
Date:   Tue, 14 Aug 2018 17:42:32 +0530
Message-Id: <1534248753-2440-14-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kryo cpufreq driver reads the nvmem cell and uses that data to
populate the opps. There are other qcom cpufreq socs like krait which
does similar thing. Except for the interpretation of the read data,
rest of the driver is same for both the cases. So pull the common things
out for reuse.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt}   |   6 +-
 drivers/cpufreq/Kconfig.arm                        |   4 +-
 drivers/cpufreq/Makefile                           |   2 +-
 .../{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c}  | 124 ++++++++++++---------
 4 files changed, 80 insertions(+), 56 deletions(-)
 rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (99%)
 rename drivers/cpufreq/{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} (65%)

diff --git a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
similarity index 99%
rename from Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
rename to Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index c2127b9..6dcdfcd 100644
--- a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
+++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
@@ -19,7 +19,7 @@ In 'cpus' nodes:
 
 In 'operating-points-v2' table:
 - compatible: Should be
-	- 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
+	- 'operating-points-v2-qcom-cpu' for apq8096 and msm8996.
 - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
 		efuse registers that has information about the
 		speedbin that is used to select the right frequency/voltage
@@ -127,7 +127,7 @@ Example 1:
 	};
 
 	cluster0_opp: opp_table0 {
-		compatible = "operating-points-v2-kryo-cpu";
+		compatible = "operating-points-v2-qcom-cpu";
 		nvmem-cells = <&speedbin_efuse>;
 		opp-shared;
 
@@ -338,7 +338,7 @@ Example 1:
 	};
 
 	cluster1_opp: opp_table1 {
-		compatible = "operating-points-v2-kryo-cpu";
+		compatible = "operating-points-v2-qcom-cpu";
 		nvmem-cells = <&speedbin_efuse>;
 		opp-shared;
 
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 52f5f1a..13fbd97 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -124,8 +124,8 @@ config ARM_OMAP2PLUS_CPUFREQ
 	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 
-config ARM_QCOM_CPUFREQ_KRYO
-	tristate "Qualcomm Kryo based CPUFreq"
+config ARM_QCOM_CPUFREQ_NVMEM
+	tristate "Qualcomm nvmem based CPUFreq"
 	depends on ARM64
 	depends on QCOM_QFPROM
 	depends on QCOM_SMEM
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index fb4a2ec..5544441 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -65,7 +65,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
-obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
+obj-$(CONFIG_ARM_QCOM_CPUFREQ_NVMEM)	+= qcom-cpufreq-nvmem.o
 obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
 obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
 obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
similarity index 65%
rename from drivers/cpufreq/qcom-cpufreq-kryo.c
rename to drivers/cpufreq/qcom-cpufreq-nvmem.c
index efc9a7a..0ad8e5b 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -9,7 +9,7 @@
  * based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
  * defines the voltage and frequency value based on the msm-id in SMEM
  * and speedbin blown in the efuse combination.
- * The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
+ * The qcom-cpufreq driver reads the msm-id and efuse value from the SoC
  * to provide the OPP framework with required information.
  * This is used to determine the voltage and frequency value for each OPP of
  * operating-points-v2 table when it is parsed by the OPP framework.
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
@@ -42,9 +43,9 @@ enum _msm8996_version {
 	NUM_OF_MSM8996_VERSIONS,
 };
 
-struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
+static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
-static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
+static enum _msm8996_version __init qcom_cpufreq_get_msm_id(void)
 {
 	size_t len;
 	u32 *msm_id;
@@ -73,34 +74,70 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
 	return version;
 }
 
-static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
+static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
+					  struct nvmem_cell *speedbin_nvmem,
+					  char **pvs_name,
+					  u32 *versions)
 {
-	struct opp_table *opp_tables[NR_CPUS] = {0};
+	size_t len;
+	u8 *speedbin;
 	enum _msm8996_version msm8996_version;
+
+	msm8996_version = qcom_cpufreq_get_msm_id();
+	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
+		dev_err(cpu_dev, "Not Snapdragon 820/821!");
+		return -ENODEV;
+	}
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	switch (msm8996_version) {
+	case MSM8996_V3:
+		*versions = 1 << (unsigned int)(*speedbin);
+		break;
+	case MSM8996_SG:
+		*versions = 1 << ((unsigned int)(*speedbin) + 4);
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	kfree(speedbin);
+	return 0;
+}
+
+static int qcom_cpufreq_probe(struct platform_device *pdev)
+{
+	struct opp_table *opp_tables[NR_CPUS] = { NULL };
+	int (*get_version)(struct device *cpu_dev,
+			   struct nvmem_cell *speedbin_nvmem,
+			   char **name, int *versions);
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
 	unsigned cpu;
-	u8 *speedbin;
 	u32 versions;
-	size_t len;
+	char *pvs_name = NULL;
+	const struct of_device_id *match;
 	int ret;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev)
 		return -ENODEV;
 
-	msm8996_version = qcom_cpufreq_kryo_get_msm_id();
-	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
-		dev_err(cpu_dev, "Not Snapdragon 820/821!");
+	match = pdev->dev.platform_data;
+	get_version = match->data;
+	if (!get_version)
 		return -ENODEV;
-	}
 
 	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!np)
 		return -ENOENT;
 
-	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
+	ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
 	if (!ret) {
 		of_node_put(np);
 		return -ENOENT;
@@ -114,23 +151,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 		return PTR_ERR(speedbin_nvmem);
 	}
 
-	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	ret = get_version(cpu_dev, speedbin_nvmem, &pvs_name, &versions);
 	nvmem_cell_put(speedbin_nvmem);
-	if (IS_ERR(speedbin))
-		return PTR_ERR(speedbin);
-
-	switch (msm8996_version) {
-	case MSM8996_V3:
-		versions = 1 << (unsigned int)(*speedbin);
-		break;
-	case MSM8996_SG:
-		versions = 1 << ((unsigned int)(*speedbin) + 4);
-		break;
-	default:
-		BUG();
-		break;
-	}
-	kfree(speedbin);
+	if (ret)
+		return ret;
 
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
@@ -166,24 +190,24 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
+static int qcom_cpufreq_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(cpufreq_dt_pdev);
 	return 0;
 }
 
-static struct platform_driver qcom_cpufreq_kryo_driver = {
-	.probe = qcom_cpufreq_kryo_probe,
-	.remove = qcom_cpufreq_kryo_remove,
+static struct platform_driver qcom_cpufreq_driver = {
+	.probe = qcom_cpufreq_probe,
+	.remove = qcom_cpufreq_remove,
 	.driver = {
-		.name = "qcom-cpufreq-kryo",
+		.name = "qcom-cpufreq",
 	},
 };
 
-static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
-	{ .compatible = "qcom,apq8096", },
-	{ .compatible = "qcom,msm8996", },
-	{}
+static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
+	{ .compatible = "qcom,apq8096", .data = qcom_cpufreq_kryo_name_version},
+	{ .compatible = "qcom,msm8996", .data = qcom_cpufreq_kryo_name_version},
+	{},
 };
 
 /*
@@ -192,7 +216,7 @@ static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
  * which may be defered as well. The init here is only registering
  * the driver and the platform device.
  */
-static int __init qcom_cpufreq_kryo_init(void)
+static int __init qcom_cpufreq_init(void)
 {
 	struct device_node *np = of_find_node_by_path("/");
 	const struct of_device_id *match;
@@ -201,32 +225,32 @@ static int __init qcom_cpufreq_kryo_init(void)
 	if (!np)
 		return -ENODEV;
 
-	match = of_match_node(qcom_cpufreq_kryo_match_list, np);
+	match = of_match_node(qcom_cpufreq_match_list, np);
 	of_node_put(np);
 	if (!match)
 		return -ENODEV;
 
-	ret = platform_driver_register(&qcom_cpufreq_kryo_driver);
+	ret = platform_driver_register(&qcom_cpufreq_driver);
 	if (unlikely(ret < 0))
 		return ret;
 
-	kryo_cpufreq_pdev = platform_device_register_simple(
-		"qcom-cpufreq-kryo", -1, NULL, 0);
-	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
+	cpufreq_pdev = platform_device_register_data(NULL, "qcom-cpufreq",
+						     -1, match, sizeof(*match));
+	ret = PTR_ERR_OR_ZERO(cpufreq_pdev);
 	if (0 == ret)
 		return 0;
 
-	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
+	platform_driver_unregister(&qcom_cpufreq_driver);
 	return ret;
 }
-module_init(qcom_cpufreq_kryo_init);
+module_init(qcom_cpufreq_init);
 
-static void __init qcom_cpufreq_kryo_exit(void)
+static void __init qcom_cpufreq_exit(void)
 {
-	platform_device_unregister(kryo_cpufreq_pdev);
-	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
+	platform_device_unregister(cpufreq_pdev);
+	platform_driver_unregister(&qcom_cpufreq_driver);
 }
-module_exit(qcom_cpufreq_kryo_exit);
+module_exit(qcom_cpufreq_exit);
 
-MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. CPUfreq driver");
 MODULE_LICENSE("GPL v2");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

