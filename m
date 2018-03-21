Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeCUHVc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:21:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751455AbeCUHSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:16 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 02/11] net: hns3: fix the VF queue reset flow error
Date: Wed, 21 Mar 2018 15:49:21 +0800
Message-ID: <1521618570-129694-3-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
References: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VF queue reset flow is different from PF queue reset flow.
VF driver should stop VF queue first, then send message to PF
and PF do the reset. PF should send a response to VF after
PF complete the queue reset, VF can initialize the queue hw
after get the response.
This patch fixes the VF queue reset flow as the correct step.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 37 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 11 ++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 10 ++++--
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index e110c65..588f231 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4926,6 +4926,43 @@ void hclge_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 	}
 }
 
+void hclge_reset_vf_queue(struct hclge_vport *vport, u16 queue_id)
+{
+	struct hclge_dev *hdev = vport->back;
+	int reset_try_times = 0;
+	int reset_status;
+	u16 queue_gid;
+	int ret;
+
+	queue_gid = hclge_covert_handle_qid_global(&vport->nic, queue_id);
+
+	ret = hclge_send_reset_tqp_cmd(hdev, queue_gid, true);
+	if (ret) {
+		dev_warn(&hdev->pdev->dev,
+			 "Send reset tqp cmd fail, ret = %d\n", ret);
+		return;
+	}
+
+	reset_try_times = 0;
+	while (reset_try_times++ < HCLGE_TQP_RESET_TRY_TIMES) {
+		/* Wait for tqp hw reset */
+		msleep(20);
+		reset_status = hclge_get_reset_status(hdev, queue_gid);
+		if (reset_status)
+			break;
+	}
+
+	if (reset_try_times >= HCLGE_TQP_RESET_TRY_TIMES) {
+		dev_warn(&hdev->pdev->dev, "Reset TQP fail\n");
+		return;
+	}
+
+	ret = hclge_send_reset_tqp_cmd(hdev, queue_gid, false);
+	if (ret)
+		dev_warn(&hdev->pdev->dev,
+			 "Deassert the soft reset fail, ret = %d\n", ret);
+}
+
 static u32 hclge_get_fw_version(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 7bff6ef..edbcb73 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -646,5 +646,6 @@ void hclge_rss_indir_init_cfg(struct hclge_dev *hdev);
 
 void hclge_mbx_handler(struct hclge_dev *hdev);
 void hclge_reset_tqp(struct hnae3_handle *handle, u16 queue_id);
+void hclge_reset_vf_queue(struct hclge_vport *vport, u16 queue_id);
 int hclge_cfg_flowctrl(struct hclge_dev *hdev);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 4a49a6b..cef14e7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -322,14 +322,17 @@ static int hclge_get_link_info(struct hclge_vport *vport,
 				  HCLGE_MBX_LINK_STAT_CHANGE, dest_vfid);
 }
 
-static void hclge_reset_vf_queue(struct hclge_vport *vport,
-				 struct hclge_mbx_vf_to_pf_cmd *mbx_req)
+static void hclge_mbx_reset_vf_queue(struct hclge_vport *vport,
+				     struct hclge_mbx_vf_to_pf_cmd *mbx_req)
 {
 	u16 queue_id;
 
 	memcpy(&queue_id, &mbx_req->msg[2], sizeof(queue_id));
 
-	hclge_reset_tqp(&vport->nic, queue_id);
+	hclge_reset_vf_queue(vport, queue_id);
+
+	/* send response msg to VF after queue reset complete*/
+	hclge_gen_resp_to_vf(vport, mbx_req, 0, NULL, 0);
 }
 
 void hclge_mbx_handler(struct hclge_dev *hdev)
@@ -407,7 +410,7 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 					ret);
 			break;
 		case HCLGE_MBX_QUEUE_RESET:
-			hclge_reset_vf_queue(vport, req);
+			hclge_mbx_reset_vf_queue(vport, req);
 			break;
 		default:
 			dev_err(&hdev->pdev->dev,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 2337025..c96cf03 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -817,11 +817,17 @@ static void hclgevf_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	u8 msg_data[2];
+	int ret;
 
 	memcpy(&msg_data[0], &queue_id, sizeof(queue_id));
 
-	hclgevf_send_mbx_msg(hdev, HCLGE_MBX_QUEUE_RESET, 0, msg_data, 2, false,
-			     NULL, 0);
+	/* disable vf queue before send queue reset msg to PF */
+	ret = hclgevf_tqp_enable(hdev, queue_id, 0, false);
+	if (ret)
+		return;
+
+	hclgevf_send_mbx_msg(hdev, HCLGE_MBX_QUEUE_RESET, 0, msg_data,
+			     2, true, NULL, 0);
 }
 
 static u32 hclgevf_get_fw_version(struct hnae3_handle *handle)
-- 
2.9.3
