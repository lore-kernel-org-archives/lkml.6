Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x2250bWUaogxpFtLEBa+1dg39JRnxXs1PMH55Tl0geeVW3LaPfTcW2r4iJGlaSpkJfSX1fm0O
ARC-Seal: i=1; a=rsa-sha256; t=1517999512; cv=none;
        d=google.com; s=arc-20160816;
        b=O4g1vVAsCWODRRxDVLGcPJZ94Sfz8ZNDD+bTB5p/VWzJFkYShaCwW6IcrGF/sMH89+
         Zo3XAHuxA3n7AhQKeDyXcW+bjwzFACp70zA3VyMslbyDjI1SNV85X2WishL+y29QhdL2
         FztutBlOc2z9vlfLJ0l193f4uu/S88Xvv9I8ySxDEJxecnA7kSSraFwBRPnKjhqZeAii
         dAi36wCcPObV+Da+ru5pO+ESIPvQj3cfnGsyV+q47AYIxTTKHma3Pf4o2cLoWwiv7gc5
         lGTuy3zcF5r3nrfOnWMO1d8Dpun9AqyDEibfucqJfZGracwFvZuALN7GeDz22gabo16m
         /MIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=011l5+J9L21hndchlzZpUZ7nGOSclwXNe16Z5yJ7emw=;
        b=ippnLIjyBl2oet+aCUERVGpfYs2lHw80VijLr8yRZnUycH/zXwuBb6Y4E8hdE9Cl1h
         HwBnYpzNsyMIYYc+j7ngEeRCBtGiP2I1OD8ag6pEgbaG84WynpkhCWAeopioadCvNJuM
         RFM17YyF1Afvx5RmxxTPDSN3upKCODQLaZVohEmDuZ2zeFAGaMzYT/+jxh/L+2CGjCSc
         kPCTGH0RL21A4wY9lOA6+JQrVxYDmAS+0X0DpiWyBOwJKvUY4sXQ+MLGNxqXDh3WPVY/
         nasvOmt7s89dpOLMVE6pgoJqNNyIjuXhUfdOPnq+r0B/HkyFFHFQQk77+gExx/vOKPA3
         Y07g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=gGQ3bd0x;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SRy+X6Gc;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=gGQ3bd0x;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SRy+X6Gc;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FDFA609FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	rjw@rjwysocki.net,
	robin.murphy@arm.com,
	will.deacon@arm.com,
	robdclark@gmail.com,
	iommu@lists.linux-foundation.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Cc: alex.williamson@redhat.com,
	gregkh@linuxfoundation.org,
	airlied@linux.ie,
	sboyd@codeaurora.org,
	sricharan@codeaurora.org,
	m.szyprowski@samsung.com,
	architt@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	vivek.gautam@codeaurora.org
Subject: [PATCH v7 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Wed,  7 Feb 2018 16:01:18 +0530
Message-Id: <1517999482-17317-3-git-send-email-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737857427495630?=
X-GMAIL-MSGID: =?utf-8?q?1591737857427495630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Archit Taneja <architt@codeaurora.org>
[vivek: Clock rework to request bulk of clocks]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 69e7c60792a8..9e2f917e16c2 100644
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
+	struct clk_bulk_data		*clocks;
+	int				num_clks;
 
 	u32				cavium_id_base; /* Specific to Cavium */
 
@@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
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
@@ -2001,6 +2006,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	data = of_device_get_match_data(dev);
 	smmu->version = data->version;
 	smmu->model = data->model;
+	smmu->num_clks = data->num_clks;
 
 	parse_driver_options(smmu);
 
@@ -2039,6 +2045,28 @@ static void arm_smmu_bus_init(void)
 #endif
 }
 
+static int arm_smmu_init_clks(struct arm_smmu_device *smmu)
+{
+	int i;
+	int num = smmu->num_clks;
+	const struct arm_smmu_match_data *data;
+
+	if (num < 1)
+		return 0;
+
+	smmu->clocks = devm_kcalloc(smmu->dev, num,
+				    sizeof(*smmu->clocks), GFP_KERNEL);
+	if (!smmu->clocks)
+		return -ENOMEM;
+
+	data = of_device_get_match_data(smmu->dev);
+
+	for (i = 0; i < num; i++)
+		smmu->clocks[i].id = data->clks[i];
+
+	return devm_clk_bulk_get(smmu->dev, num, smmu->clocks);
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -2099,6 +2127,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	err = arm_smmu_init_clks(smmu);
+	if (err)
+		return err;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2197,7 +2229,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
+static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	return clk_bulk_prepare_enable(smmu->num_clks, smmu->clocks);
+}
+
+static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(smmu->num_clks, smmu->clocks);
+
+	return 0;
+}
+
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
+	SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
+			   arm_smmu_runtime_resume, NULL)
+};
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
