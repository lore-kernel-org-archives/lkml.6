Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeCFDWY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:22:24 -0500
Received: from regular1.263xmail.com ([211.150.99.135]:36021 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbeCFDWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:22:22 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <56e165e9ffef6cf8c835d3c562aa4fb5>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 08/14] iommu/rockchip: Control clocks needed to access the IOMMU
Date: Tue,  6 Mar 2018 11:21:07 +0800
Message-Id: <20180306032113.22247-5-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306032113.22247-1-jeffy.chen@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306032113.22247-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

Current code relies on master driver enabling necessary clocks before
IOMMU is accessed, however there are cases when the IOMMU should be
accessed while the master is not running yet, for example allocating
V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
mapping API and doesn't engage the master driver at all.

This patch fixes the problem by letting clocks needed for IOMMU
operation to be listed in Device Tree and making the driver enable them
for the time of accessing the hardware.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---

Changes in v7: None
Changes in v6:
Fix dt-binding as Robin suggested.
Use aclk and iface clk as Rob and Robin suggested, and split binding
patch.

Changes in v5:
Use clk_bulk APIs.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 54 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index c4131ca792e0..6c6275589bd5 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -4,6 +4,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -87,10 +88,17 @@ struct rk_iommu_domain {
 	struct iommu_domain domain;
 };
 
+/* list of clocks required by IOMMU */
+static const char * const rk_iommu_clocks[] = {
+	"aclk", "iface",
+};
+
 struct rk_iommu {
 	struct device *dev;
 	void __iomem **bases;
 	int num_mmu;
+	struct clk_bulk_data *clocks;
+	int num_clocks;
 	bool reset_disabled;
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
@@ -506,6 +514,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	irqreturn_t ret = IRQ_NONE;
 	int i;
 
+	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
+
 	for (i = 0; i < iommu->num_mmu; i++) {
 		int_status = rk_iommu_read(iommu->bases[i], RK_MMU_INT_STATUS);
 		if (int_status == 0)
@@ -552,6 +562,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_CLEAR, int_status);
 	}
 
+	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+
 	return ret;
 }
 
@@ -594,7 +606,9 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
 	list_for_each(pos, &rk_domain->iommus) {
 		struct rk_iommu *iommu;
 		iommu = list_entry(pos, struct rk_iommu, node);
+		WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
 		rk_iommu_zap_lines(iommu, iova, size);
+		clk_bulk_disable(iommu->num_clocks, iommu->clocks);
 	}
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 }
@@ -823,10 +837,14 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return 0;
 
-	ret = rk_iommu_enable_stall(iommu);
+	ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
 	if (ret)
 		return ret;
 
+	ret = rk_iommu_enable_stall(iommu);
+	if (ret)
+		goto out_disable_clocks;
+
 	ret = rk_iommu_force_reset(iommu);
 	if (ret)
 		goto out_disable_stall;
@@ -852,6 +870,8 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 out_disable_stall:
 	rk_iommu_disable_stall(iommu);
+out_disable_clocks:
+	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
 	return ret;
 }
 
@@ -873,6 +893,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 
 	/* Ignore error while disabling, just keep going */
+	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
 	rk_iommu_enable_stall(iommu);
 	rk_iommu_disable_paging(iommu);
 	for (i = 0; i < iommu->num_mmu; i++) {
@@ -880,6 +901,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
 	}
 	rk_iommu_disable_stall(iommu);
+	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
 
 	iommu->domain = NULL;
 
@@ -1172,18 +1194,38 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
 
-	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
+	iommu->num_clocks = ARRAY_SIZE(rk_iommu_clocks);
+	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
+				     sizeof(*iommu->clocks), GFP_KERNEL);
+	if (!iommu->clocks)
+		return -ENOMEM;
+
+	for (i = 0; i < iommu->num_clocks; ++i)
+		iommu->clocks[i].id = rk_iommu_clocks[i];
+
+	err = devm_clk_bulk_get(iommu->dev, iommu->num_clocks, iommu->clocks);
 	if (err)
 		return err;
 
+	err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
+	if (err)
+		return err;
+
+	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
+	if (err)
+		goto err_unprepare_clocks;
+
 	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
 	err = iommu_device_register(&iommu->iommu);
-	if (err) {
-		iommu_device_sysfs_remove(&iommu->iommu);
-		return err;
-	}
+	if (err)
+		goto err_remove_sysfs;
 
 	return 0;
+err_remove_sysfs:
+	iommu_device_sysfs_remove(&iommu->iommu);
+err_unprepare_clocks:
+	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
+	return err;
 }
 
 static const struct of_device_id rk_iommu_dt_ids[] = {
-- 
2.11.0
