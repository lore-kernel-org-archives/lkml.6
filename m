Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F15C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1524C213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1524C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJDFQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:16:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:58241 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeJDFQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:16:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 15:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,337,1534834800"; 
   d="scan'208";a="88962357"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.132])
  by orsmga003.jf.intel.com with ESMTP; 03 Oct 2018 15:25:58 -0700
From:   thor.thayer@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        aisheng.dong@nxp.com, sboyd@kernel.org
Cc:     vivek.gautam@codeaurora.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv3 2/2] iommu/arm-smmu: Add SMMU clock
Date:   Wed,  3 Oct 2018 17:28:13 -0500
Message-Id: <1538605693-22073-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
References: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add a clock to the SMMU structure. In the device tree case,
check for a clock node and enable the clock if found.

This patch is dependent upon the following patches that add
a device tree bulk clock function.
"[V6, 1/4] clk: bulk: add of_clk_bulk_get()"
https://patchwork.kernel.org/patch/10583133/
"[V6, 2/4] clk: add new APIs to operation on all available
clocks"
https://patchwork.kernel.org/patch/10583131/
"[V6, 3/4] clk: add managerged version of clk_bulk_get_all"
https://patchwork.kernel.org/patch/10583139/

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5a28ae892504..0f4596b42ca7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -213,6 +213,8 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+	int				num_clks;
+	struct clk_bulk_data		*clks;
 };
 
 enum arm_smmu_context_fmt {
@@ -2038,6 +2040,17 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	const struct arm_smmu_match_data *data;
 	struct device *dev = &pdev->dev;
 	bool legacy_binding;
+	int ret;
+
+	/* If a clock is declared, enable it */
+	ret = devm_clk_bulk_get_all(smmu->dev, &smmu->clks);
+	if (IS_ERR(ret)) {
+		smmu->clks = NULL;
+		dev_dbg(dev, "cannot get smmu clock\n");
+	} else {
+		smmu->num_clks = ret;
+		clk_bulk_prepare_enable(smmu->num_clks, smmu->clks);
+	}
 
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
@@ -2236,6 +2249,10 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+
+	if (smmu->clks)
+		clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
+
 	return 0;
 }
 
@@ -2248,6 +2265,9 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
 {
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 
+	if (smmu->clks)
+		clk_bulk_prepare_enable(smmu->num_clks, smmu->clks);
+
 	arm_smmu_device_reset(smmu);
 	return 0;
 }
-- 
2.7.4

