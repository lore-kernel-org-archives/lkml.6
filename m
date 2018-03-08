Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964927AbeCHCkD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:40:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934770AbeCHCfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:35:00 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 14/23] {topost} net: hns3: fix for use-after-free when setting ring parameter
Date: Thu, 8 Mar 2018 11:06:39 +0800
Message-ID: <1520478408-116992-15-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
References: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

In hns3_set_ringparam, hns3_uninit_all_ring frees the
memory pointed by priv->ring_data[i].ring, and
hns3_change_all_ring_bd_num use that pointer without mallocing,
which will cause a use-after-free problem.

The patch fixes it by not freeing the memory in
hns3_uninit_all_ring, and uses hns3_put_ring_config to free it
when necessary.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index f50245d..2bed73e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2955,13 +2955,8 @@ int hns3_uninit_all_ring(struct hns3_nic_priv *priv)
 			h->ae_algo->ops->reset_queue(h, i);
 
 		hns3_fini_ring(priv->ring_data[i].ring);
-		devm_kfree(priv->dev, priv->ring_data[i].ring);
 		hns3_fini_ring(priv->ring_data[i + h->kinfo.num_tqps].ring);
-		devm_kfree(priv->dev,
-			   priv->ring_data[i + h->kinfo.num_tqps].ring);
 	}
-	devm_kfree(priv->dev, priv->ring_data);
-
 	return 0;
 }
 
@@ -3099,6 +3094,8 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 	if (ret)
 		netdev_err(netdev, "uninit ring error\n");
 
+	hns3_put_ring_config(priv);
+
 	priv->ring_data = NULL;
 
 	free_netdev(netdev);
@@ -3304,6 +3301,8 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 	if (ret)
 		netdev_err(netdev, "uninit ring error\n");
 
+	hns3_put_ring_config(priv);
+
 	priv->ring_data = NULL;
 
 	return ret;
@@ -3421,6 +3420,7 @@ int hns3_set_channels(struct net_device *netdev,
 	}
 
 	hns3_uninit_all_ring(priv);
+	hns3_put_ring_config(priv);
 
 	org_tqp_num = h->kinfo.num_tqps;
 	ret = hns3_modify_tqp_num(netdev, new_tqp_num);
-- 
2.9.3
