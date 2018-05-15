Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeEOSVQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:21:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59840 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752458AbeEOSVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:21:11 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 02/10] net: hns3: Fix for the null pointer problem occurring when initializing ae_dev failed
Date: Tue, 15 May 2018 19:20:06 +0100
Message-ID: <20180515182014.42196-3-salil.mehta@huawei.com>
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

When initializing ae_dev failed during loading hclge.ko, the drvdata will
be set to null. When removing hns3.ko, we get a null ae_dev. It causes the
null pointer problem.

This patch removes pci_set_drvdata from error handle of hclge_init_ae_dev
to fix the bug, since pci_set_drvdata has been called in hns3_remove.
Also, we do not need to uninit the ae_dev which is not initialized. And
it may be the one which is initialized failed.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c               | 6 ++++++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 5 +----
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 6 ++----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 1686ceb..ab2e72c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -168,6 +168,9 @@ void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo)
 	mutex_lock(&hnae3_common_lock);
 	/* Check if there are matched ae_dev */
 	list_for_each_entry(ae_dev, &hnae3_ae_dev_list, node) {
+		if (!hnae_get_bit(ae_dev->flag, HNAE3_DEV_INITED_B))
+			continue;
+
 		id = pci_match_id(ae_algo->pdev_id_table, ae_dev->pdev);
 		if (!id)
 			continue;
@@ -256,6 +259,9 @@ void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev)
 	mutex_lock(&hnae3_common_lock);
 	/* Check if there are matched ae_algo */
 	list_for_each_entry(ae_algo, &hnae3_ae_algo_list, node) {
+		if (!hnae_get_bit(ae_dev->flag, HNAE3_DEV_INITED_B))
+			continue;
+
 		id = pci_match_id(ae_algo->pdev_id_table, ae_dev->pdev);
 		if (!id)
 			continue;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 343197a..c2501b1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5379,7 +5379,7 @@ static int hclge_pci_init(struct hclge_dev *hdev)
 	ret = pci_enable_device(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable PCI device\n");
-		goto err_no_drvdata;
+		return ret;
 	}
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -5417,8 +5417,6 @@ static int hclge_pci_init(struct hclge_dev *hdev)
 	pci_release_regions(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
-err_no_drvdata:
-	pci_set_drvdata(pdev, NULL);
 
 	return ret;
 }
@@ -5594,7 +5592,6 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	pci_set_drvdata(pdev, NULL);
 out:
 	return ret;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 2dbffce..b7578c6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1563,7 +1563,7 @@ static int hclgevf_pci_init(struct hclgevf_dev *hdev)
 	ret = pci_enable_device(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable PCI device\n");
-		goto err_no_drvdata;
+		return ret;
 	}
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -1595,8 +1595,7 @@ static int hclgevf_pci_init(struct hclgevf_dev *hdev)
 	pci_release_regions(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
-err_no_drvdata:
-	pci_set_drvdata(pdev, NULL);
+
 	return ret;
 }
 
@@ -1608,7 +1607,6 @@ static void hclgevf_pci_uninit(struct hclgevf_dev *hdev)
 	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	pci_set_drvdata(pdev, NULL);
 }
 
 static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
-- 
2.7.4
