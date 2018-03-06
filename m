Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeCFDEI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:04:08 -0500
Received: from regular1.263xmail.com ([211.150.99.133]:59357 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932417AbeCFDEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:04:05 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <de816481d75c731981595cdb9bfbb146>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 03/14] iommu/rockchip: Request irqs in rk_iommu_probe()
Date: Tue,  6 Mar 2018 11:02:41 +0800
Message-Id: <20180306030252.3197-4-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move request_irq to the end of rk_iommu_probe().

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
Loop platform_get_irq() as Robin suggested.

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index c2ef3cbd4401..b743d82e6fe1 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -90,8 +90,6 @@ struct rk_iommu {
 	struct device *dev;
 	void __iomem **bases;
 	int num_mmu;
-	int *irq;
-	int num_irq;
 	bool reset_disabled;
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
@@ -830,13 +828,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	iommu->domain = domain;
 
-	for (i = 0; i < iommu->num_irq; i++) {
-		ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
-				       IRQF_SHARED, dev_name(dev), iommu);
-		if (ret)
-			return ret;
-	}
-
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
 			       rk_domain->dt_dma);
@@ -885,9 +876,6 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	}
 	rk_iommu_disable_stall(iommu);
 
-	for (i = 0; i < iommu->num_irq; i++)
-		devm_free_irq(iommu->dev, iommu->irq[i], iommu);
-
 	iommu->domain = NULL;
 
 	dev_dbg(dev, "Detached from iommu domain\n");
@@ -1138,7 +1126,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	struct rk_iommu *iommu;
 	struct resource *res;
 	int num_res = pdev->num_resources;
-	int err, i;
+	int err, i, irq;
 
 	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
@@ -1165,23 +1153,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (iommu->num_mmu == 0)
 		return PTR_ERR(iommu->bases[0]);
 
-	iommu->num_irq = platform_irq_count(pdev);
-	if (iommu->num_irq < 0)
-		return iommu->num_irq;
-	if (iommu->num_irq == 0)
-		return -ENXIO;
+	i = 0;
+	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
+		if (irq < 0)
+			return irq;
 
-	iommu->irq = devm_kcalloc(dev, iommu->num_irq, sizeof(*iommu->irq),
-				  GFP_KERNEL);
-	if (!iommu->irq)
-		return -ENOMEM;
-
-	for (i = 0; i < iommu->num_irq; i++) {
-		iommu->irq[i] = platform_get_irq(pdev, i);
-		if (iommu->irq[i] < 0) {
-			dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq[i]);
-			return -ENXIO;
-		}
+		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
+				       IRQF_SHARED, dev_name(dev), iommu);
+		if (err)
+			return err;
 	}
 
 	iommu->reset_disabled = device_property_read_bool(dev,
-- 
2.11.0
