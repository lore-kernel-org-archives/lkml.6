Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeENMO4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:14:56 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:12801 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752153AbeENMOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:14:54 -0400
From: <hpreg@vmware.com>
To: <netdev@vger.kernel.org>
CC: Regis Duchesne <hpreg@vmware.com>, Ronak Doshi <doshir@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/2] vmxnet3: use DMA memory barriers where required
Date: Mon, 14 May 2018 08:14:49 -0400
Message-ID: <1526300090-78546-1-git-send-email-hpreg@vmware.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gen bits must be read first from (resp. written last to) DMA memory.
The proper way to enforce this on Linux is to call dma_rmb() (resp.
dma_wmb()).

Signed-off-by: Regis Duchesne <hpreg@vmware.com>
Acked-by: Ronak Doshi <doshir@vmware.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 22 ++++++++++++++++++++++
 drivers/net/vmxnet3/vmxnet3_int.h |  4 ++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index ed58685..27a9bb8 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -369,6 +369,11 @@ vmxnet3_tq_tx_complete(struct vmxnet3_tx_queue *tq,
 
 	gdesc = tq->comp_ring.base + tq->comp_ring.next2proc;
 	while (VMXNET3_TCD_GET_GEN(&gdesc->tcd) == tq->comp_ring.gen) {
+		/* Prevent any &gdesc->tcd field from being (speculatively)
+		 * read before (&gdesc->tcd)->gen is read.
+		 */
+		dma_rmb();
+
 		completed += vmxnet3_unmap_pkt(VMXNET3_TCD_GET_TXIDX(
 					       &gdesc->tcd), tq, adapter->pdev,
 					       adapter);
@@ -1103,6 +1108,11 @@ vmxnet3_tq_xmit(struct sk_buff *skb, struct vmxnet3_tx_queue *tq,
 		gdesc->txd.tci = skb_vlan_tag_get(skb);
 	}
 
+	/* Ensure that the write to (&gdesc->txd)->gen will be observed after
+	 * all other writes to &gdesc->txd.
+	 */
+	dma_wmb();
+
 	/* finally flips the GEN bit of the SOP desc. */
 	gdesc->dword[2] = cpu_to_le32(le32_to_cpu(gdesc->dword[2]) ^
 						  VMXNET3_TXD_GEN);
@@ -1298,6 +1308,12 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 			 */
 			break;
 		}
+
+		/* Prevent any rcd field from being (speculatively) read before
+		 * rcd->gen is read.
+		 */
+		dma_rmb();
+
 		BUG_ON(rcd->rqID != rq->qid && rcd->rqID != rq->qid2 &&
 		       rcd->rqID != rq->dataRingQid);
 		idx = rcd->rxdIdx;
@@ -1528,6 +1544,12 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 		ring->next2comp = idx;
 		num_to_alloc = vmxnet3_cmd_ring_desc_avail(ring);
 		ring = rq->rx_ring + ring_idx;
+
+		/* Ensure that the writes to rxd->gen bits will be observed
+		 * after all other writes to rxd objects.
+		 */
+		dma_wmb();
+
 		while (num_to_alloc) {
 			vmxnet3_getRxDesc(rxd, &ring->base[ring->next2fill].rxd,
 					  &rxCmdDesc);
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index b379bed..a2c554f 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,12 +69,12 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.4.15.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.4.16.0-k"
 
 /* Each byte of this 32-bit integer encodes a version number in
  * VMXNET3_DRIVER_VERSION_STRING.
  */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01040f00
+#define VMXNET3_DRIVER_VERSION_NUM      0x01041000
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
-- 
2.7.4
