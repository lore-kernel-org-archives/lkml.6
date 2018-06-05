Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeFEMdC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:33:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751948AbeFEMcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:32:25 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jcliburn@gmail.com>, <chris.snook@gmail.com>, <benve@cisco.com>,
        <jdmason@kudzu.us>, <chessman@tux.org>, <jes@trained-monkey.org>,
        <rahul.verma@cavium.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 2/6] net: atheros: use pci_zalloc_consistent
Date: Tue, 5 Jun 2018 20:28:47 +0800
Message-ID: <20180605122851.23912-3-yuehaibing@huawei.com>
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

use pci_zalloc_consistent to remove unnecessary memset

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c | 2 +-
 drivers/net/ethernet/atheros/atlx/atl1.c        | 8 +++-----
 drivers/net/ethernet/atheros/atlx/atl2.c        | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 9dc6da0..41da42f 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -829,7 +829,7 @@ static int atl1e_setup_ring_resources(struct atl1e_adapter *adapter)
 						       &adapter->ring_dma);
 	if (adapter->ring_vir_addr == NULL) {
 		netdev_err(adapter->netdev,
-			   "pci_alloc_consistent failed, size = D%d\n", size);
+			   "pci_zalloc_consistent failed, size = D%d\n", size);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index b81fbf11..c72ef33 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -1069,16 +1069,14 @@ static s32 atl1_setup_ring_resources(struct atl1_adapter *adapter)
 		+ sizeof(struct stats_msg_block)
 		+ 40;
 
-	ring_header->desc = pci_alloc_consistent(pdev, ring_header->size,
-		&ring_header->dma);
+	ring_header->desc = pci_zalloc_consistent(pdev, ring_header->size,
+						  &ring_header->dma);
 	if (unlikely(!ring_header->desc)) {
 		if (netif_msg_drv(adapter))
-			dev_err(&pdev->dev, "pci_alloc_consistent failed\n");
+			dev_err(&pdev->dev, "pci_zalloc_consistent failed\n");
 		goto err_nomem;
 	}
 
-	memset(ring_header->desc, 0, ring_header->size);
-
 	/* init TPD ring */
 	tpd_ring->dma = ring_header->dma;
 	offset = (tpd_ring->dma & 0x7) ? (8 - (ring_header->dma & 0x7)) : 0;
diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index db4bcc5..d430dc9 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -300,11 +300,10 @@ static s32 atl2_setup_ring_resources(struct atl2_adapter *adapter)
 		adapter->txs_ring_size * 4 + 7 +	/* dword align */
 		adapter->rxd_ring_size * 1536 + 127;	/* 128bytes align */
 
-	adapter->ring_vir_addr = pci_alloc_consistent(pdev, size,
-		&adapter->ring_dma);
+	adapter->ring_vir_addr = pci_zalloc_consistent(pdev, size,
+						       &adapter->ring_dma);
 	if (!adapter->ring_vir_addr)
 		return -ENOMEM;
-	memset(adapter->ring_vir_addr, 0, adapter->ring_size);
 
 	/* Init TXD Ring */
 	adapter->txd_dma = adapter->ring_dma ;
-- 
2.7.0
