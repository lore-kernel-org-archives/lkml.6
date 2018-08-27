Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46FCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90338208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iQT9+C5w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OVWILMIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90338208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeH0OnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:43:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeH0OnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:43:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DAD5160912; Mon, 27 Aug 2018 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535367427;
        bh=gr3y4usWI/kzaDB8MqWoMbF+UWKgIeMkdzh48Cb1Jek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQT9+C5wbHL8dr0spT6PmMS7WdGYN2QIAnlcdieCdxV3RSDkp0RpF5vkPmfCnbK64
         AJ475da+yzaA8I228OLXy89onCQf1TiQ7mN8krcSCAlr1gjQrQIGZGqCM6FL5mEdWf
         tvuVCTfSo+55htH95U9O7Qvb2vC/NTGnOfRN882g=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62D2560227;
        Mon, 27 Aug 2018 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535367425;
        bh=gr3y4usWI/kzaDB8MqWoMbF+UWKgIeMkdzh48Cb1Jek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVWILMIYoIgyzJRs9YjFyFlyxqMGGh5h7tu+P7NiMbAPKCLYA8A9Y/aMZFdMl+l9U
         46trIZcojxV1pDdqQGf6Leh0QmxToXwqvymE4lpD/jiNbaMGLaB8sunmne7lqDZMdq
         gbeBGDfoi54dPNbmDBQat1GlH4ugeg+pi+8r47Tg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62D2560227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com, andy.gross@linaro.org,
        linux-pm@vger.kernel.org, sboyd@kernel.org, tfiga@chromium.org,
        jcrouse@codeaurora.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [Patch v15 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
Date:   Mon, 27 Aug 2018 16:25:47 +0530
Message-Id: <20180827105551.16346-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

The smmu needs to be functional only when the respective
master's using it are active. The device_link feature
helps to track such functional dependencies, so that the
iommu gets powered when the master device enables itself
using pm_runtime. So by adapting the smmu driver for
runtime pm, above said dependency can be addressed.

This patch adds the pm runtime/sleep callbacks to the
driver and also the functions to parse the smmu clocks
from DT and enable them in resume/suspend.

Also, while we enable the runtime pm add a pm sleep suspend
callback that pushes devices to low power state by turning
the clocks off in a system sleep.
Also add corresponding clock enable path in resume callback.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Archit Taneja <architt@codeaurora.org>
[vivek: rework for clock and pm ops]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v14:
 - none.

 drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fd1b80ef9490..a81224bc6637 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -48,6 +48,7 @@
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -205,6 +206,8 @@ struct arm_smmu_device {
 	u32				num_global_irqs;
 	u32				num_context_irqs;
 	unsigned int			*irqs;
+	struct clk_bulk_data		*clks;
+	int				num_clks;
 
 	u32				cavium_id_base; /* Specific to Cavium */
 
@@ -1896,10 +1899,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 struct arm_smmu_match_data {
 	enum arm_smmu_arch_version version;
 	enum arm_smmu_implementation model;
+	const char * const *clks;
+	int num_clks;
 };
 
 #define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
-static struct arm_smmu_match_data name = { .version = ver, .model = imp }
+static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
 
 ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
@@ -1918,6 +1923,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
+				   const char * const *clks)
+{
+	int i;
+
+	if (smmu->num_clks < 1)
+		return;
+
+	smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
+				  sizeof(*smmu->clks), GFP_KERNEL);
+	if (!smmu->clks)
+		return;
+
+	for (i = 0; i < smmu->num_clks; i++)
+		smmu->clks[i].id = clks[i];
+}
+
 #ifdef CONFIG_ACPI
 static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
 {
@@ -2000,6 +2022,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	data = of_device_get_match_data(dev);
 	smmu->version = data->version;
 	smmu->model = data->model;
+	smmu->num_clks = data->num_clks;
+
+	arm_smmu_fill_clk_data(smmu, data->clks);
 
 	parse_driver_options(smmu);
 
@@ -2098,6 +2123,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
+	if (err)
+		return err;
+
+	err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
+	if (err)
+		return err;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2184,6 +2217,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+
+	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
+
 	return 0;
 }
 
@@ -2192,15 +2228,50 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	arm_smmu_device_remove(pdev);
 }
 
-static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
+static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
 {
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
+	if (ret)
+		return ret;
 
 	arm_smmu_device_reset(smmu);
+
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
+static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	clk_bulk_disable(smmu->num_clks, smmu->clks);
+
+	return 0;
+}
+
+static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
+{
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	return arm_smmu_runtime_resume(dev);
+}
+
+static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
+{
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	return arm_smmu_runtime_suspend(dev);
+}
+
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)
+	SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
+			   arm_smmu_runtime_resume, NULL)
+};
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

