Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6582AC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363E221477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363E221477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbeJFAE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:04:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbeJFAE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:04:28 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 97609D51EFE39;
        Sat,  6 Oct 2018 01:04:49 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Sat, 6 Oct 2018 01:04:40 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 6/6] net: hns3: Fix for rx vlan id handle to support Rev 0x21 hardware
Date:   Fri, 5 Oct 2018 18:03:29 +0100
Message-ID: <20181005170329.6512-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181005170329.6512-1-salil.mehta@huawei.com>
References: <20181005170329.6512-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

In revision 0x20, we use vlan id != 0 to check whether a vlan tag
has been offloaded, so vlan id 0 is not supported.

In revision 0x21, rx buffer descriptor adds two bits to indicate
whether one or more vlan tags have been offloaded, so vlan id 0
is valid now.

This patch seperates the handle for vlan id 0, add vlan id 0 support
for revision 0x21.

Fixes: 5b5455a9ed5a ("net: hns3: Add STRP_TAGP field support for hardware revision 0x21")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 30 +++++++++++--------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 3f36c38..e9d4564 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2200,18 +2200,18 @@ static void hns3_rx_skb(struct hns3_enet_ring *ring, struct sk_buff *skb)
 	napi_gro_receive(&ring->tqp_vector->napi, skb);
 }
 
-static u16 hns3_parse_vlan_tag(struct hns3_enet_ring *ring,
-			       struct hns3_desc *desc, u32 l234info)
+static bool hns3_parse_vlan_tag(struct hns3_enet_ring *ring,
+				struct hns3_desc *desc, u32 l234info,
+				u16 *vlan_tag)
 {
 	struct pci_dev *pdev = ring->tqp->handle->pdev;
-	u16 vlan_tag;
 
 	if (pdev->revision == 0x20) {
-		vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
-		if (!(vlan_tag & VLAN_VID_MASK))
-			vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
+		*vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
+		if (!(*vlan_tag & VLAN_VID_MASK))
+			*vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
 
-		return vlan_tag;
+		return (*vlan_tag != 0);
 	}
 
 #define HNS3_STRP_OUTER_VLAN	0x1
@@ -2220,17 +2220,14 @@ static u16 hns3_parse_vlan_tag(struct hns3_enet_ring *ring,
 	switch (hnae3_get_field(l234info, HNS3_RXD_STRP_TAGP_M,
 				HNS3_RXD_STRP_TAGP_S)) {
 	case HNS3_STRP_OUTER_VLAN:
-		vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
-		break;
+		*vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
+		return true;
 	case HNS3_STRP_INNER_VLAN:
-		vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
-		break;
+		*vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
+		return true;
 	default:
-		vlan_tag = 0;
-		break;
+		return false;
 	}
-
-	return vlan_tag;
 }
 
 static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
@@ -2332,8 +2329,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX) {
 		u16 vlan_tag;
 
-		vlan_tag = hns3_parse_vlan_tag(ring, desc, l234info);
-		if (vlan_tag & VLAN_VID_MASK)
+		if (hns3_parse_vlan_tag(ring, desc, l234info, &vlan_tag))
 			__vlan_hwaccel_put_tag(skb,
 					       htons(ETH_P_8021Q),
 					       vlan_tag);
-- 
2.7.4


