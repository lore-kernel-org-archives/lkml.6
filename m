Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeCUHSS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:18:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751040AbeCUHSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:15 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 06/11] net: hns3: change GL update rate
Date: Wed, 21 Mar 2018 15:49:25 +0800
Message-ID: <1521618570-129694-7-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
References: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

The interrupt coalescing self-adaptive function updates the int_gl every
interrupt. The GL update rate is too faster to get a better new GL value.
This patch changes the GL update rate to every one hundred interrupts.
The GL update rate is defined by HNS3_INT_ADAPT_DOWN_START.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 8 ++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index f700ec1..e7cf7b4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -214,6 +214,7 @@ static void hns3_vector_gl_rl_init(struct hns3_enet_tqp_vector *tqp_vector,
 	/* Default: disable RL */
 	h->kinfo.int_rl_setting = 0;
 
+	tqp_vector->int_adapt_down = HNS3_INT_ADAPT_DOWN_START;
 	tqp_vector->rx_group.coal.flow_level = HNS3_FLOW_LOW;
 	tqp_vector->tx_group.coal.flow_level = HNS3_FLOW_LOW;
 }
@@ -2492,6 +2493,11 @@ static void hns3_update_new_int_gl(struct hns3_enet_tqp_vector *tqp_vector)
 	struct hns3_enet_ring_group *tx_group = &tqp_vector->tx_group;
 	bool rx_update, tx_update;
 
+	if (tqp_vector->int_adapt_down > 0) {
+		tqp_vector->int_adapt_down--;
+		return;
+	}
+
 	if (rx_group->coal.gl_adapt_enable) {
 		rx_update = hns3_get_new_int_gl(rx_group);
 		if (rx_update)
@@ -2505,6 +2511,8 @@ static void hns3_update_new_int_gl(struct hns3_enet_tqp_vector *tqp_vector)
 			hns3_set_vector_coalesce_tx_gl(tqp_vector,
 						       tx_group->coal.int_gl);
 	}
+
+	tqp_vector->int_adapt_down = HNS3_INT_ADAPT_DOWN_START;
 }
 
 static int hns3_nic_common_poll(struct napi_struct *napi, int budget)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index c313780..2fe870b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -462,6 +462,8 @@ enum hns3_link_mode_bits {
 #define HNS3_INT_RL_MAX			0x00EC
 #define HNS3_INT_RL_ENABLE_MASK		0x40
 
+#define HNS3_INT_ADAPT_DOWN_START	100
+
 struct hns3_enet_coalesce {
 	u16 int_gl;
 	u8 gl_adapt_enable;
-- 
2.9.3
