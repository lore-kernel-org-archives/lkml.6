Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A65DECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7822159F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7822159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390755AbeIUVcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:32:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390678AbeIUVcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:32:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 63CF7934E985E;
        Fri, 21 Sep 2018 23:43:13 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 23:43:06 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 09/12] net: hns3: Remove print messages for error packet
Date:   Fri, 21 Sep 2018 16:41:45 +0100
Message-ID: <20180921154148.26756-10-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180921154148.26756-1-salil.mehta@huawei.com>
References: <20180921154148.26756-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

There are already multiple types packets statistics for error packets,
it's unnecessary to print them, which may affect the rx performance if
print too many.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 8b63707..5a4773a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2149,7 +2149,6 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 		     hnae3_get_bit(l234info, HNS3_RXD_L4E_B) ||
 		     hnae3_get_bit(l234info, HNS3_RXD_OL3E_B) ||
 		     hnae3_get_bit(l234info, HNS3_RXD_OL4E_B))) {
-		netdev_err(netdev, "L3/L4 error pkt\n");
 		u64_stats_update_begin(&ring->syncp);
 		ring->stats.l3l4_csum_err++;
 		u64_stats_update_end(&ring->syncp);
@@ -2328,8 +2327,6 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	}
 
 	if (unlikely(!hnae3_get_bit(bd_base_info, HNS3_RXD_VLD_B))) {
-		netdev_err(netdev, "no valid bd,%016llx,%016llx\n",
-			   ((u64 *)desc)[0], ((u64 *)desc)[1]);
 		u64_stats_update_begin(&ring->syncp);
 		ring->stats.non_vld_descs++;
 		u64_stats_update_end(&ring->syncp);
@@ -2340,7 +2337,6 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 
 	if (unlikely((!desc->rx.pkt_len) ||
 		     hnae3_get_bit(l234info, HNS3_RXD_TRUNCAT_B))) {
-		netdev_err(netdev, "truncated pkt\n");
 		u64_stats_update_begin(&ring->syncp);
 		ring->stats.err_pkt_len++;
 		u64_stats_update_end(&ring->syncp);
@@ -2350,7 +2346,6 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	}
 
 	if (unlikely(hnae3_get_bit(l234info, HNS3_RXD_L2E_B))) {
-		netdev_err(netdev, "L2 error pkt\n");
 		u64_stats_update_begin(&ring->syncp);
 		ring->stats.l2_err++;
 		u64_stats_update_end(&ring->syncp);
-- 
2.7.4


