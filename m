Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EED7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3381420850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfBWJX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbfBWJXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:17 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BC20C73E20399F010B00;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:23:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 06/12] net: hns3: replace hnae3_set_bit and hnae3_set_field in data path
Date:   Sat, 23 Feb 2019 17:22:13 +0800
Message-ID: <1550913739-13232-7-git-send-email-tanhuazhong@huawei.com>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

hnae3_set_bit and hnae3_set_field masks the data before setting
the field or bit, which is unnecessary because the data is already
zero initialized.

Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 120 ++++++++++--------------
 1 file changed, 51 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 50bfdba..ce9878b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -21,6 +21,8 @@
 #include "hnae3.h"
 #include "hns3_enet.h"
 
+#define hns3_set_field(origin, shift, val)	((origin) |= ((val) << (shift)))
+
 static void hns3_clear_all_ring(struct hnae3_handle *h);
 static void hns3_force_clear_all_rx_ring(struct hnae3_handle *h);
 static void hns3_remove_hw_addr(struct net_device *netdev);
@@ -667,8 +669,7 @@ static int hns3_set_tso(struct sk_buff *skb, u32 *paylen,
 
 	/* find the txbd field values */
 	*paylen = skb->len - hdr_len;
-	hnae3_set_bit(*type_cs_vlan_tso,
-		      HNS3_TXD_TSO_B, 1);
+	hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_TSO_B, 1);
 
 	/* get MSS for TSO */
 	*mss = skb_shinfo(skb)->gso_size;
@@ -747,21 +748,19 @@ static void hns3_set_l2l3l4_len(struct sk_buff *skb, u8 ol4_proto,
 
 	/* compute L2 header size for normal packet, defined in 2 Bytes */
 	l2_len = l3.hdr - skb->data;
-	hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L2LEN_M,
-			HNS3_TXD_L2LEN_S, l2_len >> 1);
+	hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L2LEN_S, l2_len >> 1);
 
 	/* tunnel packet*/
 	if (skb->encapsulation) {
 		/* compute OL2 header size, defined in 2 Bytes */
 		ol2_len = l2_len;
-		hnae3_set_field(*ol_type_vlan_len_msec,
-				HNS3_TXD_L2LEN_M,
-				HNS3_TXD_L2LEN_S, ol2_len >> 1);
+		hns3_set_field(*ol_type_vlan_len_msec,
+			       HNS3_TXD_L2LEN_S, ol2_len >> 1);
 
 		/* compute OL3 header size, defined in 4 Bytes */
 		ol3_len = l4.hdr - l3.hdr;
-		hnae3_set_field(*ol_type_vlan_len_msec, HNS3_TXD_L3LEN_M,
-				HNS3_TXD_L3LEN_S, ol3_len >> 2);
+		hns3_set_field(*ol_type_vlan_len_msec, HNS3_TXD_L3LEN_S,
+			       ol3_len >> 2);
 
 		/* MAC in UDP, MAC in GRE (0x6558)*/
 		if ((ol4_proto == IPPROTO_UDP) || (ol4_proto == IPPROTO_GRE)) {
@@ -770,17 +769,16 @@ static void hns3_set_l2l3l4_len(struct sk_buff *skb, u8 ol4_proto,
 
 			/* compute OL4 header size, defined in 4 Bytes. */
 			ol4_len = l2_hdr - l4.hdr;
-			hnae3_set_field(*ol_type_vlan_len_msec,
-					HNS3_TXD_L4LEN_M, HNS3_TXD_L4LEN_S,
-					ol4_len >> 2);
+			hns3_set_field(*ol_type_vlan_len_msec,
+				       HNS3_TXD_L4LEN_S, ol4_len >> 2);
 
 			/* switch IP header ptr from outer to inner header */
 			l3.hdr = skb_inner_network_header(skb);
 
 			/* compute inner l2 header size, defined in 2 Bytes. */
 			l2_len = l3.hdr - l2_hdr;
-			hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L2LEN_M,
-					HNS3_TXD_L2LEN_S, l2_len >> 1);
+			hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L2LEN_S,
+				       l2_len >> 1);
 		} else {
 			/* skb packet types not supported by hardware,
 			 * txbd len fild doesn't be filled.
@@ -796,24 +794,21 @@ static void hns3_set_l2l3l4_len(struct sk_buff *skb, u8 ol4_proto,
 
 	/* compute inner(/normal) L3 header size, defined in 4 Bytes */
 	l3_len = l4.hdr - l3.hdr;
-	hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3LEN_M,
-			HNS3_TXD_L3LEN_S, l3_len >> 2);
+	hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3LEN_S, l3_len >> 2);
 
 	/* compute inner(/normal) L4 header size, defined in 4 Bytes */
 	switch (l4_proto) {
 	case IPPROTO_TCP:
-		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_M,
-				HNS3_TXD_L4LEN_S, l4.tcp->doff);
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_S,
+			       l4.tcp->doff);
 		break;
 	case IPPROTO_SCTP:
-		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_M,
-				HNS3_TXD_L4LEN_S,
-				(sizeof(struct sctphdr) >> 2));
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_S,
+			       (sizeof(struct sctphdr) >> 2));
 		break;
 	case IPPROTO_UDP:
