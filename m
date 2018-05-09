Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965604AbeEIQ0o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:26:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965558AbeEIQ0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:26:23 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 2/4] net: hns3: remove add/del_tunnel_udp in hns3_enet module
Date: Wed, 9 May 2018 17:24:39 +0100
Message-ID: <20180509162441.18068-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180509162441.18068-1-salil.mehta@huawei.com>
References: <20180509162441.18068-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The add/del_tunnel_udp is not implemented in hclge_main moulde,
the NETIF_F_RX_UDP_TUNNEL_PORT feature bit is added automatically
by stack when ndo_udp_tunnel_add is not null in dev->netdev_ops.

This patch removes the add/del_tunnel_udp related function, for
we do not support this feature now.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h     |  7 --
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 89 -------------------------
 2 files changed, 96 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 37ec1b3..804ea83 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -273,10 +273,6 @@ struct hnae3_ae_dev {
  *   Map rings to vector
  * unmap_ring_from_vector()
  *   Unmap rings from vector
- * add_tunnel_udp()
- *   Add tunnel information to hardware
- * del_tunnel_udp()
- *   Delete tunnel information from hardware
  * reset_queue()
  *   Reset queue
  * get_fw_version()
@@ -388,9 +384,6 @@ struct hnae3_ae_ops {
 				      int vector_num,
 				      struct hnae3_ring_chain_node *vr_chain);
 
-	int (*add_tunnel_udp)(struct hnae3_handle *handle, u16 port_num);
-	int (*del_tunnel_udp)(struct hnae3_handle *handle, u16 port_num);
-
 	void (*reset_queue)(struct hnae3_handle *handle, u16 queue_id);
 	u32 (*get_fw_version)(struct hnae3_handle *handle);
 	void (*get_mdix_mode)(struct hnae3_handle *handle,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a55c8f515..bd8e14b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1244,93 +1244,6 @@ static void hns3_nic_get_stats64(struct net_device *netdev,
 	stats->tx_compressed = netdev->stats.tx_compressed;
 }
 
-static void hns3_add_tunnel_port(struct net_device *netdev, u16 port,
-				 enum hns3_udp_tnl_type type)
-{
-	struct hns3_nic_priv *priv = netdev_priv(netdev);
-	struct hns3_udp_tunnel *udp_tnl = &priv->udp_tnl[type];
-	struct hnae3_handle *h = priv->ae_handle;
-
-	if (udp_tnl->used && udp_tnl->dst_port == port) {
-		udp_tnl->used++;
-		return;
-	}
-
-	if (udp_tnl->used) {
-		netdev_warn(netdev,
-			    "UDP tunnel [%d], port [%d] offload\n", type, port);
-		return;
-	}
-
-	udp_tnl->dst_port = port;
-	udp_tnl->used = 1;
-	/* TBD send command to hardware to add port */
-	if (h->ae_algo->ops->add_tunnel_udp)
-		h->ae_algo->ops->add_tunnel_udp(h, port);
-}
-
-static void hns3_del_tunnel_port(struct net_device *netdev, u16 port,
-				 enum hns3_udp_tnl_type type)
-{
-	struct hns3_nic_priv *priv = netdev_priv(netdev);
-	struct hns3_udp_tunnel *udp_tnl = &priv->udp_tnl[type];
-	struct hnae3_handle *h = priv->ae_handle;
-
-	if (!udp_tnl->used || udp_tnl->dst_port != port) {
-		netdev_warn(netdev,
-			    "Invalid UDP tunnel port %d\n", port);
-		return;
-	}
-
-	udp_tnl->used--;
-	if (udp_tnl->used)
-		return;
-
-	udp_tnl->dst_port = 0;
-	/* TBD send command to hardware to del port  */
-	if (h->ae_algo->ops->del_tunnel_udp)
-		h->ae_algo->ops->del_tunnel_udp(h, port);
-}
-
-/* hns3_nic_udp_tunnel_add - Get notifiacetion about UDP tunnel ports
- * @netdev: This physical ports's netdev
- * @ti: Tunnel information
- */
-static void hns3_nic_udp_tunnel_add(struct net_device *netdev,
-				    struct udp_tunnel_info *ti)
-{
-	u16 port_n = ntohs(ti->port);
-
-	switch (ti->type) {
-	case UDP_TUNNEL_TYPE_VXLAN:
-		hns3_add_tunnel_port(netdev, port_n, HNS3_UDP_TNL_VXLAN);
-		break;
-	case UDP_TUNNEL_TYPE_GENEVE:
-		hns3_add_tunnel_port(netdev, port_n, HNS3_UDP_TNL_GENEVE);
-		break;
-	default:
-		netdev_err(netdev, "unsupported tunnel type %d\n", ti->type);
-		break;
-	}
-}
-
-static void hns3_nic_udp_tunnel_del(struct net_device *netdev,
-				    struct udp_tunnel_info *ti)
-{
-	u16 port_n = ntohs(ti->port);
-
-	switch (ti->type) {
-	case UDP_TUNNEL_TYPE_VXLAN:
-		hns3_del_tunnel_port(netdev, port_n, HNS3_UDP_TNL_VXLAN);
-		break;
-	case UDP_TUNNEL_TYPE_GENEVE:
-		hns3_del_tunnel_port(netdev, port_n, HNS3_UDP_TNL_GENEVE);
-		break;
-	default:
-		break;
-	}
-}
-
 static int hns3_setup_tc(struct net_device *netdev, void *type_data)
 {
 	struct tc_mqprio_qopt_offload *mqprio_qopt = type_data;
@@ -1569,8 +1482,6 @@ static const struct net_device_ops hns3_nic_netdev_ops = {
 	.ndo_get_stats64	= hns3_nic_get_stats64,
 	.ndo_setup_tc		= hns3_nic_setup_tc,
 	.ndo_set_rx_mode	= hns3_nic_set_rx_mode,
-	.ndo_udp_tunnel_add	= hns3_nic_udp_tunnel_add,
-	.ndo_udp_tunnel_del	= hns3_nic_udp_tunnel_del,
 	.ndo_vlan_rx_add_vid	= hns3_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= hns3_vlan_rx_kill_vid,
 	.ndo_set_vf_vlan	= hns3_ndo_set_vf_vlan,
-- 
2.7.4
