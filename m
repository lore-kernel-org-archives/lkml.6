Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73809C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DC12086A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956021;
	bh=CaUv/Rrvki4dgrokKbgWJqIwPlgDBHdBu+ux08yN7TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SMFl2IcEUYVJCbwAhDOZx6G62iFperpQZ4cZA+0szAVyvCcB2Kl8i8zd7WNDMszdX
	 p4BKSVwBuvPreXZPhIBJXWgJePGBu6qml3UXIcgt1FlUdfVrivHu4/3ua2Clgw53C3
	 SH1nnkNLVKgAhdItu0zNpA4KlFbE8JeLlVfbUT6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfBWVG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbfBWVG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3EB20861;
        Sat, 23 Feb 2019 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956016;
        bh=CaUv/Rrvki4dgrokKbgWJqIwPlgDBHdBu+ux08yN7TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yW1TByysDr+28Nlu8ZUXCHQINNW5+wZFCE9E6ug5bcu6DxaPSan/MyuPS+h3Xg4if
         1gMCWrJhbBw2WV7w7TEPPbQJLs0To5ermxwKQX7Jv4PeAAOvyDcWzfkl0YW0rH1KOB
         AdNh3Od7IFGiduSV+MTV9e5ThHmOmiW+tgj5OIIc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 12/65] iommu/amd: Unmap all mapped pages in error path of map_sg
Date:   Sat, 23 Feb 2019 16:05:47 -0500
Message-Id: <20190223210640.200911-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerry Snitselaar <jsnitsel@redhat.com>

[ Upstream commit f1724c0883bb0ce93b8dcb94b53dcca3b75ac9a7 ]

In the error path of map_sg there is an incorrect if condition
for breaking out of the loop that searches the scatterlist
for mapped pages to unmap. Instead of breaking out of the
loop once all the pages that were mapped have been unmapped,
it will break out of the loop after it has unmapped 1 page.
Fix the condition, so it breaks out of the loop only after
all the mapped pages have been unmapped.

Fixes: 80187fd39dcb ("iommu/amd: Optimize map_sg and unmap_sg")
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5edc8e6f27114..6459f4f621314 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2548,7 +2548,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 			bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
 			iommu_unmap_page(domain, bus_addr, PAGE_SIZE);
 
-			if (--mapped_pages)
+			if (--mapped_pages == 0)
 				goto out_free_iova;
 		}
 	}
-- 
2.19.1

