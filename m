Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeFELnp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:43:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751866AbeFELnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:43:10 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH net-next 2/3] net: hns3: Fix for VF mailbox receiving unknown message
Date: Tue, 5 Jun 2018 12:42:00 +0100
Message-ID: <20180605114201.29900-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180605114201.29900-1-salil.mehta@huawei.com>
References: <20180605114201.29900-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Before the firmware updates the crq's tail pointer, if the VF driver
reads the data in the crq, the data may be incomplete at this time,
which will lead to the driver read an unknown message.

This patch fixes it by checking if crq is empty before reading the
message.

Fixes: b11a0bb231f3 ("net: hns3: Add mailbox support to VF driver")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index a286184..173ca27 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -126,6 +126,13 @@ int hclgevf_send_mbx_msg(struct hclgevf_dev *hdev, u16 code, u16 subcode,
 	return status;
 }
 
+static bool hclgevf_cmd_crq_empty(struct hclgevf_hw *hw)
+{
+	u32 tail = hclgevf_read_dev(hw, HCLGEVF_NIC_CRQ_TAIL_REG);
+
+	return tail == hw->cmq.crq.next_to_use;
+}
+
 void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 {
 	struct hclgevf_mbx_resp_status *resp;
@@ -140,11 +147,22 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 	resp = &hdev->mbx_resp;
 	crq = &hdev->hw.cmq.crq;
 
-	flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
-	while (hnae_get_bit(flag, HCLGEVF_CMDQ_RX_OUTVLD_B)) {
+	while (!hclgevf_cmd_crq_empty(&hdev->hw)) {
 		desc = &crq->desc[crq->next_to_use];
 		req = (struct hclge_mbx_pf_to_vf_cmd *)desc->data;
 
+		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
+		if (unlikely(!hnae3_get_bit(flag, HCLGEVF_CMDQ_RX_OUTVLD_B))) {
+			dev_warn(&hdev->pdev->dev,
+				 "dropped invalid mailbox message, code = %d\n",
+				 req->msg[0]);
+
+			/* dropping/not processing this invalid message */
+			crq->desc[crq->next_to_use].flag = 0;
+			hclge_mbx_ring_ptr_move_crq(crq);
+			continue;
+		}
+
 		/* synchronous messages are time critical and need preferential
 		 * treatment. Therefore, we need to acknowledge all the sync
 		 * responses as quickly as possible so that waiting tasks do not
@@ -205,7 +223,6 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 		}
 		crq->desc[crq->next_to_use].flag = 0;
 		hclge_mbx_ring_ptr_move_crq(crq);
-		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
 	}
 
 	/* Write back CMDQ_RQ header pointer, M7 need this pointer */
-- 
2.7.4
