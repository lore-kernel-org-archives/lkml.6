Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756047AbeCVOaV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:30:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45602 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754649AbeCVOaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:17 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <mehta.salil.lnk@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 4/9] net: hns3: Add support to request VF Reset to PF
Date: Thu, 22 Mar 2018 14:28:55 +0000
Message-ID: <20180322142900.22860-5-salil.mehta@huawei.com>
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

VF driver depends upon PF to eventually reset the hardware. This
request is made using the mailbox command. This patch adds the
required function to acheive above.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 0d204e2..b648311 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -832,6 +832,20 @@ static void hclgevf_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 			     2, true, NULL, 0);
 }
 
+static int hclgevf_do_reset(struct hclgevf_dev *hdev)
+{
+	int status;
+	u8 respmsg;
+
+	status = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_RESET, 0, NULL,
+				      0, false, &respmsg, sizeof(u8));
+	if (status)
+		dev_err(&hdev->pdev->dev,
+			"VF reset request to PF failed(=%d)\n", status);
+
+	return status;
+}
+
 static void hclgevf_reset_event(struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
@@ -910,6 +924,7 @@ static void hclgevf_reset_service_task(struct work_struct *work)
 {
 	struct hclgevf_dev *hdev =
 		container_of(work, struct hclgevf_dev, rst_service_task);
+	int ret;
 
 	if (test_and_set_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state))
 		return;
@@ -965,6 +980,10 @@ static void hclgevf_reset_service_task(struct work_struct *work)
 			hdev->reset_attempts++;
 
 			/* request PF for resetting this VF via mailbox */
+			ret = hclgevf_do_reset(hdev);
+			if (ret)
+				dev_warn(&hdev->pdev->dev,
+					 "VF rst fail, stack will call\n");
 		}
 	}
 
-- 
2.7.4
