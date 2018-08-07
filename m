Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1835C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D13208CB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D13208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbeHGLHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:07:39 -0400
Received: from foss.arm.com ([217.140.101.70]:51192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387702AbeHGLHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:07:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22A5815AB;
        Tue,  7 Aug 2018 01:54:21 -0700 (PDT)
Received: from approximate.Emea.Arm.com (approximate.Emea.Arm.com [10.4.13.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C286B3F5D4;
        Tue,  7 Aug 2018 01:54:19 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 2/2] iommu/rockchip: Move irq request past pm_runtime_enable
Date:   Tue,  7 Aug 2018 09:54:06 +0100
Message-Id: <20180807085406.3863-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807085406.3863-1-marc.zyngier@arm.com>
References: <20180807085406.3863-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the interrupt early, before power has been applied to the
device, can result in an interrupt being delivered too early if:

- the IOMMU shares an interrupt with a VOP
- the VOP has a pending interrupt (after a kexec, for example)

In these conditions, we end-up taking the interrupt without
the IOMMU being ready to handle the interrupt (not powered on).

Moving the interrupt request past the pm_runtime_enable() call
makes sure we can at least access the IOMMU registers. Note that
this is only a partial fix, and that the VOP interrupt will still
be screaming until the VOP driver kicks in, which advocates for
a more synchronized interrupt enabling/disabling approach.

Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/iommu/rockchip-iommu.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4e0f9b61cd7f..2b1724e8d307 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1161,17 +1161,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (iommu->num_mmu == 0)
 		return PTR_ERR(iommu->bases[0]);
 
-	i = 0;
-	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
-		if (irq < 0)
-			return irq;
-
-		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
-				       IRQF_SHARED, dev_name(dev), iommu);
-		if (err)
-			return err;
-	}
-
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
 
@@ -1228,6 +1217,19 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	i = 0;
+	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
+		if (irq < 0)
+			return irq;
+
+		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
+				       IRQF_SHARED, dev_name(dev), iommu);
+		if (err) {
+			pm_runtime_disable(dev);
+			goto err_remove_sysfs;
+		}
+	}
+
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
-- 
2.18.0

