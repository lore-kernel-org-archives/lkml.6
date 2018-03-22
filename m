Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756034AbeCVOaO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:30:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45609 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755890AbeCVOaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:10 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <mehta.salil.lnk@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 5/9] net: hns3: Add support to reset the enet/ring mgmt layer
Date: Thu, 22 Mar 2018 14:28:56 +0000
Message-ID: <20180322142900.22860-6-salil.mehta@huawei.com>
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

After VF driver knows that hardware reset has been performed
successfully, it should proceed ahead and reset the enet layer.
This primarily consists of bringing down interface, clearing
TX/RX rings, disassociating vectors from ring etc.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 103 ++++++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   3 +
 2 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index b648311..bd45b11 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include <linux/etherdevice.h>
+#include <net/rtnetlink.h>
 #include "hclgevf_cmd.h"
 #include "hclgevf_main.h"
 #include "hclge_mbx.h"
@@ -832,6 +833,101 @@ static void hclgevf_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 			     2, true, NULL, 0);
 }
 
+static int hclgevf_notify_client(struct hclgevf_dev *hdev,
+				 enum hnae3_reset_notify_type type)
+{
+	struct hnae3_client *client = hdev->nic_client;
+	struct hnae3_handle *handle = &hdev->nic;
+
+	if (!client->ops->reset_notify)
+		return -EOPNOTSUPP;
+
+	return client->ops->reset_notify(handle, type);
+}
+
+static int hclgevf_reset_wait(struct hclgevf_dev *hdev)
+{
+#define HCLGEVF_RESET_WAIT_MS	500
+#define HCLGEVF_RESET_WAIT_CNT	20
+	u32 val, cnt = 0;
+
+	/* wait to check the hardware reset completion status */
+	val = hclgevf_read_dev(&hdev->hw, HCLGEVF_FUN_RST_ING);
+	while (hnae_get_bit(val, HCLGEVF_FUN_RST_ING_B) &&
+			    (cnt < HCLGEVF_RESET_WAIT_CNT)) {
+		msleep(HCLGEVF_RESET_WAIT_MS);
+		val = hclgevf_read_dev(&hdev->hw, HCLGEVF_FUN_RST_ING);
+		cnt++;
+	}
+
+	/* hardware completion status should be available by this time */
+	if (cnt >= HCLGEVF_RESET_WAIT_CNT) {
+		dev_warn(&hdev->pdev->dev,
+			 "could'nt get reset done status from h/w, timeout!\n");
+		return -EBUSY;
+	}
+
+	/* we will wait a bit more to let reset of the stack to complete. This
+	 * might happen in case reset assertion was made by PF. Yes, this also
+	 * means we might end up waiting bit more even for VF reset.
+	 */
+	msleep(5000);
+
+	return 0;
+}
+
+static int hclgevf_reset_stack(struct hclgevf_dev *hdev)
+{
+	/* uninitialize the nic client */
+	hclgevf_notify_client(hdev, HNAE3_UNINIT_CLIENT);
+
+	/* re-initialize the hclge device - add code here */
+
+	/* bring up the nic client again */
+	hclgevf_notify_client(hdev, HNAE3_INIT_CLIENT);
+
+	return 0;
+}
+
+static int hclgevf_reset(struct hclgevf_dev *hdev)
+{
+	int ret;
+
+	rtnl_lock();
+
+	/* bring down the nic to stop any ongoing TX/RX */
+	hclgevf_notify_client(hdev, HNAE3_DOWN_CLIENT);
+
+	/* check if VF could successfully fetch the hardware reset completion
+	 * status from the hardware
+	 */
+	ret = hclgevf_reset_wait(hdev);
+	if (ret) {
+		/* can't do much in this situation, will disable VF */
+		dev_err(&hdev->pdev->dev,
+			"VF failed(=%d) to fetch H/W reset completion status\n",
+			ret);
+
+		dev_warn(&hdev->pdev->dev, "VF reset failed, disabling VF!\n");
+		hclgevf_notify_client(hdev, HNAE3_UNINIT_CLIENT);
+
+		rtnl_unlock();
+		return ret;
+	}
+
+	/* now, re-initialize the nic client and ae device*/
+	ret = hclgevf_reset_stack(hdev);
+	if (ret)
+		dev_err(&hdev->pdev->dev, "failed to reset VF stack\n");
+
+	/* bring up the nic to enable TX/RX again */
+	hclgevf_notify_client(hdev, HNAE3_UP_CLIENT);
+
+	rtnl_unlock();
+
+	return ret;
+}
+
 static int hclgevf_do_reset(struct hclgevf_dev *hdev)
 {
 	int status;
@@ -940,10 +1036,9 @@ static void hclgevf_reset_service_task(struct work_struct *work)
 		 */
 		hdev->reset_attempts = 0;
 
-		/* code to check/wait for hardware reset completion and the
-		 * further initiating software stack reset would be added here
-		 */
-
+		ret = hclgevf_reset(hdev);
+		if (ret)
+			dev_err(&hdev->pdev->dev, "VF stack reset failed.\n");
 	} else if (test_and_clear_bit(HCLGEVF_RESET_REQUESTED,
 				      &hdev->reset_state)) {
 		/* we could be here when either of below happens:
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 1c9cf87..afdb15d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -34,6 +34,9 @@
 #define HCLGEVF_VECTOR0_RX_CMDQ_INT_B	1
 
 #define HCLGEVF_TQP_RESET_TRY_TIMES	10
+/* Reset related Registers */
+#define HCLGEVF_FUN_RST_ING		0x20C00
+#define HCLGEVF_FUN_RST_ING_B		0
 
 #define HCLGEVF_RSS_IND_TBL_SIZE		512
 #define HCLGEVF_RSS_SET_BITMAP_MSK	0xffff
-- 
2.7.4
