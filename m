Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756104AbeCVOak (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:30:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751753AbeCVOa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:28 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <mehta.salil.lnk@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 7/9] net: hns3: Changes to support ARQ(Asynchronous Receive Queue)
Date: Thu, 22 Mar 2018 14:28:58 +0000
Message-ID: <20180322142900.22860-8-salil.mehta@huawei.com>
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

Current mailbox CRQ could consists of both synchronous and async
responses from the PF. Synchronous responses are time critical
and should be handed over to the waiting tasks/context as quickly
as possible otherwise timeout occurs.

Above problem gets accentuated if CRQ consists of even single
async message. Hence, it is important to have quick handling of
synchronous messages and maybe deferred handling of async messages
This patch introduces separate ARQ(async receive queues) for the
async messages. These messages are processed later with repsect
to mailbox task while synchronous messages still gets processed
in context to mailbox interrupt.

ARQ is important as VF reset introduces some new async messages
like MBX_ASSERTING_RESET which adds up to the presssure on the
responses for synchronousmessages and they timeout even more
quickly.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    | 15 ++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  6 ++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 16 +++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  5 ++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   | 83 +++++++++++++++++++---
 5 files changed, 111 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index e6e1d22..f3e90c2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -85,6 +85,21 @@ struct hclge_mbx_pf_to_vf_cmd {
 	u16 msg[8];
 };
 
+/* used by VF to store the received Async responses from PF */
+struct hclgevf_mbx_arq_ring {
+#define HCLGE_MBX_MAX_ARQ_MSG_SIZE	8
+#define HCLGE_MBX_MAX_ARQ_MSG_NUM	1024
+	struct hclgevf_dev *hdev;
+	u32 head;
+	u32 tail;
+	u32 count;
+	u16 msg_q[HCLGE_MBX_MAX_ARQ_MSG_NUM][HCLGE_MBX_MAX_ARQ_MSG_SIZE];
+};
+
 #define hclge_mbx_ring_ptr_move_crq(crq) \
 	(crq->next_to_use = (crq->next_to_use + 1) % crq->desc_num)
+#define hclge_mbx_tail_ptr_move_arq(arq) \
+	(arq.tail = (arq.tail + 1) % HCLGE_MBX_MAX_ARQ_MSG_SIZE)
+#define hclge_mbx_head_ptr_move_arq(arq) \
+		(arq.head = (arq.head + 1) % HCLGE_MBX_MAX_ARQ_MSG_SIZE)
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index 85985e7..1bbfe13 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -315,6 +315,12 @@ int hclgevf_cmd_init(struct hclgevf_dev *hdev)
 		goto err_csq;
 	}
 
+	/* initialize the pointers of async rx queue of mailbox */
+	hdev->arq.hdev = hdev;
+	hdev->arq.head = 0;
+	hdev->arq.tail = 0;
+	hdev->arq.count = 0;
+
 	/* get firmware version */
 	ret = hclgevf_cmd_query_firmware_version(&hdev->hw, &version);
 	if (ret) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 6dd7561..2b84264 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1010,10 +1010,13 @@ void hclgevf_reset_task_schedule(struct hclgevf_dev *hdev)
 	}
 }
 
-static void hclgevf_mbx_task_schedule(struct hclgevf_dev *hdev)
+void hclgevf_mbx_task_schedule(struct hclgevf_dev *hdev)
 {
-	if (!test_and_set_bit(HCLGEVF_STATE_MBX_SERVICE_SCHED, &hdev->state))
+	if (!test_bit(HCLGEVF_STATE_MBX_SERVICE_SCHED, &hdev->state) &&
+	    !test_bit(HCLGEVF_STATE_MBX_HANDLING, &hdev->state)) {
+		set_bit(HCLGEVF_STATE_MBX_SERVICE_SCHED, &hdev->state);
 		schedule_work(&hdev->mbx_service_task);
+	}
 }
 
 static void hclgevf_task_schedule(struct hclgevf_dev *hdev)
@@ -1025,6 +1028,10 @@ static void hclgevf_task_schedule(struct hclgevf_dev *hdev)
 
 static void hclgevf_deferred_task_schedule(struct hclgevf_dev *hdev)
 {
+	/* if we have any pending mailbox event then schedule the mbx task */
+	if (hdev->mbx_event_pending)
+		hclgevf_mbx_task_schedule(hdev);
+
 	if (test_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state))
 		hclgevf_reset_task_schedule(hdev);
 }
@@ -1118,7 +1125,7 @@ static void hclgevf_mailbox_service_task(struct work_struct *work)
 
 	clear_bit(HCLGEVF_STATE_MBX_SERVICE_SCHED, &hdev->state);
 
-	hclgevf_mbx_handler(hdev);
+	hclgevf_mbx_async_handler(hdev);
 
 	clear_bit(HCLGEVF_STATE_MBX_HANDLING, &hdev->state);
 }
@@ -1178,8 +1185,7 @@ static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 	if (!hclgevf_check_event_cause(hdev, &clearval))
 		goto skip_sched;
 
