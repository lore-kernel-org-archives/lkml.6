Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeCMT5h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:57:37 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:16488 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932448AbeCMT5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:57:36 -0400
From: Ronak Doshi <doshir@vmware.com>
To: <netdev@vger.kernel.org>
CC: <rachel_lunnon@stormagic.com>, Ronak Doshi <doshir@vmware.com>,
        Shrikrishna Khare <skhare@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/2] vmxnet3: use correct flag to indicate LRO feature
Date: Tue, 13 Mar 2018 12:41:41 -0700
Message-ID: <20180313194141.12913-1-doshir@vmware.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'Commit 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2
(fwd)")' introduced a flag "lro" in structure vmxnet3_adapter which is
used to indicate whether LRO is enabled or not. However, the patch
did not set the flag and hence it was never exercised.

So, when LRO is enabled, it resulted in poor TCP performance due to
delayed acks. This issue is seen with packets which are larger than
the mss getting a delayed ack rather than an immediate ack, thus
resulting in high latency.

This patch removes the lro flag and directly uses device features
against NETIF_F_LRO to check if lro is enabled.

Reported-by: Rachel Lunnon <rachel_lunnon@stormagic.com>
Signed-off-by: Ronak Doshi <doshir@vmware.com>
Acked-by: Shrikrishna Khare <skhare@vmware.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 3 ++-
 drivers/net/vmxnet3/vmxnet3_int.h | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 052eef2f729f..86c4d6e4dfaa 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1473,7 +1473,8 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 			vmxnet3_rx_csum(adapter, skb,
 					(union Vmxnet3_GenericDesc *)rcd);
 			skb->protocol = eth_type_trans(skb, adapter->netdev);
-			if (!rcd->tcp || !adapter->lro)
+			if (!rcd->tcp ||
+			    !(adapter->netdev->features & NETIF_F_LRO))
 				goto not_lro;
 
 			if (segCnt != 0 && mss != 0) {
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index b94fdfd0b6f1..99387a4a20a8 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,10 +69,10 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.4.12.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.4.13.0-k"
 
 /* a 32-bit int, each byte encode a verion number in VMXNET3_DRIVER_VERSION */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01040c00
+#define VMXNET3_DRIVER_VERSION_NUM      0x01040d00
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
@@ -343,7 +343,6 @@ struct vmxnet3_adapter {
 	u8                              version;
 
 	bool				rxcsum;
-	bool				lro;
 
 #ifdef VMXNET3_RSS
 	struct UPT1_RSSConf		*rss_conf;
-- 
2.11.0
