Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACDC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398120852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4398120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbeGYTfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:35:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:39041 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730624AbeGYTfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:35:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 11:22:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,401,1526367600"; 
   d="scan'208";a="57133547"
Received: from tthayer-hp-z620-workstation.an.intel.com ([10.122.105.144])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jul 2018 11:22:13 -0700
From:   thor.thayer@linux.intel.com
To:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dinguyen@kernel.org, will.deacon@arm.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 2/2] iommu/arm-smmu: Add support for Stratix10 smmu-v2 variant
Date:   Wed, 25 Jul 2018 13:24:37 -0500
Message-Id: <1532543077-8933-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532543077-8933-1-git-send-email-thor.thayer@linux.intel.com>
References: <1532543077-8933-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the clocks required for the Stratix10 SMMU. Define the
clock names in the SMMU name array and add DT compatible
matching element.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
This patch is dependent on the patch series
"iommu/arm-smmu: Add runtime pm/sleep support"
(https://patchwork.ozlabs.org/cover/946160/)
---
 drivers/iommu/arm-smmu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c69736a30f8..d46216b34a77 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1983,6 +1983,17 @@ static const struct arm_smmu_match_data qcom_smmuv2 = {
 	.num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
 };
 
+static const char * const altr_smmuv2_clks[] = {
+	"masters"
+};
+
+static const struct arm_smmu_match_data altr_smmuv2 = {
+	.version = ARM_SMMU_V2,
+	.model = ARM_MMU500,
+	.clks = altr_smmuv2_clks,
+	.num_clks = ARRAY_SIZE(altr_smmuv2_clks),
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
 	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
@@ -1991,6 +2002,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
+	{ .compatible = "altr,smmu-v2", .data = &altr_smmuv2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
-- 
2.7.4

