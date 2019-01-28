Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F8C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8807821917
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691530;
	bh=uQYtjBKDZsFz2zCHnVnVeMlqRtrAmaMlhd8HHe38UpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CIM310nKb8aqPikBBlAYY4+BEBKQc7FJq2q3AUmfV8xO+JYxKth4UqZ0jpT2r2vlg
	 E7NqTyEEvcBPkhHX1yxnb84hkHOgX4Z/02TccKchzhLu6msodjBKxDOvXG3DlAT537
	 OlrgQc++Mo707EbklX35pkLlM64CBUwpQfPsrIvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfA1QF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:05:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731235AbfA1QFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F532147A;
        Mon, 28 Jan 2019 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691523;
        bh=uQYtjBKDZsFz2zCHnVnVeMlqRtrAmaMlhd8HHe38UpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhJeZMk/H/i+J+JKUGBneoMrHK4q54gZZmv9e2E3zGiYL352JhbHE2UzWZ0XyhP1k
         eiyhDjPZ6v4VJTvCXmb75ghz+LEh5yKDtxgu3uNGHW/SI4Sesm6gXROZG5fm6bTY/h
         ZsldJcAymtQkgwXKkYBxv7zVueFHRtn2ukr2jy2I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 128/258] iommu/arm-smmu-v3: Avoid memory corruption from Hisilicon MSI payloads
Date:   Mon, 28 Jan 2019 10:57:14 -0500
Message-Id: <20190128155924.51521-128-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index 3e02aace38b1..4afb9cb99ea3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -586,7 +586,11 @@ struct arm_smmu_device {
 
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

