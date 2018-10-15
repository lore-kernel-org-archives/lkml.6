Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFA7C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A112064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A112064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeJOQWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:22:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbeJOQWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:22:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E8F7A97B8A35;
        Mon, 15 Oct 2018 16:37:49 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Mon, 15 Oct 2018
 16:37:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        LinuxArm <linuxarm@huawei.com>
Subject: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory corruption on Hi16xx soc
Date:   Mon, 15 Oct 2018 16:36:16 +0800
Message-ID: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ITS translation register map:
0x0000-0x003C	Reserved
0x0040		GITS_TRANSLATER
0x0044-0xFFFC	Reserved

The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
data will be written to MSIAddress each time.

MSIAddr: |----4bytes----|----4bytes----|
	 |    MSIData   |    IMPDEF    |

There is no problem for ITS, because the next 4 bytes space is reserved in ITS.
But it will overwrite the 4 bytes memory following "sync_count". It's very
luckly that the previous and the next neighbour of "sync_count" are both aligned
by 8 bytes, so no problem is met now.

It's good to explicitly add a workaround:
1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is always
   aligned by 8 bytes.
2. Add a "u64" union member to make sure the 4 bytes padding is always exist.

There is no functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5059d09..a07bc0d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -586,7 +586,10 @@ struct arm_smmu_device {
 
 	struct arm_smmu_strtab_cfg	strtab_cfg;
 
+	union {
+	u64				padding; /* workaround for Hisilicon */
 	u32				sync_count;
+	} __attribute__((aligned(8)));
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
-- 
1.8.3


