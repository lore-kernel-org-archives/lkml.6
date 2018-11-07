Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7385CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284DC20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284DC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbeKGNez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:34:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730995AbeKGNey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:34:54 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 351B5471BE130;
        Wed,  7 Nov 2018 12:06:17 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 12:06:08 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 12/12] net: hns3: fix for cmd queue memory not freed problem during reset
Date:   Wed, 7 Nov 2018 12:06:18 +0800
Message-ID: <1541563578-28973-13-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
References: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to reallocate the descriptor and remap the
descriptor memory in reset process, otherwise it may cause memory
not freed problem.

Also, this patch initializes the cmd queue's spinlocks in
hclgevf_alloc_cmd_queue, and take the spinlocks when reinitializing
cmd queue' registers.

Fixes: fedd0c15d288 ("net: hns3: Add HNS3 VF IMP(Integrated Management Proc) cmd interface")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   | 141 ++++++++++++---------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h   |   1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  14 +-
 3 files changed, 91 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index 0d3b445..b917acf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -72,6 +72,45 @@ static bool hclgevf_is_special_opcode(u16 opcode)
 	return false;
 }
 
+static void hclgevf_cmd_config_regs(struct hclgevf_cmq_ring *ring)
+{
+	struct hclgevf_dev *hdev = ring->dev;
+	struct hclgevf_hw *hw = &hdev->hw;
+	u32 reg_val;
+
+	if (ring->flag == HCLGEVF_TYPE_CSQ) {
+		reg_val = (u32)ring->desc_dma_addr;
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_BASEADDR_L_REG, reg_val);
+		reg_val = (u32)((ring->desc_dma_addr >> 31) >> 1);
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_BASEADDR_H_REG, reg_val);
+
+		reg_val = (ring->desc_num >> HCLGEVF_NIC_CMQ_DESC_NUM_S);
+		reg_val |= HCLGEVF_NIC_CMQ_ENABLE;
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_DEPTH_REG, reg_val);
+
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_HEAD_REG, 0);
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_TAIL_REG, 0);
+	} else {
+		reg_val = (u32)ring->desc_dma_addr;
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_BASEADDR_L_REG, reg_val);
+		reg_val = (u32)((ring->desc_dma_addr >> 31) >> 1);
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_BASEADDR_H_REG, reg_val);
+
+		reg_val = (ring->desc_num >> HCLGEVF_NIC_CMQ_DESC_NUM_S);
+		reg_val |= HCLGEVF_NIC_CMQ_ENABLE;
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_DEPTH_REG, reg_val);
+
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_HEAD_REG, 0);
+		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_TAIL_REG, 0);
+	}
+}
+
+static void hclgevf_cmd_init_regs(struct hclgevf_hw *hw)
+{
+	hclgevf_cmd_config_regs(&hw->cmq.csq);
+	hclgevf_cmd_config_regs(&hw->cmq.crq);
+}
+
 static int hclgevf_alloc_cmd_desc(struct hclgevf_cmq_ring *ring)
 {
 	int size = ring->desc_num * sizeof(struct hclgevf_desc);
@@ -96,61 +135,23 @@ static void hclgevf_free_cmd_desc(struct hclgevf_cmq_ring *ring)
 	}
 }
 
