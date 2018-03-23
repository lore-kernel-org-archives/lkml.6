Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeCWHky (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:40:54 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:55106 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeCWHkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:40:51 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <ce0e03f0d69dbb82455c4a0e110695bb>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 13/14] iommu/rockchip: Add runtime PM support
Date: Fri, 23 Mar 2018 15:38:13 +0800
Message-Id: <20180323073814.5802-14-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the power domain is powered off, the IOMMU cannot be accessed and
register programming must be deferred until the power domain becomes
enabled.

Add runtime PM support, and use runtime PM device link from IOMMU to
master to enable and disable IOMMU.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v8:
Rename startup()/shutdown() to enable()/disable().
Do runtime PM suspend in .shutdown().
Modify pm_runtime_get_if_in_use()/pm_runtime_put() as Tomasz suggested.

Changes in v7: None
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

 drivers/iommu/rockchip-iommu.c | 181 +++++++++++++++++++++++++++++------------
 1 file changed, 129 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0ce5e8a0658c..9f6f74689464 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -22,6 +22,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -106,6 +107,7 @@ struct rk_iommu {
 };
 
 struct rk_iommudata {
+	struct device_link *link; /* runtime PM link from IOMMU to master */
 	struct rk_iommu *iommu;
 };
 
@@ -520,7 +522,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	irqreturn_t ret = IRQ_NONE;
 	int i;
 
-	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
+	if (WARN_ON(!pm_runtime_get_if_in_use(iommu->dev)))
+		return 0;
+
+	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
+		goto out;
 
 	for (i = 0; i < iommu->num_mmu; i++) {
 		int_status = rk_iommu_read(iommu->bases[i], RK_MMU_INT_STATUS);
@@ -570,6 +576,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 
 	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
 
+out:
+	pm_runtime_put(iommu->dev);
 	return ret;
 }
 
@@ -611,10 +619,17 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_for_each(pos, &rk_domain->iommus) {
 		struct rk_iommu *iommu;
+
 		iommu = list_entry(pos, struct rk_iommu, node);
-		WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
-		rk_iommu_zap_lines(iommu, iova, size);
-		clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+
+		/* Only zap TLBs of IOMMUs that are powered on. */
+		if (pm_runtime_get_if_in_use(iommu->dev)) {
+			WARN_ON(clk_bulk_enable(iommu->num_clocks,
+						iommu->clocks));
+			rk_iommu_zap_lines(iommu, iova, size);
+			clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+			pm_runtime_put(iommu->dev);
+		}
 	}
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 }
@@ -817,22 +832,30 @@ static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 	return data ? data->iommu : NULL;
 }
 
-static int rk_iommu_attach_device(struct iommu_domain *domain,
-				  struct device *dev)
+/* Must be called with iommu powered on and attached */
+static void rk_iommu_disable(struct rk_iommu *iommu)
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
+static int rk_iommu_enable(struct rk_iommu *iommu)
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
@@ -845,8 +868,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		goto out_disable_stall;
 
-	iommu->domain = domain;
-
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
 			       rk_domain->dt_dma);
@@ -855,14 +876,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
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
@@ -877,31 +890,71 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	struct rk_iommu *iommu;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
-	int i;
 
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
+	if (pm_runtime_get_if_in_use(iommu->dev)) {
+		rk_iommu_disable(iommu);
+		pm_runtime_put(iommu->dev);
 	}
-	rk_iommu_disable_stall(iommu);
-	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+}
 
-	iommu->domain = NULL;
+static int rk_iommu_attach_device(struct iommu_domain *domain,
+		struct device *dev)
+{
+	struct rk_iommu *iommu;
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	unsigned long flags;
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
+	if (!pm_runtime_get_if_in_use(iommu->dev))
+		return 0;
+
+	ret = rk_iommu_enable(iommu);
+	if (ret)
+		rk_iommu_detach_device(iommu->domain, dev);
+
+	pm_runtime_put(iommu->dev);
+
+	return ret;
 }
 
 static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
@@ -989,17 +1042,21 @@ static int rk_iommu_add_device(struct device *dev)
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
@@ -1007,9 +1064,11 @@ static int rk_iommu_add_device(struct device *dev)
 static void rk_iommu_remove_device(struct device *dev)
 {
 	struct rk_iommu *iommu;
+	struct rk_iommudata *data = dev->archdata.iommu;
 
 	iommu = rk_iommu_from_dev(dev);
 
+	device_link_del(data->link);
 	iommu_device_unlink(&iommu->iommu, dev);
 	iommu_group_remove_device(dev);
 }
@@ -1135,6 +1194,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
 
+	pm_runtime_enable(dev);
+
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
@@ -1145,21 +1206,36 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 static void rk_iommu_shutdown(struct platform_device *pdev)
 {
-	struct rk_iommu *iommu = platform_get_drvdata(pdev);
+	pm_runtime_force_suspend(&pdev->dev);
+}
 
-	/*
-	 * Be careful not to try to shutdown an otherwise unused
-	 * IOMMU, as it is likely not to be clocked, and accessing it
-	 * would just block. An IOMMU without a domain is likely to be
-	 * unused, so let's use this as a (weak) guard.
-	 */
-	if (iommu && iommu->domain) {
-		rk_iommu_enable_stall(iommu);
-		rk_iommu_disable_paging(iommu);
-		rk_iommu_force_reset(iommu);
-	}
+static int __maybe_unused rk_iommu_suspend(struct device *dev)
+{
+	struct rk_iommu *iommu = dev_get_drvdata(dev);
+
+	if (!iommu->domain)
+		return 0;
+
+	rk_iommu_disable(iommu);
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
+	return rk_iommu_enable(iommu);
 }
 
+static const struct dev_pm_ops rk_iommu_pm_ops = {
+	SET_RUNTIME_PM_OPS(rk_iommu_suspend, rk_iommu_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
 static const struct of_device_id rk_iommu_dt_ids[] = {
 	{ .compatible = "rockchip,iommu" },
 	{ /* sentinel */ }
@@ -1172,6 +1248,7 @@ static struct platform_driver rk_iommu_driver = {
 	.driver = {
 		   .name = "rk_iommu",
 		   .of_match_table = rk_iommu_dt_ids,
+		   .pm = &rk_iommu_pm_ops,
 		   .suppress_bind_attrs = true,
 	},
 };
-- 
2.11.0
