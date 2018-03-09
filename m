Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeCICGY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:06:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38064 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751045AbeCICFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:05:04 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 7/9] net: hns3: fix for coalesce configuration lost during reset
Date: Fri, 9 Mar 2018 10:37:02 +0800
Message-ID: <1520563024-94811-8-git-send-email-lipeng321@huawei.com>
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

Coalesce configuration will be set to default value by
hns3_nic_init_vector_data during reset, which causes the
coalesce configuration loss problem.

This patch fixes it by setting the default value in
hns3_nic_alloc_vector_data, which will not be called in the
reset process.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 156 +++++++++++++++++-------
 1 file changed, 114 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index bbaa21f..07dbebb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -211,19 +211,25 @@ static void hns3_vector_gl_rl_init(struct hns3_enet_tqp_vector *tqp_vector,
 	tqp_vector->tx_group.int_gl = HNS3_INT_GL_50K;
 	tqp_vector->rx_group.int_gl = HNS3_INT_GL_50K;
 
-	hns3_set_vector_coalesce_tx_gl(tqp_vector,
-				       tqp_vector->tx_group.int_gl);
-	hns3_set_vector_coalesce_rx_gl(tqp_vector,
-				       tqp_vector->rx_group.int_gl);
-
 	/* Default: disable RL */
 	h->kinfo.int_rl_setting = 0;
-	hns3_set_vector_coalesce_rl(tqp_vector, h->kinfo.int_rl_setting);
 
 	tqp_vector->rx_group.flow_level = HNS3_FLOW_LOW;
 	tqp_vector->tx_group.flow_level = HNS3_FLOW_LOW;
 }
 
+static void hns3_vector_gl_rl_init_hw(struct hns3_enet_tqp_vector *tqp_vector,
+				      struct hns3_nic_priv *priv)
+{
+	struct hnae3_handle *h = priv->ae_handle;
+
+	hns3_set_vector_coalesce_tx_gl(tqp_vector,
+				       tqp_vector->tx_group.int_gl);
+	hns3_set_vector_coalesce_rx_gl(tqp_vector,
+				       tqp_vector->rx_group.int_gl);
+	hns3_set_vector_coalesce_rl(tqp_vector, h->kinfo.int_rl_setting);
+}
+
 static int hns3_nic_set_real_num_queue(struct net_device *netdev)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
@@ -2625,32 +2631,18 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 	struct hnae3_ring_chain_node vector_ring_chain;
 	struct hnae3_handle *h = priv->ae_handle;
 	struct hns3_enet_tqp_vector *tqp_vector;
-	struct hnae3_vector_info *vector;
-	struct pci_dev *pdev = h->pdev;
-	u16 tqp_num = h->kinfo.num_tqps;
-	u16 vector_num;
 	int ret = 0;
 	u16 i;
 
-	/* RSS size, cpu online and vector_num should be the same */
-	/* Should consider 2p/4p later */
-	vector_num = min_t(u16, num_online_cpus(), tqp_num);
-	vector = devm_kcalloc(&pdev->dev, vector_num, sizeof(*vector),
-			      GFP_KERNEL);
-	if (!vector)
-		return -ENOMEM;
-
-	vector_num = h->ae_algo->ops->get_vector(h, vector_num, vector);
-
-	priv->vector_num = vector_num;
-	priv->tqp_vector = (struct hns3_enet_tqp_vector *)
-		devm_kcalloc(&pdev->dev, vector_num, sizeof(*priv->tqp_vector),
-			     GFP_KERNEL);
-	if (!priv->tqp_vector)
-		return -ENOMEM;
+	for (i = 0; i < priv->vector_num; i++) {
+		tqp_vector = &priv->tqp_vector[i];
+		hns3_vector_gl_rl_init_hw(tqp_vector, priv);
+		tqp_vector->num_tqps = 0;
+	}
 