-static int hclgevf_init_cmd_queue(struct hclgevf_dev *hdev,
-				  struct hclgevf_cmq_ring *ring)
+static int hclgevf_alloc_cmd_queue(struct hclgevf_dev *hdev, int ring_type)
 {
 	struct hclgevf_hw *hw = &hdev->hw;
-	int ring_type = ring->flag;
-	u32 reg_val;
+	struct hclgevf_cmq_ring *ring =
+		(ring_type == HCLGEVF_TYPE_CSQ) ? &hw->cmq.csq : &hw->cmq.crq;
 	int ret;
 
-	ring->desc_num = HCLGEVF_NIC_CMQ_DESC_NUM;
-	spin_lock_init(&ring->lock);
-	ring->next_to_clean = 0;
-	ring->next_to_use = 0;
 	ring->dev = hdev;
+	ring->flag = ring_type;
 
 	/* allocate CSQ/CRQ descriptor */
 	ret = hclgevf_alloc_cmd_desc(ring);
-	if (ret) {
+	if (ret)
 		dev_err(&hdev->pdev->dev, "failed(%d) to alloc %s desc\n", ret,
 			(ring_type == HCLGEVF_TYPE_CSQ) ? "CSQ" : "CRQ");
-		return ret;
-	}
-
-	/* initialize the hardware registers with csq/crq dma-address,
-	 * descriptor number, head & tail pointers
-	 */
-	switch (ring_type) {
-	case HCLGEVF_TYPE_CSQ:
-		reg_val = (u32)ring->desc_dma_addr;
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_BASEADDR_L_REG, reg_val);
-		reg_val = (u32)((ring->desc_dma_addr >> 31) >> 1);
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_BASEADDR_H_REG, reg_val);
 
-		reg_val = (ring->desc_num >> HCLGEVF_NIC_CMQ_DESC_NUM_S);
-		reg_val |= HCLGEVF_NIC_CMQ_ENABLE;
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_DEPTH_REG, reg_val);
-
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_HEAD_REG, 0);
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_TAIL_REG, 0);
-		return 0;
-	case HCLGEVF_TYPE_CRQ:
-		reg_val = (u32)ring->desc_dma_addr;
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_BASEADDR_L_REG, reg_val);
-		reg_val = (u32)((ring->desc_dma_addr >> 31) >> 1);
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_BASEADDR_H_REG, reg_val);
-
-		reg_val = (ring->desc_num >> HCLGEVF_NIC_CMQ_DESC_NUM_S);
-		reg_val |= HCLGEVF_NIC_CMQ_ENABLE;
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_DEPTH_REG, reg_val);
-
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_HEAD_REG, 0);
-		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_TAIL_REG, 0);
-		return 0;
-	default:
-		return -EINVAL;
-	}
+	return ret;
 }
 
 void hclgevf_cmd_setup_basic_desc(struct hclgevf_desc *desc,
@@ -282,55 +283,73 @@ static int  hclgevf_cmd_query_firmware_version(struct hclgevf_hw *hw,
 	return status;
 }
 
-int hclgevf_cmd_init(struct hclgevf_dev *hdev)
+int hclgevf_cmd_queue_init(struct hclgevf_dev *hdev)
 {
-	u32 version;
 	int ret;
 
-	/* setup Tx write back timeout */
+	/* Setup the lock for command queue */
+	spin_lock_init(&hdev->hw.cmq.csq.lock);
+	spin_lock_init(&hdev->hw.cmq.crq.lock);
+
 	hdev->hw.cmq.tx_timeout = HCLGEVF_CMDQ_TX_TIMEOUT;
+	hdev->hw.cmq.csq.desc_num = HCLGEVF_NIC_CMQ_DESC_NUM;
+	hdev->hw.cmq.crq.desc_num = HCLGEVF_NIC_CMQ_DESC_NUM;
 
-	/* setup queue CSQ/CRQ rings */
-	hdev->hw.cmq.csq.flag = HCLGEVF_TYPE_CSQ;
-	ret = hclgevf_init_cmd_queue(hdev, &hdev->hw.cmq.csq);
+	ret = hclgevf_alloc_cmd_queue(hdev, HCLGEVF_TYPE_CSQ);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
-			"failed(%d) to initialize CSQ ring\n", ret);
+			"CSQ ring setup error %d\n", ret);
 		return ret;
 	}
 
