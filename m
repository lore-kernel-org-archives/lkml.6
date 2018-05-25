Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968005AbeEYSox (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:44:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8141 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967820AbeEYSoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:44:44 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 01/12] net: hns3: Updates RX packet info fetch in case of multi BD
Date: Fri, 25 May 2018 19:42:56 +0100
Message-ID: <20180525184307.36288-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180525184307.36288-1-salil.mehta@huawei.com>
References: <20180525184307.36288-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

In the latest revision of the hardware, if a packet is spanning
across multiple BDs then only VLD bit and current data size info
is valid in each BD, and rest of the information is only valid
in the last BD of the packet. In such case we should make sure
we are fetching RX packet size from the first descriptor and
information like VLAN should be fetched from last BD.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Reviewed-by: Yisen Zhuang <yisen.zhuang@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 36 ++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index cac5195..ae8d749 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2085,9 +2085,8 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 
 	prefetch(desc);
 
-	length = le16_to_cpu(desc->rx.pkt_len);
+	length = le16_to_cpu(desc->rx.size);
 	bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
-	l234info = le32_to_cpu(desc->rx.l234_info);
 
 	/* Check valid BD */
 	if (!hnae_get_bit(bd_base_info, HNS3_RXD_VLD_B))
@@ -2121,22 +2120,6 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 
 	prefetchw(skb->data);
 
-	/* Based on hw strategy, the tag offloaded will be stored at
-	 * ot_vlan_tag in two layer tag case, and stored at vlan_tag
-	 * in one layer tag case.
-	 */
-	if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX) {
-		u16 vlan_tag;
-
-		vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
-		if (!(vlan_tag & VLAN_VID_MASK))
-			vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
-		if (vlan_tag & VLAN_VID_MASK)
-			__vlan_hwaccel_put_tag(skb,
-					       htons(ETH_P_8021Q),
-					       vlan_tag);
-	}
-
 	bnum = 1;
 	if (length <= HNS3_RX_HEAD_SIZE) {
 		memcpy(__skb_put(skb, length), va, ALIGN(length, sizeof(long)));
@@ -2172,6 +2155,23 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	}
 
 	*out_bnum = bnum;
+	/* Based on hw strategy, the tag offloaded will be stored at
+	 * ot_vlan_tag in two layer tag case, and stored at vlan_tag
+	 * in one layer tag case.
+	 */
+	if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX) {
+		u16 vlan_tag;
+
+		vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
+		if (!(vlan_tag & VLAN_VID_MASK))
+			vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
+		if (vlan_tag & VLAN_VID_MASK)
+			__vlan_hwaccel_put_tag(skb,
+					       htons(ETH_P_8021Q),
+					       vlan_tag);
+	}
+
+	l234info = le32_to_cpu(desc->rx.l234_info);
 
 	if (unlikely(!hnae_get_bit(bd_base_info, HNS3_RXD_VLD_B))) {
 		netdev_err(netdev, "no valid bd,%016llx,%016llx\n",
-- 
2.7.4
