Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6ACC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F81206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfBWJX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbfBWJXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:16 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B7705E4704F2EE1001A1;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:22:58 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 01/12] net: hns3: add xps setting support for hns3 driver
Date:   Sat, 23 Feb 2019 17:22:08 +0800
Message-ID: <1550913739-13232-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
References: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch adds xps setting support for hns3 driver based on
the interrupt affinity info.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 40b1722..d75977c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -378,6 +378,29 @@ static int hns3_nic_net_up(struct net_device *netdev)
 	return ret;
 }
 
+static void hns3_config_xps(struct hns3_nic_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->vector_num; i++) {
+		struct hns3_enet_tqp_vector *tqp_vector = &priv->tqp_vector[i];
+		struct hns3_enet_ring *ring = tqp_vector->tx_group.ring;
+
+		while (ring) {
+			int ret;
+
+			ret = netif_set_xps_queue(priv->netdev,
+						  &tqp_vector->affinity_mask,
+						  ring->tqp->tqp_index);
+			if (ret)
+				netdev_warn(priv->netdev,
+					    "set xps queue failed: %d", ret);
+
+			ring = ring->next;
+		}
+	}
+}
+
 static int hns3_nic_net_open(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
@@ -410,6 +433,7 @@ static int hns3_nic_net_open(struct net_device *netdev)
 	if (h->ae_algo->ops->set_timer_task)
 		h->ae_algo->ops->set_timer_task(priv->ae_handle, true);
 
+	hns3_config_xps(priv);
 	return 0;
 }
 
-- 
2.7.4

