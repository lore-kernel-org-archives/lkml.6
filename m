Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FBDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BA42084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BA42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeLKPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:05:21 -0500
Received: from 8bytes.org ([81.169.241.247]:53544 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKPFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:05:18 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CC5FD4BD; Tue, 11 Dec 2018 16:05:15 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ACPI/IORT: Don't call iommu_ops->add_device directly
Date:   Tue, 11 Dec 2018 16:05:13 +0100
Message-Id: <20181211150513.15161-5-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211150513.15161-1-joro@8bytes.org>
References: <20181211150513.15161-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Make sure to invoke this call-back through the proper
function of the IOMMU-API.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/arm64/iort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..d4f7c1adc048 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -805,8 +805,8 @@ static inline int iort_add_device_replay(const struct iommu_ops *ops,
 {
 	int err = 0;
 
-	if (ops->add_device && dev->bus && !dev->iommu_group)
-		err = ops->add_device(dev);
+	if (dev->bus && !dev->iommu_group)
+		err = iommu_probe_device(dev);
 
 	return err;
 }
-- 
2.17.1

