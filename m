Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeFAQyS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:54:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753273AbeFAQyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:54:14 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 09/11] net: hns3: Fix for vxlan tx checksum bug
Date: Fri, 1 Jun 2018 17:52:09 +0100
Message-ID: <20180601165211.46372-10-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180601165211.46372-1-salil.mehta@huawei.com>
References: <20180601165211.46372-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

when skb->encapsulation is 0, skb->ip_summed is CHECKSUM_PARTIAL
and it is udp packet, which has a dest port as the IANA assigned.
the hardware is expected to do the checksum offload, but the
hardware will not do the checksum offload when udp dest port is
4789.

This patch fixes it by doing the checksum in software.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 235eea1..e572804 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -655,6 +655,32 @@ static void hns3_set_l2l3l4_len(struct sk_buff *skb, u8 ol4_proto,
 	}
 }
 
+/* when skb->encapsulation is 0, skb->ip_summed is CHECKSUM_PARTIAL
+ * and it is udp packet, which has a dest port as the IANA assigned.
+ * the hardware is expected to do the checksum offload, but the
+ * hardware will not do the checksum offload when udp dest port is
+ * 4789.
+ */
+static bool hns3_tunnel_csum_bug(struct sk_buff *skb)
+{
+#define IANA_VXLAN_PORT	4789
+	union {
+		struct tcphdr *tcp;
+		struct udphdr *udp;
+		struct gre_base_hdr *gre;
+		unsigned char *hdr;
+	} l4;
+
+	l4.hdr = skb_transport_header(skb);
+
+	if (!(!skb->encapsulation && l4.udp->dest == htons(IANA_VXLAN_PORT)))
+		return false;
+
+	skb_checksum_help(skb);
+
+	return true;
+}
+
 static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 				   u8 il4_proto, u32 *type_cs_vlan_tso,
 				   u32 *ol_type_vlan_len_msec)
@@ -743,6 +769,9 @@ static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 			       HNS3_L4T_TCP);
 		break;
 	case IPPROTO_UDP:
+		if (hns3_tunnel_csum_bug(skb))
+			break;
+
 		hnae_set_field(*type_cs_vlan_tso,
 			       HNS3_TXD_L4T_M,
 			       HNS3_TXD_L4T_S,
-- 
2.7.4
