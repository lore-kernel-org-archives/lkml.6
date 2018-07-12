Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E7C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EFE20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EFE20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeGLG1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:27:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732191AbeGLG1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:27:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7AB07ACFC0DCF;
        Thu, 12 Jul 2018 14:19:15 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Thu, 12 Jul 2018
 14:19:07 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 6/6] iommu/arm-smmu-v3: add bootup option "iommu_strict_mode"
Date:   Thu, 12 Jul 2018 14:18:32 +0800
Message-ID: <1531376312-2192-7-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the non-strict mode introduces a vulnerability window, so add a
bootup option to make the manager can choose which mode to be used. The
default mode is IOMMU_STRICT.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++
 drivers/iommu/arm-smmu-v3.c                     | 32 ++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7..0cc80bc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1720,6 +1720,18 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
+	iommu_strict_mode=	[arm-smmu-v3]
+		0 - strict mode
+		    Make sure all related TLBs to be invalidated before the
+		    memory released.
+		1 - non-strict mode
+		    Put off TLBs invalidation and release memory first. This mode
+		    introduces a vlunerability window, an untrusted device can
+		    access the reused memory because the TLBs may still valid.
+		    Please take full consideration before choosing this mode.
+		    Note that, VFIO is always use strict mode.
+		others - strict mode
+
 	iommu.passthrough=
 			[ARM64] Configure DMA to bypass the IOMMU by default.
 			Format: { "0" | "1" }
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4a198a0..9b72fc4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -631,6 +631,24 @@ struct arm_smmu_option_prop {
 	{ 0, NULL},
 };
 
+static u32 iommu_strict_mode __read_mostly = IOMMU_STRICT;
+
+static int __init setup_iommu_strict_mode(char *str)
+{
+	u32 strict_mode = IOMMU_STRICT;
+
+	get_option(&str, &strict_mode);
+	if (strict_mode == IOMMU_NON_STRICT) {
+		iommu_strict_mode = strict_mode;
+		pr_warn("WARNING: iommu non-strict mode is chose.\n"
+			"It's good for scatter-gather performance but lacks full isolation\n");
+		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
+	}
+
+	return 0;
+}
+early_param("iommu_strict_mode", setup_iommu_strict_mode);
+
 static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
 						 struct arm_smmu_device *smmu)
 {
@@ -1441,7 +1459,7 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	case IOMMU_CAP_NON_STRICT:
-		return true;
+		return (iommu_strict_mode == IOMMU_NON_STRICT) ? true : false;
 	default:
 		return false;
 	}
@@ -1750,6 +1768,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 
+static u32 arm_smmu_strict_mode(struct iommu_domain *domain)
+{
+	if (iommu_strict_mode == IOMMU_NON_STRICT)
+		return IOMMU_DOMAIN_STRICT_MODE(domain);
+
+	return IOMMU_STRICT;
+}
+
 static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int prot)
 {
@@ -1769,7 +1795,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!ops)
 		return 0;
 
-	return ops->unmap(ops, iova | IOMMU_DOMAIN_STRICT_MODE(domain), size);
+	return ops->unmap(ops, iova | arm_smmu_strict_mode(domain), size);
 }
 
 static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
@@ -1784,7 +1810,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
 {
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
 
-	if (smmu && (IOMMU_DOMAIN_STRICT_MODE(domain) == IOMMU_STRICT))
+	if (smmu && (arm_smmu_strict_mode(domain) == IOMMU_STRICT))
 		__arm_smmu_tlb_sync(smmu);
 }
 
-- 
1.8.3


