Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeFEMc1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:32:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48352 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752021AbeFEMcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:32:24 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jcliburn@gmail.com>, <chris.snook@gmail.com>, <benve@cisco.com>,
        <jdmason@kudzu.us>, <chessman@tux.org>, <jes@trained-monkey.org>,
        <rahul.verma@cavium.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 4/6] netxen_nic: use pci_zalloc_consistent
Date: Tue, 5 Jun 2018 20:28:49 +0800
Message-ID: <20180605122851.23912-5-yuehaibing@huawei.com>
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
Also remove a local intermediate pointer 'void *addr'.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 .../net/ethernet/qlogic/netxen/netxen_nic_ctx.c    | 26 +++++++++-------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
index 7503aa2..096047e 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
@@ -267,7 +267,6 @@ nx_fw_cmd_set_gbe_port(struct netxen_adapter *adapter,
 static int
 nx_fw_cmd_create_rx_ctx(struct netxen_adapter *adapter)
 {
-	void *addr;
 	nx_hostrq_rx_ctx_t *prq;
 	nx_cardrsp_rx_ctx_t *prsp;
 	nx_hostrq_rds_ring_t *prq_rds;
@@ -297,19 +296,17 @@ nx_fw_cmd_create_rx_ctx(struct netxen_adapter *adapter)
 	rsp_size =
 		SIZEOF_CARDRSP_RX(nx_cardrsp_rx_ctx_t, nrds_rings, nsds_rings);
 
-	addr = pci_alloc_consistent(adapter->pdev,
-				rq_size, &hostrq_phys_addr);
-	if (addr == NULL)
+	prq = pci_alloc_consistent(adapter->pdev,
+				   rq_size, &hostrq_phys_addr);
+	if (!prq)
 		return -ENOMEM;
-	prq = addr;
 
-	addr = pci_alloc_consistent(adapter->pdev,
-			rsp_size, &cardrsp_phys_addr);
-	if (addr == NULL) {
+	prsp = pci_alloc_consistent(adapter->pdev,
+				    rsp_size, &cardrsp_phys_addr);
+	if (!prsp) {
 		err = -ENOMEM;
 		goto out_free_rq;
 	}
-	prsp = addr;
 
 	prq->host_rsp_dma_addr = cpu_to_le64(cardrsp_phys_addr);
 
@@ -445,23 +442,20 @@ nx_fw_cmd_create_tx_ctx(struct netxen_adapter *adapter)
 	struct netxen_cmd_args cmd;
 
 	rq_size = SIZEOF_HOSTRQ_TX(nx_hostrq_tx_ctx_t);
-	rq_addr = pci_alloc_consistent(adapter->pdev,
-		rq_size, &rq_phys_addr);
+	rq_addr = pci_zalloc_consistent(adapter->pdev,
+					rq_size, &rq_phys_addr);
 	if (!rq_addr)
 		return -ENOMEM;
 
 	rsp_size = SIZEOF_CARDRSP_TX(nx_cardrsp_tx_ctx_t);
-	rsp_addr = pci_alloc_consistent(adapter->pdev,
-		rsp_size, &rsp_phys_addr);
+	rsp_addr = pci_zalloc_consistent(adapter->pdev,
+					 rsp_size, &rsp_phys_addr);
 	if (!rsp_addr) {
 		err = -ENOMEM;
 		goto out_free_rq;
 	}
 
-	memset(rq_addr, 0, rq_size);
 	prq = rq_addr;
-
-	memset(rsp_addr, 0, rsp_size);
 	prsp = rsp_addr;
 
 	prq->host_rsp_dma_addr = cpu_to_le64(rsp_phys_addr);
-- 
2.7.0
