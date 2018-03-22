Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755436AbeCVObu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:31:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754583AbeCVOaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:12 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <mehta.salil.lnk@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 2/9] net: hns3: Add VF Reset Service Task to support event handling
Date: Thu, 22 Mar 2018 14:28:53 +0000
Message-ID: <20180322142900.22860-3-salil.mehta@huawei.com>
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

VF reset would involve handling of different reset related events
from the stack, physical function, mailbox etc. Reset service task
would be used in servicing such reset event requests and later
handling the hardware completions waits and initiating the stack
resets.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 31 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  4 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 6c3881d..cdb6e7a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -867,6 +867,15 @@ static void hclgevf_get_misc_vector(struct hclgevf_dev *hdev)
 	hdev->num_msi_used += 1;
 }
 
+void hclgevf_reset_task_schedule(struct hclgevf_dev *hdev)
+{
+	if (!test_bit(HCLGEVF_STATE_RST_SERVICE_SCHED, &hdev->state) &&
+	    !test_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state)) {
+		set_bit(HCLGEVF_STATE_RST_SERVICE_SCHED, &hdev->state);
+		schedule_work(&hdev->rst_service_task);
+	}
+}
+
 static void hclgevf_mbx_task_schedule(struct hclgevf_dev *hdev)
 {
 	if (!test_and_set_bit(HCLGEVF_STATE_MBX_SERVICE_SCHED, &hdev->state))
@@ -889,6 +898,24 @@ static void hclgevf_service_timer(struct timer_list *t)
 	hclgevf_task_schedule(hdev);
 }
 
+static void hclgevf_reset_service_task(struct work_struct *work)
+{
+	struct hclgevf_dev *hdev =
+		container_of(work, struct hclgevf_dev, rst_service_task);
+
+	if (test_and_set_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state))
+		return;
+
+	clear_bit(HCLGEVF_STATE_RST_SERVICE_SCHED, &hdev->state);
+
+	/* body of the reset service task will constitute of hclge device
+	 * reset state handling. This code shall be added subsequently in
+	 * next patches.
+	 */
+
+	clear_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state);
+}
+
 static void hclgevf_mailbox_service_task(struct work_struct *work)
 {
 	struct hclgevf_dev *hdev;
@@ -1097,6 +1124,8 @@ static void hclgevf_state_init(struct hclgevf_dev *hdev)
 	INIT_WORK(&hdev->service_task, hclgevf_service_task);
 	clear_bit(HCLGEVF_STATE_SERVICE_SCHED, &hdev->state);
 
+	INIT_WORK(&hdev->rst_service_task, hclgevf_reset_service_task);
+
 	mutex_init(&hdev->mbx_resp.mbx_mutex);
 
 	/* bring the device down */
@@ -1113,6 +1142,8 @@ static void hclgevf_state_uninit(struct hclgevf_dev *hdev)
 		cancel_work_sync(&hdev->service_task);
 	if (hdev->mbx_service_task.func)
 		cancel_work_sync(&hdev->mbx_service_task);
+	if (hdev->rst_service_task.func)
+		cancel_work_sync(&hdev->rst_service_task);
 
 	mutex_destroy(&hdev->mbx_resp.mbx_mutex);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 0eaea06..8b5fa67 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -52,6 +52,8 @@ enum hclgevf_states {
 	HCLGEVF_STATE_DISABLED,
 	/* task states */
 	HCLGEVF_STATE_SERVICE_SCHED,
+	HCLGEVF_STATE_RST_SERVICE_SCHED,
+	HCLGEVF_STATE_RST_HANDLING,
 	HCLGEVF_STATE_MBX_SERVICE_SCHED,
 	HCLGEVF_STATE_MBX_HANDLING,
 };
@@ -146,6 +148,7 @@ struct hclgevf_dev {
 
 	struct timer_list service_timer;
 	struct work_struct service_task;
+	struct work_struct rst_service_task;
 	struct work_struct mbx_service_task;
 
 	struct hclgevf_tqp *htqp;
@@ -165,4 +168,5 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev);
 void hclgevf_update_link_status(struct hclgevf_dev *hdev, int link_state);
 void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
 				 u8 duplex);
+void hclgevf_reset_task_schedule(struct hclgevf_dev *hdev);
 #endif
-- 
2.7.4
