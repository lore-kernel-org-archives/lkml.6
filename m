Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967942AbeEYSot (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:44:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60872 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S967824AbeEYSop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:44:45 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH net-next 05/12] net: hns3: Fix for PF mailbox receving unknown message
Date: Fri, 25 May 2018 19:43:00 +0100
Message-ID: <20180525184307.36288-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180525184307.36288-1-salil.mehta@huawei.com>
References: <20180525184307.36288-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Before the firmware updates the crq's tail pointer, if the PF driver
reads the data in the crq, the data may be incomplete at this time,
which will lead to the driver read an unknown message.

This patch fixes it by checking if crq is not empty before reading the
message.

Fixes: c1a81619d73a ("net: hns3: Add mailbox interrupt handling to PF driver")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index b6ae26b..31f3d9a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -382,6 +382,13 @@ static void hclge_reset_vf(struct hclge_vport *vport,
 	hclge_func_reset_cmd(hdev, mbx_req->mbx_src_vfid);
 }
 
+static bool hclge_cmd_crq_empty(struct hclge_hw *hw)
+{
+	u32 tail = hclge_read_dev(hw, HCLGE_NIC_CRQ_TAIL_REG);
+
+	return tail == hw->cmq.crq.next_to_use;
+}
+
 void hclge_mbx_handler(struct hclge_dev *hdev)
 {
 	struct hclge_cmq_ring *crq = &hdev->hw.cmq.crq;
@@ -390,12 +397,23 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 	struct hclge_desc *desc;
 	int ret, flag;
 
-	flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
 	/* handle all the mailbox requests in the queue */
-	while (hnae_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B)) {
+	while (!hclge_cmd_crq_empty(&hdev->hw)) {
 		desc = &crq->desc[crq->next_to_use];
 		req = (struct hclge_mbx_vf_to_pf_cmd *)desc->data;
 
+		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
+		if (unlikely(!hnae_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B))) {
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
 		vport = &hdev->vport[req->mbx_src_vfid];
 
 		switch (req->msg[0]) {
@@ -470,7 +488,6 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 		}
 		crq->desc[crq->next_to_use].flag = 0;
 		hclge_mbx_ring_ptr_move_crq(crq);
-		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
 	}
 
 	/* Write back CMDQ_RQ header pointer, M7 need this pointer */
-- 
2.7.4
