Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755884AbeCHLK2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:10:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755773AbeCHLKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:10:17 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [Patch net-next 2/6] net: hns3: set the cmdq out_vld bit to 0 after used
Date: Thu, 8 Mar 2018 19:41:51 +0800
Message-ID: <1520509315-40895-3-git-send-email-lipeng321@huawei.com>
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

Driver check the out_vld bit when get a new cmdq BD, if the bit is 1,
the BD is valid. driver Should set the bit 0 after used and hw will
set the bit 1 if get a valid BD.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c   | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 31383a6..6d48ebf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -410,6 +410,7 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 				req->msg[0]);
 			break;
 		}
+		crq->desc[crq->next_to_use].flag = 0;
 		hclge_mbx_ring_ptr_move_crq(crq);
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index e39cad2..18283ef 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -171,6 +171,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 				req->msg[0]);
 			break;
 		}
+		crq->desc[crq->next_to_use].flag = 0;
 		hclge_mbx_ring_ptr_move_crq(crq);
 		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
 	}
-- 
2.9.3
