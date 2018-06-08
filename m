Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rklOCObxGVv+aAAAmS7hNA
	; Fri, 08 Jun 2018 03:03:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 052C2607DC; Fri,  8 Jun 2018 03:03:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E22BD601D2;
	Fri,  8 Jun 2018 03:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E22BD601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeFHDC6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 23:02:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752285AbeFHDC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 23:02:56 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF02851EEA6B7;
        Fri,  8 Jun 2018 11:02:41 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Fri, 8 Jun 2018
 11:02:34 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 net] net: fddi: fix a possible null-ptr-deref
Date: Fri, 8 Jun 2018 10:58:25 +0800
Message-ID: <20180608025825.25716-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bp->SharedMemAddr is set to NULL while bp->SharedMemSize lesser-or-equal 0,
then memset will trigger null-ptr-deref.

fix it by replacing pci_alloc_consistent with dma_zalloc_coherent.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v1->v2: move from pci_dma* to dma_* as Christoph suggested
---

 drivers/net/fddi/skfp/skfddi.c | 55 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/net/fddi/skfp/skfddi.c b/drivers/net/fddi/skfp/skfddi.c
index 2414f1d..72433f3e 100644
--- a/drivers/net/fddi/skfp/skfddi.c
+++ b/drivers/net/fddi/skfp/skfddi.c
@@ -297,11 +297,11 @@ static int skfp_init_one(struct pci_dev *pdev,
 	return 0;
 err_out5:
 	if (smc->os.SharedMemAddr) 
-		pci_free_consistent(pdev, smc->os.SharedMemSize,
-				    smc->os.SharedMemAddr, 
-				    smc->os.SharedMemDMA);
-	pci_free_consistent(pdev, MAX_FRAME_SIZE,
-			    smc->os.LocalRxBuffer, smc->os.LocalRxBufferDMA);
+		dma_free_coherent(&pdev->dev, smc->os.SharedMemSize,
+				  smc->os.SharedMemAddr,
+				  smc->os.SharedMemDMA);
+	dma_free_coherent(&pdev->dev, MAX_FRAME_SIZE,
+			  smc->os.LocalRxBuffer, smc->os.LocalRxBufferDMA);
 err_out4:
 	free_netdev(dev);
 err_out3:
@@ -328,17 +328,17 @@ static void skfp_remove_one(struct pci_dev *pdev)
 	unregister_netdev(p);
 
 	if (lp->os.SharedMemAddr) {
-		pci_free_consistent(&lp->os.pdev,
-				    lp->os.SharedMemSize,
-				    lp->os.SharedMemAddr,
-				    lp->os.SharedMemDMA);
+		dma_free_coherent(&pdev->dev,
+				  lp->os.SharedMemSize,
+				  lp->os.SharedMemAddr,
+				  lp->os.SharedMemDMA);
 		lp->os.SharedMemAddr = NULL;
 	}
 	if (lp->os.LocalRxBuffer) {
-		pci_free_consistent(&lp->os.pdev,
-				    MAX_FRAME_SIZE,
-				    lp->os.LocalRxBuffer,
-				    lp->os.LocalRxBufferDMA);
+		dma_free_coherent(&pdev->dev,
+				  MAX_FRAME_SIZE,
+				  lp->os.LocalRxBuffer,
+				  lp->os.LocalRxBufferDMA);
 		lp->os.LocalRxBuffer = NULL;
 	}
 #ifdef MEM_MAPPED_IO
@@ -394,7 +394,9 @@ static  int skfp_driver_init(struct net_device *dev)
 	spin_lock_init(&bp->DriverLock);
 	
 	// Allocate invalid frame
-	bp->LocalRxBuffer = pci_alloc_consistent(&bp->pdev, MAX_FRAME_SIZE, &bp->LocalRxBufferDMA);
+	bp->LocalRxBuffer = dma_alloc_coherent(&bp->pdev.dev, MAX_FRAME_SIZE,
+					       &bp->LocalRxBufferDMA,
+					       GFP_ATOMIC);
 	if (!bp->LocalRxBuffer) {
 		printk("could not allocate mem for ");
 		printk("LocalRxBuffer: %d byte\n", MAX_FRAME_SIZE);
@@ -407,23 +409,22 @@ static  int skfp_driver_init(struct net_device *dev)
 	if (bp->SharedMemSize > 0) {
 		bp->SharedMemSize += 16;	// for descriptor alignment
 
-		bp->SharedMemAddr = pci_alloc_consistent(&bp->pdev,
-							 bp->SharedMemSize,
-							 &bp->SharedMemDMA);
+		bp->SharedMemAddr = dma_zalloc_coherent(&bp->pdev.dev,
+							bp->SharedMemSize,
+							&bp->SharedMemDMA,
+							GFP_ATOMIC);
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
-	}			// SharedMemSize > 0
+	}
 
-	memset(bp->SharedMemAddr, 0, bp->SharedMemSize);
+	bp->SharedMemHeap = 0;
 
 	card_stop(smc);		// Reset adapter.
 
@@ -442,15 +443,15 @@ static  int skfp_driver_init(struct net_device *dev)
 
 fail:
 	if (bp->SharedMemAddr) {
-		pci_free_consistent(&bp->pdev,
-				    bp->SharedMemSize,
-				    bp->SharedMemAddr,
-				    bp->SharedMemDMA);
+		dma_free_coherent(&bp->pdev.dev,
+				  bp->SharedMemSize,
+				  bp->SharedMemAddr,
+				  bp->SharedMemDMA);
 		bp->SharedMemAddr = NULL;
 	}
 	if (bp->LocalRxBuffer) {
-		pci_free_consistent(&bp->pdev, MAX_FRAME_SIZE,
-				    bp->LocalRxBuffer, bp->LocalRxBufferDMA);
+		dma_free_coherent(&bp->pdev.dev, MAX_FRAME_SIZE,
+				  bp->LocalRxBuffer, bp->LocalRxBufferDMA);
 		bp->LocalRxBuffer = NULL;
 	}
 	return err;
-- 
2.7.0