-	/* schedule the VF mailbox service task, if not already scheduled */
-	hclgevf_mbx_task_schedule(hdev);
+	hclgevf_mbx_handler(hdev);
 
 	hclgevf_clear_event_cause(hdev, clearval);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 8cdc602..a477a7c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -152,7 +152,9 @@ struct hclgevf_dev {
 	int *vector_irq;
 
 	bool accept_mta_mc; /* whether to accept mta filter multicast */
+	bool mbx_event_pending;
 	struct hclgevf_mbx_resp_status mbx_resp; /* mailbox response */
+	struct hclgevf_mbx_arq_ring arq; /* mailbox async rx queue */
 
 	struct timer_list service_timer;
 	struct work_struct service_task;
@@ -187,8 +189,11 @@ int hclgevf_send_mbx_msg(struct hclgevf_dev *hdev, u16 code, u16 subcode,
 			 const u8 *msg_data, u8 msg_len, bool need_resp,
 			 u8 *resp_data, u16 resp_len);
 void hclgevf_mbx_handler(struct hclgevf_dev *hdev);
+void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev);
+
 void hclgevf_update_link_status(struct hclgevf_dev *hdev, int link_state);
 void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
 				 u8 duplex);
 void hclgevf_reset_task_schedule(struct hclgevf_dev *hdev);
+void hclgevf_mbx_task_schedule(struct hclgevf_dev *hdev);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index a63ed3a..7687911 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -132,9 +132,8 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 	struct hclge_mbx_pf_to_vf_cmd *req;
 	struct hclgevf_cmq_ring *crq;
 	struct hclgevf_desc *desc;
-	u16 link_status, flag;
-	u32 speed;
-	u8 duplex;
+	u16 *msg_q;
+	u16 flag;
 	u8 *temp;
 	int i;
 
@@ -146,6 +145,12 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 		desc = &crq->desc[crq->next_to_use];
 		req = (struct hclge_mbx_pf_to_vf_cmd *)desc->data;
 
+		/* synchronous messages are time critical and need preferential
+		 * treatment. Therefore, we need to acknowledge all the sync
+		 * responses as quickly as possible so that waiting tasks do not
+		 * timeout and simultaneously queue the async messages for later
+		 * prcessing in context of mailbox task i.e. the slow path.
+		 */
 		switch (req->msg[0]) {
 		case HCLGE_MBX_PF_VF_RESP:
 			if (resp->received_resp)
@@ -165,13 +170,30 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 			}
 			break;
 		case HCLGE_MBX_LINK_STAT_CHANGE:
-			link_status = le16_to_cpu(req->msg[1]);
-			memcpy(&speed, &req->msg[2], sizeof(speed));
-			duplex = (u8)le16_to_cpu(req->msg[4]);
+			/* set this mbx event as pending. This is required as we
+			 * might loose interrupt event when mbx task is busy
+			 * handling. This shall be cleared when mbx task just
+			 * enters handling state.
+			 */
+			hdev->mbx_event_pending = true;
 
-			/* update upper layer with new link link status */
-			hclgevf_update_link_status(hdev, link_status);
-			hclgevf_update_speed_duplex(hdev, speed, duplex);
+			/* we will drop the async msg if we find ARQ as full
+			 * and continue with next message
+			 */
+			if (hdev->arq.count >= HCLGE_MBX_MAX_ARQ_MSG_NUM) {
+				dev_warn(&hdev->pdev->dev,
+					 "Async Q full, dropping msg(%d)\n",
+					 req->msg[1]);
+				break;
+			}
+
+			/* tail the async message in arq */
+			msg_q = hdev->arq.msg_q[hdev->arq.tail];
+			memcpy(&msg_q[0], req->msg, HCLGE_MBX_MAX_ARQ_MSG_SIZE);
+			hclge_mbx_tail_ptr_move_arq(hdev->arq);
+			hdev->arq.count++;
+
+			hclgevf_mbx_task_schedule(hdev);
 
 			break;
 		default:
@@ -189,3 +211,46 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 	hclgevf_write_dev(&hdev->hw, HCLGEVF_NIC_CRQ_HEAD_REG,
 			  crq->next_to_use);
 }
+
+void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
+{
+	u16 link_status;
+	u16 *msg_q;
+	u8 duplex;
+	u32 speed;
+	u32 tail;
+
+	/* we can safely clear it now as we are at start of the async message
+	 * processing
+	 */
+	hdev->mbx_event_pending = false;
+
+	tail = hdev->arq.tail;
+
+	/* process all the async queue messages */
+	while (tail != hdev->arq.head) {
+		msg_q = hdev->arq.msg_q[hdev->arq.head];
+
+		switch (msg_q[0]) {
+		case HCLGE_MBX_LINK_STAT_CHANGE:
+			link_status = le16_to_cpu(msg_q[1]);
+			memcpy(&speed, &msg_q[2], sizeof(speed));
+			duplex = (u8)le16_to_cpu(msg_q[4]);
+
+			/* update upper layer with new link link status */
+			hclgevf_update_link_status(hdev, link_status);
+			hclgevf_update_speed_duplex(hdev, speed, duplex);
+
+			break;
+		default:
+			dev_err(&hdev->pdev->dev,
+				"fetched unsupported(%d) message from arq\n",
+				msg_q[0]);
+			break;
+		}
+
+		hclge_mbx_head_ptr_move_arq(hdev->arq);
+		hdev->arq.count--;
+		msg_q = hdev->arq.msg_q[hdev->arq.head];
+	}
+}
-- 
2.7.4
