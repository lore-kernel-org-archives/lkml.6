Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeESPyb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:54:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59934 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752344AbeESPy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:54:27 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH net-next 1/9] net: hns3: Fixes error reported by Kbuild and internal review
Date: Sat, 19 May 2018 16:53:15 +0100
Message-ID: <20180519155323.68960-2-salil.mehta@huawei.com>
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

This patch fixes the error reported by Intel's kbuild and fixes a
return value in one of the legs, caught during review of the original
patch sent by kbuild.

Fixes: fdb793670a00 ("net: hns3: Add support of .sriov_configure in HNS3 driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
Patch V1:
1. Fixes the errors reported by kbuild - using its fix
        Link: https://lkml.org/lkml/2018/5/16/894
2. Places a necessary missed return value of num_vfs figured out
   while reviewing kbuild patch.
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index e85ff38..e75c652 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1579,7 +1579,7 @@ static void hns3_remove(struct pci_dev *pdev)
  * Enable or change the number of VFs. Called when the user updates the number
  * of VFs in sysfs.
  **/
-int hns3_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+static int hns3_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	int ret;
 
@@ -1592,6 +1592,8 @@ int hns3_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 		ret = pci_enable_sriov(pdev, num_vfs);
 		if (ret)
 			dev_err(&pdev->dev, "SRIOV enable failed %d\n", ret);
+		else
+			return num_vfs;
 	} else if (!pci_vfs_assigned(pdev)) {
 		pci_disable_sriov(pdev);
 	} else {
-- 
2.7.4
