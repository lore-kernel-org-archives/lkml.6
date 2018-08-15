Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B5C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4E82156B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4E82156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeHOEWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:22:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbeHOEWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:22:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6F72B8C1BE635;
        Wed, 15 Aug 2018 09:32:42 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 15 Aug 2018
 09:32:33 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v5 5/5] iommu/arm-smmu-v3: add bootup option "iommu.non_strict"
Date:   Wed, 15 Aug 2018 09:28:30 +0800
Message-ID: <1534296510-12888-6-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bootup option to make the system manager can choose which mode to
be used. The default mode is strict.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 drivers/iommu/arm-smmu-v3.c                     | 22 +++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5cde1ff..cb9d043e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1720,6 +1720,19 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.

+	iommu.non_strict=	[ARM64]
+			Format: { "0" | "1" }
+			0 - strict mode, default.
+			    Release IOVAs after the related TLBs are invalid
+			    completely.
+			1 - non-strict mode.
+			    Put off TLBs invalidation and release memory first.
+			    It's good for scatter-gather performance but lacks
+			    full isolation, an untrusted device can access the
+			    reused memory because the TLBs may still valid.
+			    Please take	full consideration before choosing this
+			    mode. Note that, VFIO will always use strict mode.
+
 	iommu.passthrough=
 			[ARM64] Configure DMA to bypass the IOMMU by default.
 			Format: { "0" | "1" }
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 61eb7ec..0eda90e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -631,6 +631,26 @@ struct arm_smmu_option_prop {
 	{ 0, NULL},
 };

+static bool smmu_non_strict __read_mostly;
+
+static int __init arm_smmu_setup(char *str)
+{
+	int ret;
+
+	ret = kstrtobool(str, &smmu_non_strict);
+	if (ret)
+		return ret;
+
+	if (smmu_non_strict) {
+		pr_warn("WARNING: iommu non-strict mode is chosen.\n"
+			"It's good for scatter-gather performance but lacks full isolation\n");
+		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
+	}
+
+	return 0;
+}
+early_param("iommu.non_strict", arm_smmu_setup);
+
 static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
 						 struct arm_smmu_device *smmu)
 {
@@ -1622,7 +1642,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;

-	if (domain->type == IOMMU_DOMAIN_DMA) {
+	if ((domain->type == IOMMU_DOMAIN_DMA) && smmu_non_strict) {
 		domain->non_strict = true;
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 	}
--
1.8.3


