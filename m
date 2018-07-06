Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6D9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527ED23F13
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527ED23F13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932524AbeGFK3V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:29:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932439AbeGFK3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:29:19 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 93EFD6ABBC82C;
        Fri,  6 Jul 2018 18:29:05 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.382.0; Fri, 6 Jul 2018 18:28:58 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 04/10] net: hns3: Fix for l4 checksum offload bug
Date:   Fri, 6 Jul 2018 11:27:58 +0100
Message-ID: <20180706102804.196-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706102804.196-1-salil.mehta@huawei.com>
References: <20180706102804.196-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Hardware only support tcp/udp/sctp l4 checksum offload, but
the driver currently tell hardware to do l4 checksum offlad when
l3 is IPv4 or IPv6, which may cause checksumm error.

This patch fixes it by only enabling the l4 offload when l4 is
tcp/udp/sctp.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index e5e51e8..c211450 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -791,16 +791,14 @@ static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 		 */
 		if (skb_is_gso(skb))
 			hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L3CS_B, 1);
-
-		hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
 	} else if (l3.v6->version == 6) {
 		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3T_M,
 				HNS3_TXD_L3T_S, HNS3_L3T_IPV6);
-		hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
 	}
 
 	switch (l4_proto) {
 	case IPPROTO_TCP:
+		hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
 		hnae3_set_field(*type_cs_vlan_tso,
 				HNS3_TXD_L4T_M,
 				HNS3_TXD_L4T_S,
@@ -810,12 +808,14 @@ static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 		if (hns3_tunnel_csum_bug(skb))
 			break;
 
+		hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
 		hnae3_set_field(*type_cs_vlan_tso,
 				HNS3_TXD_L4T_M,
 				HNS3_TXD_L4T_S,
 				HNS3_L4T_UDP);
 		break;
 	case IPPROTO_SCTP:
+		hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
 		hnae3_set_field(*type_cs_vlan_tso,
 				HNS3_TXD_L4T_M,
 				HNS3_TXD_L4T_S,
-- 
2.7.4


