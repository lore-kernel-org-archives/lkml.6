Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeD1VvH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 17:51:07 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41174 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeD1VvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 17:51:05 -0400
X-Google-Smtp-Source: AB8JxZqOEKu7Y0W/SkVRA5+ID0gXCIrJYcVf6sVkytf5xe7BjTjn77uOJ1e86PZkLUE9/CSrJ7beMQ==
From: Frank Mori Hess <fmh6jj@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com
Subject: [PATCH] Revert "dmaengine: pl330: add DMA_PAUSE feature"
Date: Sat, 28 Apr 2018 17:50:58 -0400
Message-ID: <2484918.HKVQc3yJkt@bear>
User-Agent: KMail/5.2.3 (Linux/4.9.0-6-amd64; KDE/5.28.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 88987d2c7534a0269f567fb101e6d71a08f0f01d.

The pl330.c pause implementation violates the dmaengine requirement
for no data loss, since it relies on the DMAKILL
instruction.  However, DMAKILL discards in-flight data from the
dma controller's fifo.  This is documented in the dma-330 manual
and I have observed it with hardware doing device-to-memory burst
transfers.  The discarded data may or may not show up in the
residue count, depending on timing (resulting in data corruption
effectively).

Signed-off-by: Frank Mori Hess <fmh6jj@gmail.com>
---
 drivers/dma/pl330.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 6237069001c4..f802bd3b0481 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2290,33 +2290,6 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
-/*
- * We don't support DMA_RESUME command because of hardware
- * limitations, so after pausing the channel we cannot restore
- * it to active state. We have to terminate channel and setup
- * DMA transfer again. This pause feature was implemented to
- * allow safely read residue before channel termination.
- */
-static int pl330_pause(struct dma_chan *chan)
-{
-	struct dma_pl330_chan *pch = to_pchan(chan);
-	struct pl330_dmac *pl330 = pch->dmac;
-	unsigned long flags;
-
-	pm_runtime_get_sync(pl330->ddma.dev);
-	spin_lock_irqsave(&pch->lock, flags);
-
-	spin_lock(&pl330->lock);
-	_stop(pch->thread);
-	spin_unlock(&pl330->lock);
-
-	spin_unlock_irqrestore(&pch->lock, flags);
-	pm_runtime_mark_last_busy(pl330->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
-
-	return 0;
-}
-
 static void pl330_free_chan_resources(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
@@ -3027,7 +3000,6 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
 	pd->device_config = pl330_config;
-	pd->device_pause = pl330_pause;
 	pd->device_terminate_all = pl330_terminate_all;
 	pd->device_issue_pending = pl330_issue_pending;
 	pd->src_addr_widths = PL330_DMA_BUSWIDTHS;
-- 
2.11.0