-	hdev->hw.cmq.crq.flag = HCLGEVF_TYPE_CRQ;
-	ret = hclgevf_init_cmd_queue(hdev, &hdev->hw.cmq.crq);
+	ret = hclgevf_alloc_cmd_queue(hdev, HCLGEVF_TYPE_CRQ);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
-			"failed(%d) to initialize CRQ ring\n", ret);
+			"CRQ ring setup error %d\n", ret);
 		goto err_csq;
 	}
 
+	return 0;
+err_csq:
+	hclgevf_free_cmd_desc(&hdev->hw.cmq.csq);
+	return ret;
+}
+
+int hclgevf_cmd_init(struct hclgevf_dev *hdev)
+{
+	u32 version;
+	int ret;
+
+	spin_lock_bh(&hdev->hw.cmq.csq.lock);
+	spin_lock_bh(&hdev->hw.cmq.crq.lock);
+
 	/* initialize the pointers of async rx queue of mailbox */
 	hdev->arq.hdev = hdev;
 	hdev->arq.head = 0;
 	hdev->arq.tail = 0;
 	hdev->arq.count = 0;
+	hdev->hw.cmq.csq.next_to_clean = 0;
+	hdev->hw.cmq.csq.next_to_use = 0;
+	hdev->hw.cmq.crq.next_to_clean = 0;
+	hdev->hw.cmq.crq.next_to_use = 0;
+
+	hclgevf_cmd_init_regs(&hdev->hw);
+
+	spin_unlock_bh(&hdev->hw.cmq.crq.lock);
+	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
 
 	/* get firmware version */
 	ret = hclgevf_cmd_query_firmware_version(&hdev->hw, &version);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed(%d) to query firmware version\n", ret);
-		goto err_crq;
+		return ret;
 	}
 	hdev->fw_version = version;
 
 	dev_info(&hdev->pdev->dev, "The firmware version is %08x\n", version);
 
 	return 0;
-err_crq:
-	hclgevf_free_cmd_desc(&hdev->hw.cmq.crq);
-err_csq:
-	hclgevf_free_cmd_desc(&hdev->hw.cmq.csq);
-
-	return ret;
 }
 
 void hclgevf_cmd_uninit(struct hclgevf_dev *hdev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
index bc294b0..090541d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
@@ -256,6 +256,7 @@ static inline u32 hclgevf_read_reg(u8 __iomem *base, u32 reg)
 
 int hclgevf_cmd_init(struct hclgevf_dev *hdev);
 void hclgevf_cmd_uninit(struct hclgevf_dev *hdev);
+int hclgevf_cmd_queue_init(struct hclgevf_dev *hdev);
 
 int hclgevf_cmd_send(struct hclgevf_hw *hw, struct hclgevf_desc *desc, int num);
 void hclgevf_cmd_setup_basic_desc(struct hclgevf_desc *desc,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 4a2148b..29da480 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1966,6 +1966,12 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		return ret;
 	}
 
+	ret = hclgevf_cmd_queue_init(hdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Cmd queue init failed: %d\n", ret);
+		goto err_cmd_queue_init;
+	}
+
 	ret = hclgevf_cmd_init(hdev);
 	if (ret)
 		goto err_cmd_init;
@@ -1975,13 +1981,13 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"Query vf status error, ret = %d.\n", ret);
-		goto err_query_vf;
+		goto err_cmd_init;
 	}
 
 	ret = hclgevf_init_msi(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed(%d) to init MSI/MSI-X\n", ret);
-		goto err_query_vf;
+		goto err_cmd_init;
 	}
 
 	hclgevf_state_init(hdev);
@@ -2037,9 +2043,9 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 err_misc_irq_init:
 	hclgevf_state_uninit(hdev);
 	hclgevf_uninit_msi(hdev);
-err_query_vf:
-	hclgevf_cmd_uninit(hdev);
 err_cmd_init:
+	hclgevf_cmd_uninit(hdev);
+err_cmd_queue_init:
 	hclgevf_pci_uninit(hdev);
 	return ret;
 }
-- 
2.7.4

