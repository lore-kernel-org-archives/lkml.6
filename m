Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeEOSVP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:21:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59834 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752978AbeEOSVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:21:11 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 01/10] net: hns3: Fix for deadlock problem occurring when unregistering ae_algo
Date: Tue, 15 May 2018 19:20:05 +0100
Message-ID: <20180515182014.42196-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180515182014.42196-1-salil.mehta@huawei.com>
References: <20180515182014.42196-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

When hnae3_unregister_ae_algo is called by PF, pci_disable_sriov is
called. And then, hns3_remove is called by VF. We get deadlocked in
this case.

Since VF pci device is dependent on PF pci device, When PF pci device
is removed, VF pci device must be removed. Also, To solve the deadlock
problem, VF pci device should be removed before PF pci device is removed.

This patch moves pci_enable/disable_sriov from hclge to hns3 to solve
the deadlock problem.

Also, we do not need to return EPROBE_DEFER in hnae3_register_ae_dev,
because SRIOV is no longer enabled in the context calling
hnae3_register_ae_dev. Mutex_trylock can be replaced with mutex_lock.

Fixes: 424eb834a9be ("net: hns3: Unified HNS3 {VF|PF} Ethernet Driver for hip08 SoC")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c        | 12 +---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 74 +++++++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 42 ++----------
 3 files changed, 79 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 02145f2..1686ceb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -196,17 +196,9 @@ int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 	const struct pci_device_id *id;
 	struct hnae3_ae_algo *ae_algo;
 	struct hnae3_client *client;
-	int ret = 0, lock_acquired;
+	int ret = 0;
 
-	/* we can get deadlocked if SRIOV is being enabled in context to probe
-	 * and probe gets called again in same context. This can happen when
-	 * pci_enable_sriov() is called to create VFs from PF probes context.
-	 * Therefore, for simplicity uniformly defering further probing in all
-	 * cases where we detect contention.
-	 */
-	lock_acquired = mutex_trylock(&hnae3_common_lock);
-	if (!lock_acquired)
-		return -EPROBE_DEFER;
+	mutex_lock(&hnae3_common_lock);
 
 	list_add_tail(&ae_dev->node, &hnae3_ae_dev_list);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4031174..af9e90f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1487,6 +1487,68 @@ static const struct net_device_ops hns3_nic_netdev_ops = {
 	.ndo_set_vf_vlan	= hns3_ndo_set_vf_vlan,
 };
 