-	for (i = 0; i < tqp_num; i++) {
-		u16 vector_i = i % vector_num;
+	for (i = 0; i < h->kinfo.num_tqps; i++) {
+		u16 vector_i = i % priv->vector_num;
+		u16 tqp_num = h->kinfo.num_tqps;
 
 		tqp_vector = &priv->tqp_vector[vector_i];
 
@@ -2660,52 +2652,94 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 		hns3_add_ring_to_group(&tqp_vector->rx_group,
 				       priv->ring_data[i + tqp_num].ring);
 
-		tqp_vector->idx = vector_i;
-		tqp_vector->mask_addr = vector[vector_i].io_addr;
-		tqp_vector->vector_irq = vector[vector_i].vector;
-		tqp_vector->num_tqps++;
-
 		priv->ring_data[i].ring->tqp_vector = tqp_vector;
 		priv->ring_data[i + tqp_num].ring->tqp_vector = tqp_vector;
+		tqp_vector->num_tqps++;
 	}
 
-	for (i = 0; i < vector_num; i++) {
+	for (i = 0; i < priv->vector_num; i++) {
 		tqp_vector = &priv->tqp_vector[i];
 
 		tqp_vector->rx_group.total_bytes = 0;
 		tqp_vector->rx_group.total_packets = 0;
 		tqp_vector->tx_group.total_bytes = 0;
 		tqp_vector->tx_group.total_packets = 0;
-		hns3_vector_gl_rl_init(tqp_vector, priv);
 		tqp_vector->handle = h;
 
 		ret = hns3_get_vector_ring_chain(tqp_vector,
 						 &vector_ring_chain);
 		if (ret)
-			goto out;
+			return ret;
 
 		ret = h->ae_algo->ops->map_ring_to_vector(h,
 			tqp_vector->vector_irq, &vector_ring_chain);
-		if (ret)
-			goto out;
 
 		hns3_free_vector_ring_chain(tqp_vector, &vector_ring_chain);
 
+		if (ret)
+			return ret;
+
 		netif_napi_add(priv->netdev, &tqp_vector->napi,
 			       hns3_nic_common_poll, NAPI_POLL_WEIGHT);
 	}
 
+	return 0;
+}
+
+static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
+{
+	struct hnae3_handle *h = priv->ae_handle;
+	struct hns3_enet_tqp_vector *tqp_vector;
+	struct hnae3_vector_info *vector;
+	struct pci_dev *pdev = h->pdev;
+	u16 tqp_num = h->kinfo.num_tqps;
+	u16 vector_num;
+	int ret = 0;
+	u16 i;
+
+	/* RSS size, cpu online and vector_num should be the same */
+	/* Should consider 2p/4p later */
+	vector_num = min_t(u16, num_online_cpus(), tqp_num);
+	vector = devm_kcalloc(&pdev->dev, vector_num, sizeof(*vector),
+			      GFP_KERNEL);
+	if (!vector)
+		return -ENOMEM;
+
+	vector_num = h->ae_algo->ops->get_vector(h, vector_num, vector);
+
+	priv->vector_num = vector_num;
+	priv->tqp_vector = (struct hns3_enet_tqp_vector *)
+		devm_kcalloc(&pdev->dev, vector_num, sizeof(*priv->tqp_vector),
+			     GFP_KERNEL);
+	if (!priv->tqp_vector) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < priv->vector_num; i++) {
+		tqp_vector = &priv->tqp_vector[i];
+		tqp_vector->idx = i;
+		tqp_vector->mask_addr = vector[i].io_addr;
+		tqp_vector->vector_irq = vector[i].vector;
+		hns3_vector_gl_rl_init(tqp_vector, priv);
+	}
+
 out:
 	devm_kfree(&pdev->dev, vector);
 	return ret;
 }
 
