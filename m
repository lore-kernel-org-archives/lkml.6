Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeESPzh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:55:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752623AbeESPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:54:58 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 7/9] net: hns3: Fix for netdev not running problem after calling net_stop and net_open
Date: Sat, 19 May 2018 16:53:21 +0100
Message-ID: <20180519155323.68960-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180519155323.68960-1-salil.mehta@huawei.com>
References: <20180519155323.68960-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
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

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 46e030c..2f0bbb6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3793,6 +3793,9 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 
 	/* reset tqp stats */
 	hclge_reset_tqp_stats(handle);
+	del_timer_sync(&hdev->service_timer);
+	cancel_work_sync(&hdev->service_task);
+	hclge_update_link_status(hdev);
 }
 
 static int hclge_get_mac_vlan_cmd_status(struct hclge_vport *vport,
-- 
2.7.4
