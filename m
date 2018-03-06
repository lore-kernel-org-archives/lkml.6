Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeCFDVl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:21:41 -0500
Received: from regular1.263xmail.com ([211.150.99.138]:42021 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeCFDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:21:40 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <6a9a1a6cf59081b900f9ee308139f8f2>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 04/14] iommu/rockchip: Fix error handling in attach
Date: Tue,  6 Mar 2018 11:21:03 +0800
Message-Id: <20180306032113.22247-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

Currently if the driver encounters an error while attaching device, it
will leave the IOMMU in an inconsistent state. Even though it shouldn't
really happen in reality, let's just add proper error path to keep
things consistent.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5:
Use out labels to save the duplication between the error and success paths.

Changes in v4: None
Changes in v3: None
Changes in v2:
Move irq request to probe(in patch[0])

 drivers/iommu/rockchip-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index b743d82e6fe1..f7ff3a3645ea 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -824,7 +824,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	ret = rk_iommu_force_reset(iommu);
 	if (ret)
-		return ret;
+		goto out_disable_stall;
 
 	iommu->domain = domain;
 
@@ -837,7 +837,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	ret = rk_iommu_enable_paging(iommu);
 	if (ret)
-		return ret;
+		goto out_disable_stall;
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_add_tail(&iommu->node, &rk_domain->iommus);
@@ -845,9 +845,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	dev_dbg(dev, "Attached to iommu domain\n");
 
+out_disable_stall:
 	rk_iommu_disable_stall(iommu);
-
-	return 0;
+	return ret;
 }
 
 static void rk_iommu_detach_device(struct iommu_domain *domain,
-- 
2.11.0
