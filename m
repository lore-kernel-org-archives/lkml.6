Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeCXDBx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 23:01:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752113AbeCXDBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 23:01:15 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 5/5] net: hns3: never send command queue message to IMP when reset
Date: Sat, 24 Mar 2018 11:32:47 +0800
Message-ID: <1521862367-111399-6-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521862367-111399-1-git-send-email-lipeng321@huawei.com>
References: <1521862367-111399-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMP will not handle and command queue message any more when it is
in core/global, driver should not send command queue message to
IMP until reinitialize the NIC HW.

This patch checks the status and avoid the message sent to IMP when
reset.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 23 +++++++++++++++++-----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  6 ++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ce093c3..2066dd7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3584,6 +3584,9 @@ static int hclge_unmap_ring_frm_vector(struct hnae3_handle *handle,
 	struct hclge_dev *hdev = vport->back;
 	int vector_id, ret;
 
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		return 0;
+
 	vector_id = hclge_get_vector_index(hdev, vector);
 	if (vector_id < 0) {
 		dev_err(&handle->pdev->dev,
@@ -3781,13 +3784,16 @@ static int hclge_ae_start(struct hnae3_handle *handle)
 	clear_bit(HCLGE_STATE_DOWN, &hdev->state);
 	mod_timer(&hdev->service_timer, jiffies + HZ);
 
+	/* reset tqp stats */
+	hclge_reset_tqp_stats(handle);
+
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		return 0;
+
 	ret = hclge_mac_start_phy(hdev);
 	if (ret)
 		return ret;
 
-	/* reset tqp stats */
-	hclge_reset_tqp_stats(handle);
-
 	return 0;
 }
 
@@ -3797,6 +3803,12 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 	struct hclge_dev *hdev = vport->back;
 	int i;
 
+	del_timer_sync(&hdev->service_timer);
+	cancel_work_sync(&hdev->service_task);
+
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		return;
+
 	for (i = 0; i < vport->alloc_tqps; i++)
 		hclge_tqp_enable(hdev, i, 0, false);
 
@@ -3807,8 +3819,6 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 
 	/* reset tqp stats */
 	hclge_reset_tqp_stats(handle);
-	del_timer_sync(&hdev->service_timer);
-	cancel_work_sync(&hdev->service_task);
 	hclge_update_link_status(hdev);
 }
 
@@ -4940,6 +4950,9 @@ void hclge_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 	u16 queue_gid;
 	int ret;
 
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		return;
+
 	queue_gid = hclge_covert_handle_qid_global(handle, queue_id);
 
 	ret = hclge_tqp_enable(hdev, queue_id, 0, false);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index c1dea3a..682c2d6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -60,6 +60,9 @@ static int hclge_mdio_write(struct mii_bus *bus, int phyid, int regnum,
 	struct hclge_desc desc;
 	int ret;
 
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		return 0;
+
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MDIO_CONFIG, false);
 
 	mdio_cmd = (struct hclge_mdio_cfg_cmd *)desc.data;
@@ -95,6 +98,9 @@ static int hclge_mdio_read(struct mii_bus *bus, int phyid, int regnum)
 	struct hclge_desc desc;
 	int ret;
 
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		return 0;
+
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MDIO_CONFIG, true);
 
 	mdio_cmd = (struct hclge_mdio_cfg_cmd *)desc.data;
-- 
2.9.3
