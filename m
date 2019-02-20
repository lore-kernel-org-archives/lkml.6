Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E01C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A772121773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfBTCe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:34:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730328AbfBTCdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:41 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08B3B74730D216E040D3;
        Wed, 20 Feb 2019 10:33:37 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:30 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [Patch net-next 11/12] net: hns3: uninitialize command queue while unloading PF driver
Date:   Wed, 20 Feb 2019 10:32:50 +0800
Message-ID: <1550629971-23999-12-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
References: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the hardware's description, the driver should clear
the command queue's registers when uloading driver. Otherwise,
these existing value may lead the IMP get into a wrong state.

Also this patch adds hclge_cmd_uninit() to do the command queue
uninitialization which includes clearing registers and freeing
memory.

Fixes: 68c0a5c70614 ("net: hns3: Add HNS3 IMP(Integrated Mgmt Proc) Cmd Interface Support")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 26 ++++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  4 ++--
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 1dddfcb..3a093a9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -390,6 +390,20 @@ int hclge_cmd_init(struct hclge_dev *hdev)
 	return 0;
 }
 
+static void hclge_cmd_uninit_regs(struct hclge_hw *hw)
+{
+	hclge_write_dev(hw, HCLGE_NIC_CSQ_BASEADDR_L_REG, 0);
+	hclge_write_dev(hw, HCLGE_NIC_CSQ_BASEADDR_H_REG, 0);
+	hclge_write_dev(hw, HCLGE_NIC_CSQ_DEPTH_REG, 0);
+	hclge_write_dev(hw, HCLGE_NIC_CSQ_HEAD_REG, 0);
+	hclge_write_dev(hw, HCLGE_NIC_CSQ_TAIL_REG, 0);
+	hclge_write_dev(hw, HCLGE_NIC_CRQ_BASEADDR_L_REG, 0);
+	hclge_write_dev(hw, HCLGE_NIC_CRQ_BASEADDR_H_REG, 0);
+	hclge_write_dev(hw, HCLGE_NIC_CRQ_DEPTH_REG, 0);
+	hclge_write_dev(hw, HCLGE_NIC_CRQ_HEAD_REG, 0);
+	hclge_write_dev(hw, HCLGE_NIC_CRQ_TAIL_REG, 0);
+}
+
 static void hclge_destroy_queue(struct hclge_cmq_ring *ring)
 {
 	spin_lock(&ring->lock);
@@ -402,3 +416,15 @@ void hclge_destroy_cmd_queue(struct hclge_hw *hw)
 	hclge_destroy_queue(&hw->cmq.csq);
 	hclge_destroy_queue(&hw->cmq.crq);
 }
+
+void hclge_cmd_uninit(struct hclge_dev *hdev)
+{
+	spin_lock_bh(&hdev->hw.cmq.csq.lock);
+	spin_lock(&hdev->hw.cmq.crq.lock);
+	set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	hclge_cmd_uninit_regs(&hdev->hw);
+	spin_unlock(&hdev->hw.cmq.crq.lock);
+	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
+
+	hclge_destroy_cmd_queue(&hdev->hw);
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index ac2cd21..bad21c89 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -975,6 +975,6 @@ enum hclge_cmd_status hclge_cmd_mdio_write(struct hclge_hw *hw,
 enum hclge_cmd_status hclge_cmd_mdio_read(struct hclge_hw *hw,
 					  struct hclge_desc *desc);
 
-void hclge_destroy_cmd_queue(struct hclge_hw *hw);
+void hclge_cmd_uninit(struct hclge_dev *hdev);
 int hclge_cmd_queue_init(struct hclge_dev *hdev);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 4a59646..5c8f2e4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7669,7 +7669,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 err_msi_uninit:
 	pci_free_irq_vectors(pdev);
 err_cmd_uninit:
-	hclge_destroy_cmd_queue(&hdev->hw);
+	hclge_cmd_uninit(hdev);
 err_pci_uninit:
 	pcim_iounmap(pdev, hdev->hw.io_base);
 	pci_clear_master(pdev);
@@ -7796,7 +7796,7 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 	synchronize_irq(hdev->misc_vector.vector_irq);
 
 	hclge_hw_error_set_state(hdev, false);
-	hclge_destroy_cmd_queue(&hdev->hw);
+	hclge_cmd_uninit(hdev);
 	hclge_misc_irq_uninit(hdev);
 	hclge_pci_uninit(hdev);
 	mutex_destroy(&hdev->vport_lock);
-- 
2.7.4

