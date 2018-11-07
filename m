Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF524C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B052086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B052086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbeKGNff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:35:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730924AbeKGNew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:34:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C86F8E064E8EB;
        Wed,  7 Nov 2018 12:06:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 12:06:06 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 05/12] net: hns3: enable/disable ring in the enet while doing UP/DOWN
Date:   Wed, 7 Nov 2018 12:06:11 +0800
Message-ID: <1541563578-28973-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
References: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While hardware gets into reset status, the firmware will not respond to
driver's command request, which may cause ring not disabled problem
during reset process.

So this patch uses register instead of command to enable/disable the ring
in the enet while doing UP/DOWN operation.

Also, HNS3_RING_RX_VM_REG is previously unused, so change it to the
correct meaning, and add a wrapper function for readl().

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 30 +++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    | 12 +++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  8 -----
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 35 ----------------------
 4 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 75e3e79..e4cf3247 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -312,6 +312,24 @@ static u16 hns3_get_max_available_channels(struct hnae3_handle *h)
 	return min_t(u16, rss_size, max_rss_size);
 }
 
+static void hns3_tqp_enable(struct hnae3_queue *tqp)
+{
+	u32 rcb_reg;
+
+	rcb_reg = hns3_read_dev(tqp, HNS3_RING_EN_REG);
+	rcb_reg |= BIT(HNS3_RING_EN_B);
+	hns3_write_dev(tqp, HNS3_RING_EN_REG, rcb_reg);
+}
+
+static void hns3_tqp_disable(struct hnae3_queue *tqp)
+{
+	u32 rcb_reg;
+
+	rcb_reg = hns3_read_dev(tqp, HNS3_RING_EN_REG);
+	rcb_reg &= ~BIT(HNS3_RING_EN_B);
+	hns3_write_dev(tqp, HNS3_RING_EN_REG, rcb_reg);
+}
+
 static int hns3_nic_net_up(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
@@ -334,6 +352,10 @@ static int hns3_nic_net_up(struct net_device *netdev)
 	for (i = 0; i < priv->vector_num; i++)
 		hns3_vector_enable(&priv->tqp_vector[i]);
 
+	/* enable rcb */
+	for (j = 0; j < h->kinfo.num_tqps; j++)
+		hns3_tqp_enable(h->kinfo.tqp[j]);
+
 	/* start the ae_dev */
 	ret = h->ae_algo->ops->start ? h->ae_algo->ops->start(h) : 0;
 	if (ret)
@@ -344,6 +366,9 @@ static int hns3_nic_net_up(struct net_device *netdev)
 	return 0;
 
 out_start_err:
+	while (j--)
+		hns3_tqp_disable(h->kinfo.tqp[j]);
+
 	for (j = i - 1; j >= 0; j--)
 		hns3_vector_disable(&priv->tqp_vector[j]);
 
@@ -385,6 +410,7 @@ static int hns3_nic_net_open(struct net_device *netdev)
 static void hns3_nic_net_down(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops;
 	int i;
 
@@ -395,6 +421,10 @@ static void hns3_nic_net_down(struct net_device *netdev)
 	for (i = 0; i < priv->vector_num; i++)
 		hns3_vector_disable(&priv->tqp_vector[i]);
 
+	/* disable rcb */
+	for (i = 0; i < h->kinfo.num_tqps; i++)
+		hns3_tqp_disable(h->kinfo.tqp[i]);
+
 	/* stop ae_dev */
 	ops = priv->ae_handle->ae_algo->ops;
 	if (ops->stop)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 7b759e4..3e9db73 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -47,7 +47,7 @@ enum hns3_nic_state {
 #define HNS3_RING_PREFETCH_EN_REG		0x0007C
 #define HNS3_RING_CFG_VF_NUM_REG		0x00080
 #define HNS3_RING_ASID_REG			0x0008C
-#define HNS3_RING_RX_VM_REG			0x00090
+#define HNS3_RING_EN_REG			0x00090
 #define HNS3_RING_T0_BE_RST			0x00094
 #define HNS3_RING_COULD_BE_RST			0x00098
 #define HNS3_RING_WRR_WEIGHT_REG		0x0009c
@@ -194,6 +194,8 @@ enum hns3_nic_state {
 #define HNS3_VECTOR_RL_OFFSET			0x900
 #define HNS3_VECTOR_RL_EN_B			6
 
+#define HNS3_RING_EN_B				0
+
 enum hns3_pkt_l3t_type {
 	HNS3_L3T_NONE,
 	HNS3_L3T_IPV6,
@@ -577,6 +579,11 @@ static inline int is_ring_empty(struct hns3_enet_ring *ring)
 	return ring->next_to_use == ring->next_to_clean;
 }
 
+static inline u32 hns3_read_reg(void __iomem *base, u32 reg)
+{
+	return readl(base + reg);
+}
+
 static inline void hns3_write_reg(void __iomem *base, u32 reg, u32 value)
 {
 	u8 __iomem *reg_addr = READ_ONCE(base);
@@ -589,6 +596,9 @@ static inline bool hns3_dev_ongoing_func_reset(struct hnae3_ae_dev *ae_dev)
 	return (ae_dev && (ae_dev->reset_type == HNAE3_FUNC_RESET));
 }
 
+#define hns3_read_dev(a, reg) \
+	hns3_read_reg((a)->io_base, (reg))
+
 #define hns3_write_dev(a, reg, value) \
 	hns3_write_reg((a)->io_base, (reg), (value))
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b669542..b784db0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4843,10 +4843,6 @@ static int hclge_ae_start(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	int i;
-
-	for (i = 0; i < vport->alloc_tqps; i++)
-		hclge_tqp_enable(hdev, i, 0, true);
 
 	/* mac enable */
 	hclge_cfg_mac_mode(hdev, true);
@@ -4866,7 +4862,6 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	int i;
 
 	set_bit(HCLGE_STATE_DOWN, &hdev->state);
 
@@ -4879,9 +4874,6 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 		return;
 	}
 
-	for (i = 0; i < vport->alloc_tqps; i++)
-		hclge_tqp_enable(hdev, i, 0, false);
-
 	/* Mac disable */
 	hclge_cfg_mac_mode(hdev, false);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 517204b..7531bdd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -956,13 +956,6 @@ static int hclgevf_tqp_enable(struct hclgevf_dev *hdev, int tqp_id,
 	return status;
 }
 
-static int hclgevf_get_queue_id(struct hnae3_queue *queue)
-{
-	struct hclgevf_tqp *tqp = container_of(queue, struct hclgevf_tqp, q);
-
-	return tqp->index;
-}
-
 static void hclgevf_reset_tqp_stats(struct hnae3_handle *handle)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
@@ -1593,21 +1586,7 @@ static int hclgevf_init_vlan_config(struct hclgevf_dev *hdev)
 
 static int hclgevf_ae_start(struct hnae3_handle *handle)
 {
-	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
-	int i, queue_id;
-
-	for (i = 0; i < kinfo->num_tqps; i++) {
-		/* ring enable */
-		queue_id = hclgevf_get_queue_id(kinfo->tqp[i]);
-		if (queue_id < 0) {
-			dev_warn(&hdev->pdev->dev,
-				 "Get invalid queue id, ignore it\n");
-			continue;
-		}
-
-		hclgevf_tqp_enable(hdev, queue_id, 0, true);
-	}
 
 	/* reset tqp stats */
 	hclgevf_reset_tqp_stats(handle);
@@ -1622,24 +1601,10 @@ static int hclgevf_ae_start(struct hnae3_handle *handle)
 
 static void hclgevf_ae_stop(struct hnae3_handle *handle)
 {
-	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
-	int i, queue_id;
 
 	set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
 
-	for (i = 0; i < kinfo->num_tqps; i++) {
-		/* Ring disable */
-		queue_id = hclgevf_get_queue_id(kinfo->tqp[i]);
-		if (queue_id < 0) {
-			dev_warn(&hdev->pdev->dev,
-				 "Get invalid queue id, ignore it\n");
-			continue;
-		}
-
-		hclgevf_tqp_enable(hdev, queue_id, 0, false);
-	}
-
 	/* reset tqp stats */
 	hclgevf_reset_tqp_stats(handle);
 	del_timer_sync(&hdev->service_timer);
-- 
2.7.4

