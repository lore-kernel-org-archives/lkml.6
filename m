Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388C4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39F1208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EbP6k13J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l/2LqoKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39F1208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeH0Onx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:43:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40136 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeH0Onx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:43:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A8DC60B1E; Mon, 27 Aug 2018 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535367462;
        bh=zqhjyYXYCkGxUuBTOWuU20CG4QwyI9M1vCIVXijAu+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbP6k13JiCgxBB7Wo2Y4Kuv4b6a8s0XrxjLzatH4NCrPptInNBOxAPxJdwmO2sP6E
         JuMfBicb5zZeI8PzjhyZcSFO4FiPlufpUc8sTmtK3nifTEg2jiRqvPZXL+bWo4Mpcz
         zeetQjHgqmhSPd7eK0uNRDIn16WuYAGy1fGx+j20=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1EAC5601D1;
        Mon, 27 Aug 2018 10:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535367453;
        bh=zqhjyYXYCkGxUuBTOWuU20CG4QwyI9M1vCIVXijAu+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/2LqoKdUPVYnpg8y8vWMAdGS4ZSlnYf09nT+7ceBiS+BLySHhcldPRWQTK8O2hzh
         dFUnc2qKw/guEbaNILPJr3hTSnApQ76rrvU4qJJp0wb8YZmO+tIdSCBWN0nJxqV/9M
         NXb/NcXt7YfC4itaGQ216oXsnuVuFs5pXXQodXf8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EAC5601D1
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
Subject: [Patch v15 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2 variant
Date:   Mon, 27 Aug 2018 16:25:51 +0530
Message-Id: <20180827105551.16346-6-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
clock and power requirements.
On msm8996, multiple cores, viz. mdss, video, etc. use this
smmu. On sdm845, this smmu is used with gpu.
Add bindings for the same.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v14:
 - Moved out dt-bindings change to separate patch.

 drivers/iommu/arm-smmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b5e7f72d418c..c0177ea32678 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -119,6 +119,7 @@ enum arm_smmu_implementation {
 	GENERIC_SMMU,
 	ARM_MMU500,
 	CAVIUM_SMMUV2,
+	QCOM_SMMUV2,
 };
 
 struct arm_smmu_s2cr {
@@ -1970,6 +1971,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
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
@@ -1977,6 +1989,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
+	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

