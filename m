Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628C5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B5C20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B5C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeLEOhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:37:12 -0500
Received: from 8bytes.org ([81.169.241.247]:51858 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeLEOgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:36:54 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DF96B432; Wed,  5 Dec 2018 15:36:52 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Date:   Wed,  5 Dec 2018 15:36:45 +0100
Message-Id: <20181205143646.4876-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205143646.4876-1-joro@8bytes.org>
References: <20181205143646.4876-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Make sure to invoke this call-back through the proper
function of the IOMMU-API.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/of_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index c5dd63072529..4d4847de727e 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -218,10 +218,10 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		ops = dev->iommu_fwspec->ops;
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
-	 * add_device callback for dev, replay it to get things in order.
+	 * probe for dev, replay it to get things in order.
 	 */
-	if (ops && ops->add_device && dev->bus && !dev->iommu_group)
-		err = ops->add_device(dev);
+	if (dev->bus && !dev->iommu_group)
+		err = iommu_probe_device(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
-- 
2.17.1

