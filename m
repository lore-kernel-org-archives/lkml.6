Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935028AbeCHCkB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:40:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934814AbeCHCfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:35:00 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 08/23] {topost} net: hns3: fix rx path skb->truesize reporting bug
Date: Thu, 8 Mar 2018 11:06:33 +0800
Message-ID: <1520478408-116992-9-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
References: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original skb->truesize reports the received packet size,
not the actual buffer size NIC driver allocated(1 Page).
The linux net protocol will misjudge the true size of rx queue.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 83f4b36..f50245d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2064,15 +2064,13 @@ static void hns3_nic_reuse_page(struct sk_buff *skb, int i,
 	desc = &ring->desc[ring->next_to_clean];
 	size = le16_to_cpu(desc->rx.size);
 
-	if (twobufs) {
-		truesize = hnae_buf_size(ring);
-	} else {
-		truesize = ALIGN(size, L1_CACHE_BYTES);
+	truesize = hnae_buf_size(ring);
+
+	if (!twobufs)
 		last_offset = hnae_page_size(ring) - hnae_buf_size(ring);
-	}
 
 	skb_add_rx_frag(skb, i, desc_cb->priv, desc_cb->page_offset + pull_len,
-			size - pull_len, truesize - pull_len);
+			size - pull_len, truesize);
 
 	 /* Avoid re-using remote pages,flag default unreuse */
 	if (unlikely(page_to_nid(desc_cb->priv) != numa_node_id()))
-- 
2.9.3
