Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbeCFD3B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:29:01 -0500
Received: from regular1.263xmail.com ([211.150.99.130]:59397 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbeCFD24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:28:56 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <da64d876db201edfdbeb88836cd13736>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 13/14] iommu/rockchip: Add runtime PM support
Date: Tue,  6 Mar 2018 11:27:58 +0800
Message-Id: <20180306032759.29069-4-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306032759.29069-1-jeffy.chen@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306032759.29069-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the power domain is powered off, the IOMMU cannot be accessed and
register programming must be deferred until the power domain becomes
enabled.

Add runtime PM support, and use runtime PM device link from IOMMU to
master to startup and shutdown IOMMU.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v7:
Add WARN_ON in irq isr, and modify iommu archdata comment.

Changes in v6: None
Changes in v5:
Avoid race about pm_runtime_get_if_in_use() and pm_runtime_enabled().

Changes in v4: None
Changes in v3:
Only call startup() and shutdown() when iommu attached.
Remove pm_mutex.
Check runtime PM disabled.
Check pm_runtime in rk_iommu_irq().

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 189 ++++++++++++++++++++++++++++++++---------
 1 file changed, 148 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 2448a0528e39..db08978203f7 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -22,6 +22,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -105,7 +106,14 @@ struct rk_iommu {
 	struct iommu_domain *domain; /* domain to which iommu is attached */
 };
 
+/**
+ * struct rk_iommudata - iommu archdata of master device.
+ * @link:	device link with runtime PM integration from the master
+ *		(consumer) to the IOMMU (supplier).
+ * @iommu:	IOMMU of the master device.
+ */
 struct rk_iommudata {
+	struct device_link *link;
 	struct rk_iommu *iommu;
 };
 
@@ -518,7 +526,13 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	u32 int_status;
 	dma_addr_t iova;
 	irqreturn_t ret = IRQ_NONE;
-	int i;
+	bool need_runtime_put;
+	int i, err;
+
+	err = pm_runtime_get_if_in_use(iommu->dev);
+	if (WARN_ON(err <= 0 && err != -EINVAL))
+		return ret;
+	need_runtime_put = err > 0;
 
 	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
 
@@ -570,6 +584,9 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 
 	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
 
+	if (need_runtime_put)
+		pm_runtime_put(iommu->dev);
+
 	return ret;
 }
 
@@ -611,10 +628,20 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_for_each(pos, &rk_domain->iommus) {
 		struct rk_iommu *iommu;
+		int ret;
+
 		iommu = list_entry(pos, struct rk_iommu, node);
-		WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
-		rk_iommu_zap_lines(iommu, iova, size);
-		clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+
+		/* Only zap TLBs of IOMMUs that are powered on. */
+		ret = pm_runtime_get_if_in_use(iommu->dev);
+		if (ret > 0 || ret == -EINVAL) {
+			WARN_ON(clk_bulk_enable(iommu->num_clocks,
+						iommu->clocks));
+			rk_iommu_zap_lines(iommu, iova, size);
+			clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+		}
+		if (ret > 0)
+			pm_runtime_put(iommu->dev);
 	}
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 }
@@ -817,22 +844,30 @@ static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 	return data ? data->iommu : NULL;
 }
 
-static int rk_iommu_attach_device(struct iommu_domain *domain,
-				  struct device *dev)
+/* Must be called with iommu powered on and attached */
+static void rk_iommu_shutdown(struct rk_iommu *iommu)
 {
-	struct rk_iommu *iommu;
+	int i;
+
+	/* Ignore error while disabling, just keep going */
+	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
+	rk_iommu_enable_stall(iommu);
+	rk_iommu_disable_paging(iommu);
+	for (i = 0; i < iommu->num_mmu; i++) {
+		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
+		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
+	}
+	rk_iommu_disable_stall(iommu);
+	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+}
+
+/* Must be called with iommu powered on and attached */
+static int rk_iommu_startup(struct rk_iommu *iommu)
+{
+	struct iommu_domain *domain = iommu->domain;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
-	unsigned long flags;
 	int ret, i;
 
-	/*
-	 * Allow 'virtual devices' (e.g., drm) to attach to domain.
-	 * Such a device does not belong to an iommu group.
-	 */
-	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
-		return 0;
-
 	ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
 	if (ret)
 		return ret;
@@ -845,8 +880,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		goto out_disable_stall;
 
-	iommu->domain = domain;
-
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
 			       rk_domain->dt_dma);
@@ -855,14 +888,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	}
 
 	ret = rk_iommu_enable_paging(iommu);
-	if (ret)
-		goto out_disable_stall;
-
-	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
-	list_add_tail(&iommu->node, &rk_domain->iommus);
-	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
-
-	dev_dbg(dev, "Attached to iommu domain\n");
 
 out_disable_stall:
 	rk_iommu_disable_stall(iommu);
