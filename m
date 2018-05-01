Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756670AbeEAS6K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:58:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756593AbeEAS6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:58:05 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 4/9] net: hns3: Fixes the error legs in hclge_init_ae_dev function
Date: Tue, 1 May 2018 19:56:00 +0100
Message-ID: <20180501185605.9584-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180501185605.9584-1-salil.mehta@huawei.com>
References: <20180501185605.9584-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

This patch fixes some of the missed error legs in the initialization
function of the ae device. This might cause leaks in case of failure.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer
Support")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 55 +++++++++++++---------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c9e80ca..b5e0c58 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5430,7 +5430,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hdev = devm_kzalloc(&pdev->dev, sizeof(*hdev), GFP_KERNEL);
 	if (!hdev) {
 		ret = -ENOMEM;
-		goto err_hclge_dev;
+		goto out;
 	}
 
 	hdev->pdev = pdev;
@@ -5443,38 +5443,38 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	ret = hclge_pci_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "PCI init failed\n");
-		goto err_pci_init;
+		goto out;
 	}
 
 	/* Firmware command queue initialize */
 	ret = hclge_cmd_queue_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Cmd queue init failed, ret = %d.\n", ret);
-		return ret;
+		goto err_pci_uninit;
 	}
 
 	/* Firmware command initialize */
 	ret = hclge_cmd_init(hdev);
 	if (ret)
-		goto err_cmd_init;
+		goto err_cmd_uninit;
 
 	ret = hclge_get_cap(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "get hw capability error, ret = %d.\n",
 			ret);
-		return ret;
+		goto err_cmd_uninit;
 	}
 
 	ret = hclge_configure(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Configure dev error, ret = %d.\n", ret);
-		return ret;
+		goto err_cmd_uninit;
 	}
 
 	ret = hclge_init_msi(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Init MSI/MSI-X error, ret = %d.\n", ret);
-		return ret;
+		goto err_cmd_uninit;
 	}
 
 	ret = hclge_misc_irq_init(hdev);
@@ -5482,69 +5482,69 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		dev_err(&pdev->dev,
 			"Misc IRQ(vector0) init error, ret = %d.\n",
 			ret);
-		return ret;
+		goto err_msi_uninit;
 	}
 
 	ret = hclge_alloc_tqps(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Allocate TQPs error, ret = %d.\n", ret);
-		return ret;
+		goto err_msi_irq_uninit;
 	}
 
 	ret = hclge_alloc_vport(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Allocate vport error, ret = %d.\n", ret);
-		return ret;
+		goto err_msi_irq_uninit;
 	}
 
 	ret = hclge_map_tqp(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Map tqp error, ret = %d.\n", ret);
-		return ret;
+		goto err_sriov_disable;
 	}
 
 	ret = hclge_mac_mdio_config(hdev);
 	if (ret) {
 		dev_warn(&hdev->pdev->dev,
 			 "mdio config fail ret=%d\n", ret);
-		return ret;
+		goto err_sriov_disable;
 	}
 
 	ret = hclge_mac_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Mac init error, ret = %d\n", ret);
-		return ret;
+		goto err_mdiobus_unreg;
 	}
 
 	ret = hclge_config_tso(hdev, HCLGE_TSO_MSS_MIN, HCLGE_TSO_MSS_MAX);
 	if (ret) {
 		dev_err(&pdev->dev, "Enable tso fail, ret =%d\n", ret);
-		return ret;
+		goto err_mdiobus_unreg;
 	}
 
 	ret = hclge_init_vlan_config(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "VLAN init fail, ret =%d\n", ret);
-		return  ret;
+		goto err_mdiobus_unreg;
 	}
 
 	ret = hclge_tm_schd_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "tm schd init fail, ret =%d\n", ret);
-		return ret;
+		goto err_mdiobus_unreg;
 	}
 
 	hclge_rss_init_cfg(hdev);
 	ret = hclge_rss_init_hw(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Rss init fail, ret =%d\n", ret);
-		return ret;
+		goto err_mdiobus_unreg;
 	}
 
 	ret = init_mgr_tbl(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "manager table init fail, ret =%d\n", ret);
-		return ret;
+		goto err_mdiobus_unreg;
 	}
 
 	hclge_dcb_ops_set(hdev);
@@ -5567,11 +5567,24 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	pr_info("%s driver initialization finished.\n", HCLGE_DRIVER_NAME);
 	return 0;
 
-err_cmd_init:
+err_mdiobus_unreg:
+	if (hdev->hw.mac.phydev)
+		mdiobus_unregister(hdev->hw.mac.mdio_bus);
+err_sriov_disable:
+	if (IS_ENABLED(CONFIG_PCI_IOV))
+		hclge_disable_sriov(hdev);
+err_msi_irq_uninit:
+	hclge_misc_irq_uninit(hdev);
+err_msi_uninit:
+	pci_free_irq_vectors(pdev);
+err_cmd_uninit:
+	hclge_destroy_cmd_queue(&hdev->hw);
+err_pci_uninit:
+	pci_clear_master(pdev);
 	pci_release_regions(pdev);
-err_pci_init:
+	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
-err_hclge_dev:
+out:
 	return ret;
 }
 
-- 
2.7.4
