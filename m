Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43C72184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbfA3U5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:57:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387877AbfA3U41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0D9119B60E62D0E57A37;
        Thu, 31 Jan 2019 04:56:25 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.134.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 04:56:15 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 07/12] net: hns3: fix netif_napi_del() not do problem when unloading
Date:   Thu, 31 Jan 2019 04:55:47 +0800
Message-ID: <20190130205552.8512-8-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190130205552.8512-1-tanhuazhong@huawei.com>
References: <20190130205552.8512-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.134.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver is unloading, if a global reset occurs,
unmap_ring_from_vector() in the hns3_nic_uninit_vector_data() will
fail, and hns3_nic_uninit_vector_data() just return. There may be
some netif_napi_del() not be done.

Since hardware will unmap all ring while resetting, so
hns3_nic_uninit_vector_data() should ignore this error, and do the
rest uninitialization.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 27 +++++--------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index ac9b0aa258ec..c546b874d659 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3183,12 +3183,12 @@ static void hns3_clear_ring_group(struct hns3_enet_ring_group *group)
 	group->count = 0;
 }
 
-static int hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
+static void hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 {
 	struct hnae3_ring_chain_node vector_ring_chain;
 	struct hnae3_handle *h = priv->ae_handle;
 	struct hns3_enet_tqp_vector *tqp_vector;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < priv->vector_num; i++) {
 		tqp_vector = &priv->tqp_vector[i];
@@ -3196,15 +3196,10 @@ static int hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 		if (!tqp_vector->rx_group.ring && !tqp_vector->tx_group.ring)
 			continue;
 
-		ret = hns3_get_vector_ring_chain(tqp_vector,
-						 &vector_ring_chain);
-		if (ret)
-			return ret;
+		hns3_get_vector_ring_chain(tqp_vector, &vector_ring_chain);
 
-		ret = h->ae_algo->ops->unmap_ring_from_vector(h,
+		h->ae_algo->ops->unmap_ring_from_vector(h,
 			tqp_vector->vector_irq, &vector_ring_chain);
-		if (ret)
-			return ret;
 
 		hns3_free_vector_ring_chain(tqp_vector, &vector_ring_chain);
 
@@ -3220,8 +3215,6 @@ static int hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 		hns3_clear_ring_group(&tqp_vector->tx_group);
 		netif_napi_del(&priv->tqp_vector[i].napi);
 	}
-
-	return 0;
 }
 
 static int hns3_nic_dealloc_vector_data(struct hns3_nic_priv *priv)
@@ -3691,7 +3684,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 out_init_phy:
 	hns3_uninit_all_ring(priv);
 out_init_ring_data:
-	(void)hns3_nic_uninit_vector_data(priv);
+	hns3_nic_uninit_vector_data(priv);
 out_init_vector_data:
 	hns3_nic_dealloc_vector_data(priv);
 out_alloc_vector_data:
@@ -3726,9 +3719,7 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	hns3_uninit_phy(netdev);
 
-	ret = hns3_nic_uninit_vector_data(priv);
-	if (ret)
-		netdev_err(netdev, "uninit vector error\n");
+	hns3_nic_uninit_vector_data(priv);
 
 	ret = hns3_nic_dealloc_vector_data(priv);
 	if (ret)
@@ -4121,11 +4112,7 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 
 	hns3_force_clear_all_rx_ring(handle);
 
-	ret = hns3_nic_uninit_vector_data(priv);
-	if (ret) {
-		netdev_err(netdev, "uninit vector error\n");
-		return ret;
-	}
+	hns3_nic_uninit_vector_data(priv);
 
 	hns3_store_coal(priv);
 
-- 
2.20.1