@@ -877,31 +902,77 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	struct rk_iommu *iommu;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
-	int i;
+	int ret;
 
 	/* Allow 'virtual devices' (eg drm) to detach from domain */
 	iommu = rk_iommu_from_dev(dev);
 	if (!iommu)
 		return;
 
+	dev_dbg(dev, "Detaching from iommu domain\n");
+
+	/* iommu already detached */
+	if (iommu->domain != domain)
+		return;
+
+	iommu->domain = NULL;
+
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_del_init(&iommu->node);
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 
-	/* Ignore error while disabling, just keep going */
-	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
-	rk_iommu_enable_stall(iommu);
-	rk_iommu_disable_paging(iommu);
-	for (i = 0; i < iommu->num_mmu; i++) {
-		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
-		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
-	}
-	rk_iommu_disable_stall(iommu);
-	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+	ret = pm_runtime_get_if_in_use(iommu->dev);
+	if (ret > 0 || ret == -EINVAL)
+		rk_iommu_shutdown(iommu);
+	if (ret > 0)
+		pm_runtime_put(iommu->dev);
+}
 
-	iommu->domain = NULL;
+static int rk_iommu_attach_device(struct iommu_domain *domain,
+		struct device *dev)
+{
+	struct rk_iommu *iommu;
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	unsigned long flags;
+	bool need_runtime_put;
+	int ret;
 
-	dev_dbg(dev, "Detached from iommu domain\n");
+	/*
+	 * Allow 'virtual devices' (e.g., drm) to attach to domain.
+	 * Such a device does not belong to an iommu group.
+	 */
+	iommu = rk_iommu_from_dev(dev);
+	if (!iommu)
+		return 0;
+
+	dev_dbg(dev, "Attaching to iommu domain\n");
+
+	/* iommu already attached */
+	if (iommu->domain == domain)
+		return 0;
+
+	if (iommu->domain)
+		rk_iommu_detach_device(iommu->domain, dev);
+
+	iommu->domain = domain;
+
+	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
+	list_add_tail(&iommu->node, &rk_domain->iommus);
+	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
+
+	ret = pm_runtime_get_if_in_use(iommu->dev);
+	if (ret <= 0 && ret != -EINVAL)
+		return 0;
+	need_runtime_put = ret > 0;
+
+	ret = rk_iommu_startup(iommu);
+	if (ret)
+		rk_iommu_detach_device(iommu->domain, dev);
+
+	if (need_runtime_put)
+		pm_runtime_put(iommu->dev);
+
+	return ret;
 }
 
 static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
@@ -989,17 +1060,21 @@ static int rk_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
 	struct rk_iommu *iommu;
+	struct rk_iommudata *data;
 
-	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
+	data = dev->archdata.iommu;
+	if (!data)
 		return -ENODEV;
 
+	iommu = rk_iommu_from_dev(dev);
+
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 	iommu_group_put(group);
 
 	iommu_device_link(&iommu->iommu, dev);
+	data->link = device_link_add(dev, iommu->dev, DL_FLAG_PM_RUNTIME);
 
 	return 0;
 }
@@ -1007,9 +1082,11 @@ static int rk_iommu_add_device(struct device *dev)
 static void rk_iommu_remove_device(struct device *dev)
 {
 	struct rk_iommu *iommu;
+	struct rk_iommudata *data = dev->archdata.iommu;
 
 	iommu = rk_iommu_from_dev(dev);
 
+	device_link_del(data->link);
 	iommu_device_unlink(&iommu->iommu, dev);
 	iommu_group_remove_device(dev);
 }
@@ -1135,6 +1212,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
 
+	pm_runtime_enable(dev);
+
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
@@ -1143,6 +1222,33 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int __maybe_unused rk_iommu_suspend(struct device *dev)
+{
+	struct rk_iommu *iommu = dev_get_drvdata(dev);
+
+	if (!iommu->domain)
+		return 0;
+
+	rk_iommu_shutdown(iommu);
+	return 0;
+}
+
+static int __maybe_unused rk_iommu_resume(struct device *dev)
+{
+	struct rk_iommu *iommu = dev_get_drvdata(dev);
+
+	if (!iommu->domain)
+		return 0;
+
+	return rk_iommu_startup(iommu);
+}
+
+static const struct dev_pm_ops rk_iommu_pm_ops = {
+	SET_RUNTIME_PM_OPS(rk_iommu_suspend, rk_iommu_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
 static const struct of_device_id rk_iommu_dt_ids[] = {
 	{ .compatible = "rockchip,iommu" },
 	{ /* sentinel */ }
@@ -1154,6 +1260,7 @@ static struct platform_driver rk_iommu_driver = {
 	.driver = {
 		   .name = "rk_iommu",
 		   .of_match_table = rk_iommu_dt_ids,
+		   .pm = &rk_iommu_pm_ops,
 		   .suppress_bind_attrs = true,
 	},
 };
-- 
2.11.0
