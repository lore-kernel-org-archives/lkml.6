Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968076AbeEYSpA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:45:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60905 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S967835AbeEYSoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:44:54 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 08/12] net: hns3: Removes unnecessary check when clearing TX/RX rings
Date: Fri, 25 May 2018 19:43:03 +0100
Message-ID: <20180525184307.36288-9-salil.mehta@huawei.com>
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

From: Fuyun Liang <liangfuyun1@huawei.com>

Our code will ensure that hns3_clear_tx_ring is not used to cleared
RX rings and hns3_clear_rx_ring is not used to cleared TX rings. So
the ring type check is unnecessary.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index d1ef104..4c13c52 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3217,9 +3217,6 @@ static void hns3_recover_hw_addr(struct net_device *ndev)
 
 static void hns3_clear_tx_ring(struct hns3_enet_ring *ring)
 {
-	if (!HNAE3_IS_TX_RING(ring))
-		return;
-
 	while (ring->next_to_clean != ring->next_to_use) {
 		hns3_free_buffer_detach(ring, ring->next_to_clean);
 		ring_ptr_move_fw(ring, next_to_clean);
@@ -3228,9 +3225,6 @@ static void hns3_clear_tx_ring(struct hns3_enet_ring *ring)
 
 static void hns3_clear_rx_ring(struct hns3_enet_ring *ring)
 {
-	if (HNAE3_IS_TX_RING(ring))
-		return;
-
 	while (ring->next_to_use != ring->next_to_clean) {
 		/* When a buffer is not reused, it's memory has been
 		 * freed in hns3_handle_rx_bd or will be freed by
-- 
2.7.4
