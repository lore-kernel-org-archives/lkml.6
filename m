Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeFEMdt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:33:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48364 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752022AbeFEMcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:32:24 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jcliburn@gmail.com>, <chris.snook@gmail.com>, <benve@cisco.com>,
        <jdmason@kudzu.us>, <chessman@tux.org>, <jes@trained-monkey.org>,
        <rahul.verma@cavium.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 3/6] net: neterion: use pci_zalloc_consistent
Date: Tue, 5 Jun 2018 20:28:48 +0800
Message-ID: <20180605122851.23912-4-yuehaibing@huawei.com>
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

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/neterion/s2io.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index b8983e7..4e8a2fd 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -733,8 +733,8 @@ static int init_shared_mem(struct s2io_nic *nic)
 
 			rx_blocks = &ring->rx_blocks[j];
 			size = SIZE_OF_BLOCK;	/* size is always page size */
-			tmp_v_addr = pci_alloc_consistent(nic->pdev, size,
-							  &tmp_p_addr);
+			tmp_v_addr = pci_zalloc_consistent(nic->pdev, size,
+							   &tmp_p_addr);
 			if (tmp_v_addr == NULL) {
 				/*
 				 * In case of failure, free_shared_mem()
@@ -746,7 +746,6 @@ static int init_shared_mem(struct s2io_nic *nic)
 				return -ENOMEM;
 			}
 			mem_allocated += size;
-			memset(tmp_v_addr, 0, size);
 
 			size = sizeof(struct rxd_info) *
 				rxd_count[nic->rxd_mode];
@@ -835,8 +834,8 @@ static int init_shared_mem(struct s2io_nic *nic)
 	/* Allocation and initialization of Statistics block */
 	size = sizeof(struct stat_block);
 	mac_control->stats_mem =
-		pci_alloc_consistent(nic->pdev, size,
-				     &mac_control->stats_mem_phy);
+		pci_zalloc_consistent(nic->pdev, size,
+				      &mac_control->stats_mem_phy);
 
 	if (!mac_control->stats_mem) {
 		/*
@@ -851,7 +850,6 @@ static int init_shared_mem(struct s2io_nic *nic)
 
 	tmp_v_addr = mac_control->stats_mem;
 	mac_control->stats_info = tmp_v_addr;
-	memset(tmp_v_addr, 0, size);
 	DBG_PRINT(INIT_DBG, "%s: Ring Mem PHY: 0x%llx\n",
 		dev_name(&nic->pdev->dev), (unsigned long long)tmp_p_addr);
 	mac_control->stats_info->sw_stat.mem_allocated += mem_allocated;
-- 
2.7.0
