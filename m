Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C18C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4164F20811
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4164F20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbeKMUMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:12:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732232AbeKMUMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:12:07 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 28F8070E14F99;
        Tue, 13 Nov 2018 18:14:41 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.86.21) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 13 Nov 2018 18:14:32 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 5/5] net: hns3: Adds GRO params to SKB for the stack
Date:   Tue, 13 Nov 2018 10:13:07 +0000
Message-ID: <20181113101307.6020-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181113101307.6020-1-salil.mehta@huawei.com>
References: <20181113101307.6020-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.86.21]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

When HW GRO enable, protocol stack will not do GRO again,
driver should add gro param to the skb for the protocol
stack..

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 43 +++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  9 ++--
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 7776089b6bc2..22220af92aa9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -15,6 +15,7 @@
 #include <linux/vermagic.h>
 #include <net/gre.h>
 #include <net/pkt_cls.h>
+#include <net/tcp.h>
 #include <net/vxlan.h>
 
 #include "hnae3.h"
@@ -2318,6 +2319,12 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 	if (!(netdev->features & NETIF_F_RXCSUM))
 		return;
 
+	/* We MUST enable hardware checksum before enabling hardware GRO */
+	if (skb_shinfo(skb)->gso_size) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		return;
+	}
+
 	/* check if hardware has done checksum */
 	if (!hnae3_get_bit(bd_base_info, HNS3_RXD_L3L4P_B))
 		return;
@@ -2511,6 +2518,39 @@ static int hns3_add_frag(struct hns3_enet_ring *ring, struct hns3_desc *desc,
 	return 0;
 }
 
+static void hns3_set_gro_param(struct sk_buff *skb, u32 l234info,
+			       u32 bd_base_info)
+{
+	u16 gro_count;
+	u32 l3_type;
+
+	gro_count = hnae3_get_field(l234info, HNS3_RXD_GRO_COUNT_M,
+				    HNS3_RXD_GRO_COUNT_S);
+	/* if there is no HW GRO, do not set gro params */
+	if (!gro_count)
+		return;
+
+	/* tcp_gro_complete() will copy NAPI_GRO_CB(skb)->count
+	 * to skb_shinfo(skb)->gso_segs
+	 */
+	NAPI_GRO_CB(skb)->count = gro_count;
+
+	l3_type = hnae3_get_field(l234info, HNS3_RXD_L3ID_M,
+				  HNS3_RXD_L3ID_S);
+	if (l3_type == HNS3_L3_TYPE_IPV4)
+		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
+	else if (l3_type == HNS3_L3_TYPE_IPV6)
+		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
+	else
+		return;
+
+	skb_shinfo(skb)->gso_size = hnae3_get_field(bd_base_info,
+						    HNS3_RXD_GRO_SIZE_M,
+						    HNS3_RXD_GRO_SIZE_S);
+	if (skb_shinfo(skb)->gso_size)
+		tcp_gro_complete(skb);
+}
+
 static void hns3_set_rx_skb_rss_type(struct hns3_enet_ring *ring,
 				     struct sk_buff *skb)
 {
@@ -2645,6 +2685,9 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 
 	ring->tqp_vector->rx_group.total_bytes += skb->len;
 
+	/* This is needed in order to enable forwarding support */
+	hns3_set_gro_param(skb, l234info, bd_base_info);
+
 	hns3_rx_checksum(ring, skb, desc);
 	*out_skb = skb;
 	hns3_set_rx_skb_rss_type(ring, skb);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 8e56b7e44978..3365c9596983 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -109,6 +109,10 @@ enum hns3_nic_state {
 #define HNS3_RXD_DOI_B				21
 #define HNS3_RXD_OL3E_B				22
 #define HNS3_RXD_OL4E_B				23
+#define HNS3_RXD_GRO_COUNT_S			24
+#define HNS3_RXD_GRO_COUNT_M			(0x3f << HNS3_RXD_GRO_COUNT_S)
+#define HNS3_RXD_GRO_FIXID_B			30
+#define HNS3_RXD_GRO_ECN_B			31
 
 #define HNS3_RXD_ODMAC_S			0
 #define HNS3_RXD_ODMAC_M			(0x3 << HNS3_RXD_ODMAC_S)
@@ -135,9 +139,8 @@ enum hns3_nic_state {
 #define HNS3_RXD_TSIND_S			12
 #define HNS3_RXD_TSIND_M			(0x7 << HNS3_RXD_TSIND_S)
 #define HNS3_RXD_LKBK_B				15
-#define HNS3_RXD_HDL_S				16
-#define HNS3_RXD_HDL_M				(0x7ff << HNS3_RXD_HDL_S)
-#define HNS3_RXD_HSIND_B			31
+#define HNS3_RXD_GRO_SIZE_S			16
+#define HNS3_RXD_GRO_SIZE_M			(0x3ff << HNS3_RXD_GRO_SIZE_S)
 
 #define HNS3_TXD_L3T_S				0
 #define HNS3_TXD_L3T_M				(0x3 << HNS3_TXD_L3T_S)
-- 
2.17.1


