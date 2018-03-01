Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030227AbeCAKJK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:09:10 -0500
Received: from regular1.263xmail.com ([211.150.99.138]:39326 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967178AbeCAKJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:09:05 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <5848c984e68f54606d1e0b92b7f25ead>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 02/14] iommu/rockchip: Fix error handling in probe
Date: Thu,  1 Mar 2018 18:08:12 +0800
Message-Id: <20180301100824.14887-3-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180301100824.14887-1-jeffy.chen@rock-chips.com>
References: <20180301100824.14887-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing iommu_device_sysfs_remove in error path.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 16cd8780c289..c2ef3cbd4401 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1193,8 +1193,12 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
 	err = iommu_device_register(&iommu->iommu);
+	if (err) {
+		iommu_device_sysfs_remove(&iommu->iommu);
+		return err;
+	}
 
-	return err;
+	return 0;
 }
 
 static const struct of_device_id rk_iommu_dt_ids[] = {
-- 
2.11.0
