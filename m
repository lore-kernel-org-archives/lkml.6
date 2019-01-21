Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E4C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E51820989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gu893gCs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dw7WdVi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfAUHNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:13:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43290 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfAUHNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5410D60A34; Mon, 21 Jan 2019 05:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548050041;
        bh=TL7zgB0m7LfWtfKkA5XH+oaFc8qMHKopAjg5Aq+3o/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gu893gCs2E//yCSZZN1lzgiZZCKjan+WcXVDUcBGSviW6CkYD2+FRvwEAMbKb7agv
         we09e+DpyPJkTSHVOzp7FWRp0sR1dTkNFcR0fntXTYLW8/E7DRkB3KT+vh1K5H9pgN
         DId25rC7fyIo3U5Q4Awbm8uqj1MGm9hse04buyTM=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E929609BD;
        Mon, 21 Jan 2019 05:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548050040;
        bh=TL7zgB0m7LfWtfKkA5XH+oaFc8qMHKopAjg5Aq+3o/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dw7WdVi/8T6G7C6y8yBGXR+rj/0SdpbO7iU56HQq4m2SarCfX1sre/pQB/lQs0YlY
         rftBKz8sKcSwPqbYBJc5Lh2+4rTBn8u5SmU9ABAI6fQBuXEnGESkhXwstGrVfm1XPT
         fdVfMWQWngzNV5UEv4dc4SzmwmiB/NTkmdXNmbao=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E929609BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org,
        pratikp@codeaurora.org, pdaly@codeaurora.org,
        jcrouse@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 3/3] iommu/arm-smmu: Add support to use system cache
Date:   Mon, 21 Jan 2019 11:23:35 +0530
Message-Id: <20190121055335.15430-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few Qualcomm platforms, such as sdm845 have an additional outer
cache called as System cache, aka. Last level cache (LLC) that
allows non-coherent devices to upgrade to using caching.
This last level cache sits right before the DDR, and is tightly
coupled with the memory controller.
The cache is available to a number of devices - coherent and
non-coherent, present in the SoC system, and to CPUs.
The devices request their slices from this system cache, make it
active, and can then start using it.

Devices can set iommu domain attributes and page protection
while mapping the buffers to set the required memory attributes
to use system cache for buffers and page tables.
This change adds the support for iommu domain attributes and the
interaction with io page table driver.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 52b300dfc096..324f3bb54c78 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -260,7 +260,8 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
-#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT	BIT(0)
+#define ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE	BIT(1)
+#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT		BIT(0)
 	unsigned int			attr;
 };
 
@@ -910,6 +911,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	    smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_COHERENT;
 
+	if (smmu_domain->attr & ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_QCOM_SYS_CACHE;
+
 	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
@@ -1592,6 +1596,10 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_NESTING:
 			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 			return 0;
+		case DOMAIN_ATTR_QCOM_SYS_CACHE:
+			*(int *)data = !!(smmu_domain->attr &
+					  ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE);
+			return 0;
 		default:
 			return -ENODEV;
 		}
@@ -1633,6 +1641,16 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			else
 				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 			break;
+		case DOMAIN_ATTR_QCOM_SYS_CACHE:
+			if (smmu_domain->smmu) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+			if (*(int *)data)
+				smmu_domain->attr |= ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE;
+			else
+				smmu_domain->attr &= ~ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE;
+			break;
 		default:
 			ret = -ENODEV;
 		}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

