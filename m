Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeEOSVs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:21:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752485AbeEOSVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:21:46 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 10/10] net: hns3: Fixes the missing PCI iounmap for various legs
Date: Tue, 15 May 2018 19:20:14 +0100
Message-ID: <20180515182014.42196-11-salil.mehta@huawei.com>
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

We call pcim_iomap in hclge_pci_init, pcim_iounmap should be called
in error handle of hclge_init_ae_dev.

We call pcim_iomap in hclge_pci_init, but do not call pcim_iounmap in
hclge_pci_uninit. When we remove the hclge.ko and insert it again, a
problem that pci can not map will happen. pcim_iounmap need to be called
in hclge_pci_uninit.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 75d9b8c..46435c8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5425,6 +5425,7 @@ static void hclge_pci_uninit(struct hclge_dev *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
 
+	pcim_iounmap(pdev, hdev->hw.io_base);
 	pci_free_irq_vectors(pdev);
 	pci_clear_master(pdev);
 	pci_release_mem_regions(pdev);
@@ -5589,6 +5590,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 err_cmd_uninit:
 	hclge_destroy_cmd_queue(&hdev->hw);
 err_pci_uninit:
+	pcim_iounmap(pdev, hdev->hw.io_base);
 	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.7.4
