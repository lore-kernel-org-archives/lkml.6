Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932930AbeCJDAt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 22:00:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751392AbeCJC5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:57:36 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 02/12] net: hns3: fix for netdev not running problem after calling net_stop and net_open
Date: Sat, 10 Mar 2018 11:29:23 +0800
Message-ID: <1520652573-75644-3-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
References: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

The link status update function is called by timer every second. But
net_stop and net_open may be called with very short intervals. The link
status update function can not detect the link state has changed. It
causes the netdev not running problem.

This patch fixes it by updating the link state in ae_stop function.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 3 +++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 632672c..cc60407 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3756,6 +3756,9 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 
 	/* reset tqp stats */
 	hclge_reset_tqp_stats(handle);
+	del_timer_sync(&hdev->service_timer);
+	cancel_work_sync(&hdev->service_task);
+	hclge_update_link_status(hdev);
 }
 
 static int hclge_get_mac_vlan_cmd_status(struct hclge_vport *vport,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index ba3fed1..c80a604 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1066,6 +1066,9 @@ static void hclgevf_ae_stop(struct hnae3_handle *handle)
 
 	/* reset tqp stats */
 	hclgevf_reset_tqp_stats(handle);
+	del_timer_sync(&hdev->service_timer);
+	cancel_work_sync(&hdev->service_task);
+	hclgevf_update_link_status(hdev, 0);
 }
 
 static void hclgevf_state_init(struct hclgevf_dev *hdev)
-- 
2.9.3
