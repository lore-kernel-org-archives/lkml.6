Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE2521537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE2521537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeI0AoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:44:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbeI0AoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:44:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 39018E8D1A59A;
        Thu, 27 Sep 2018 02:29:59 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 27 Sep 2018 02:29:49 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 10/10] net: hns3: Fix loss of coal configuration while doing reset
Date:   Wed, 26 Sep 2018 19:28:40 +0100
Message-ID: <20180926182840.28392-11-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180926182840.28392-1-salil.mehta@huawei.com>
References: <20180926182840.28392-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

The user's coal configuration will be lost after reset, so the tx_coal
and rx_coal fields are added to the struct hns_nic_priv to save the coal
configuration and used to restore the user's configuration after the reset
is complete.

Fixes: bb6b94a896d4 ("net: hns3: Add reset interface implementation in client")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 71 ++++++++++++-------------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  2 +
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 8273c03..10506522 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -225,8 +225,6 @@ void hns3_set_vector_coalesce_tx_gl(struct hns3_enet_tqp_vector *tqp_vector,
 static void hns3_vector_gl_rl_init(struct hns3_enet_tqp_vector *tqp_vector,
 				   struct hns3_nic_priv *priv)
 {
-	struct hnae3_handle *h = priv->ae_handle;
-
 	/* initialize the configuration for interrupt coalescing.
 	 * 1. GL (Interrupt Gap Limiter)
 	 * 2. RL (Interrupt Rate Limiter)
@@ -239,9 +237,6 @@ static void hns3_vector_gl_rl_init(struct hns3_enet_tqp_vector *tqp_vector,
 	tqp_vector->tx_group.coal.int_gl = HNS3_INT_GL_50K;
 	tqp_vector->rx_group.coal.int_gl = HNS3_INT_GL_50K;
 
-	/* Default: disable RL */
-	h->kinfo.int_rl_setting = 0;
-
 	tqp_vector->int_adapt_down = HNS3_INT_ADAPT_DOWN_START;
 	tqp_vector->rx_group.coal.flow_level = HNS3_FLOW_LOW;
 	tqp_vector->tx_group.coal.flow_level = HNS3_FLOW_LOW;
@@ -3490,6 +3485,31 @@ int hns3_nic_reset_all_ring(struct hnae3_handle *h)
 	return 0;
 }
 
+static void hns3_store_coal(struct hns3_nic_priv *priv)
+{
+	/* ethtool only support setting and querying one coal
+	 * configuation for now, so save the vector 0' coal
+	 * configuation here in order to restore it.
+	 */
+	memcpy(&priv->tx_coal, &priv->tqp_vector[0].tx_group.coal,
+	       sizeof(struct hns3_enet_coalesce));
+	memcpy(&priv->rx_coal, &priv->tqp_vector[0].rx_group.coal,
+	       sizeof(struct hns3_enet_coalesce));
+}
+
+static void hns3_restore_coal(struct hns3_nic_priv *priv)
+{
+	u16 vector_num = priv->vector_num;
+	int i;
+
+	for (i = 0; i < vector_num; i++) {
+		memcpy(&priv->tqp_vector[i].tx_group.coal, &priv->tx_coal,
+		       sizeof(struct hns3_enet_coalesce));
+		memcpy(&priv->tqp_vector[i].rx_group.coal, &priv->rx_coal,
+		       sizeof(struct hns3_enet_coalesce));
+	}
+}
+
 static int hns3_reset_notify_down_enet(struct hnae3_handle *handle)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
@@ -3536,6 +3556,8 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 	/* Carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
 
+	hns3_restore_coal(priv);
+
 	ret = hns3_nic_init_vector_data(priv);
 	if (ret)
 		return ret;
@@ -3563,6 +3585,8 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 		return ret;
 	}
 
+	hns3_store_coal(priv);
+
 	ret = hns3_uninit_all_ring(priv);
 	if (ret)
 		netdev_err(netdev, "uninit ring error\n");
@@ -3597,24 +3621,7 @@ static int hns3_reset_notify(struct hnae3_handle *handle,
 	return ret;
 }
 
-static void hns3_restore_coal(struct hns3_nic_priv *priv,
-			      struct hns3_enet_coalesce *tx,
-			      struct hns3_enet_coalesce *rx)
-{
-	u16 vector_num = priv->vector_num;
-	int i;
-
-	for (i = 0; i < vector_num; i++) {
-		memcpy(&priv->tqp_vector[i].tx_group.coal, tx,
-		       sizeof(struct hns3_enet_coalesce));
-		memcpy(&priv->tqp_vector[i].rx_group.coal, rx,
-		       sizeof(struct hns3_enet_coalesce));
-	}
-}
-
-static int hns3_modify_tqp_num(struct net_device *netdev, u16 new_tqp_num,
-			       struct hns3_enet_coalesce *tx,
-			       struct hns3_enet_coalesce *rx)
+static int hns3_modify_tqp_num(struct net_device *netdev, u16 new_tqp_num)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = hns3_get_handle(netdev);
@@ -3632,7 +3639,7 @@ static int hns3_modify_tqp_num(struct net_device *netdev, u16 new_tqp_num,
 	if (ret)
 		goto err_alloc_vector;
 
-	hns3_restore_coal(priv, tx, rx);
+	hns3_restore_coal(priv);
 
 	ret = hns3_nic_init_vector_data(priv);
 	if (ret)
@@ -3664,7 +3671,6 @@ int hns3_set_channels(struct net_device *netdev,
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	struct hnae3_knic_private_info *kinfo = &h->kinfo;
-	struct hns3_enet_coalesce tx_coal, rx_coal;
 	bool if_running = netif_running(netdev);
 	u32 new_tqp_num = ch->combined_count;
 	u16 org_tqp_num;
@@ -3696,15 +3702,7 @@ int hns3_set_channels(struct net_device *netdev,
 		goto open_netdev;
 	}
 
-	/* Changing the tqp num may also change the vector num,
-	 * ethtool only support setting and querying one coal
-	 * configuation for now, so save the vector 0' coal
-	 * configuation here in order to restore it.
-	 */
-	memcpy(&tx_coal, &priv->tqp_vector[0].tx_group.coal,
-	       sizeof(struct hns3_enet_coalesce));
-	memcpy(&rx_coal, &priv->tqp_vector[0].rx_group.coal,
-	       sizeof(struct hns3_enet_coalesce));
+	hns3_store_coal(priv);
 
 	hns3_nic_dealloc_vector_data(priv);
 
@@ -3712,10 +3710,9 @@ int hns3_set_channels(struct net_device *netdev,
 	hns3_put_ring_config(priv);
 
 	org_tqp_num = h->kinfo.num_tqps;
-	ret = hns3_modify_tqp_num(netdev, new_tqp_num, &tx_coal, &rx_coal);
+	ret = hns3_modify_tqp_num(netdev, new_tqp_num);
 	if (ret) {
-		ret = hns3_modify_tqp_num(netdev, org_tqp_num,
-					  &tx_coal, &rx_coal);
+		ret = hns3_modify_tqp_num(netdev, org_tqp_num);
 		if (ret) {
 			/* If revert to old tqp failed, fatal error occurred */
 			dev_err(&netdev->dev,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 4a56c3d..27d704f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -543,6 +543,8 @@ struct hns3_nic_priv {
 	/* Vxlan/Geneve information */
 	struct hns3_udp_tunnel udp_tnl[HNS3_UDP_TNL_MAX];
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+	struct hns3_enet_coalesce tx_coal;
+	struct hns3_enet_coalesce rx_coal;
 };
 
 union l3_hdr_info {
-- 
2.7.4


