Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeCICHR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:07:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38061 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750996AbeCICFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:05:04 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 5/9] net: hns3: fix for use-after-free when setting ring parameter
Date: Fri, 9 Mar 2018 10:37:00 +0800
Message-ID: <1520563024-94811-6-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
References: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
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
index c936945..e0ab161 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2967,13 +2967,8 @@ int hns3_uninit_all_ring(struct hns3_nic_priv *priv)
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
 
@@ -3111,6 +3106,8 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 	if (ret)
 		netdev_err(netdev, "uninit ring error\n");
 
+	hns3_put_ring_config(priv);
+
 	priv->ring_data = NULL;
 
 	free_netdev(netdev);
@@ -3316,6 +3313,8 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 	if (ret)
 		netdev_err(netdev, "uninit ring error\n");
 
+	hns3_put_ring_config(priv);
+
 	priv->ring_data = NULL;
 
 	return ret;
@@ -3422,6 +3421,7 @@ int hns3_set_channels(struct net_device *netdev,
 	}
 
 	hns3_uninit_all_ring(priv);
+	hns3_put_ring_config(priv);
 
 	org_tqp_num = h->kinfo.num_tqps;
 	ret = hns3_modify_tqp_num(netdev, new_tqp_num);
-- 
2.9.3
