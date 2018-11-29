Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB327C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE8E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5qF3ncE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE8E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbeK2RGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:06:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeK2RGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:06:06 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B82F208E7;
        Thu, 29 Nov 2018 06:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471314;
        bh=r/Q8WR9zXUQ7bVZSXH1Aob+rsUAAuekePC9aESqj4Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5qF3ncE9RXQZiGkhs52ttYsPwUuv8XU23bb5qU/8X6pQUE+Dhmc4QgCM+2UeKu4e
         Qd7AZlF8vAwmp9WGTMAV460ZlCxAfaVvmnohlsibAeT8rFQGJC3sxBOd0YudCzhzbj
         pxxu0FavU5MgZp0ccFkigAzRK+TmD/Th64bCjoK0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Filippo Sironi <sironi@amazon.de>, Wei Wang <wawei@amazon.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.14 10/35] amd/iommu: Fix Guest Virtual APIC Log Tail Address Register
Date:   Thu, 29 Nov 2018 01:00:44 -0500
Message-Id: <20181129060110.159878-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filippo Sironi <sironi@amazon.de>

[ Upstream commit ab99be4683d9db33b100497d463274ebd23bd67e ]

This register should have been programmed with the physical address
of the memory location containing the shadow tail pointer for
the guest virtual APIC log instead of the base address.

Fixes: 8bda0cfbdc1a  ('iommu/amd: Detect and initialize guest vAPIC log')
Signed-off-by: Filippo Sironi <sironi@amazon.de>
Signed-off-by: Wei Wang <wawei@amazon.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6fe2d0346073..b97984a5ddad 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -796,7 +796,8 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 	entry = iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
 	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
 		    &entry, sizeof(entry));
-	entry = (iommu_virt_to_phys(iommu->ga_log) & 0xFFFFFFFFFFFFFULL) & ~7ULL;
+	entry = (iommu_virt_to_phys(iommu->ga_log_tail) &
+		 (BIT_ULL(52)-1)) & ~7ULL;
 	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_TAIL_OFFSET,
 		    &entry, sizeof(entry));
 	writel(0x00, iommu->mmio_base + MMIO_GA_HEAD_OFFSET);
-- 
2.17.1

