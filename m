Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF1C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B312081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B312081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeLDQa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:30:28 -0500
Received: from 8bytes.org ([81.169.241.247]:51518 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbeLDQaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:30:07 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 407C9451; Tue,  4 Dec 2018 17:30:05 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 7/9] iommu/of: Use helper functions to access dev->iommu_fwspec
Date:   Tue,  4 Dec 2018 17:30:00 +0100
Message-Id: <20181204163002.15800-8-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204163002.15800-1-joro@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/of_iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index c5dd63072529..38232250b5f4 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -164,7 +164,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
 	const struct iommu_ops *ops = NULL;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int err = NO_IOMMU;
 
 	if (!master_np)
@@ -208,6 +208,9 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		}
 	}
 
+	/* The fwspec pointer changed, read it again */
+	fwspec = dev_iommu_fwspec_get(dev);
+
 	/*
 	 * Two success conditions can be represented by non-negative err here:
 	 * >0 : there is no IOMMU, or one was unavailable for non-fatal reasons
@@ -215,7 +218,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	 * <0 : any actual error
 	 */
 	if (!err)
-		ops = dev->iommu_fwspec->ops;
+		ops = fwspec->ops;
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * add_device callback for dev, replay it to get things in order.
-- 
2.17.1