+static void hns3_clear_ring_group(struct hns3_enet_ring_group *group)
+{
+	group->ring = NULL;
+	group->count = 0;
+}
+
 static int hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 {
 	struct hnae3_ring_chain_node vector_ring_chain;
 	struct hnae3_handle *h = priv->ae_handle;
 	struct hns3_enet_tqp_vector *tqp_vector;
-	struct pci_dev *pdev = h->pdev;
 	int i, ret;
 
 	for (i = 0; i < priv->vector_num; i++) {
@@ -2736,12 +2770,30 @@ static int hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 		}
 
 		priv->ring_data[i].ring->irq_init_flag = HNS3_VECTOR_NOT_INITED;
-
+		hns3_clear_ring_group(&tqp_vector->rx_group);
+		hns3_clear_ring_group(&tqp_vector->tx_group);
 		netif_napi_del(&priv->tqp_vector[i].napi);
 	}
 
-	devm_kfree(&pdev->dev, priv->tqp_vector);
+	return 0;
+}
+
+static int hns3_nic_dealloc_vector_data(struct hns3_nic_priv *priv)
+{
+	struct hnae3_handle *h = priv->ae_handle;
+	struct pci_dev *pdev = h->pdev;
+	int i, ret;
+
+	for (i = 0; i < priv->vector_num; i++) {
+		struct hns3_enet_tqp_vector *tqp_vector;
+
+		tqp_vector = &priv->tqp_vector[i];
+		ret = h->ae_algo->ops->put_vector(h, tqp_vector->vector_irq);
+		if (ret)
+			return ret;
+	}
 
+	devm_kfree(&pdev->dev, priv->tqp_vector);
 	return 0;
 }
 
@@ -3057,6 +3109,12 @@ static int hns3_client_init(struct hnae3_handle *handle)
 		goto out_get_ring_cfg;
 	}
 
+	ret = hns3_nic_alloc_vector_data(priv);
+	if (ret) {
+		ret = -ENOMEM;
+		goto out_alloc_vector_data;
+	}
+
 	ret = hns3_nic_init_vector_data(priv);
 	if (ret) {
 		ret = -ENOMEM;
@@ -3085,8 +3143,10 @@ static int hns3_client_init(struct hnae3_handle *handle)
 out_reg_netdev_fail:
 out_init_ring_data:
 	(void)hns3_nic_uninit_vector_data(priv);
-	priv->ring_data = NULL;
 out_init_vector_data:
+	hns3_nic_dealloc_vector_data(priv);
+out_alloc_vector_data:
+	priv->ring_data = NULL;
 out_get_ring_cfg:
 	priv->ae_handle = NULL;
 	free_netdev(netdev);
@@ -3106,6 +3166,10 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 	if (ret)
 		netdev_err(netdev, "uninit vector error\n");
 
+	ret = hns3_nic_dealloc_vector_data(priv);
+	if (ret)
+		netdev_err(netdev, "dealloc vector error\n");
+
 	ret = hns3_uninit_all_ring(priv);
 	if (ret)
 		netdev_err(netdev, "uninit ring error\n");
@@ -3363,6 +3427,10 @@ static int hns3_modify_tqp_num(struct net_device *netdev, u16 new_tqp_num)
 	if (ret)
 		return ret;
 
+	ret = hns3_nic_alloc_vector_data(priv);
+	if (ret)
+		goto err_alloc_vector;
+
 	ret = hns3_nic_init_vector_data(priv);
 	if (ret)
 		goto err_uninit_vector;
@@ -3377,6 +3445,8 @@ static int hns3_modify_tqp_num(struct net_device *netdev, u16 new_tqp_num)
 	hns3_put_ring_config(priv);
 err_uninit_vector:
 	hns3_nic_uninit_vector_data(priv);
+err_alloc_vector:
+	hns3_nic_dealloc_vector_data(priv);
 	return ret;
 }
 
@@ -3424,6 +3494,8 @@ int hns3_set_channels(struct net_device *netdev,
 		goto open_netdev;
 	}
 
+	hns3_nic_dealloc_vector_data(priv);
+
 	hns3_uninit_all_ring(priv);
 	hns3_put_ring_config(priv);
 
-- 
2.9.3
