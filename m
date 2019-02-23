Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387A2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E1620651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956942;
	bh=qJVDrCjPd6BiJUAXmNPkqwU2bUDIjNe6dSioMpSkcsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hW5V9+0wqeBtJ9SiPC+8UvzFe3N2T8Y7J08cy0cBT50ti/BdyImDEZ1tG/3sqWCuE
	 Roj0EICPb1VWgZAnRGvK1NdS3ZQKawbQAGd27WGm3Ls6vafSHSlYBVnyDO/MeWDM7l
	 +7zHDtD/9euTsypWTvSTxgkVPMfUcz7IV2eG8wuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfBWVWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:22:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbfBWVIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:08:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD3A2085A;
        Sat, 23 Feb 2019 21:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956125;
        bh=qJVDrCjPd6BiJUAXmNPkqwU2bUDIjNe6dSioMpSkcsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgFESxjbaLWuXT2YK91ZqP/4uJEC+nTkFZq3LBOjdOC+HL4GaP98fc0gCVFaBlrnx
         t2fFkuwlr3ddPwAmG1+7hfhb0BV5XBZkiIQSBGoPxbxLYoL5yZlJb/KkObuXZ7FW4s
         D5seDj8m2r0MCxtPddRRa0kVJHRmRGCxLFeG6ESU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.14 06/45] iommu/amd: Call free_iova_fast with pfn in map_sg
Date:   Sat, 23 Feb 2019 16:07:56 -0500
Message-Id: <20190223210835.201708-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210835.201708-1-sashal@kernel.org>
References: <20190223210835.201708-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerry Snitselaar <jsnitsel@redhat.com>

[ Upstream commit 51d8838d66d3249508940d8f59b07701f2129723 ]

In the error path of map_sg, free_iova_fast is being called with
address instead of the pfn. This results in a bad value getting into
the rcache, and can result in hitting a BUG_ON when
iova_magazine_free_pfns is called.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: 80187fd39dcb ("iommu/amd: Optimize map_sg and unmap_sg")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index efa6cd2500b93..2dc9a71cb54f8 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2559,7 +2559,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	}
 
 out_free_iova:
-	free_iova_fast(&dma_dom->iovad, address, npages);
+	free_iova_fast(&dma_dom->iovad, address >> PAGE_SHIFT, npages);
 
 out_err:
 	return 0;
-- 
2.19.1

