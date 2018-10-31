Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA989ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847EE2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847EE2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeJaNBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 09:01:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14163 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728467AbeJaNBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 09:01:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1EB989C66F38F;
        Wed, 31 Oct 2018 12:04:37 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Wed, 31 Oct 2018
 12:04:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        LinuxArm <linuxarm@huawei.com>
Subject: [PATCH v3 1/1] iommu/arm-smmu-v3: eliminate a potential memory corruption on hi1620 and earlier
Date:   Wed, 31 Oct 2018 12:02:07 +0800
Message-ID: <1540958527-15408-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard GITS_TRANSLATER register in ITS is only 4 bytes, but
Hisilicon expands the next 4 bytes to carry some IMPDEF information. That
means, total 8 bytes data will be written to MSIAddress each time.

MSIAddr: |----4bytes----|----4bytes----|
	 |    MSIData   |    IMPDEF    |

There is no problem for ITS, because the next 4 bytes space is reserved
in ITS. But it will overwrite the 4 bytes memory following "sync_count".
It's very fortunately that the previous and the next neighbour of the
"sync_count" are both aligned by 8 bytes, so no problem is met now.

It's good to explicitly add a workaround. Let's enclose the "sync_count"
into a union and companion with a new member "padding" of type u64.

There is no functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6947ccf..4e94730 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -576,7 +576,23 @@ struct arm_smmu_device {

 	struct arm_smmu_strtab_cfg	strtab_cfg;

-	u32				sync_count;
+	/*
+	 * The member "padding" is used to make sure the member "sync_count" to
+	 * be aligned at 8 bytes boundary, and 4 bytes padding memory followed.
+	 *
+	 * These are required by hi1620 and earlier of Hisilicon. Because the
+	 * ITS hardware on hi1620 and earlier will truncate the MSIAddress(Here
+	 * it's the address of "sync_count") to 8 bytes boundary first, then
+	 * write 32 bits MSIdata at offset 0, and 32 bits IMPDEF data at offset
+	 * 4. Without this workaround, the adjacent member maybe overwritten.
+	 *
+	 *                    |---4bytes---|---4bytes---|
+	 * MSIAddress & (~0x7):   MSIdata  | IMPDEF data|
+	 */
+	union {
+		u32			sync_count;
+		u64			padding;
+	};

 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
--
1.8.3


