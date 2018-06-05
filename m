Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeFEMcQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:32:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48303 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751989AbeFEMcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:32:13 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jcliburn@gmail.com>, <chris.snook@gmail.com>, <benve@cisco.com>,
        <jdmason@kudzu.us>, <chessman@tux.org>, <jes@trained-monkey.org>,
        <rahul.verma@cavium.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 1/6] net: hippi: use pci_zalloc_consistent
Date: Tue, 5 Jun 2018 20:28:46 +0800
Message-ID: <20180605122851.23912-2-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20180605122851.23912-1-yuehaibing@huawei.com>
References: <20180605122851.23912-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use pci_zalloc_consistent to remove unnecessary memset.
Also remove a local intermediate pointer 'tmpptr'.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/hippi/rrunner.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index f411164..9de7d2a 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -93,7 +93,6 @@ static int rr_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	static int version_disp;
 	u8 pci_latency;
 	struct rr_private *rrpriv;
-	void *tmpptr;
 	dma_addr_t ring_dma;
 	int ret = -ENOMEM;
 
@@ -155,29 +154,26 @@ static int rr_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto out;
 	}
 
-	tmpptr = pci_alloc_consistent(pdev, TX_TOTAL_SIZE, &ring_dma);
-	rrpriv->tx_ring = tmpptr;
+	rrpriv->tx_ring = pci_alloc_consistent(pdev, TX_TOTAL_SIZE, &ring_dma);
 	rrpriv->tx_ring_dma = ring_dma;
 
-	if (!tmpptr) {
+	if (!rrpriv->tx_ring) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	tmpptr = pci_alloc_consistent(pdev, RX_TOTAL_SIZE, &ring_dma);
-	rrpriv->rx_ring = tmpptr;
+	rrpriv->rx_ring = pci_alloc_consistent(pdev, RX_TOTAL_SIZE, &ring_dma);
 	rrpriv->rx_ring_dma = ring_dma;
 
-	if (!tmpptr) {
+	if (!rrpriv->rx_ring) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	tmpptr = pci_alloc_consistent(pdev, EVT_RING_SIZE, &ring_dma);
-	rrpriv->evt_ring = tmpptr;
+	rrpriv->evt_ring = pci_alloc_consistent(pdev, EVT_RING_SIZE, &ring_dma);
 	rrpriv->evt_ring_dma = ring_dma;
 
-	if (!tmpptr) {
+	if (!trrpriv->evt_ring) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -1192,24 +1188,22 @@ static int rr_open(struct net_device *dev)
 		goto error;
 	}
 
-	rrpriv->rx_ctrl = pci_alloc_consistent(pdev,
-					       256 * sizeof(struct ring_ctrl),
-					       &dma_addr);
+	rrpriv->rx_ctrl = pci_zalloc_consistent(pdev,
+						256 * sizeof(struct ring_ctrl),
+						&dma_addr);
 	if (!rrpriv->rx_ctrl) {
 		ecode = -ENOMEM;
 		goto error;
 	}
 	rrpriv->rx_ctrl_dma = dma_addr;
-	memset(rrpriv->rx_ctrl, 0, 256*sizeof(struct ring_ctrl));
 
-	rrpriv->info = pci_alloc_consistent(pdev, sizeof(struct rr_info),
-					    &dma_addr);
+	rrpriv->info = pci_zalloc_consistent(pdev, sizeof(struct rr_info),
+					     &dma_addr);
 	if (!rrpriv->info) {
 		ecode = -ENOMEM;
 		goto error;
 	}
 	rrpriv->info_dma = dma_addr;
-	memset(rrpriv->info, 0, sizeof(struct rr_info));
 	wmb();
 
 	spin_lock_irqsave(&rrpriv->lock, flags);
-- 
2.7.0
