Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7D5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D522070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfADG6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:58:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfADG6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:58:00 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 70C98D8AA80C8;
        Fri,  4 Jan 2019 14:57:57 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Fri, 4 Jan 2019 14:57:52 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <xuechaojing@huawei.com>,
        <netdev@vger.kernel.org>, <wulike1@huawei.com>,
        <chiqijun@huawei.com>, <fy.wang@huawei.com>, <tony.qu@huawei.com>,
        <luoshaokai@huawei.com>
Subject: [PATCH 1/1] net-next/hinic: replace disable_irq_nosync/enable_irq
Date:   Thu, 3 Jan 2019 23:04:00 +0000
Message-ID: <20190103230400.29738-1-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid frequent system interrupts when sending and
receiving packets. we replace disable_irq_nosync/enable_irq
with hinic_set_msix_state(), hinic_set_msix_state is used to
access memory mapped hinic devices.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  | 13 +++++++++
 .../net/ethernet/huawei/hinic/hinic_hw_dev.h  |  3 ++
 .../net/ethernet/huawei/hinic/hinic_hw_if.c   | 28 +++++++++++++++++++
 .../net/ethernet/huawei/hinic/hinic_hw_if.h   | 14 ++++++++++
 drivers/net/ethernet/huawei/hinic/hinic_rx.c  | 11 ++++++--
 drivers/net/ethernet/huawei/hinic/hinic_tx.c  |  8 ++++--
 6 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
index 6b19607a4caa..3875f39f43bb 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
@@ -1008,3 +1008,16 @@ int hinic_hwdev_hw_ci_addr_set(struct hinic_hwdev *hwdev, struct hinic_sq *sq,
 				 &hw_ci, sizeof(hw_ci), NULL,
 				 NULL, HINIC_MGMT_MSG_SYNC);
 }
