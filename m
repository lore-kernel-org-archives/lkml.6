Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755367AbeCVObs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:31:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42394 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754591AbeCVOaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:12 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <mehta.salil.lnk@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 3/9] net: hns3: Add VF Reset device state and its handling
Date: Thu, 22 Mar 2018 14:28:54 +0000
Message-ID: <20180322142900.22860-4-salil.mehta@huawei.com>
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

This introduces the hclge device reset states of "requested" and
"pending" and also its handling in context to Reset Service Task.

Device gets into requested state because of any VF reset request
asserted from upper layers, for example due to watchdog timeout
expiration. Requested state would result in eventually forwarding
the VF reset request to PF which would actually reset the VF.

Device will get into pending state if:
1. VF receives the acknowledgement from PF for the VF reset
   request it originally sent to PF.
2. Reset Service Task detects that after asserting VF reset for
   certain times the data-path is not working and device then
   decides to assert full VF reset(this means also resetting the
   PCIe interface).
3. PF intimates the VF that it has undergone reset.
Pending state would result in VF to poll for hardware reset
completion status and then resetting the stack/enet layer, which
in turn means reinitializing the ring management/enet layer.

Note: we would be adding support of 3. later as a separate patch.
This decision should not affect VF reset as its event handling
is generic in nature.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 67 ++++++++++++++++++++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  5 ++
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 56f9e650..37ec1b3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -119,6 +119,7 @@ enum hnae3_reset_notify_type {
 
 enum hnae3_reset_type {
 	HNAE3_VF_RESET,
+	HNAE3_VF_FULL_RESET,
 	HNAE3_FUNC_RESET,
 	HNAE3_CORE_RESET,
 	HNAE3_GLOBAL_RESET,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index cdb6e7a..0d204e2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -840,7 +840,9 @@ static void hclgevf_reset_event(struct hnae3_handle *handle)
 
 	handle->reset_level = HNAE3_VF_RESET;
 
-	/* request VF reset here. Code added later */
+	/* reset of this VF requested */
+	set_bit(HCLGEVF_RESET_REQUESTED, &hdev->reset_state);
+	hclgevf_reset_task_schedule(hdev);
 
 	handle->last_reset_time = jiffies;
 }
@@ -889,6 +891,12 @@ static void hclgevf_task_schedule(struct hclgevf_dev *hdev)
 		schedule_work(&hdev->service_task);
 }
 
+static void hclgevf_deferred_task_schedule(struct hclgevf_dev *hdev)
+{
+	if (test_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state))
+		hclgevf_reset_task_schedule(hdev);
+}
+
 static void hclgevf_service_timer(struct timer_list *t)
 {
 	struct hclgevf_dev *hdev = from_timer(hdev, t, service_timer);
@@ -908,10 +916,57 @@ static void hclgevf_reset_service_task(struct work_struct *work)
 
 	clear_bit(HCLGEVF_STATE_RST_SERVICE_SCHED, &hdev->state);
 
-	/* body of the reset service task will constitute of hclge device
-	 * reset state handling. This code shall be added subsequently in
-	 * next patches.
-	 */
+	if (test_and_clear_bit(HCLGEVF_RESET_PENDING,
+			       &hdev->reset_state)) {
+		/* PF has initmated that it is about to reset the hardware.
+		 * We now have to poll & check if harware has actually completed
+		 * the reset sequence. On hardware reset completion, VF needs to
+		 * reset the client and ae device.
+		 */
+		hdev->reset_attempts = 0;
+
+		/* code to check/wait for hardware reset completion and the
+		 * further initiating software stack reset would be added here
+		 */
+
+	} else if (test_and_clear_bit(HCLGEVF_RESET_REQUESTED,
+				      &hdev->reset_state)) {
+		/* we could be here when either of below happens:
+		 * 1. reset was initiated due to watchdog timeout due to
+		 *    a. IMP was earlier reset and our TX got choked down and
+		 *       which resulted in watchdog reacting and inducing VF
+		 *       reset. This also means our cmdq would be unreliable.
+		 *    b. problem in TX due to other lower layer(example link
+		 *       layer not functioning properly etc.)
+		 * 2. VF reset might have been initiated due to some config
+		 *    change.
+		 *
+		 * NOTE: Theres no clear way to detect above cases than to react
+		 * to the response of PF for this reset request. PF will ack the
+		 * 1b and 2. cases but we will not get any intimation about 1a
+		 * from PF as cmdq would be in unreliable state i.e. mailbox
+		 * communication between PF and VF would be broken.
+		 */
+
+		/* if we are never geting into pending state it means either:
+		 * 1. PF is not receiving our request which could be due to IMP
+		 *    reset
+		 * 2. PF is screwed
+		 * We cannot do much for 2. but to check first we can try reset
+		 * our PCIe + stack and see if it alleviates the problem.
+		 */
+		if (hdev->reset_attempts > 3) {
+			/* prepare for full reset of stack + pcie interface */
+			hdev->nic.reset_level = HNAE3_VF_FULL_RESET;
+
+			/* "defer" schedule the reset task again */
+			set_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state);
+		} else {
+			hdev->reset_attempts++;
+
+			/* request PF for resetting this VF via mailbox */
+		}
+	}
 
 	clear_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state);
 }
@@ -943,6 +998,8 @@ static void hclgevf_service_task(struct work_struct *work)
 	 */
 	hclgevf_request_link_info(hdev);
 
+	hclgevf_deferred_task_schedule(hdev);
+
 	clear_bit(HCLGEVF_STATE_SERVICE_SCHED, &hdev->state);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 8b5fa67..1c9cf87 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -124,6 +124,11 @@ struct hclgevf_dev {
 	struct hclgevf_rss_cfg rss_cfg;
 	unsigned long state;
 
+#define HCLGEVF_RESET_REQUESTED		0
+#define HCLGEVF_RESET_PENDING		1
+	unsigned long reset_state;	/* requested, pending */
+	u32 reset_attempts;
+
 	u32 fw_version;
 	u16 num_tqps;		/* num task queue pairs of this PF */
 
-- 
2.7.4
