Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeFAQ5s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:57:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40993 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753197AbeFAQxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:53:55 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 07/11] net: hns3: Fix for phy not link up problem after resetting
Date: Fri, 1 Jun 2018 17:52:07 +0100
Message-ID: <20180601165211.46372-8-salil.mehta@huawei.com>
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

When resetting, phy_state_machine may be accessing the phy through
firmware if the phy is not stopped or disconnected, which will
cause firemware timeout problem because the firmware is busy
processing the reset request.

This patch fixes it by disabling the phy when resetting.

Fixes: b940aeae0ed6 ("net: hns3: never send command queue message to IMP when reset")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index fb44b1e..58fef5e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3761,9 +3761,6 @@ static int hclge_ae_start(struct hnae3_handle *handle)
 	/* reset tqp stats */
 	hclge_reset_tqp_stats(handle);
 
-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
-		return 0;
-
 	ret = hclge_mac_start_phy(hdev);
 	if (ret)
 		return ret;
@@ -3781,8 +3778,10 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 	cancel_work_sync(&hdev->service_task);
 	clear_bit(HCLGE_STATE_SERVICE_SCHED, &hdev->state);
 
-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state)) {
+		hclge_mac_stop_phy(hdev);
 		return;
+	}
 
 	for (i = 0; i < vport->alloc_tqps; i++)
 		hclge_tqp_enable(hdev, i, 0, false);
-- 
2.7.4
