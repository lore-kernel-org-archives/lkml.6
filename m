Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbeEOSVd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:21:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59571 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752861AbeEOSVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:21:31 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 08/10] net: hns3: Fix for fiber link up problem
Date: Tue, 15 May 2018 19:20:12 +0100
Message-ID: <20180515182014.42196-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180515182014.42196-1-salil.mehta@huawei.com>
References: <20180515182014.42196-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When hclge_ae_start is called, hdev->hw.mac.link may be set
to one after up/down multi-times, which does not correspond to
the link state of netdev when the netdev is up.

This fixes it by setting hdev->hw.mac.link to zero when
hclge_ae_start is called.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d060903..75d9b8c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3756,6 +3756,7 @@ static int hclge_ae_start(struct hnae3_handle *handle)
 	hclge_cfg_mac_mode(hdev, true);
 	clear_bit(HCLGE_STATE_DOWN, &hdev->state);
 	mod_timer(&hdev->service_timer, jiffies + HZ);
+	hdev->hw.mac.link = 0;
 
 	/* reset tqp stats */
 	hclge_reset_tqp_stats(handle);
@@ -3792,7 +3793,6 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 
 	/* reset tqp stats */
 	hclge_reset_tqp_stats(handle);
-	hclge_update_link_status(hdev);
 }
 
 static int hclge_get_mac_vlan_cmd_status(struct hclge_vport *vport,
-- 
2.7.4
