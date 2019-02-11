Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D74C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160C42081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896370;
	bh=l834Psl9nZOCjPUyC6DZ1YnQQzDj4egt9fCRUFEOrjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qu+ilDoAFMpYNOFhKjxc/sYmMia6vDS+0dnV4T+xsfiwUCDF+LlmaBgJN+MVRTQkx
	 2Wyjg/cWkaus5olnTxm4//URO/5ZQ8EN8BDz/qwZiodo7e1jFGgLJ3SZ9LuBjlpWar
	 BDo5MNdwOfJ6iXOzBHX5D5M9SfJDgqTLhFx0ewig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfBKOqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733165AbfBKOqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C853206BA;
        Mon, 11 Feb 2019 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896363;
        bh=l834Psl9nZOCjPUyC6DZ1YnQQzDj4egt9fCRUFEOrjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSi9jT7hvDJRM9Nnja3PTz2uFHXGY+P5ceCRwIQX9hMwNNE4rH9/ih+Zb9iJriK2v
         Mnask1NLWoxSdDebza4XBuHQzGg4spn+96Lktz104C23pH+29VvZi2uZaXK5MDgGEH
         nNB8I4YvrbWyUzOJBKwF3bDaGoFyPfxTtDtW5Q1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 120/313] iommu/arm-smmu-v3: Avoid memory corruption from Hisilicon MSI payloads
Date:   Mon, 11 Feb 2019 15:16:40 +0100
Message-Id: <20190211141901.833693497@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



