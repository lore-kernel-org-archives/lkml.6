Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756119AbeEAS55 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:57:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753505AbeEAS5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:57:55 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 1/9] net: hns3: Remove error log when getting pfc stats fails
Date: Tue, 1 May 2018 19:55:57 +0100
Message-ID: <20180501185605.9584-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180501185605.9584-1-salil.mehta@huawei.com>
References: <20180501185605.9584-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When mac supports DCB, but is in GE mode, it does not support
querying pfc stats, firmware returns error when trying to
query the pfc stats. this creates a lot of noise in the kernel
log when it prints the error log.

This patch fixes it by removing the error log, because it already
return the error to the user space, so the user should be aware of
the error.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 885f25c..c69ecab 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -134,11 +134,8 @@ static int hclge_pfc_stats_get(struct hclge_dev *hdev,
 	}
 
 	ret = hclge_cmd_send(&hdev->hw, desc, HCLGE_TM_PFC_PKT_GET_CMD_NUM);
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"Get pfc pause stats fail, ret = %d.\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	for (i = 0; i < HCLGE_TM_PFC_PKT_GET_CMD_NUM; i++) {
 		struct hclge_pfc_stats_cmd *pfc_stats =
-- 
2.7.4
