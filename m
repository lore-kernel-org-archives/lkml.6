Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A635C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC0920890
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R4xGa76u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gl4OA7MX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC0920890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbeGHRey (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 13:34:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60402 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbeGHRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 13:34:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F44360B6B; Sun,  8 Jul 2018 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531071290;
        bh=paoQyA5Glk5O5rRbAmlCWxuUTlj/UxqVmHa/wJCf3q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4xGa76uklySj8Nt3YD3VRnTp4hlnM/n6phuo0cjM1aSwNVRyA2gAri5iUsZS5ceI
         1EM5GJlE36gZ/ykFu2JrZc9fn1ti7oIeZHhGus+C1mykMvL/jCKpnmdujqRecgT8o4
         JE51yeE5uwKlPoZacrFIf2423E106uuc3qeEVv4w=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C89A60B16;
        Sun,  8 Jul 2018 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531071289;
        bh=paoQyA5Glk5O5rRbAmlCWxuUTlj/UxqVmHa/wJCf3q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gl4OA7MX0MNqKqjld1iOc1JYkcMPYmojxoEns4JLMtDRn+T3H/MgwFkifcgcD+n58
         mH+BHQM7Tfhve6Je3x6vBlap66QvXKO2VYBpTtLDoJpnYtIj2K+/douhDzKptyl4X3
         iiT699Kn5AEsa+/OmNeAep6iKh+frAy2Yr/BMD+0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C89A60B16
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, rjw@rjwysocki.net, robdclark@gmail.com,
        linux-pm@vger.kernel.org, freedreno@lists.freedesktop.org,
        sboyd@kernel.org, tfiga@chromium.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jcrouse@codeaurora.org,
        vivek.gautam@codeaurora.org
Subject: [PATCH v12 4/4] iommu/arm-smmu: Add support for qcom,smmu-v2 variant
Date:   Sun,  8 Jul 2018 23:04:13 +0530
Message-Id: <20180708173413.1965-5-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
clock and power requirements. This smmu core is used with
multiple masters on msm8996, viz. mdss, video, etc.
Add bindings for the same.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---

 - No change since v11.

 .../devicetree/bindings/iommu/arm,smmu.txt         | 42 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           | 14 ++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 8a6ffce12af5..7c71a6ed465a 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -17,10 +17,19 @@ conditions.
                         "arm,mmu-401"
                         "arm,mmu-500"
                         "cavium,smmu-v2"
+                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
 
+                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
+                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
+                  string that should be present along with the "qcom,smmu-v2"
+                  to facilitate SoC specific clocks/power connections and to
+                  address specific bug fixes.
+                  An example string would be -
+                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
+
 - reg           : Base address and size of the SMMU.
 
 - #global-interrupts : The number of global interrupts exposed by the
@@ -71,6 +80,22 @@ conditions.
                   or using stream matching with #iommu-cells = <2>, and
                   may be ignored if present in such cases.
 
+- clock-names:    List of the names of clocks input to the device. The
+                  required list depends on particular implementation and
+                  is as follows:
+                  - for "qcom,smmu-v2":
+                    - "bus": clock required for downstream bus access and
+                             for the smmu ptw,
+                    - "iface": clock required to access smmu's registers
+                               through the TCU's programming interface.
+                  - unspecified for other implementations.
+
+- clocks:         Specifiers for all clocks listed in the clock-names property,
+                  as per generic clock bindings.
+
+- power-domains:  Specifiers for power domains required to be powered on for
+                  the SMMU to operate, as per generic power domain bindings.
+
 ** Deprecated properties:
 
 - mmu-masters (deprecated in favour of the generic "iommus" binding) :
@@ -137,3 +162,20 @@ conditions.
                 iommu-map = <0 &smmu3 0 0x400>;
                 ...
         };
+
+	/* Qcom's arm,smmu-v2 implementation */
+	smmu4: iommu {
+		compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+		reg = <0xd00000 0x10000>;
+
+		#global-interrupts = <1>;
+		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		power-domains = <&mmcc MDSS_GDSC>;
+
+		clocks = <&mmcc SMMU_MDP_AXI_CLK>,
+			 <&mmcc SMMU_MDP_AHB_CLK>;
+		clock-names = "bus", "iface";
+	};
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 916cde4954d2..a9edb17f09bf 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -119,6 +119,7 @@ enum arm_smmu_implementation {
 	GENERIC_SMMU,
 	ARM_MMU500,
 	CAVIUM_SMMUV2,
+	QCOM_SMMUV2,
 };
 
 struct arm_smmu_s2cr {
@@ -1980,6 +1981,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
 
+static const char * const qcom_smmuv2_clks[] = {
+	"bus", "iface",
+};
+
+static const struct arm_smmu_match_data qcom_smmuv2 = {
+	.version = ARM_SMMU_V2,
+	.model = QCOM_SMMUV2,
+	.clks = qcom_smmuv2_clks,
+	.num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
 	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
@@ -1987,6 +1999,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
+	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
@@ -2361,6 +2374,7 @@ IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400");
 IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401");
 IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500");
 IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2");
+IOMMU_OF_DECLARE(qcom_smmuv2, "qcom,smmu-v2");
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

