Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeCPVsn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 17:48:43 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:58591 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751269AbeCPVsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 17:48:39 -0400
From: Ronak Doshi <doshir@vmware.com>
To: <netdev@vger.kernel.org>
CC: <ntanaka@vmware.com>, Ronak Doshi <doshir@vmware.com>,
        Shrikrishna Khare <skhare@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net 1/2] vmxnet3: avoid xmit reset due to a race in vmxnet3
Date: Fri, 16 Mar 2018 14:47:54 -0700
Message-ID: <20180316214754.20650-1-doshir@vmware.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field txNumDeferred is used by the driver to keep track of the number
of packets it has pushed to the emulation. The driver increments it on
pushing the packet to the emulation and the emulation resets it to 0 at
the end of the transmit.

There is a possibility of a race either when (a) ESX is under heavy load or
(b) workload inside VM is of low packet rate.

This race results in xmit hangs when network coalescing is disabled. This
change creates a local copy of txNumDeferred and uses it to perform ring
arithmetic.

Reported-by: Noriho Tanaka <ntanaka@vmware.com>
Signed-off-by: Ronak Doshi <doshir@vmware.com>
Acked-by: Shrikrishna Khare <skhare@vmware.com>
---
Changes in v2:
 - Used lowercase letters for local variables

 drivers/net/vmxnet3/vmxnet3_drv.c | 13 ++++++++-----
 drivers/net/vmxnet3/vmxnet3_int.h |  4 ++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 8b39c160743d..b466a422b72d 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -977,6 +977,8 @@ vmxnet3_tq_xmit(struct sk_buff *skb, struct vmxnet3_tx_queue *tq,
 {
 	int ret;
 	u32 count;
+	int num_pkts;
+	int tx_num_deferred;
 	unsigned long flags;
 	struct vmxnet3_tx_ctx ctx;
 	union Vmxnet3_GenericDesc *gdesc;
@@ -1075,12 +1077,12 @@ vmxnet3_tq_xmit(struct sk_buff *skb, struct vmxnet3_tx_queue *tq,
 #else
 	gdesc = ctx.sop_txd;
 #endif
+	tx_num_deferred = le32_to_cpu(tq->shared->txNumDeferred);
 	if (ctx.mss) {
 		gdesc->txd.hlen = ctx.eth_ip_hdr_size + ctx.l4_hdr_size;
 		gdesc->txd.om = VMXNET3_OM_TSO;
 		gdesc->txd.msscof = ctx.mss;
-		le32_add_cpu(&tq->shared->txNumDeferred, (skb->len -
-			     gdesc->txd.hlen + ctx.mss - 1) / ctx.mss);
+		num_pkts = (skb->len - gdesc->txd.hlen + ctx.mss - 1) / ctx.mss;
 	} else {
 		if (skb->ip_summed == CHECKSUM_PARTIAL) {
 			gdesc->txd.hlen = ctx.eth_ip_hdr_size;
@@ -1091,8 +1093,10 @@ vmxnet3_tq_xmit(struct sk_buff *skb, struct vmxnet3_tx_queue *tq,
 			gdesc->txd.om = 0;
 			gdesc->txd.msscof = 0;
 		}
-		le32_add_cpu(&tq->shared->txNumDeferred, 1);
+		num_pkts = 1;
 	}
+	le32_add_cpu(&tq->shared->txNumDeferred, num_pkts);
+	tx_num_deferred += num_pkts;
 
 	if (skb_vlan_tag_present(skb)) {
 		gdesc->txd.ti = 1;
@@ -1118,8 +1122,7 @@ vmxnet3_tq_xmit(struct sk_buff *skb, struct vmxnet3_tx_queue *tq,
 
 	spin_unlock_irqrestore(&tq->tx_lock, flags);
 
-	if (le32_to_cpu(tq->shared->txNumDeferred) >=
-					le32_to_cpu(tq->shared->txThreshold)) {
+	if (tx_num_deferred >= le32_to_cpu(tq->shared->txThreshold)) {
 		tq->shared->txNumDeferred = 0;
 		VMXNET3_WRITE_BAR0_REG(adapter,
 				       VMXNET3_REG_TXPROD + tq->qid * 8,
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 5ba222920e80..b94fdfd0b6f1 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,10 +69,10 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.4.11.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.4.12.0-k"
 
 /* a 32-bit int, each byte encode a verion number in VMXNET3_DRIVER_VERSION */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01040b00
+#define VMXNET3_DRIVER_VERSION_NUM      0x01040c00
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
-- 
2.11.0
