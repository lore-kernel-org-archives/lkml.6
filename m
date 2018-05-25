Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967883AbeEYSos (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:44:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60871 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S967830AbeEYSop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:44:45 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: Add support to enable TX/RX promisc mode for H/W rev(0x21)
Date: Fri, 25 May 2018 19:42:59 +0100
Message-ID: <20180525184307.36288-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180525184307.36288-1-salil.mehta@huawei.com>
References: <20180525184307.36288-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

HCLGE_PROMISC_TX_EN_B and HCLGE_PROMISC_RX_EN_B are not supported
on pdev revision(0x20), new revision(0x21) supports them.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 3fa08f7..e9be6aa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -484,6 +484,8 @@ struct hclge_promisc_param {
 	u8 enable;
 };
 
+#define HCLGE_PROMISC_TX_EN_B	BIT(4)
+#define HCLGE_PROMISC_RX_EN_B	BIT(5)
 #define HCLGE_PROMISC_EN_B	1
 #define HCLGE_PROMISC_EN_ALL	0x7
 #define HCLGE_PROMISC_EN_UC	0x1
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c0b8d5a..8ad8f62 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3586,7 +3586,14 @@ int hclge_cmd_set_promisc_mode(struct hclge_dev *hdev,
 
 	req = (struct hclge_promisc_cfg_cmd *)desc.data;
 	req->vf_id = param->vf_id;
-	req->flag = (param->enable << HCLGE_PROMISC_EN_B);
+
+	/* HCLGE_PROMISC_TX_EN_B and HCLGE_PROMISC_RX_EN_B are not supported on
+	 * pdev revision(0x20), new revision support them. The
+	 * value of this two fields will not return error when driver
+	 * send command to fireware in revision(0x20).
+	 */
+	req->flag = (param->enable << HCLGE_PROMISC_EN_B) |
+		HCLGE_PROMISC_TX_EN_B | HCLGE_PROMISC_RX_EN_B;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret) {
-- 
2.7.4
