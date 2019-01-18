Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2385C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94442086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfARIOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:14:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2265 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727545AbfARINx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:53 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B41D31A1BC471F3D7F40;
        Fri, 18 Jan 2019 16:13:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:42 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: reuse reinitialization interface in the hns3_set_channels
Date:   Fri, 18 Jan 2019 16:13:06 +0800
Message-ID: <1547799194-38212-5-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
References: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already common interface for network device reinitialization,
so hns3_set_channels() should just call them.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 75 ++++---------------------
 1 file changed, 12 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index c88714c..0cd70d7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4144,52 +4144,11 @@ static int hns3_reset_notify(struct hnae3_handle *handle,
 	return ret;
 }
 
-static int hns3_modify_tqp_num(struct net_device *netdev, u16 new_tqp_num)
-{
-	struct hns3_nic_priv *priv = netdev_priv(netdev);
-	struct hnae3_handle *h = hns3_get_handle(netdev);
-	int ret;
-
-	ret = h->ae_algo->ops->set_channels(h, new_tqp_num);
-	if (ret)
-		return ret;
-
-	ret = hns3_get_ring_config(priv);
-	if (ret)
-		return ret;
-
-	ret = hns3_nic_alloc_vector_data(priv);
-	if (ret)
-		goto err_alloc_vector;
-
-	hns3_restore_coal(priv);
-
-	ret = hns3_nic_init_vector_data(priv);
-	if (ret)
-		goto err_uninit_vector;
-
-	ret = hns3_init_all_ring(priv);
-	if (ret)
-		goto err_put_ring;
-
-	return 0;
-
-err_put_ring:
-	hns3_put_ring_config(priv);
-err_uninit_vector:
-	hns3_nic_uninit_vector_data(priv);
-err_alloc_vector:
-	hns3_nic_dealloc_vector_data(priv);
-	return ret;
-}
-
 int hns3_set_channels(struct net_device *netdev,
 		      struct ethtool_channels *ch)
 {
-	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	struct hnae3_knic_private_info *kinfo = &h->kinfo;
-	bool if_running = netif_running(netdev);
 	u32 new_tqp_num = ch->combined_count;
 	u16 org_tqp_num;
 	int ret;
@@ -4209,27 +4168,18 @@ int hns3_set_channels(struct net_device *netdev,
 	if (kinfo->num_tqps == new_tqp_num)
 		return 0;
 
-	if (if_running)
-		hns3_nic_net_stop(netdev);
-
-	ret = hns3_nic_uninit_vector_data(priv);
-	if (ret) {
-		dev_err(&netdev->dev,
-			"Unbind vector with tqp fail, nothing is changed");
-		goto open_netdev;
-	}
-
-	hns3_store_coal(priv);
-
-	hns3_nic_dealloc_vector_data(priv);
+	ret = hns3_reset_notify(h, HNAE3_DOWN_CLIENT);
+	if (ret)
+		return ret;
 
-	hns3_uninit_all_ring(priv);
-	hns3_put_ring_config(priv);
+	ret = hns3_reset_notify(h, HNAE3_UNINIT_CLIENT);
+	if (ret)
+		return ret;
 
 	org_tqp_num = h->kinfo.num_tqps;
-	ret = hns3_modify_tqp_num(netdev, new_tqp_num);
+	ret = h->ae_algo->ops->set_channels(h, new_tqp_num);
 	if (ret) {
-		ret = hns3_modify_tqp_num(netdev, org_tqp_num);
+		ret = h->ae_algo->ops->set_channels(h, org_tqp_num);
 		if (ret) {
 			/* If revert to old tqp failed, fatal error occurred */
 			dev_err(&netdev->dev,
@@ -4239,12 +4189,11 @@ int hns3_set_channels(struct net_device *netdev,
 		dev_info(&netdev->dev,
 			 "Change tqp num fail, Revert to old tqp num");
 	}
+	ret = hns3_reset_notify(h, HNAE3_INIT_CLIENT);
+	if (ret)
+		return ret;
 
-open_netdev:
-	if (if_running)
-		hns3_nic_net_open(netdev);
-
-	return ret;
+	return hns3_reset_notify(h, HNAE3_UP_CLIENT);
 }
 
 static const struct hnae3_client_ops client_ops = {
-- 
2.7.4

