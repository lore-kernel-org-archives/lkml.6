Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74365C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F7420880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xs/4UlIj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A7n7B4m5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfAUHOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:14:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfAUHNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 78F47608BA; Mon, 21 Jan 2019 05:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548050032;
        bh=4mDXwAKHFSc10cR+k82iN/G4anm4O+nQXiSjDjukJ9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xs/4UlIjpWtE/38obAbEUQYGPqNjN4R+mOKk8kr4h1S+TK+0PrcyAIH1XwB5yXp1C
         Wi9juo6Tw4hd/VnQyB/eWlyeehoC3xWxB8xB4bK5JV8AP4gPMWhFx2O33iL2d4d+O2
         twpFBOVeUrso7f/BtjYjkQHJ5kvHqHxTMLJbKvyA=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 441566020B;
        Mon, 21 Jan 2019 05:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548050031;
        bh=4mDXwAKHFSc10cR+k82iN/G4anm4O+nQXiSjDjukJ9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7n7B4m5rAc5QToi9qamk/lPuXijQkDh0YIFRtv+Ku3l12hOlgK9FHgAbLFMywE3x
         w/aMMEhshHhzRNXFWosXrtLWrr3YRVdZhPNhoLB1hkgbtJrjAhFzAm+d4e4hU206lQ
         Cl2KzUIKR8kagaBcNuWUc/Mqr1wNr9ecdXBx8AQI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 441566020B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org,
        pratikp@codeaurora.org, pdaly@codeaurora.org,
        jcrouse@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 1/3] iommu/arm-smmu: Move to bitmap for arm_smmu_domain atrributes
Date:   Mon, 21 Jan 2019 11:23:33 +0530
Message-Id: <20190121055335.15430-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of arm_smmu_domain's attributes can be assigned based
on the iommu domains's attributes. These local attributes better
be managed by a bitmap.
So remove boolean flags and move to a 32-bit bitmap, and enable
each bits separtely.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7ebbcf1b2eb3..52b300dfc096 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -257,10 +257,11 @@ struct arm_smmu_domain {
 	const struct iommu_gather_ops	*tlb_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
-	bool				non_strict;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
+#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT	BIT(0)
+	unsigned int			attr;
 };
 
 struct arm_smmu_option_prop {
@@ -901,7 +902,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
 
-	if (smmu_domain->non_strict)
+	if (smmu_domain->attr & ARM_SMMU_DOMAIN_ATTR_NON_STRICT)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
 	/* Non coherent page table mappings only for Stage-1 */
@@ -1598,7 +1599,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case IOMMU_DOMAIN_DMA:
 		switch (attr) {
 		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
-			*(int *)data = smmu_domain->non_strict;
+			*(int *)data = !!(smmu_domain->attr &
+					  ARM_SMMU_DOMAIN_ATTR_NON_STRICT);
 			return 0;
 		default:
 			return -ENODEV;
@@ -1638,7 +1640,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	case IOMMU_DOMAIN_DMA:
 		switch (attr) {
 		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
-			smmu_domain->non_strict = *(int *)data;
+			smmu_domain->attr |= ARM_SMMU_DOMAIN_ATTR_NON_STRICT;
 			break;
 		default:
 			ret = -ENODEV;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

