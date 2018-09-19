Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8364ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF79E2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF79E2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbeISXKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:10:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732969AbeISXKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:10:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB9C051A5FF33;
        Thu, 20 Sep 2018 01:31:08 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 01:31:01 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: Remove tx budget to clean more TX descriptors in a napi
Date:   Wed, 19 Sep 2018 18:29:49 +0100
Message-ID: <20180919172958.12992-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180919172958.12992-1-salil.mehta@huawei.com>
References: <20180919172958.12992-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

The the actual Tx work is minimal, driver can clean up as more
Tx descriptors as possible in a irq.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 17 ++++++-----------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  2 +-
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 837c6d6..99209a0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1955,7 +1955,7 @@ static int is_valid_clean_head(struct hns3_enet_ring *ring, int h)
 	return u > c ? (h > c && h <= u) : (h > c || h <= u);
 }
 
-bool hns3_clean_tx_ring(struct hns3_enet_ring *ring, int budget)
+void hns3_clean_tx_ring(struct hns3_enet_ring *ring)
 {
 	struct net_device *netdev = ring->tqp->handle->kinfo.netdev;
 	struct netdev_queue *dev_queue;
@@ -1966,7 +1966,7 @@ bool hns3_clean_tx_ring(struct hns3_enet_ring *ring, int budget)
 	rmb(); /* Make sure head is ready before touch any data */
 
 	if (is_ring_empty(ring) || head == ring->next_to_clean)
-		return true; /* no data to poll */
+		return; /* no data to poll */
 
 	if (unlikely(!is_valid_clean_head(ring, head))) {
 		netdev_err(netdev, "wrong head (%d, %d-%d)\n", head,
@@ -1975,16 +1975,15 @@ bool hns3_clean_tx_ring(struct hns3_enet_ring *ring, int budget)
 		u64_stats_update_begin(&ring->syncp);
 		ring->stats.io_err_cnt++;
 		u64_stats_update_end(&ring->syncp);
-		return true;
+		return;
 	}
 
 	bytes = 0;
 	pkts = 0;
-	while (head != ring->next_to_clean && budget) {
+	while (head != ring->next_to_clean) {
 		hns3_nic_reclaim_one_desc(ring, &bytes, &pkts);
 		/* Issue prefetch for next Tx descriptor */
 		prefetch(&ring->desc_cb[ring->next_to_clean]);
-		budget--;
 	}
 
 	ring->tqp_vector->tx_group.total_bytes += bytes;
@@ -2009,8 +2008,6 @@ bool hns3_clean_tx_ring(struct hns3_enet_ring *ring, int budget)
 			ring->stats.restart_queue++;
 		}
 	}
-
-	return !!budget;
 }
 
 static int hns3_desc_unused(struct hns3_enet_ring *ring)
@@ -2544,10 +2541,8 @@ static int hns3_nic_common_poll(struct napi_struct *napi, int budget)
 	/* Since the actual Tx work is minimal, we can give the Tx a larger
 	 * budget and be more aggressive about cleaning up the Tx descriptors.
 	 */
-	hns3_for_each_ring(ring, tqp_vector->tx_group) {
-		if (!hns3_clean_tx_ring(ring, budget))
-			clean_complete = false;
-	}
+	hns3_for_each_ring(ring, tqp_vector->tx_group)
+		hns3_clean_tx_ring(ring);
 
 	/* make sure rx ring budget not smaller than 1 */
 	rx_budget = max(budget / tqp_vector->num_tqps, 1);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 31fa21f..4a56c3d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -617,7 +617,7 @@ void hns3_ethtool_set_ops(struct net_device *netdev);
 int hns3_set_channels(struct net_device *netdev,
 		      struct ethtool_channels *ch);
 
-bool hns3_clean_tx_ring(struct hns3_enet_ring *ring, int budget);
+void hns3_clean_tx_ring(struct hns3_enet_ring *ring);
 int hns3_init_all_ring(struct hns3_nic_priv *priv);
 int hns3_uninit_all_ring(struct hns3_nic_priv *priv);
 int hns3_nic_reset_all_ring(struct hnae3_handle *h);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 3019007..3cfb6b8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -200,7 +200,7 @@ static void hns3_lb_clear_tx_ring(struct hns3_nic_priv *priv, u32 start_ringid,
 	for (i = start_ringid; i <= end_ringid; i++) {
 		struct hns3_enet_ring *ring = priv->ring_data[i].ring;
 
-		hns3_clean_tx_ring(ring, budget);
+		hns3_clean_tx_ring(ring);
 	}
 }
 
-- 
2.7.4


