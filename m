Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119FB217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfAVXkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:40:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60078 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727062AbfAVXkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:40:12 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1C19E97352E174BBDBD4;
        Wed, 23 Jan 2019 07:40:08 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.16) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 07:39:58 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>, <eric.dumazet@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 02/12] net: hns3: add rx multicast packets statistic
Date:   Wed, 23 Jan 2019 07:39:28 +0800
Message-ID: <20190122233938.7188-3-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190122233938.7188-1-tanhuazhong@huawei.com>
References: <20190122233938.7188-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

This patch adds rx multicast packets statistic for each ring.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
V1->V2: fixes comment from Eric Dumazet
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 6 ++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    | 8 ++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 9dd8949381bc..2ec3759961f1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2572,6 +2572,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 			     struct sk_buff **out_skb)
 {
 	struct net_device *netdev = ring->tqp->handle->kinfo.netdev;
+	enum hns3_pkt_l2t_type l2_frame_type;
 	struct sk_buff *skb = ring->skb;
 	struct hns3_desc_cb *desc_cb;
 	struct hns3_desc *desc;
@@ -2680,7 +2681,12 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 		return -EFAULT;
 	}
 
+	l2_frame_type = hnae3_get_field(l234info, HNS3_RXD_DMAC_M,
+					HNS3_RXD_DMAC_S);
 	u64_stats_update_begin(&ring->syncp);
+	if (l2_frame_type == HNS3_L2_TYPE_MULTICAST)
+		ring->stats.rx_multicast++;
+
 	ring->stats.rx_pkts++;
 	ring->stats.rx_bytes += skb->len;
 	u64_stats_update_end(&ring->syncp);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index f59ab7387b1f..f3d248626ab3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -202,6 +202,13 @@ enum hns3_nic_state {
 
 #define HNS3_RING_EN_B				0
 
+enum hns3_pkt_l2t_type {
+	HNS3_L2_TYPE_UNICAST,
+	HNS3_L2_TYPE_MULTICAST,
+	HNS3_L2_TYPE_BROADCAST,
+	HNS3_L2_TYPE_INVALID,
+};
+
 enum hns3_pkt_l3t_type {
 	HNS3_L3T_NONE,
 	HNS3_L3T_IPV6,
@@ -376,6 +383,7 @@ struct ring_stats {
 			u64 err_bd_num;
 			u64 l2_err;
 			u64 l3l4_csum_err;
+			u64 rx_multicast;
 		};
 	};
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index e678b6939da3..abb78696d7ce 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -47,6 +47,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
 	HNS3_TQP_STAT("err_bd_num", err_bd_num),
 	HNS3_TQP_STAT("l2_err", l2_err),
 	HNS3_TQP_STAT("l3l4_csum_err", l3l4_csum_err),
+	HNS3_TQP_STAT("multicast", rx_multicast),
 };
 
 #define HNS3_RXQ_STATS_COUNT ARRAY_SIZE(hns3_rxq_stats)
-- 
2.20.1


