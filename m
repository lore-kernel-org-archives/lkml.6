Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753674AbeEOSVe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:21:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59564 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751859AbeEOSVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:21:31 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 09/10] net: hns3: Add support of .sriov_configure in HNS3 driver
Date: Tue, 15 May 2018 19:20:13 +0100
Message-ID: <20180515182014.42196-10-salil.mehta@huawei.com>
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

From: Peng Li <lipeng321@huawei.com>

As HNS3 driver will enable SRIOV default and enable all VFs the
HW support, if PF and VF driver compiled to kernel, VF driver
will work on host default, it is not right.

This patch adds support for hns3_driver.sriov_configure to support
user configs the VF_num, and do not enable sriov default.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Suggested-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 58 ++++++++++++++-----------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index ac75b5d..e85ff38 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1511,29 +1511,6 @@ static bool hns3_is_phys_func(struct pci_dev *pdev)
 	return false;
 }
 
-static int get_num_req_vfs(struct pci_dev *pdev)
-{
-	/* a variable vf num will be supported later */
-	return pci_sriov_get_totalvfs(pdev);
-}
-
-static void hns3_enable_sriov(struct pci_dev *pdev)
-{
-	int num_req_vfs = get_num_req_vfs(pdev);
-	int ret;
-
-	/* Enable SRIOV */
-	if (!num_req_vfs)
-		return;
-
-	dev_info(&pdev->dev, "active VFs(%d) found, enabling SRIOV\n",
-		 num_req_vfs);
-
-	ret = pci_enable_sriov(pdev, num_req_vfs);
-	if (ret)
-		dev_err(&pdev->dev, "SRIOV enable failed %d\n", ret);
-}
-
 static void hns3_disable_sriov(struct pci_dev *pdev)
 {
 	/* If our VFs are assigned we cannot shut down SR-IOV
@@ -1578,9 +1555,6 @@ static int hns3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	hnae3_register_ae_dev(ae_dev);
 
-	if (hns3_is_phys_func(pdev) && IS_ENABLED(CONFIG_PCI_IOV))
-		hns3_enable_sriov(pdev);
-
 	return 0;
 }
 
@@ -1597,11 +1571,43 @@ static void hns3_remove(struct pci_dev *pdev)
 	hnae3_unregister_ae_dev(ae_dev);
 }
 
+/**
+ * hns3_pci_sriov_configure
+ * @pdev: pointer to a pci_dev structure
+ * @num_vfs: number of VFs to allocate
+ *
+ * Enable or change the number of VFs. Called when the user updates the number
+ * of VFs in sysfs.
+ **/
+int hns3_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	int ret;
+
+	if (!(hns3_is_phys_func(pdev) && IS_ENABLED(CONFIG_PCI_IOV))) {
+		dev_warn(&pdev->dev, "Can not config SRIOV\n");
+		return -EINVAL;
+	}
+
+	if (num_vfs) {
+		ret = pci_enable_sriov(pdev, num_vfs);
+		if (ret)
+			dev_err(&pdev->dev, "SRIOV enable failed %d\n", ret);
+	} else if (!pci_vfs_assigned(pdev)) {
+		pci_disable_sriov(pdev);
+	} else {
+		dev_warn(&pdev->dev,
+			 "Unable to free VFs because some are assigned to VMs.\n");
+	}
+
+	return 0;
+}
+
 static struct pci_driver hns3_driver = {
 	.name     = hns3_driver_name,
 	.id_table = hns3_pci_tbl,
 	.probe    = hns3_probe,
 	.remove   = hns3_remove,
+	.sriov_configure = hns3_pci_sriov_configure,
 };
 
 /* set default feature to hns3 */
-- 
2.7.4
