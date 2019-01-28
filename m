Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8EBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE77E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690653;
	bh=LprpV4UnOTPZ1HfCtr1O1VSOnkqTd/K3SXOPvtZgANQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yTiz0fF3kxQBB53jxhGQkQ+F4UJWag8zD65trhY/fbOR4U2xV1xRXsGnqDJmtRf3V
	 XDHCYIhMFNsDbID0Xwad/9iFbGQx8VPwMGDKZD/6v4hIVG+/+2nMp/DX1mYYSzmW/o
	 CZHMtOGmVOgjCr5hSXrLUYVwLfv3Fn3MBksPiWIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfA1Puw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbfA1Pus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:50:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3FB2147A;
        Mon, 28 Jan 2019 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690647;
        bh=LprpV4UnOTPZ1HfCtr1O1VSOnkqTd/K3SXOPvtZgANQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pd4VNRG8qxAIN+psLEXEbeJ/o7+W7n+KpOGs2m55L5VMewF2FEI1+f6kSvQnVegW5
         cw1MQOT9xkN9cErJ5hNnWmd2DaNs+QL8goppko4ZVhbUdZOK50GPG4wjs8xs9fUbin
         vuxIa0zwEkgvU68OVIwnA7sQsqtx1Uijaj1MLdx8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.20 152/304] iommu/arm-smmu-v3: Avoid memory corruption from Hisilicon MSI payloads
Date:   Mon, 28 Jan 2019 10:41:09 -0500
Message-Id: <20190128154341.47195-152-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 84a9a75774961612d0c7dd34a1777e8f98a65abd ]

The GITS_TRANSLATER MMIO doorbell register in the ITS hardware is
architected to be 4 bytes in size, yet on hi1620 and earlier, Hisilicon
have allocated the adjacent 4 bytes to carry some IMPDEF sideband
information which results in an 8-byte MSI payload being delivered when
signalling an interrupt:

MSIAddr:
	 |----4bytes----|----4bytes----|
	 |    MSIData   |    IMPDEF    |

This poses no problem for the ITS hardware because the adjacent 4 bytes
are reserved in the memory map. However, when delivering MSIs to memory,
as we do in the SMMUv3 driver for signalling the completion of a SYNC
command, the extended payload will corrupt the 4 bytes adjacent to the
"sync_count" member in struct arm_smmu_device. Fortunately, the current
layout allocates these bytes to padding, but this is fragile and we
should make this explicit.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[will: Rewrote commit message and comment]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 71eda422c926..62ef4afc9ee5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -576,7 +576,11 @@ struct arm_smmu_device {
 
 	struct arm_smmu_strtab_cfg	strtab_cfg;
 
-	u32				sync_count;
+	/* Hi16xx adds an extra 32 bits of goodness to its MSI payload */
+	union {
+		u32			sync_count;
+		u64			padding;
+	};
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
-- 
2.19.1

