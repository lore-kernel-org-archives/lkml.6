Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935142AbeCHCk7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:40:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5749 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934785AbeCHCfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:35:00 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 05/23] {topost} net: hns3: fix for netdev not running problem after calling net_stop and net_open
Date: Thu, 8 Mar 2018 11:06:30 +0800
Message-ID: <1520478408-116992-6-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
References: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
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
index 0b74461..83be4d5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3770,6 +3770,9 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 
 	/* reset tqp stats */
 	hclge_reset_tqp_stats(handle);
+	del_timer_sync(&hdev->service_timer);
+	cancel_work_sync(&hdev->service_task);
+	hclge_update_link_status(hdev);
 }
 
 static int hclge_get_mac_vlan_cmd_status(struct hclge_vport *vport,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index ccb6756..eee5e20 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1061,6 +1061,9 @@ static void hclgevf_ae_stop(struct hnae3_handle *handle)
 
 	/* reset tqp stats */
 	hclgevf_reset_tqp_stats(handle);
+	del_timer_sync(&hdev->service_timer);
+	cancel_work_sync(&hdev->service_task);
+	hclgevf_update_link_status(hdev, 0);
 }
 
 static void hclgevf_state_init(struct hclgevf_dev *hdev)
-- 
2.9.3