+static bool hns3_is_phys_func(struct pci_dev *pdev)
+{
+	u32 dev_id = pdev->device;
+
+	switch (dev_id) {
+	case HNAE3_DEV_ID_GE:
+	case HNAE3_DEV_ID_25GE:
+	case HNAE3_DEV_ID_25GE_RDMA:
+	case HNAE3_DEV_ID_25GE_RDMA_MACSEC:
+	case HNAE3_DEV_ID_50GE_RDMA:
+	case HNAE3_DEV_ID_50GE_RDMA_MACSEC:
+	case HNAE3_DEV_ID_100G_RDMA_MACSEC:
+		return true;
+	case HNAE3_DEV_ID_100G_VF:
+	case HNAE3_DEV_ID_100G_RDMA_DCB_PFC_VF:
+		return false;
+	default:
+		dev_warn(&pdev->dev, "un-recognized pci device-id %d",
+			 dev_id);
+	}
+
+	return false;
+}
+
+static int get_num_req_vfs(struct pci_dev *pdev)
+{
+	/* a variable vf num will be supported later */
+	return pci_sriov_get_totalvfs(pdev);
+}
+
+static void hns3_enable_sriov(struct pci_dev *pdev)
+{
+	int num_req_vfs = get_num_req_vfs(pdev);
+	int ret;
+
+	/* Enable SRIOV */
+	if (!num_req_vfs)
+		return;
+
+	dev_info(&pdev->dev, "active VFs(%d) found, enabling SRIOV\n",
+		 num_req_vfs);
+
+	ret = pci_enable_sriov(pdev, num_req_vfs);
+	if (ret)
+		dev_err(&pdev->dev, "SRIOV enable failed %d\n", ret);
+}
+
+static void hns3_disable_sriov(struct pci_dev *pdev)
+{
+	/* If our VFs are assigned we cannot shut down SR-IOV
+	 * without causing issues, so just leave the hardware
+	 * available but disabled
+	 */
+	if (pci_vfs_assigned(pdev)) {
+		dev_warn(&pdev->dev,
+			 "disabling driver while VFs are assigned\n");
+		return;
+	}
+
+	pci_disable_sriov(pdev);
+}
+
 /* hns3_probe - Device initialization routine
  * @pdev: PCI device information struct
  * @ent: entry in hns3_pci_tbl
@@ -1514,7 +1576,14 @@ static int hns3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ae_dev->dev_type = HNAE3_DEV_KNIC;
 	pci_set_drvdata(pdev, ae_dev);
 
-	return hnae3_register_ae_dev(ae_dev);
+	ret = hnae3_register_ae_dev(ae_dev);
+	if (ret)
+		return ret;
+
+	if (hns3_is_phys_func(pdev) && IS_ENABLED(CONFIG_PCI_IOV))
+		hns3_enable_sriov(pdev);
+
+	return 0;
 }
 
 /* hns3_remove - Device removal routine
@@ -1524,6 +1593,9 @@ static void hns3_remove(struct pci_dev *pdev)
 {
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
 
+	if (hns3_is_phys_func(pdev) && IS_ENABLED(CONFIG_PCI_IOV))
+		hns3_disable_sriov(pdev);
+
 	hnae3_unregister_ae_dev(ae_dev);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 316ec842..343197a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1473,21 +1473,8 @@ static int hclge_alloc_vport(struct hclge_dev *hdev)
 	hdev->vport = vport;
 	hdev->num_alloc_vport = num_vport;
 
-#ifdef CONFIG_PCI_IOV
-	/* Enable SRIOV */
-	if (hdev->num_req_vfs) {
-		dev_info(&pdev->dev, "active VFs(%d) found, enabling SRIOV\n",
-			 hdev->num_req_vfs);
-		ret = pci_enable_sriov(hdev->pdev, hdev->num_req_vfs);
-		if (ret) {
-			hdev->num_alloc_vfs = 0;
-			dev_err(&pdev->dev, "SRIOV enable failed %d\n",
-				ret);
-			return ret;
-		}
-	}
-	hdev->num_alloc_vfs = hdev->num_req_vfs;
-#endif
+	if (IS_ENABLED(CONFIG_PCI_IOV))
+		hdev->num_alloc_vfs = hdev->num_req_vfs;
 
 	for (i = 0; i < num_vport; i++) {
 		vport->back = hdev;
@@ -2946,21 +2933,6 @@ static void hclge_service_task(struct work_struct *work)
 	hclge_service_complete(hdev);
 }
 
-static void hclge_disable_sriov(struct hclge_dev *hdev)
-{
-	/* If our VFs are assigned we cannot shut down SR-IOV
-	 * without causing issues, so just leave the hardware
-	 * available but disabled
-	 */
-	if (pci_vfs_assigned(hdev->pdev)) {
-		dev_warn(&hdev->pdev->dev,
-			 "disabling driver while VFs are assigned\n");
-		return;
-	}
-
-	pci_disable_sriov(hdev->pdev);
-}
-
 struct hclge_vport *hclge_get_vport(struct hnae3_handle *handle)
 {
 	/* VF handle has no client */
@@ -5540,7 +5512,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	ret = hclge_map_tqp(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Map tqp error, ret = %d.\n", ret);
-		goto err_sriov_disable;
+		goto err_msi_irq_uninit;
 	}
 
 	if (hdev->hw.mac.media_type == HNAE3_MEDIA_TYPE_COPPER) {
@@ -5548,7 +5520,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		if (ret) {
 			dev_err(&hdev->pdev->dev,
 				"mdio config fail ret=%d\n", ret);
-			goto err_sriov_disable;
+			goto err_msi_irq_uninit;
 		}
 	}
 
@@ -5612,9 +5584,6 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 err_mdiobus_unreg:
 	if (hdev->hw.mac.phydev)
 		mdiobus_unregister(hdev->hw.mac.mdio_bus);
-err_sriov_disable:
-	if (IS_ENABLED(CONFIG_PCI_IOV))
-		hclge_disable_sriov(hdev);
 err_msi_irq_uninit:
 	hclge_misc_irq_uninit(hdev);
 err_msi_uninit:
@@ -5717,9 +5686,6 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	set_bit(HCLGE_STATE_DOWN, &hdev->state);
 
-	if (IS_ENABLED(CONFIG_PCI_IOV))
-		hclge_disable_sriov(hdev);
-
 	if (hdev->service_timer.function)
 		del_timer_sync(&hdev->service_timer);
 	if (hdev->service_task.func)
-- 
2.7.4
