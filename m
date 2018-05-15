Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeEOSVY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:21:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59900 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752836AbeEOSVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:21:21 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 05/10] net: hns3: Change return type of hnae3_register_ae_algo
Date: Tue, 15 May 2018 19:20:09 +0100
Message-ID: <20180515182014.42196-6-salil.mehta@huawei.com>
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

The ae_algo is used by many ae_devs. It is not only belong to just a
ae_dev. Initializing ae_dev failed does not represent registering ae_algo
failed. Because the action of registering ae_algo just is adding ae_algo
to the ae_algo list and it is always is true, it make no sense to define
return type as int.

This patch changes the return type of hnae3_register_ae_algo from int to
void.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c               | 4 +---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 +++-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index cb93295..3b1c396 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -121,7 +121,7 @@ EXPORT_SYMBOL(hnae3_unregister_client);
  * @ae_algo: AE algorithm
  * NOTE: the duplicated name will not be checked
  */
-int hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo)
+void hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo)
 {
 	const struct pci_device_id *id;
 	struct hnae3_ae_dev *ae_dev;
@@ -160,8 +160,6 @@ int hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo)
 	}
 
 	mutex_unlock(&hnae3_common_lock);
-
-	return ret;
 }
 EXPORT_SYMBOL(hnae3_register_ae_algo);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index ea6e6ea..2f266ef 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -519,7 +519,7 @@ void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev);
 void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev);
 
 void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo);
-int hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo);
+void hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo);
 
 void hnae3_unregister_client(struct hnae3_client *client);
 int hnae3_register_client(struct hnae3_client *client);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c2501b1..d060903 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6250,7 +6250,9 @@ static int hclge_init(void)
 {
 	pr_info("%s is initializing\n", HCLGE_NAME);
 
-	return hnae3_register_ae_algo(&ae_algo);
+	hnae3_register_ae_algo(&ae_algo);
+
+	return 0;
 }
 
 static void hclge_exit(void)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index b7578c6..f1f4a17 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1852,7 +1852,9 @@ static int hclgevf_init(void)
 {
 	pr_info("%s is initializing\n", HCLGEVF_NAME);
 
-	return hnae3_register_ae_algo(&ae_algovf);
+	hnae3_register_ae_algo(&ae_algovf);
+
+	return 0;
 }
 
 static void hclgevf_exit(void)
-- 
2.7.4
