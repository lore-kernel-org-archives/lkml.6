Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCBB2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895379;
	bh=xd5acvtQcvElPKnope4Wr/VzdUtMc+tIoMV+NAEGtR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hjjz+W9K0vJJB6H4ADI4JmqhxAcKI2P7wdA4uFnotbyGREcyqnzOdRo61uqZqI6Gy
	 WYagI0ZRLhNlH6ZYUqQUirNddEzisn4HAOHM1FoRQoBlefle/cejPYE0H2BK5HOkeT
	 neAVusR8q/Vo020DeKrdANP6zbMRf8NvkJOh45wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfBKO3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:29:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbfBKO3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:29:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1BB20675;
        Mon, 11 Feb 2019 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895372;
        bh=xd5acvtQcvElPKnope4Wr/VzdUtMc+tIoMV+NAEGtR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xsfePqPsi/GA1VNzPcet8RS1snAXxFXHWTp5OcdzLVvucNGEqNolGpdpKs0VASC4Y
         5gyIgfR7z/BH/Nv6t1zEEXyYbNHCvxZJ+H7wQEOu5IYcc/7ENA0Eo8csBeuH21PCRl
         4LqVnkmVH9eBAoP6OAoUjt6ZhVq0l8m3uxVa6F/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 142/352] iommu/arm-smmu-v3: Avoid memory corruption from Hisilicon MSI payloads
Date:   Mon, 11 Feb 2019 15:16:09 +0100
Message-Id: <20190211141855.585453813@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



