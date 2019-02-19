Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC59FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8465721908
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfBSH5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:57:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3783 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbfBSH5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:57:10 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CE2F61F92350A8F9A9FE;
        Tue, 19 Feb 2019 15:57:05 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 15:56:55 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/5] iommu/arm-smmu-v3: make sure the stale caching of L1STD are invalid
Date:   Tue, 19 Feb 2019 15:54:39 +0800
Message-ID: <20190219075443.17732-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190219075443.17732-1-thunder.leizhen@huawei.com>
References: <20190219075443.17732-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invalidate the caching of the intermediate L1ST descriptor after it has
been updated.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 0d28402..2072897 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1072,13 +1072,14 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	*dst = cpu_to_le64(val);
 }

-static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
+static void
+__arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid, bool leaf)
 {
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_STE,
 		.cfgi	= {
 			.sid	= sid,
-			.leaf	= true,
+			.leaf	= leaf,
 		},
 	};

@@ -1086,6 +1087,16 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	arm_smmu_cmdq_issue_sync(smmu);
 }

+static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	__arm_smmu_sync_ste_for_sid(smmu, sid, true);
+}
+
+static void arm_smmu_sync_std_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	__arm_smmu_sync_ste_for_sid(smmu, sid, false);
+}
+
 static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 				      __le64 *dst, struct arm_smmu_strtab_ent *ste)
 {
@@ -1233,6 +1244,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)

 	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
+	arm_smmu_sync_std_for_sid(smmu, sid);
 	return 0;
 }

--
1.8.3


