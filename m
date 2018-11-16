Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8190E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kPclpEq6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LdjvKpVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8190E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbeKPVg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:36:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49784 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKPVg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:36:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3F64460791; Fri, 16 Nov 2018 11:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542367499;
        bh=QR7wGVu1g0QX6aG9Xp76qX52AHOVlhpCcUIqLiw2ZwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPclpEq6qb4JBhP80exQbaVB8L9IRaqigXBmCocbL4HZO4ayYpDqVFBZhNs+Q5F/E
         pFFc7hczMPFd8WNgD/fTYi46/dmSA91Mu5IuQrvTkOmii0uMzP99eN1APFpPvzkPMi
         rFgEdACIQs7Gw0mIFpPB8gky0R2+uyQ0J1XIfCNs=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67AAD607EF;
        Fri, 16 Nov 2018 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542367497;
        bh=QR7wGVu1g0QX6aG9Xp76qX52AHOVlhpCcUIqLiw2ZwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdjvKpVBafLC5eDFcnShK8OFav+7/LY2ZjIGVLp+vMa9USqRtNpPK+LxkU/FpWrFt
         4zSFh+0DrD+R+fn3iTSZRoQflB5Rk2nx+VY5soyexcSw0wwPoguvKntS1xC6C1/PpE
         VX3os1Ag0pYs5MJGCTO9ikrZM5JyELsIMY0AuouI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67AAD607EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [RESEND PATCH v17 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
Date:   Fri, 16 Nov 2018 16:54:26 +0530
Message-Id: <20181116112430.31248-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5a28ae892504..f7ab7ce87a94 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -48,6 +48,7 @@
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -206,6 +207,8 @@ struct arm_smmu_device {
 	u32				num_global_irqs;
 	u32				num_context_irqs;
 	unsigned int			*irqs;
+	struct clk_bulk_data		*clks;
+	int				num_clks;
 
 	u32				cavium_id_base; /* Specific to Cavium */
 
@@ -1944,10 +1947,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
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
@@ -1966,6 +1971,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
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
@@ -2048,6 +2070,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	data = of_device_get_match_data(dev);
 	smmu->version = data->version;
 	smmu->model = data->model;
+	smmu->num_clks = data->num_clks;
+
+	arm_smmu_fill_clk_data(smmu, data->clks);
 
 	parse_driver_options(smmu);
 
@@ -2150,6 +2175,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
+	if (err)
+		return err;
+
+	err = clk_bulk_prepare_enable(smmu->num_clks, smmu->clks);
+	if (err)
+		return err;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2236,6 +2269,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+
+	clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
+
 	return 0;
 }
 
@@ -2244,15 +2280,50 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
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

