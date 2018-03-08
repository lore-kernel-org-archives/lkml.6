Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965206AbeCHLMA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:12:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755135AbeCHLKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:10:19 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [Patch net-next 4/6] net: hns3: fix the queue id for tqp enable&&reset
Date: Thu, 8 Mar 2018 19:41:53 +0800
Message-ID: <1520509315-40895-5-git-send-email-lipeng321@huawei.com>
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

Command HCLGE_OPC_CFG_COM_TQP_QUEUE should use queue id in the
function, but command HCLGE_OPC_RESET_TQP_QUEUE should use global
queue id.
This patch fixes the queue id about queue enable/disable/reset.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 50 +++++++++++-----------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 32bc6f6..39bc0e6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3717,20 +3717,11 @@ static int hclge_ae_start(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	int i, queue_id, ret;
+	int i, ret;
 
-	for (i = 0; i < vport->alloc_tqps; i++) {
-		/* todo clear interrupt */
-		/* ring enable */
-		queue_id = hclge_get_queue_id(handle->kinfo.tqp[i]);
-		if (queue_id < 0) {
-			dev_warn(&hdev->pdev->dev,
-				 "Get invalid queue id, ignore it\n");
-			continue;
-		}
+	for (i = 0; i < vport->alloc_tqps; i++)
+		hclge_tqp_enable(hdev, i, 0, true);
 
-		hclge_tqp_enable(hdev, queue_id, 0, true);
-	}
 	/* mac enable */
 	hclge_cfg_mac_mode(hdev, true);
 	clear_bit(HCLGE_STATE_DOWN, &hdev->state);
@@ -3750,19 +3741,11 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	int i, queue_id;
+	int i;
 
-	for (i = 0; i < vport->alloc_tqps; i++) {
-		/* Ring disable */
-		queue_id = hclge_get_queue_id(handle->kinfo.tqp[i]);
-		if (queue_id < 0) {
-			dev_warn(&hdev->pdev->dev,
-				 "Get invalid queue id, ignore it\n");
-			continue;
-		}
+	for (i = 0; i < vport->alloc_tqps; i++)
+		hclge_tqp_enable(hdev, i, 0, false);
 
-		hclge_tqp_enable(hdev, queue_id, 0, false);
-	}
 	/* Mac disable */
 	hclge_cfg_mac_mode(hdev, false);
 
@@ -4848,21 +4831,36 @@ static int hclge_get_reset_status(struct hclge_dev *hdev, u16 queue_id)
 	return hnae_get_bit(req->ready_to_reset, HCLGE_TQP_RESET_B);
 }
 
+static u16 hclge_covert_handle_qid_global(struct hnae3_handle *handle,
+					  u16 queue_id)
+{
+	struct hnae3_queue *queue;
+	struct hclge_tqp *tqp;
+
+	queue = handle->kinfo.tqp[queue_id];
+	tqp = container_of(queue, struct hclge_tqp, q);
+
+	return tqp->index;
+}
+
 void hclge_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 	int reset_try_times = 0;
 	int reset_status;
+	u16 queue_gid;
 	int ret;
 
+	queue_gid = hclge_covert_handle_qid_global(handle, queue_id);
+
 	ret = hclge_tqp_enable(hdev, queue_id, 0, false);
 	if (ret) {
 		dev_warn(&hdev->pdev->dev, "Disable tqp fail, ret = %d\n", ret);
 		return;
 	}
 
-	ret = hclge_send_reset_tqp_cmd(hdev, queue_id, true);
+	ret = hclge_send_reset_tqp_cmd(hdev, queue_gid, true);
 	if (ret) {
 		dev_warn(&hdev->pdev->dev,
 			 "Send reset tqp cmd fail, ret = %d\n", ret);
@@ -4873,7 +4871,7 @@ void hclge_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 	while (reset_try_times++ < HCLGE_TQP_RESET_TRY_TIMES) {
 		/* Wait for tqp hw reset */
 		msleep(20);
-		reset_status = hclge_get_reset_status(hdev, queue_id);
+		reset_status = hclge_get_reset_status(hdev, queue_gid);
 		if (reset_status)
 			break;
 	}
@@ -4883,7 +4881,7 @@ void hclge_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 		return;
 	}
 
-	ret = hclge_send_reset_tqp_cmd(hdev, queue_id, false);
+	ret = hclge_send_reset_tqp_cmd(hdev, queue_gid, false);
 	if (ret) {
 		dev_warn(&hdev->pdev->dev,
 			 "Deassert the soft reset fail, ret = %d\n", ret);
-- 
2.9.3
