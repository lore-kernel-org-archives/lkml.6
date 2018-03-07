Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeCGGcm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 01:32:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbeCGGck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 01:32:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61D62602A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: iommu@lists.linux-foundation.org, joro@8bytes.org,
        robin.murphy@arm.com
Cc: tfiga@chromium.org, Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS)
Subject: [PATCH 1/1] iommu/arm-smmu: Add support for qcom,smmu-500 variant
Date: Wed,  7 Mar 2018 12:02:19 +0530
Message-Id: <20180307063219.14409-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm's arm-smmu 500 implementation supports runtime pm
so enable the same.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

 Based on iommu/arm-smmu pm runtime support series [1]:
 [PATCH v8 0/5] iommu/arm-smmu: Add runtime pm/sleep support
 
 Tested on sdm845 with necessary support to enable the smmu
 and with necessary user.

 [1] https://lkml.org/lkml/2018/3/2/325

 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 14 ++++++++++++++
 drivers/iommu/arm-smmu.c                             |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 6ea27bd4f785..0b5c6d2a9865 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -18,6 +18,7 @@ conditions.
                         "arm,mmu-500"
                         "cavium,smmu-v2"
                         "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
+                        "qcom,<soc>-smmu-500", "qcom,smmu-500"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
@@ -30,6 +31,10 @@ conditions.
                   An example string would be -
                   "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
 
+                  "qcom,smmu-500" is arm,mmu-500 implementation that supports
+                  efficient power management by supporting smmu's state
+                  retention.
+
 - reg           : Base address and size of the SMMU.
 
 - #global-interrupts : The number of global interrupts exposed by the
@@ -179,3 +184,12 @@ conditions.
 			 <&mmcc SMMU_MDP_AHB_CLK>;
 		clock-names = "bus", "iface";
 	};
+
+	smmu5: iommu {
+		compatible = "qcom,sdm845-smmu-500", "qcom,smmu-500";
+		reg = <0x15000000 0x80000>;
+		#iommu-cells = <2>;
+		#global-interrupts = <1>;
+
+		...
+	};
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7a96c924ae22..7f52456c6b25 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2008,6 +2008,12 @@ static const char * const qcom_smmuv2_clks[] = {
 	"bus", "iface",
 };
 
+static const struct arm_smmu_match_data qcom_smmu500 = {
+	.version = ARM_SMMU_V2,
+	.model = ARM_MMU500,
+	.rpm_supported = true,
+};
+
 static const struct arm_smmu_match_data qcom_smmuv2 = {
 	.version = ARM_SMMU_V2,
 	.model = QCOM_SMMUV2,
@@ -2024,6 +2030,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
+	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu500 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
@@ -2394,6 +2401,7 @@ IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401");
 IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500");
 IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2");
 IOMMU_OF_DECLARE(qcom_smmuv2, "qcom,smmu-v2");
+IOMMU_OF_DECLARE(qcom_smmu500, "qcom,smmu-500");
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
