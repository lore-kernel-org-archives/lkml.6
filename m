Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8306FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A86E21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfAWHxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:53:30 -0500
Received: from 8bytes.org ([81.169.241.247]:59042 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfAWHxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:53:30 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BEB4239A; Wed, 23 Jan 2019 08:53:28 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/mediatek: Use correct fwspec in mtk_iommu_add_device()
Date:   Wed, 23 Jan 2019 08:53:27 +0100
Message-Id: <20190123075327.27366-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The mtk_iommu_add_device() function keeps the fwspec in an
on-stack pointer and calls mtk_iommu_create_mapping(), which
might change its source, dev->iommu_fwspec. This causes the
on-stack pointer to be obsoleted and the device
initialization to fail. Update the on-stack fwspec pointer
after mtk_iommu_create_mapping() has been called.

Reported-by: Frank Wunderlich <frank-w@public-files.de>
Fixes: a9bf2eec5a6f ('iommu/mediatek: Use helper functions to access dev->iommu_fwspec')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/mtk_iommu_v1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 6ede4286b835..f60bdb85c4c0 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -442,6 +442,10 @@ static int mtk_iommu_add_device(struct device *dev)
 		iommu_spec.args_count = count;
 
 		mtk_iommu_create_mapping(dev, &iommu_spec);
+
+		/* dev->iommu_fwspec might have changed */
+		fwspec = dev_iommu_fwspec_get(dev);
+
 		of_node_put(iommu_spec.np);
 	}
 
-- 
2.13.7

