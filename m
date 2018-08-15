Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA04AC46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCFD2156E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCFD2156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeHOEWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:22:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44799 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbeHOEWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:22:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BBF06FC51CAB9;
        Wed, 15 Aug 2018 09:32:38 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Wed, 15 Aug 2018
 09:32:31 +0800
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
Subject: [PATCH v5 4/5] iommu/arm-smmu-v3: add support for non-strict mode
Date:   Wed, 15 Aug 2018 09:28:29 +0800
Message-ID: <1534296510-12888-5-git-send-email-thunder.leizhen@huawei.com>
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

Dynamically choose strict or non-strict mode for page table config based
on the iommu domain type.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4402187..61eb7ec 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1622,6 +1622,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;

+	if (domain->type == IOMMU_DOMAIN_DMA) {
+		domain->non_strict = true;
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+	}
+
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
--
1.8.3


