Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1F8C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18DE2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543667;
	bh=fDamPqDSqbp/PBg6YMBQyoNfT2VjSY/h4hRLquaaMo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NiJumRtjhL1FQlOjl16p4GF8QuMqrphvl1/oxs+HkSU9ZSfus+i4W6zg2vc/oE5f5
	 XlPIxaAvn4mwk70mPDEzMULHISZf9BijSJiTbVGf7XaXmBOn6Jk3FghqpwXm71L4NQ
	 6/fjeCd5J2TubljOnAxn6hzZshhBMQIG39nbQpRE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18DE2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeLKPy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbeLKPyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF3820855;
        Tue, 11 Dec 2018 15:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543662;
        bh=fDamPqDSqbp/PBg6YMBQyoNfT2VjSY/h4hRLquaaMo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o99dcs6AekN2oDGTQiTyv+Pi8Gqa3qKA6iC97fK/v8e38qHA6ZszE38Eju00GlaWO
         //4q63HdSBFPzsoH2DQZlh5iuOA7AB1HO7wRWIcURGG88YNy2uSWN+b9Ny0qYMKaI2
         AkIHJcyVZ+YQdemc027Nl0vhjSY4veVQCmOgd5DQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filippo Sironi <sironi@amazon.de>,
        Wei Wang <wawei@amazon.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 016/118] amd/iommu: Fix Guest Virtual APIC Log Tail Address Register
Date:   Tue, 11 Dec 2018 16:40:35 +0100
Message-Id: <20181211151644.882490530@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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
index 84b3e4445d46..e062ab9687c7 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -797,7 +797,8 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
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
2.19.1