+
+/**
+ * hinic_hwdev_set_msix_state- set msix state
+ * @hwdev: the NIC HW device
+ * @msix_index: IRQ corresponding index number
+ * @flag: msix state
+ *
+ **/
+void hinic_hwdev_set_msix_state(struct hinic_hwdev *hwdev, u16 msix_index,
+				enum hinic_msix_state flag)
+{
+	hinic_set_msix_state(hwdev->hwif, msix_index, flag);
+}
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.h
index d1a7d2522d82..c9e621e19dd0 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.h
@@ -240,4 +240,7 @@ int hinic_hwdev_msix_set(struct hinic_hwdev *hwdev, u16 msix_index,
 int hinic_hwdev_hw_ci_addr_set(struct hinic_hwdev *hwdev, struct hinic_sq *sq,
 			       u8 pending_limit, u8 coalesc_timer);
 
+void hinic_hwdev_set_msix_state(struct hinic_hwdev *hwdev, u16 msix_index,
+				enum hinic_msix_state flag);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_if.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_if.c
index 823a17061a97..9b160f076904 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_if.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_if.c
@@ -168,6 +168,22 @@ void hinic_db_state_set(struct hinic_hwif *hwif,
 	hinic_hwif_write_reg(hwif, HINIC_CSR_FUNC_ATTR4_ADDR, attr4);
 }
 
+void hinic_set_msix_state(struct hinic_hwif *hwif, u16 msix_idx,
+			  enum hinic_msix_state flag)
+{
+	u32 offset = msix_idx * HINIC_PCI_MSIX_ENTRY_SIZE +
+			HINIC_PCI_MSIX_ENTRY_VECTOR_CTRL;
+	u32 mask_bits;
+
+	mask_bits = readl(hwif->intr_regs_base + offset);
+	mask_bits &= ~HINIC_PCI_MSIX_ENTRY_CTRL_MASKBIT;
+
+	if (flag)
+		mask_bits |= HINIC_PCI_MSIX_ENTRY_CTRL_MASKBIT;
+
+	writel(mask_bits, hwif->intr_regs_base + offset);
+}
+
 /**
  * hwif_ready - test if the HW is ready for use
  * @hwif: the HW interface of a pci function device
@@ -321,6 +337,13 @@ int hinic_init_hwif(struct hinic_hwif *hwif, struct pci_dev *pdev)
 		return -ENOMEM;
 	}
 
+	hwif->intr_regs_base = pci_ioremap_bar(pdev, HINIC_PCI_INTR_REGS_BAR);
+	if (!hwif->intr_regs_base) {
+		dev_err(&pdev->dev, "Failed to map configuration regs\n");
+		err = -ENOMEM;
+		goto err_map_intr_bar;
+	}
+
 	err = hwif_ready(hwif);
 	if (err) {
 		dev_err(&pdev->dev, "HW interface is not ready\n");
@@ -337,7 +360,11 @@ int hinic_init_hwif(struct hinic_hwif *hwif, struct pci_dev *pdev)
 	return 0;
 
 err_hwif_ready:
+	iounmap(hwif->intr_regs_base);
+
+err_map_intr_bar:
 	iounmap(hwif->cfg_regs_bar);
+
 	return err;
 }
 
@@ -347,5 +374,6 @@ int hinic_init_hwif(struct hinic_hwif *hwif, struct pci_dev *pdev)
  **/
 void hinic_free_hwif(struct hinic_hwif *hwif)
 {
+	iounmap(hwif->intr_regs_base);
 	iounmap(hwif->cfg_regs_bar);
 }
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_if.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_if.h
index 5b4760c0e9f5..22ec7f73e0a6 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_if.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_if.h
@@ -152,6 +152,7 @@
 #define HINIC_IS_PPF(hwif)              (HINIC_FUNC_TYPE(hwif) == HINIC_PPF)
 
 #define HINIC_PCI_CFG_REGS_BAR          0
+#define HINIC_PCI_INTR_REGS_BAR         2
 #define HINIC_PCI_DB_BAR                4
 
 #define HINIC_PCIE_ST_DISABLE           0
@@ -164,6 +165,10 @@
 #define HINIC_EQ_MSIX_LLI_CREDIT_LIMIT_DEFAULT  0       /* Disabled */
 #define HINIC_EQ_MSIX_RESEND_TIMER_DEFAULT      7       /* max */
 
+#define HINIC_PCI_MSIX_ENTRY_SIZE               16
+#define HINIC_PCI_MSIX_ENTRY_VECTOR_CTRL        12
+#define HINIC_PCI_MSIX_ENTRY_CTRL_MASKBIT       1
+
 enum hinic_pcie_nosnoop {
 	HINIC_PCIE_SNOOP        = 0,
 	HINIC_PCIE_NO_SNOOP     = 1,
@@ -207,6 +212,11 @@ enum hinic_db_state {
 	HINIC_DB_DISABLE = 1,
 };
 
+enum hinic_msix_state {
+	HINIC_MSIX_ENABLE,
+	HINIC_MSIX_DISABLE,
+};
+
 struct hinic_func_attr {
 	u16                     func_idx;
 	u8                      pf_idx;
@@ -226,6 +236,7 @@ struct hinic_func_attr {
 struct hinic_hwif {
 	struct pci_dev          *pdev;
 	void __iomem            *cfg_regs_bar;
+	void __iomem		*intr_regs_base;
 
 	struct hinic_func_attr  attr;
 };
@@ -251,6 +262,9 @@ int hinic_msix_attr_get(struct hinic_hwif *hwif, u16 msix_index,
 			u8 *lli_timer, u8 *lli_credit_limit,
 			u8 *resend_timer);
 
+void hinic_set_msix_state(struct hinic_hwif *hwif, u16 msix_idx,
+			  enum hinic_msix_state flag);
+
 int hinic_msix_attr_cnt_clear(struct hinic_hwif *hwif, u16 msix_index);
 
 void hinic_set_pf_action(struct hinic_hwif *hwif, enum hinic_pf_action action);
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
index 0098b206e7e9..b6d218768ec1 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
@@ -381,6 +381,7 @@ static int rxq_recv(struct hinic_rxq *rxq, int budget)
 static int rx_poll(struct napi_struct *napi, int budget)
 {
 	struct hinic_rxq *rxq = container_of(napi, struct hinic_rxq, napi);
+	struct hinic_dev *nic_dev = netdev_priv(rxq->netdev);
 	struct hinic_rq *rq = rxq->rq;
 	int pkts;
 
@@ -389,7 +390,10 @@ static int rx_poll(struct napi_struct *napi, int budget)
 		return budget;
 
 	napi_complete(napi);
-	enable_irq(rq->irq);
+	hinic_hwdev_set_msix_state(nic_dev->hwdev,
+				   rq->msix_entry,
+				   HINIC_MSIX_ENABLE);
+
 	return pkts;
 }
 
@@ -414,7 +418,10 @@ static irqreturn_t rx_irq(int irq, void *data)
 	struct hinic_dev *nic_dev;
 
 	/* Disable the interrupt until napi will be completed */
-	disable_irq_nosync(rq->irq);
+	nic_dev = netdev_priv(rxq->netdev);
+	hinic_hwdev_set_msix_state(nic_dev->hwdev,
+				   rq->msix_entry,
+				   HINIC_MSIX_DISABLE);
 
 	nic_dev = netdev_priv(rxq->netdev);
 	hinic_hwdev_msix_cnt_set(nic_dev->hwdev, rq->msix_entry);
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index 11e73e67358d..e17bf33eba0c 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -655,7 +655,9 @@ static int free_tx_poll(struct napi_struct *napi, int budget)
 
 	if (pkts < budget) {
 		napi_complete(napi);
-		enable_irq(sq->irq);
+		hinic_hwdev_set_msix_state(nic_dev->hwdev,
+					   sq->msix_entry,
+					   HINIC_MSIX_ENABLE);
 		return pkts;
 	}
 
@@ -682,7 +684,9 @@ static irqreturn_t tx_irq(int irq, void *data)
 	nic_dev = netdev_priv(txq->netdev);
 
 	/* Disable the interrupt until napi will be completed */
-	disable_irq_nosync(txq->sq->irq);
+	hinic_hwdev_set_msix_state(nic_dev->hwdev,
+				   txq->sq->msix_entry,
+				   HINIC_MSIX_DISABLE);
 
 	hinic_hwdev_msix_cnt_set(nic_dev->hwdev, txq->sq->msix_entry);
 
-- 
2.17.1