-		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_M,
-				HNS3_TXD_L4LEN_S,
-				(sizeof(struct udphdr) >> 2));
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_S,
+			       (sizeof(struct udphdr) >> 2));
 		break;
 	default:
 		/* skb packet types not supported by hardware,
@@ -858,34 +853,30 @@ static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 		/* define outer network header type.*/
 		if (skb->protocol == htons(ETH_P_IP)) {
 			if (skb_is_gso(skb))
-				hnae3_set_field(*ol_type_vlan_len_msec,
-						HNS3_TXD_OL3T_M,
-						HNS3_TXD_OL3T_S,
-						HNS3_OL3T_IPV4_CSUM);
+				hns3_set_field(*ol_type_vlan_len_msec,
+					       HNS3_TXD_OL3T_S,
+					       HNS3_OL3T_IPV4_CSUM);
 			else
-				hnae3_set_field(*ol_type_vlan_len_msec,
-						HNS3_TXD_OL3T_M,
-						HNS3_TXD_OL3T_S,
-						HNS3_OL3T_IPV4_NO_CSUM);
+				hns3_set_field(*ol_type_vlan_len_msec,
+					       HNS3_TXD_OL3T_S,
+					       HNS3_OL3T_IPV4_NO_CSUM);
 
 		} else if (skb->protocol == htons(ETH_P_IPV6)) {
-			hnae3_set_field(*ol_type_vlan_len_msec, HNS3_TXD_OL3T_M,
-					HNS3_TXD_OL3T_S, HNS3_OL3T_IPV6);
+			hns3_set_field(*ol_type_vlan_len_msec, HNS3_TXD_OL3T_S,
+				       HNS3_OL3T_IPV6);
 		}
 
 		/* define tunnel type(OL4).*/
 		switch (l4_proto) {
 		case IPPROTO_UDP:
-			hnae3_set_field(*ol_type_vlan_len_msec,
-					HNS3_TXD_TUNTYPE_M,
-					HNS3_TXD_TUNTYPE_S,
-					HNS3_TUN_MAC_IN_UDP);
+			hns3_set_field(*ol_type_vlan_len_msec,
+				       HNS3_TXD_TUNTYPE_S,
+				       HNS3_TUN_MAC_IN_UDP);
 			break;
 		case IPPROTO_GRE:
-			hnae3_set_field(*ol_type_vlan_len_msec,
-					HNS3_TXD_TUNTYPE_M,
-					HNS3_TXD_TUNTYPE_S,
-					HNS3_TUN_NVGRE);
+			hns3_set_field(*ol_type_vlan_len_msec,
+				       HNS3_TXD_TUNTYPE_S,
+				       HNS3_TUN_NVGRE);
 			break;
 		default:
 			/* drop the skb tunnel packet if hardware don't support,
@@ -906,43 +897,37 @@ static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 	}
 
 	if (l3.v4->version == 4) {
-		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3T_M,
-				HNS3_TXD_L3T_S, HNS3_L3T_IPV4);
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3T_S,
+			       HNS3_L3T_IPV4);
 
 		/* the stack computes the IP header already, the only time we
 		 * need the hardware to recompute it is in the case of TSO.
 		 */
 		if (skb_is_gso(skb))
-			hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L3CS_B, 1);
+			hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3CS_B, 1);
 	} else if (l3.v6->version == 6) {
-		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3T_M,
-				HNS3_TXD_L3T_S, HNS3_L3T_IPV6);
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3T_S,
+			       HNS3_L3T_IPV6);
 	}
 
 	switch (l4_proto) {
 	case IPPROTO_TCP:
-		hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
-		hnae3_set_field(*type_cs_vlan_tso,
-				HNS3_TXD_L4T_M,
-				HNS3_TXD_L4T_S,
-				HNS3_L4T_TCP);
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4T_S,
+			       HNS3_L4T_TCP);
 		break;
 	case IPPROTO_UDP:
 		if (hns3_tunnel_csum_bug(skb))
 			break;
 
-		hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
-		hnae3_set_field(*type_cs_vlan_tso,
-				HNS3_TXD_L4T_M,
-				HNS3_TXD_L4T_S,
-				HNS3_L4T_UDP);
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4T_S,
+			       HNS3_L4T_UDP);
 		break;
 	case IPPROTO_SCTP:
-		hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
-		hnae3_set_field(*type_cs_vlan_tso,
-				HNS3_TXD_L4T_M,
-				HNS3_TXD_L4T_S,
-				HNS3_L4T_SCTP);
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
+		hns3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4T_S,
+			       HNS3_L4T_SCTP);
 		break;
 	default:
 		/* drop the skb tunnel packet if hardware don't support,
@@ -964,11 +949,8 @@ static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 static void hns3_set_txbd_baseinfo(u16 *bdtp_fe_sc_vld_ra_ri, int frag_end)
 {
 	/* Config bd buffer end */
-	hnae3_set_field(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_BDTYPE_M,
-			HNS3_TXD_BDTYPE_S, 0);
-	hnae3_set_bit(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_FE_B, !!frag_end);
-	hnae3_set_bit(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_VLD_B, 1);
-	hnae3_set_field(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_SC_M, HNS3_TXD_SC_S, 0);
+	hns3_set_field(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_FE_B, !!frag_end);
+	hns3_set_field(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_VLD_B, 1);
 }
 
 static int hns3_fill_desc_vtags(struct sk_buff *skb,
@@ -1001,10 +983,10 @@ static int hns3_fill_desc_vtags(struct sk_buff *skb,
 		 * and use inner_vtag in one tag case.
 		 */
 		if (skb->protocol == htons(ETH_P_8021Q)) {
-			hnae3_set_bit(*out_vlan_flag, HNS3_TXD_OVLAN_B, 1);
+			hns3_set_field(*out_vlan_flag, HNS3_TXD_OVLAN_B, 1);
 			*out_vtag = vlan_tag;
 		} else {
-			hnae3_set_bit(*inner_vlan_flag, HNS3_TXD_VLAN_B, 1);
+			hns3_set_field(*inner_vlan_flag, HNS3_TXD_VLAN_B, 1);
 			*inner_vtag = vlan_tag;
 		}
 	} else if (skb->protocol == htons(ETH_P_8021Q)) {
-- 
2.7.4

