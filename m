Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeDJNSM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:18:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42366 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752936AbeDJNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:18:10 -0400
X-Google-Smtp-Source: AIpwx4/pLjwS5jXd3VlKWqKf1i4ktF4hv69Y6LQ6IdyDXmateAWryQcZqfawY+ZkYYLRQONElmAyZQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] ntb: ntb_transport: Replace GFP_ATOMIC with GFP_KERNEL in ntb_transport_create_queue
Date: Tue, 10 Apr 2018 21:17:54 +0800
Message-Id: <1523366274-31737-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ntb_transport_create_queue() is never called in atomic context.

ntb_transport_create_queue() is only called by ntb_netdev_probe(),
which is set as ".probe" in struct ntb_transport_client.

Despite never getting called from atomic context,
ntb_transport_create_queue() calls kzalloc_node() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f58d8e3..2c0c8bc 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1825,7 +1825,7 @@ struct ntb_transport_qp *
 		qp->rx_dma_chan ? "DMA" : "CPU");
 
 	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
-		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
+		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
 		if (!entry)
 			goto err1;
 
@@ -1836,7 +1836,7 @@ struct ntb_transport_qp *
 	qp->rx_alloc_entry = NTB_QP_DEF_NUM_ENTRIES;
 
 	for (i = 0; i < qp->tx_max_entry; i++) {
-		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
+		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
 		if (!entry)
 			goto err2;
 
-- 
1.9.1
