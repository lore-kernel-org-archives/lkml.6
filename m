Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeESPzm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:55:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752612AbeESPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:54:58 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH net-next 8/9] net: hns3: Fixes kernel panic issue during rmmod hns3 driver
Date: Sat, 19 May 2018 16:53:22 +0100
Message-ID: <20180519155323.68960-9-salil.mehta@huawei.com>
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

From: Xi Wang <wangxi11@huawei.com>

If CONFIG_ARM_SMMU_V3 is enabled, arm64's dma_ops will replace
arm64_swiotlb_dma_ops with iommu_dma_ops. When releasing contiguous
dma memory, the new ops will call the vunmap function which cannot
be run in interrupt context.

Currently, spin_lock_bh is called before vunmap is executed. This
disables BH and causes the interrupt context to be detected to
generate a kernel panic like below:

[ 2831.573400] kernel BUG at mm/vmalloc.c:1621!
[ 2831.577659] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
...
[ 2831.699907] Process rmmod (pid: 1893, stack limit = 0x0000000055103ee2)
[ 2831.706507] Call trace:
[ 2831.708941]  vunmap+0x48/0x50
[ 2831.711897]  dma_common_free_remap+0x78/0x88
[ 2831.716155]  __iommu_free_attrs+0xa8/0x1c0
[ 2831.720255]  hclge_free_cmd_desc+0xc8/0x118 [hclge]
[ 2831.725128]  hclge_destroy_cmd_queue+0x34/0x68 [hclge]
[ 2831.730261]  hclge_uninit_ae_dev+0x90/0x100 [hclge]
[ 2831.735127]  hnae3_unregister_ae_dev+0xb0/0x868 [hnae3]
[ 2831.740345]  hns3_remove+0x3c/0x90 [hns3]
[ 2831.744344]  pci_device_remove+0x48/0x108
[ 2831.748342]  device_release_driver_internal+0x164/0x200
[ 2831.753553]  driver_detach+0x4c/0x88
[ 2831.757116]  bus_remove_driver+0x60/0xc0
[ 2831.761026]  driver_unregister+0x34/0x60
[ 2831.764935]  pci_unregister_driver+0x30/0xb0
[ 2831.769197]  hns3_exit_module+0x10/0x978 [hns3]
[ 2831.773715]  SyS_delete_module+0x1f8/0x248
[ 2831.777799]  el0_svc_naked+0x30/0x34

This patch fixes it by using spin_lock instead of spin_lock_bh.

Fixes: 68c0a5c70614 ("net: hns3: Add HNS3 IMP(Integrated Mgmt Proc) Cmd Interface Support")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 59fb0eb..c36d647 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -385,9 +385,9 @@ int hclge_cmd_init(struct hclge_dev *hdev)
 
 static void hclge_destroy_queue(struct hclge_cmq_ring *ring)
 {
-	spin_lock_bh(&ring->lock);
+	spin_lock(&ring->lock);
 	hclge_free_cmd_desc(ring);
-	spin_unlock_bh(&ring->lock);
+	spin_unlock(&ring->lock);
 }
 
 void hclge_destroy_cmd_queue(struct hclge_hw *hw)
-- 
2.7.4
