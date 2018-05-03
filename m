Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeECQ3N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:29:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751141AbeECQ3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:29:09 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next] net: hns3: Add support of hardware rx-vlan-offload to HNS3 VF driver
Date: Thu, 3 May 2018 17:28:11 +0100
Message-ID: <20180503162811.12440-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch adds support of hardware rx-vlan-offload to VF driver.
VF uses mailbox to convey PF to configure the hardware.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           |  8 +-------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h   |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c    |  5 +++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 12 ++++++++++++
 5 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index c4e2950..729bcab 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1626,8 +1626,6 @@ static struct pci_driver hns3_driver = {
 /* set default feature to hns3 */
 static void hns3_set_default_feature(struct net_device *netdev)
 {
-	struct hnae3_handle *h = hns3_get_handle(netdev);
-
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
 	netdev->hw_enc_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
@@ -1656,15 +1654,11 @@ static void hns3_set_default_feature(struct net_device *netdev)
 		NETIF_F_GSO_UDP_TUNNEL_CSUM;
 
 	netdev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-		NETIF_F_HW_VLAN_CTAG_TX |
+		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 		NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_GSO |
 		NETIF_F_GRO | NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_GSO_GRE |
 		NETIF_F_GSO_GRE_CSUM | NETIF_F_GSO_UDP_TUNNEL |
 		NETIF_F_GSO_UDP_TUNNEL_CSUM;
-
-	if (!(h->flags & HNAE3_SUPPORT_VF))
-		netdev->hw_features |=
-			NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
 }
 
 static int hns3_alloc_buffer(struct hns3_enet_ring *ring,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index dd5d65c..084b904 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4862,7 +4862,7 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 	return hclge_set_vlan_filter(handle, htons(ETH_P_8021Q), 0, false);
 }
 
-static int hclge_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
+int hclge_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index b7ee91d..af736a4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -652,6 +652,7 @@ static inline int hclge_get_queue_id(struct hnae3_queue *queue)
 int hclge_cfg_mac_speed_dup(struct hclge_dev *hdev, int speed, u8 duplex);
 int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
 			  u16 vlan_id, bool is_kill);
+int hclge_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable);
 
 int hclge_buffer_alloc(struct hclge_dev *hdev);
 int hclge_rss_init_hw(struct hclge_dev *hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 7563335..b6ae26b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -276,6 +276,11 @@ static int hclge_set_vf_vlan_cfg(struct hclge_vport *vport,
 		memcpy(&proto, &mbx_req->msg[5], sizeof(proto));
 		status = hclge_set_vlan_filter(handle, cpu_to_be16(proto),
 					       vlan, is_kill);
+	} else if (mbx_req->msg[1] == HCLGE_MBX_VLAN_RX_OFF_CFG) {
+		struct hnae3_handle *handle = &vport->nic;
+		bool en = mbx_req->msg[2] ? true : false;
+
+		status = hclge_en_hw_strip_rxvtag(handle, en);
 	}
 
 	if (gen_resp)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 2b84264..2dbffce 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -830,6 +830,17 @@ static int hclgevf_set_vlan_filter(struct hnae3_handle *handle,
 				    HCLGEVF_VLAN_MBX_MSG_LEN, false, NULL, 0);
 }
 
+static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	u8 msg_data;
+
+	msg_data = enable ? 1 : 0;
+	return hclgevf_send_mbx_msg(hdev, HCLGE_MBX_SET_VLAN,
+				    HCLGE_MBX_VLAN_RX_OFF_CFG, &msg_data,
+				    1, false, NULL, 0);
+}
+
 static void hclgevf_reset_tqp(struct hnae3_handle *handle, u16 queue_id)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
@@ -1825,6 +1836,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.get_tc_size = hclgevf_get_tc_size,
 	.get_fw_version = hclgevf_get_fw_version,
 	.set_vlan_filter = hclgevf_set_vlan_filter,
+	.enable_hw_strip_rxvtag = hclgevf_en_hw_strip_rxvtag,
 	.reset_event = hclgevf_reset_event,
 	.get_channels = hclgevf_get_channels,
 	.get_tqps_and_rss_info = hclgevf_get_tqps_and_rss_info,
-- 
2.7.4
