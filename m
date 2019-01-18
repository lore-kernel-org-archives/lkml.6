Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB2CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DE82086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfARINw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:13:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbfARINv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:51 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AB618D5D5EDDA5EDF4DE;
        Fri, 18 Jan 2019 16:13:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:41 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 01/12] net: hns3: modify enet reinitialization interface
Date:   Fri, 18 Jan 2019 16:13:03 +0800
Message-ID: <1547799194-38212-2-git-send-email-tanhuazhong@huawei.com>
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

hns3_reset_notify_init_enet and hns3_reset_notify_uninit_enet are the
reinitialization interface that will be called when the device reset,
the number of TC changed, or the queue length changed. So these two
function should call hns3_get_ring_config() and hns3_put_ring_config()
to allocate and free memory for the ring with the correct number.

Also this patch fixes a double free problem when
hns3_reset_notify_uninit_enet calling hns3_nic_dealloc_vector_data

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 1bf7a5f..e0621ef 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3185,6 +3185,9 @@ static int hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 	for (i = 0; i < priv->vector_num; i++) {
 		tqp_vector = &priv->tqp_vector[i];
 
+		if (!tqp_vector->rx_group.ring && !tqp_vector->tx_group.ring)
+			continue;
+
 		ret = hns3_get_vector_ring_chain(tqp_vector,
 						 &vector_ring_chain);
 		if (ret)
@@ -3238,6 +3241,7 @@ static int hns3_ring_get_cfg(struct hnae3_queue *q, struct hns3_nic_priv *priv,
 {
 	struct hns3_nic_ring_data *ring_data = priv->ring_data;
 	int queue_num = priv->ae_handle->kinfo.num_tqps;
+	int desc_num = priv->ae_handle->kinfo.num_desc;
 	struct pci_dev *pdev = priv->ae_handle->pdev;
 	struct hns3_enet_ring *ring;
 
@@ -3263,7 +3267,7 @@ static int hns3_ring_get_cfg(struct hnae3_queue *q, struct hns3_nic_priv *priv,
 	ring->dev = priv->dev;
 	ring->desc_dma_addr = 0;
 	ring->buf_size = q->buf_size;
-	ring->desc_num = q->desc_num;
+	ring->desc_num = desc_num;
 	ring->next_to_use = 0;
 	ring->next_to_clean = 0;
 
@@ -4045,10 +4049,14 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 	/* Carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
 
-	ret = hns3_nic_alloc_vector_data(priv);
+	ret = hns3_get_ring_config(priv);
 	if (ret)
 		return ret;
 
+	ret = hns3_nic_alloc_vector_data(priv);
+	if (ret)
+		goto err_put_ring;
+
 	hns3_restore_coal(priv);
 
 	ret = hns3_nic_init_vector_data(priv);
@@ -4068,6 +4076,9 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 	priv->ring_data = NULL;
 err_dealloc_vector:
 	hns3_nic_dealloc_vector_data(priv);
+err_put_ring:
+	hns3_put_ring_config(priv);
+	priv->ring_data = NULL;
 
 	return ret;
 }
@@ -4101,6 +4112,9 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 	if (ret)
 		netdev_err(netdev, "uninit ring error\n");
 
+	hns3_put_ring_config(priv);
+	priv->ring_data = NULL;
+
 	clear_bit(HNS3_NIC_STATE_INITED, &priv->state);
 
 	return ret;
-- 
2.7.4

