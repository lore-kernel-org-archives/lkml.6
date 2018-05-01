Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756443AbeEAS6D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:58:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754790AbeEAS6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:58:00 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 3/9] net: hns3: Fixes the out of bounds access in hclge_map_tqp
Date: Tue, 1 May 2018 19:55:59 +0100
Message-ID: <20180501185605.9584-4-salil.mehta@huawei.com>
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

From: Huazhong Tan <tanhuazhong@huawei.com>

This patch fixes the handling of the check when number of vports
are detected to be more than available TPQs. Current handling causes
an out of bounds access in hclge_map_tqp().

Fixes: 7df7dad633e2 ("net: hns3: Refactor the mapping of tqp to vport")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2066dd7..c9e80ca 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1459,8 +1459,11 @@ static int hclge_alloc_vport(struct hclge_dev *hdev)
 	/* We need to alloc a vport for main NIC of PF */
 	num_vport = hdev->num_vmdq_vport + hdev->num_req_vfs + 1;
 
-	if (hdev->num_tqps < num_vport)
-		num_vport = hdev->num_tqps;
+	if (hdev->num_tqps < num_vport) {
+		dev_err(&hdev->pdev->dev, "tqps(%d) is less than vports(%d)",
+			hdev->num_tqps, num_vport);
+		return -EINVAL;
+	}
 
 	/* Alloc the same number of TQPs for every vport */
 	tqp_per_vport = hdev->num_tqps / num_vport;
-- 
2.7.4
