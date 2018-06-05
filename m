Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeFEKGm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:06:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33373 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751590AbeFEKGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:06:41 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: fddi: fix a possible null-ptr-deref
Date: Tue, 5 Jun 2018 18:06:27 +0800
Message-ID: <20180605100627.16184-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bp->SharedMemAddr is set to NULL while bp->SharedMemSize less than 0,
then memset will trigger null-ptr-deref.

Fix it use pci_zalloc_consistent when bp->SharedMemSize is greater than 0.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/fddi/skfp/skfddi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/fddi/skfp/skfddi.c b/drivers/net/fddi/skfp/skfddi.c
index 2414f1d..90164e0 100644
--- a/drivers/net/fddi/skfp/skfddi.c
+++ b/drivers/net/fddi/skfp/skfddi.c
@@ -407,23 +407,21 @@ static  int skfp_driver_init(struct net_device *dev)
 	if (bp->SharedMemSize > 0) {
 		bp->SharedMemSize += 16;	// for descriptor alignment
 
-		bp->SharedMemAddr = pci_alloc_consistent(&bp->pdev,
-							 bp->SharedMemSize,
-							 &bp->SharedMemDMA);
+		bp->SharedMemAddr = pci_zalloc_consistent(&bp->pdev,
+							  bp->SharedMemSize,
+							  &bp->SharedMemDMA);
 		if (!bp->SharedMemAddr) {
 			printk("could not allocate mem for ");
 			printk("hardware module: %ld byte\n",
 			       bp->SharedMemSize);
 			goto fail;
 		}
-		bp->SharedMemHeap = 0;	// Nothing used yet.
 
 	} else {
 		bp->SharedMemAddr = NULL;
-		bp->SharedMemHeap = 0;
 	}			// SharedMemSize > 0
 
-	memset(bp->SharedMemAddr, 0, bp->SharedMemSize);
+	bp->SharedMemHeap = 0;
 
 	card_stop(smc);		// Reset adapter.
 
-- 
2.7.0
