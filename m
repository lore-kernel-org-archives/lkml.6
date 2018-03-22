Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756085AbeCVOad (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:30:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6677 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751742AbeCVOaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:30 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <mehta.salil.lnk@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 9/9] net: hns3: Changes required in PF mailbox to support VF reset
Date: Thu, 22 Mar 2018 14:29:00 +0000
Message-ID: <20180322142900.22860-10-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180322142900.22860-1-salil.mehta@huawei.com>
References: <20180322142900.22860-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.47]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PF needs to assert the VF reset when it receives the request to
reset from VF. After receiving request PF ackknowledges the
request by replying back MBX_ASSERTING_RESET message to VF.
VF then goes to pending state and wait for hardware to complete
the reset.

This patch contains code to handle the received VF message, inform
the VF of assertion and reset the VF using cmdq interface.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 42 ++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a3e00da..bede411 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2749,7 +2749,7 @@ static int hclge_reset_wait(struct hclge_dev *hdev)
 	return 0;
 }
 
-static int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id)
+int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id)
 {
 	struct hclge_desc desc;
 	struct hclge_reset_cmd *req = (struct hclge_reset_cmd *)desc.data;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 8c14d10..0f4157e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -657,4 +657,5 @@ void hclge_mbx_handler(struct hclge_dev *hdev);
 void hclge_reset_tqp(struct hnae3_handle *handle, u16 queue_id);
 void hclge_reset_vf_queue(struct hclge_vport *vport, u16 queue_id);
 int hclge_cfg_flowctrl(struct hclge_dev *hdev);
+int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 949da0c..3901333 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -79,6 +79,18 @@ static int hclge_send_mbx_msg(struct hclge_vport *vport, u8 *msg, u16 msg_len,
 	return status;
 }
 
+int hclge_inform_reset_assert_to_vf(struct hclge_vport *vport)
+{
+	u8 msg_data[2];
+	u8 dest_vfid;
+
+	dest_vfid = (u8)vport->vport_id;
+
+	/* send this requested info to VF */
+	return hclge_send_mbx_msg(vport, msg_data, sizeof(u8),
+				  HCLGE_MBX_ASSERTING_RESET, dest_vfid);
+}
+
 static void hclge_free_vector_ring_chain(struct hnae3_ring_chain_node *head)
 {
 	struct hnae3_ring_chain_node *chain_tmp, *chain;
@@ -339,6 +351,33 @@ static void hclge_mbx_reset_vf_queue(struct hclge_vport *vport,
 	hclge_gen_resp_to_vf(vport, mbx_req, 0, NULL, 0);
 }
 
+static void hclge_reset_vf(struct hclge_vport *vport,
+			   struct hclge_mbx_vf_to_pf_cmd *mbx_req)
+{
+	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	dev_warn(&hdev->pdev->dev, "PF received VF reset request from VF %d!",
+		 mbx_req->mbx_src_vfid);
+
+	/* Acknowledge VF that PF is now about to assert the reset for the VF.
+	 * On receiving this message VF will get into pending state and will
+	 * start polling for the hardware reset completion status.
+	 */
+	ret = hclge_inform_reset_assert_to_vf(vport);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"PF fail(%d) to inform VF(%d)of reset, reset failed!\n",
+			ret, vport->vport_id);
+		return;
+	}
+
+	dev_warn(&hdev->pdev->dev, "PF is now resetting VF %d.\n",
+		 mbx_req->mbx_src_vfid);
+	/* reset this virtual function */
+	hclge_func_reset_cmd(hdev, mbx_req->mbx_src_vfid);
+}
+
 void hclge_mbx_handler(struct hclge_dev *hdev)
 {
 	struct hclge_cmq_ring *crq = &hdev->hw.cmq.crq;
@@ -416,6 +455,9 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 		case HCLGE_MBX_QUEUE_RESET:
 			hclge_mbx_reset_vf_queue(vport, req);
 			break;
+		case HCLGE_MBX_RESET:
+			hclge_reset_vf(vport, req);
+			break;
 		default:
 			dev_err(&hdev->pdev->dev,
 				"un-supported mailbox message, code = %d\n",
-- 
2.7.4
