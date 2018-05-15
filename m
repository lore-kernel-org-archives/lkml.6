Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753766AbeEOSYI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:24:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59458 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753118AbeEOSVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:21:16 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 04/10] net: hns3: Change return type of hnae3_register_ae_dev
Date: Tue, 15 May 2018 19:20:08 +0100
Message-ID: <20180515182014.42196-5-salil.mehta@huawei.com>
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

If hclge.ko has not been inserted, the value of ret always is zero
in hnae3_register_ae_dev. If hclge.ko has been inserted, the value
of ret is zero or non zero. Different execution ways have different
results. It is confusing.

The ae_dev which is initialized failed can be reinitialized when we
remove hclge.ko and insert it again. For the case initializing client
instance, it is just like the case initializing ae_dev. The main function
of hnae3_register_ae_dev is adding the ae_dev to ad_dev list. Because
adding ae_dev is always ok, we does not need to return any in this
function.

This patch changes the return type of hnae3_register_ae_dev from int
to void.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c     | 5 +----
 drivers/net/ethernet/hisilicon/hns3/hnae3.h     | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 +---
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 21cb0c5..cb93295 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -203,7 +203,7 @@ EXPORT_SYMBOL(hnae3_unregister_ae_algo);
  * @ae_dev: the AE device
  * NOTE: the duplicated name will not be checked
  */
-int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
+void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 {
 	const struct pci_device_id *id;
 	struct hnae3_ae_algo *ae_algo;
@@ -224,7 +224,6 @@ int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 		if (!ae_dev->ops) {
 			dev_err(&ae_dev->pdev->dev, "ae_dev ops are null\n");
-			ret = -EOPNOTSUPP;
 			goto out_err;
 		}
 
@@ -251,8 +250,6 @@ int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 out_err:
 	mutex_unlock(&hnae3_common_lock);
-
-	return ret;
 }
 EXPORT_SYMBOL(hnae3_register_ae_dev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index ffec231..ea6e6ea 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -515,7 +515,7 @@ struct hnae3_handle {
 #define hnae_get_bit(origin, shift) \
 	hnae_get_field((origin), (0x1 << (shift)), (shift))
 
-int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev);
+void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev);
 void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev);
 
 void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index af9e90f..ac75b5d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1576,9 +1576,7 @@ static int hns3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ae_dev->dev_type = HNAE3_DEV_KNIC;
 	pci_set_drvdata(pdev, ae_dev);
 
-	ret = hnae3_register_ae_dev(ae_dev);
-	if (ret)
-		return ret;
+	hnae3_register_ae_dev(ae_dev);
 
 	if (hns3_is_phys_func(pdev) && IS_ENABLED(CONFIG_PCI_IOV))
 		hns3_enable_sriov(pdev);
-- 
2.7.4
