Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D6FC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E900214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E900214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJTPrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 11:47:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbeJTPrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 11:47:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4A12089EE3D1;
        Sat, 20 Oct 2018 15:38:04 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Sat, 20 Oct 2018
 15:37:57 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        LinuxArm <linuxarm@huawei.com>
Subject: [PATCH v2 1/1] iommu/arm-smmu-v3: eliminate a potential memory corruption on Hi16xx soc
Date:   Sat, 20 Oct 2018 15:36:54 +0800
Message-ID: <1540021014-8176-1-git-send-email-thunder.leizhen@huawei.com>
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

It's good to explicitly add a workaround:
1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is
   always aligned by 8 bytes.
2. Add a "int" struct member to make sure the 4 bytes padding is always
   exist.

There is no functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5059d09..624fdd0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -586,7 +586,20 @@ struct arm_smmu_device {
 
 	struct arm_smmu_strtab_cfg	strtab_cfg;
 
-	u32				sync_count;
+	/*
+	 * The alignment and padding is required by Hi16xx of Hisilicon.
+	 * Because the ITS hardware on Hi16xx will truncate the MSIAddress(Here
+	 * it's the address of "sync_count") to 8 bytes boundary first, then
+	 * write 32 bits MSIdata at offset 0, and 32 bits IMPDEF data at offset
+	 * 4. Without this workaround, the adjacent member maybe overwritten.
+	 *
+	 *                    |---4bytes---|---4bytes---|
+	 * MSIAddress & (~0x7):   MSIdata  | IMPDEF data|
+	 */
+	struct {
+		u32			sync_count;
+		int			padding;
+	} __attribute__((aligned(8)));
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
-- 
1.8.3


