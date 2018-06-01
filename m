Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeFAQyK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:54:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753273AbeFAQyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:54:06 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 05/11] net: hns3: Fix for service_task not running problem after resetting
Date: Fri, 1 Jun 2018 17:52:05 +0100
Message-ID: <20180601165211.46372-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180601165211.46372-1-salil.mehta@huawei.com>
References: <20180601165211.46372-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When hclge_ae_stop is called during resetting, it will cancel the
service_task by calling cancel_work_sync, which may cause the
service_task to exit without clearing HCLGE_STATE_SERVICE_SCHED
bit. If this happens, the service_task will never run again.

This patch fixes this problem by clearing it after calling
cancel_work_sync in hclge_ae_stop.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 18027bc..746987f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3748,6 +3748,7 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 
 	del_timer_sync(&hdev->service_timer);
 	cancel_work_sync(&hdev->service_task);
+	clear_bit(HCLGE_STATE_SERVICE_SCHED, &hdev->state);
 
 	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
 		return;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index e28e0db..5d28052 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1337,6 +1337,7 @@ static void hclgevf_ae_stop(struct hnae3_handle *handle)
 	hclgevf_reset_tqp_stats(handle);
 	del_timer_sync(&hdev->service_timer);
 	cancel_work_sync(&hdev->service_task);
+	clear_bit(HCLGEVF_STATE_SERVICE_SCHED, &hdev->state);
 	hclgevf_update_link_status(hdev, 0);
 }
 
-- 
2.7.4
