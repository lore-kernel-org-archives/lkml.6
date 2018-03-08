Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755909AbeCHLL2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:11:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755818AbeCHLKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:10:22 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [Patch net-next 3/6] net: hns3: fix endian issue when PF get mbx message flag
Date: Thu, 8 Mar 2018 19:41:52 +0800
Message-ID: <1520509315-40895-4-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520509315-40895-1-git-send-email-lipeng321@huawei.com>
References: <1520509315-40895-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the endian issue when PF get mbx message flag.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 6d48ebf..f332de6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -333,11 +333,11 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 	struct hclge_mbx_vf_to_pf_cmd *req;
 	struct hclge_vport *vport;
 	struct hclge_desc *desc;
-	int ret;
+	int ret, flag;
 
+	flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
 	/* handle all the mailbox requests in the queue */
-	while (hnae_get_bit(crq->desc[crq->next_to_use].flag,
-			    HCLGE_CMDQ_RX_OUTVLD_B)) {
+	while (hnae_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B)) {
 		desc = &crq->desc[crq->next_to_use];
 		req = (struct hclge_mbx_vf_to_pf_cmd *)desc->data;
 
@@ -412,6 +412,7 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 		}
 		crq->desc[crq->next_to_use].flag = 0;
 		hclge_mbx_ring_ptr_move_crq(crq);
+		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
 	}
 
 	/* Write back CMDQ_RQ header pointer, M7 need this pointer */
-- 
2.9.3
