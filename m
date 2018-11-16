Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7974C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5CF2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="osbite6+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CkWqG133"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5CF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbeKPVhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:37:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51248 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKPVhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:37:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A796960C64; Fri, 16 Nov 2018 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542367543;
        bh=cch7VYbwoW1uJmF+lpFKVMJL3h07U+AHWKeO8B5gIXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osbite6+IZwU2442+CVVkzk1IAWKCSqLWCE4rJp+Eytv1yIqFq5EYSMNs6PJ2vvMN
         xazeIx4PrB+20YXpJuc03uISx379YuYgwzIb7HEukE3yT6QFl/L/caaJuVWy1KapG8
         ia7WSLYNNjHbZ/FHVrpanMvortc4Bao/t/2i3QZI=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DA1260D88;
        Fri, 16 Nov 2018 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542367526;
        bh=cch7VYbwoW1uJmF+lpFKVMJL3h07U+AHWKeO8B5gIXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkWqG133Y1mC7zAPzBlXbQZ3JFliKj2LagfCVitPKlzj7aAgANvuXrHxtbFvvgvoh
         liH4ABxATf4wn3Gk4xUAbz+MsTMg7l1dEeNvpPfeQ3wx4emiQyFufP5SELC67/o7K9
         tWT4LXSUt598EINuCElU1QiJCsDwgXVZOC+0m4hw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DA1260D88
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
Subject: [RESEND PATCH v17 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2 variant
Date:   Fri, 16 Nov 2018 16:54:30 +0530
Message-Id: <20181116112430.31248-6-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2098c3141f5f..d315ca637097 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -120,6 +120,7 @@ enum arm_smmu_implementation {
 	GENERIC_SMMU,
 	ARM_MMU500,
 	CAVIUM_SMMUV2,
+	QCOM_SMMUV2,
 };
 
 struct arm_smmu_s2cr {
@@ -2026,6 +2027,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
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
@@ -2033,6 +2045,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
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

