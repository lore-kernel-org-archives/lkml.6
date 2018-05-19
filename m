Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeESP4m (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:56:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39243 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752584AbeESPyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:54:55 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 9/9] net: hns3: Fix for CMDQ and Misc. interrupt init order problem
Date: Sat, 19 May 2018 16:53:23 +0100
Message-ID: <20180519155323.68960-10-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180519155323.68960-1-salil.mehta@huawei.com>
References: <20180519155323.68960-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When vf module is loading, the cmd queue initialization should
happen before misc interrupt initialization, otherwise the misc
interrupt handle will cause using uninitialized cmd queue problem.
There is also the same issue when vf module is unloading.

This patch fixes it by adjusting the location of some function.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index f1f4a17..2b0e329 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1634,6 +1634,10 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 
 	hclgevf_state_init(hdev);
 
+	ret = hclgevf_cmd_init(hdev);
+	if (ret)
+		goto err_cmd_init;
+
 	ret = hclgevf_misc_irq_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed(%d) to init Misc IRQ(vector0)\n",
@@ -1641,10 +1645,6 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		goto err_misc_irq_init;
 	}
 
-	ret = hclgevf_cmd_init(hdev);
-	if (ret)
-		goto err_cmd_init;
-
 	ret = hclgevf_configure(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed(%d) to fetch configuration\n", ret);
@@ -1692,10 +1692,10 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 	return 0;
 
 err_config:
-	hclgevf_cmd_uninit(hdev);
-err_cmd_init:
 	hclgevf_misc_irq_uninit(hdev);
 err_misc_irq_init:
+	hclgevf_cmd_uninit(hdev);
+err_cmd_init:
 	hclgevf_state_uninit(hdev);
 	hclgevf_uninit_msi(hdev);
 err_irq_init:
@@ -1705,9 +1705,9 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 
 static void hclgevf_uninit_hdev(struct hclgevf_dev *hdev)
 {
-	hclgevf_cmd_uninit(hdev);
-	hclgevf_misc_irq_uninit(hdev);
 	hclgevf_state_uninit(hdev);
+	hclgevf_misc_irq_uninit(hdev);
+	hclgevf_cmd_uninit(hdev);
 	hclgevf_uninit_msi(hdev);
 	hclgevf_pci_uninit(hdev);
 }
-- 
2.7.4
