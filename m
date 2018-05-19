Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeESPy4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:54:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752489AbeESPyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:54:51 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 2/9] net: hns3: Fixes API to fetch ethernet header length with kernel default
Date: Sat, 19 May 2018 16:53:16 +0100
Message-ID: <20180519155323.68960-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180519155323.68960-1-salil.mehta@huawei.com>
References: <20180519155323.68960-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

During the RX leg driver needs to fetch the ethernet header
length from the RX'ed Buffer Descriptor. Currently, proprietary
version hns3_nic_get_headlen is being used to fetch the header
length which uses l234info present in the Buffer Descriptor
which might not be valid for the first Buffer Descriptor if the
packet is spanning across multiple descriptors.
Kernel default eth_get_headlen API does the job correctly.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Peng Li <lipeng321@huawei.com>
Reviewed-by: Yisen Zhuang <yisen.zhuang@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 104 +-----------------------
 1 file changed, 2 insertions(+), 102 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index e75c652..66cbb66 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1954,106 +1954,6 @@ hns3_nic_alloc_rx_buffers(struct hns3_enet_ring *ring, int cleand_count)
 	writel_relaxed(i, ring->tqp->io_base + HNS3_RING_RX_RING_HEAD_REG);
 }
 
-/* hns3_nic_get_headlen - determine size of header for LRO/GRO
- * @data: pointer to the start of the headers
- * @max: total length of section to find headers in
- *
- * This function is meant to determine the length of headers that will
- * be recognized by hardware for LRO, GRO, and RSC offloads.  The main
- * motivation of doing this is to only perform one pull for IPv4 TCP
- * packets so that we can do basic things like calculating the gso_size
- * based on the average data per packet.
- */
-static unsigned int hns3_nic_get_headlen(unsigned char *data, u32 flag,
-					 unsigned int max_size)
-{
-	unsigned char *network;
-	u8 hlen;
-
-	/* This should never happen, but better safe than sorry */
-	if (max_size < ETH_HLEN)
-		return max_size;
-
-	/* Initialize network frame pointer */
-	network = data;
-
-	/* Set first protocol and move network header forward */
-	network += ETH_HLEN;
-
-	/* Handle any vlan tag if present */
-	if (hnae_get_field(flag, HNS3_RXD_VLAN_M, HNS3_RXD_VLAN_S)
-		== HNS3_RX_FLAG_VLAN_PRESENT) {
-		if ((typeof(max_size))(network - data) > (max_size - VLAN_HLEN))
-			return max_size;
-
-		network += VLAN_HLEN;
-	}
-
-	/* Handle L3 protocols */
-	if (hnae_get_field(flag, HNS3_RXD_L3ID_M, HNS3_RXD_L3ID_S)
-		== HNS3_RX_FLAG_L3ID_IPV4) {
-		if ((typeof(max_size))(network - data) >
-		    (max_size - sizeof(struct iphdr)))
-			return max_size;
-
-		/* Access ihl as a u8 to avoid unaligned access on ia64 */
-		hlen = (network[0] & 0x0F) << 2;
-
-		/* Verify hlen meets minimum size requirements */
-		if (hlen < sizeof(struct iphdr))
-			return network - data;
-
-		/* Record next protocol if header is present */
-	} else if (hnae_get_field(flag, HNS3_RXD_L3ID_M, HNS3_RXD_L3ID_S)
-		== HNS3_RX_FLAG_L3ID_IPV6) {
-		if ((typeof(max_size))(network - data) >
-		    (max_size - sizeof(struct ipv6hdr)))
-			return max_size;
-
-		/* Record next protocol */
-		hlen = sizeof(struct ipv6hdr);
-	} else {
-		return network - data;
-	}
-
-	/* Relocate pointer to start of L4 header */
-	network += hlen;
-
-	/* Finally sort out TCP/UDP */
-	if (hnae_get_field(flag, HNS3_RXD_L4ID_M, HNS3_RXD_L4ID_S)
-		== HNS3_RX_FLAG_L4ID_TCP) {
-		if ((typeof(max_size))(network - data) >
-		    (max_size - sizeof(struct tcphdr)))
-			return max_size;
-
-		/* Access doff as a u8 to avoid unaligned access on ia64 */
-		hlen = (network[12] & 0xF0) >> 2;
-
-		/* Verify hlen meets minimum size requirements */
-		if (hlen < sizeof(struct tcphdr))
-			return network - data;
-
-		network += hlen;
-	} else if (hnae_get_field(flag, HNS3_RXD_L4ID_M, HNS3_RXD_L4ID_S)
-		== HNS3_RX_FLAG_L4ID_UDP) {
-		if ((typeof(max_size))(network - data) >
-		    (max_size - sizeof(struct udphdr)))
-			return max_size;
-
-		network += sizeof(struct udphdr);
-	}
-
-	/* If everything has gone correctly network should be the
-	 * data section of the packet and will be the end of the header.
-	 * If not then it probably represents the end of the last recognized
-	 * header.
-	 */
-	if ((typeof(max_size))(network - data) < max_size)
-		return network - data;
-	else
-		return max_size;
-}
-
 static void hns3_nic_reuse_page(struct sk_buff *skb, int i,
 				struct hns3_enet_ring *ring, int pull_len,
 				struct hns3_desc_cb *desc_cb)
@@ -2253,8 +2153,8 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 		ring->stats.seg_pkt_cnt++;
 		u64_stats_update_end(&ring->syncp);
 
-		pull_len = hns3_nic_get_headlen(va, l234info,
-						HNS3_RX_HEAD_SIZE);
+		pull_len = eth_get_headlen(va, HNS3_RX_HEAD_SIZE);
+
 		memcpy(__skb_put(skb, pull_len), va,
 		       ALIGN(pull_len, sizeof(long)));
 
-- 
2.7.4
