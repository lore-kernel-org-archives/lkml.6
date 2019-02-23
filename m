Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7944C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E77206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfBWJXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4267 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfBWJXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:13 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7FF837241B68B79E0144;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:23:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 08/12] net: hns3: add support to config depth for tx|rx ring separately
Date:   Sat, 23 Feb 2019 17:22:15 +0800
Message-ID: <1550913739-13232-9-git-send-email-tanhuazhong@huawei.com>
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

From: Peng Li <lipeng321@huawei.com>

This patch adds support to config depth for tx|rx ring separately
by ethtool command "-G".

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        | 10 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 54 ++++++++++++----------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 22 ++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 28 +++++++++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 39 ++++++++++++++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  3 +-
 10 files changed, 119 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index 9b6b7b4..299b277 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -21,6 +21,7 @@ enum HCLGE_MBX_OPCODE {
 	HCLGE_MBX_SET_MACVLAN,		/* (VF -> PF) set unicast filter */
 	HCLGE_MBX_API_NEGOTIATE,	/* (VF -> PF) negotiate API version */
 	HCLGE_MBX_GET_QINFO,		/* (VF -> PF) get queue config */
+	HCLGE_MBX_GET_QDEPTH,		/* (VF -> PF) get queue depth */
 	HCLGE_MBX_GET_TCINFO,		/* (VF -> PF) get TC config */
 	HCLGE_MBX_GET_RETA,		/* (VF -> PF) get RETA */
 	HCLGE_MBX_GET_RSS_KEY,		/* (VF -> PF) get RSS key */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 10f1cc2..66d7a8b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -87,7 +87,8 @@ struct hnae3_queue {
 	struct hnae3_handle *handle;
 	int tqp_index;	/* index in a handle */
 	u32 buf_size;	/* size for hnae_desc->addr, preset by AE */
-	u16 desc_num;	/* total number of desc */
+	u16 tx_desc_num;/* total number of tx desc */
+	u16 rx_desc_num;/* total number of rx desc */
 };
 
 /*hnae3 loop mode*/
@@ -505,7 +506,8 @@ struct hnae3_knic_private_info {
 	u16 rss_size;		   /* Allocated RSS queues */
 	u16 req_rss_size;
 	u16 rx_buf_len;
-	u16 num_desc;
+	u16 num_tx_desc;
+	u16 num_rx_desc;
 
 	u8 num_tc;		   /* Total number of enabled TCs */
 	u8 prio_tc[HNAE3_MAX_USER_PRIO];  /* TC indexed by prio */
@@ -537,7 +539,9 @@ struct hnae3_roce_private_info {
 struct hnae3_unic_private_info {
 	struct net_device *netdev;
 	u16 rx_buf_len;
-	u16 num_desc;
+	u16 num_tx_desc;
+	u16 num_rx_desc;
+
 	u16 num_tqps;	/* total number of tqps in this handle */
 	struct hnae3_queue **tqp;  /* array base of all TQPs of this instance */
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 236b340..9f9a52d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3231,19 +3231,21 @@ static int hns3_ring_get_cfg(struct hnae3_queue *q, struct hns3_nic_priv *priv,
 {
 	struct hns3_nic_ring_data *ring_data = priv->ring_data;
 	int queue_num = priv->ae_handle->kinfo.num_tqps;
-	int desc_num = priv->ae_handle->kinfo.num_desc;
 	struct pci_dev *pdev = priv->ae_handle->pdev;
 	struct hns3_enet_ring *ring;
+	int desc_num;
 
 	ring = devm_kzalloc(&pdev->dev, sizeof(*ring), GFP_KERNEL);
 	if (!ring)
 		return -ENOMEM;
 
 	if (ring_type == HNAE3_RING_TYPE_TX) {
+		desc_num = priv->ae_handle->kinfo.num_tx_desc;
 		ring_data[q->tqp_index].ring = ring;
 		ring_data[q->tqp_index].queue_index = q->tqp_index;
 		ring->io_base = (u8 __iomem *)q->io_base + HNS3_TX_REG_OFFSET;
 	} else {
+		desc_num = priv->ae_handle->kinfo.num_rx_desc;
 		ring_data[q->tqp_index + queue_num].ring = ring;
 		ring_data[q->tqp_index + queue_num].queue_index = q->tqp_index;
 		ring->io_base = q->io_base;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 3a1e487..1db0bd4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -74,7 +74,7 @@ enum hns3_nic_state {
 #define HNS3_RING_NAME_LEN			16
 #define HNS3_BUFFER_SIZE_2048			2048
 #define HNS3_RING_MAX_PENDING			32768
-#define HNS3_RING_MIN_PENDING			8
+#define HNS3_RING_MIN_PENDING			24
 #define HNS3_RING_BD_MULTIPLE			8
 /* max frame size of mac */
 #define HNS3_MAC_MAX_FRAME			9728
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index d94c90a..359d473 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -748,15 +748,19 @@ static int hns3_get_rxnfc(struct net_device *netdev,
 }
 
 static int hns3_change_all_ring_bd_num(struct hns3_nic_priv *priv,
-				       u32 new_desc_num)
+				       u32 tx_desc_num, u32 rx_desc_num)
 {
 	struct hnae3_handle *h = priv->ae_handle;
 	int i;
 
-	h->kinfo.num_desc = new_desc_num;
+	h->kinfo.num_tx_desc = tx_desc_num;
+	h->kinfo.num_rx_desc = rx_desc_num;
 
-	for (i = 0; i < h->kinfo.num_tqps * 2; i++)
-		priv->ring_data[i].ring->desc_num = new_desc_num;
+	for (i = 0; i < h->kinfo.num_tqps; i++) {
+		priv->ring_data[i].ring->desc_num = tx_desc_num;
+		priv->ring_data[i + h->kinfo.num_tqps].ring->desc_num =
+			rx_desc_num;
+	}
 
 	return hns3_init_all_ring(priv);
 }
@@ -767,7 +771,9 @@ static int hns3_set_ringparam(struct net_device *ndev,
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = priv->ae_handle;
 	bool if_running = netif_running(ndev);
-	u32 old_desc_num, new_desc_num;
+	u32 old_tx_desc_num, new_tx_desc_num;
+	u32 old_rx_desc_num, new_rx_desc_num;
+	int queue_num = h->kinfo.num_tqps;
 	int ret;
 
 	if (hns3_nic_resetting(ndev))
@@ -776,32 +782,28 @@ static int hns3_set_ringparam(struct net_device *ndev,
 	if (param->rx_mini_pending || param->rx_jumbo_pending)
 		return -EINVAL;
 
-	if (param->tx_pending != param->rx_pending) {
-		netdev_err(ndev,
-			   "Descriptors of tx and rx must be equal");
-		return -EINVAL;
-	}
-
 	if (param->tx_pending > HNS3_RING_MAX_PENDING ||
-	    param->tx_pending < HNS3_RING_MIN_PENDING) {
-		netdev_err(ndev,
-			   "Descriptors requested (Tx/Rx: %d) out of range [%d-%d]\n",
-			   param->tx_pending, HNS3_RING_MIN_PENDING,
-			   HNS3_RING_MAX_PENDING);
+	    param->tx_pending < HNS3_RING_MIN_PENDING ||
+	    param->rx_pending > HNS3_RING_MAX_PENDING ||
+	    param->rx_pending < HNS3_RING_MIN_PENDING) {
+		netdev_err(ndev, "Queue depth out of range [%d-%d]\n",
+			   HNS3_RING_MIN_PENDING, HNS3_RING_MAX_PENDING);
 		return -EINVAL;
 	}
 
-	new_desc_num = param->tx_pending;
-
 	/* Hardware requires that its descriptors must be multiple of eight */
-	new_desc_num = ALIGN(new_desc_num, HNS3_RING_BD_MULTIPLE);
-	old_desc_num = h->kinfo.num_desc;
-	if (old_desc_num == new_desc_num)
+	new_tx_desc_num = ALIGN(param->tx_pending, HNS3_RING_BD_MULTIPLE);
+	new_rx_desc_num = ALIGN(param->rx_pending, HNS3_RING_BD_MULTIPLE);
+	old_tx_desc_num = priv->ring_data[0].ring->desc_num;
+	old_rx_desc_num = priv->ring_data[queue_num].ring->desc_num;
+	if (old_tx_desc_num == new_tx_desc_num &&
+	    old_rx_desc_num == new_rx_desc_num)
 		return 0;
 
 	netdev_info(ndev,
-		    "Changing descriptor count from %d to %d.\n",
-		    old_desc_num, new_desc_num);
+		    "Changing Tx/Rx ring depth from %d/%d to %d/%d\n",
+		    old_tx_desc_num, old_rx_desc_num,
+		    new_tx_desc_num, new_rx_desc_num);
 
 	if (if_running)
 		ndev->netdev_ops->ndo_stop(ndev);
@@ -810,9 +812,11 @@ static int hns3_set_ringparam(struct net_device *ndev,
 	if (ret)
 		return ret;
 
-	ret = hns3_change_all_ring_bd_num(priv, new_desc_num);
+	ret = hns3_change_all_ring_bd_num(priv, new_tx_desc_num,
+					  new_rx_desc_num);
 	if (ret) {
-		ret = hns3_change_all_ring_bd_num(priv, old_desc_num);
+		ret = hns3_change_all_ring_bd_num(priv, old_tx_desc_num,
+						  old_rx_desc_num);
 		if (ret) {
 			netdev_err(ndev,
 				   "Revert to old bd num fail, ret=%d.\n", ret);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5c8f2e4..f113439 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1033,7 +1033,8 @@ static int hclge_configure(struct hclge_dev *hdev)
 	ether_addr_copy(hdev->hw.mac.mac_addr, cfg.mac_addr);
 	hdev->hw.mac.media_type = cfg.media_type;
 	hdev->hw.mac.phy_addr = cfg.phy_addr;
-	hdev->num_desc = cfg.tqp_desc_num;
+	hdev->num_tx_desc = cfg.tqp_desc_num;
+	hdev->num_rx_desc = cfg.tqp_desc_num;
 	hdev->tm_info.num_pg = 1;
 	hdev->tc_max = cfg.tc_num;
 	hdev->tm_info.hw_pfc_map = 0;
@@ -1140,7 +1141,8 @@ static int hclge_alloc_tqps(struct hclge_dev *hdev)
 
 		tqp->q.ae_algo = &ae_algo;
 		tqp->q.buf_size = hdev->rx_buf_len;
-		tqp->q.desc_num = hdev->num_desc;
+		tqp->q.tx_desc_num = hdev->num_tx_desc;
+		tqp->q.rx_desc_num = hdev->num_rx_desc;
 		tqp->q.io_base = hdev->hw.io_base + HCLGE_TQP_REG_OFFSET +
 			i * HCLGE_TQP_REG_SIZE;
 
@@ -1184,7 +1186,8 @@ static int  hclge_assign_tqp(struct hclge_vport *vport, u16 num_tqps)
 		if (!hdev->htqp[i].alloced) {
 			hdev->htqp[i].q.handle = &vport->nic;
 			hdev->htqp[i].q.tqp_index = alloced;
-			hdev->htqp[i].q.desc_num = kinfo->num_desc;
+			hdev->htqp[i].q.tx_desc_num = kinfo->num_tx_desc;
+			hdev->htqp[i].q.rx_desc_num = kinfo->num_rx_desc;
 			kinfo->tqp[alloced] = &hdev->htqp[i].q;
 			hdev->htqp[i].alloced = true;
 			alloced++;
@@ -1197,15 +1200,18 @@ static int  hclge_assign_tqp(struct hclge_vport *vport, u16 num_tqps)
 	return 0;
 }
 
-static int hclge_knic_setup(struct hclge_vport *vport,
-			    u16 num_tqps, u16 num_desc)
+static int hclge_knic_setup(struct hclge_vport *vport, u16 num_tqps,
+			    u16 num_tx_desc, u16 num_rx_desc)
+
 {
 	struct hnae3_handle *nic = &vport->nic;
 	struct hnae3_knic_private_info *kinfo = &nic->kinfo;
 	struct hclge_dev *hdev = vport->back;
 	int ret;
 
-	kinfo->num_desc = num_desc;
+	kinfo->num_tx_desc = num_tx_desc;
+	kinfo->num_rx_desc = num_rx_desc;
+
 	kinfo->rx_buf_len = hdev->rx_buf_len;
 
 	kinfo->tqp = devm_kcalloc(&hdev->pdev->dev, num_tqps,
@@ -1279,7 +1285,9 @@ static int hclge_vport_setup(struct hclge_vport *vport, u16 num_tqps)
 	nic->numa_node_mask = hdev->numa_node_mask;
 
 	if (hdev->ae_dev->dev_type == HNAE3_DEV_KNIC) {
-		ret = hclge_knic_setup(vport, num_tqps, hdev->num_desc);
+		ret = hclge_knic_setup(vport, num_tqps,
+				       hdev->num_tx_desc, hdev->num_rx_desc);
+
 		if (ret) {
 			dev_err(&hdev->pdev->dev, "knic setup failed %d\n",
 				ret);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index abbc58e..b57ac4b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -706,7 +706,8 @@ struct hclge_dev {
 	u16 num_alloc_vport;		/* Num vports this driver supports */
 	u32 numa_node_mask;
 	u16 rx_buf_len;
-	u16 num_desc;
+	u16 num_tx_desc;		/* desc num of per tx queue */
+	u16 num_rx_desc;		/* desc num of per rx queue */
 	u8 hw_tc_map;
 	u8 tc_num_last_time;
 	enum hclge_fc_mode fc_mode_last_time;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 9e0952c..ca056b3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -357,20 +357,34 @@ static int hclge_get_vf_queue_info(struct hclge_vport *vport,
 				   struct hclge_mbx_vf_to_pf_cmd *mbx_req,
 				   bool gen_resp)
 {
-#define HCLGE_TQPS_RSS_INFO_LEN		8
+#define HCLGE_TQPS_RSS_INFO_LEN		6
 	u8 resp_data[HCLGE_TQPS_RSS_INFO_LEN];
 	struct hclge_dev *hdev = vport->back;
 
 	/* get the queue related info */
 	memcpy(&resp_data[0], &vport->alloc_tqps, sizeof(u16));
 	memcpy(&resp_data[2], &vport->nic.kinfo.rss_size, sizeof(u16));
-	memcpy(&resp_data[4], &hdev->num_desc, sizeof(u16));
-	memcpy(&resp_data[6], &hdev->rx_buf_len, sizeof(u16));
+	memcpy(&resp_data[4], &hdev->rx_buf_len, sizeof(u16));
 
 	return hclge_gen_resp_to_vf(vport, mbx_req, 0, resp_data,
 				    HCLGE_TQPS_RSS_INFO_LEN);
 }
 
+static int hclge_get_vf_queue_depth(struct hclge_vport *vport,
+				    struct hclge_mbx_vf_to_pf_cmd *mbx_req,
+				    bool gen_resp)
+{
+#define HCLGE_TQPS_DEPTH_INFO_LEN	4
+	u8 resp_data[HCLGE_TQPS_DEPTH_INFO_LEN];
+	struct hclge_dev *hdev = vport->back;
+
+	/* get the queue depth info */
+	memcpy(&resp_data[0], &hdev->num_tx_desc, sizeof(u16));
+	memcpy(&resp_data[2], &hdev->num_rx_desc, sizeof(u16));
+	return hclge_gen_resp_to_vf(vport, mbx_req, 0, resp_data,
+				    HCLGE_TQPS_DEPTH_INFO_LEN);
+}
+
 static int hclge_get_link_info(struct hclge_vport *vport,
 			       struct hclge_mbx_vf_to_pf_cmd *mbx_req)
 {
@@ -567,6 +581,14 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 					"PF failed(%d) to get Q info for VF\n",
 					ret);
 			break;
+		case HCLGE_MBX_GET_QDEPTH:
+			ret = hclge_get_vf_queue_depth(vport, req, true);
+			if (ret)
+				dev_err(&hdev->pdev->dev,
+					"PF failed(%d) to get Q depth for VF\n",
+					ret);
+			break;
+
 		case HCLGE_MBX_GET_TCINFO:
 			ret = hclge_get_vf_tcinfo(vport, req, true);
 			if (ret)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 4a897cf..12f16b9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -247,7 +247,7 @@ static int hclgevf_get_tc_info(struct hclgevf_dev *hdev)
 
 static int hclgevf_get_queue_info(struct hclgevf_dev *hdev)
 {
-#define HCLGEVF_TQPS_RSS_INFO_LEN	8
+#define HCLGEVF_TQPS_RSS_INFO_LEN	6
 	u8 resp_msg[HCLGEVF_TQPS_RSS_INFO_LEN];
 	int status;
 
@@ -263,8 +263,29 @@ static int hclgevf_get_queue_info(struct hclgevf_dev *hdev)
 
 	memcpy(&hdev->num_tqps, &resp_msg[0], sizeof(u16));
 	memcpy(&hdev->rss_size_max, &resp_msg[2], sizeof(u16));
-	memcpy(&hdev->num_desc, &resp_msg[4], sizeof(u16));
-	memcpy(&hdev->rx_buf_len, &resp_msg[6], sizeof(u16));
+	memcpy(&hdev->rx_buf_len, &resp_msg[4], sizeof(u16));
+
+	return 0;
+}
+
+static int hclgevf_get_queue_depth(struct hclgevf_dev *hdev)
+{
+#define HCLGEVF_TQPS_DEPTH_INFO_LEN	4
+	u8 resp_msg[HCLGEVF_TQPS_DEPTH_INFO_LEN];
+	int ret;
+
+	ret = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_GET_QDEPTH, 0, NULL, 0,
+				   true, resp_msg,
+				   HCLGEVF_TQPS_DEPTH_INFO_LEN);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"VF request to get tqp depth info from PF failed %d",
+			ret);
+		return ret;
+	}
+
+	memcpy(&hdev->num_tx_desc, &resp_msg[0], sizeof(u16));
+	memcpy(&hdev->num_rx_desc, &resp_msg[2], sizeof(u16));
 
 	return 0;
 }
@@ -304,7 +325,8 @@ static int hclgevf_alloc_tqps(struct hclgevf_dev *hdev)
 
 		tqp->q.ae_algo = &ae_algovf;
 		tqp->q.buf_size = hdev->rx_buf_len;
-		tqp->q.desc_num = hdev->num_desc;
+		tqp->q.tx_desc_num = hdev->num_tx_desc;
+		tqp->q.rx_desc_num = hdev->num_rx_desc;
 		tqp->q.io_base = hdev->hw.io_base + HCLGEVF_TQP_REG_OFFSET +
 			i * HCLGEVF_TQP_REG_SIZE;
 
@@ -323,7 +345,8 @@ static int hclgevf_knic_setup(struct hclgevf_dev *hdev)
 
 	kinfo = &nic->kinfo;
 	kinfo->num_tc = 0;
-	kinfo->num_desc = hdev->num_desc;
+	kinfo->num_tx_desc = hdev->num_tx_desc;
+	kinfo->num_rx_desc = hdev->num_rx_desc;
 	kinfo->rx_buf_len = hdev->rx_buf_len;
 	for (i = 0; i < HCLGEVF_MAX_TC_NUM; i++)
 		if (hdev->hw_tc_map & BIT(i))
@@ -1747,6 +1770,12 @@ static int hclgevf_configure(struct hclgevf_dev *hdev)
 	ret = hclgevf_get_queue_info(hdev);
 	if (ret)
 		return ret;
+
+	/* get queue depth info from PF */
+	ret = hclgevf_get_queue_depth(hdev);
+	if (ret)
+		return ret;
+
 	/* get tc configuration from PF */
 	return hclgevf_get_tc_info(hdev);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index eba1118..c128863 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -239,7 +239,8 @@ struct hclgevf_dev {
 	u16 num_alloc_vport;	/* num vports this driver supports */
 	u32 numa_node_mask;
 	u16 rx_buf_len;
-	u16 num_desc;
+	u16 num_tx_desc;	/* desc num of per tx queue */
+	u16 num_rx_desc;	/* desc num of per rx queue */
 	u8 hw_tc_map;
 
 	u16 num_msi;
-- 
2.7.4

