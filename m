Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B74DC65BBF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5855B213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5855B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeJFD4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:24959 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbeJFD4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 13:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,346,1534834800"; 
   d="scan'208";a="263254409"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.132])
  by orsmga005.jf.intel.com with ESMTP; 05 Oct 2018 13:55:30 -0700
From:   thor.thayer@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        aisheng.dong@nxp.com, sboyd@kernel.org
Cc:     vivek.gautam@codeaurora.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv4 2/2] iommu/arm-smmu: Get clock config from device tree
Date:   Fri,  5 Oct 2018 15:57:00 -0500
Message-Id: <1538773020-27784-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538773020-27784-1-git-send-email-thor.thayer@linux.intel.com>
References: <1538773020-27784-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Currently the clocks are specified in a structure as well as
in the device tree. Since all the information about clocks can be
pulled from the device tree, parse the device tree for the clock
information if specified.

This patch is dependent upon the following patch series that
adds clocks to the driver.
"[v16,0/5] iommu/arm-smmu: Add runtime pm/sleep support"
https://patchwork.kernel.org/cover/10581891/

particularly this patch which adds the clocks:
"[v16,1/5] iommu/arm-smmu: Add pm_runtime/sleep ops"
https://patchwork.kernel.org/patch/10581899/

Request testing on different platforms for verification.
This patch was tested on a Stratix10 SOCFPGA.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v4  Change dependency on pending patch series that adds clocks.
    Add code for parsing device tree for the clocks.
v3  Change dependency on device tree bulk clock patches.
v2  Add structure for SOCFPGA and add dependency on clock patch.
---
 drivers/iommu/arm-smmu.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d315ca637097..3dd10663b09c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -44,6 +44,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_clk.h>
 #include <linux/of_device.h>
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
@@ -2139,6 +2140,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	const struct arm_smmu_match_data *data;
 	struct device *dev = &pdev->dev;
 	bool legacy_binding;
+	const char **parent_names;
 
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
@@ -2149,9 +2151,25 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	data = of_device_get_match_data(dev);
 	smmu->version = data->version;
 	smmu->model = data->model;
-	smmu->num_clks = data->num_clks;
-
-	arm_smmu_fill_clk_data(smmu, data->clks);
+	smmu->num_clks = of_clk_get_parent_count(dev->of_node);
+	/* check to see if clocks were specified in DT */
+	if (smmu->num_clks) {
+		unsigned int i;
+
+		parent_names = kmalloc_array(smmu->num_clks,
+					     sizeof(*parent_names),
+					     GFP_KERNEL);
+		if (!parent_names)
+			goto fail_clk_name;
+
+		for (i = 0; i < smmu->num_clks; i++) {
+			if (of_property_read_string_index(dev->of_node,
+							  "clock-names", i,
+							  &parent_names[i]))
+				goto fail_clk_name;
+		}
+		arm_smmu_fill_clk_data(smmu, parent_names);
+	}
 
 	parse_driver_options(smmu);
 
@@ -2171,6 +2189,12 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
 
 	return 0;
+
+fail_clk_name:
+	kfree(parent_names);
+	/* clock-names required for clocks in devm_clk_bulk_get() */
+	dev_err(dev, "Error: clock-name required in device tree\n");
+	return -ENOMEM;
 }
 
 static void arm_smmu_bus_init(void)
-- 
2.7.4

