Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D69C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F59C2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfBCOUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55552 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728979AbfBCOUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:47 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdZ-0006M0-P8; Sun, 03 Feb 2019 14:20:45 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9t-0007Qh-MN; Sun, 03 Feb 2019 14:50:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.907787503@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 287/305] mmc: omap_hsmmc: fix DMA API warning
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

commit 0b479790684192ab7024ce6a621f93f6d0a64d92 upstream.

While booting with rootfs on MMC, the following warning is encountered
on OMAP4430:

omap-dma-engine 4a056000.dma-controller: DMA-API: mapping sg segment longer than device claims to support [len=69632] [max=65536]

This is because the DMA engine has a default maximum segment size of 64K
but HSMMC sets:

        mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
        mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
        mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
        mmc->max_seg_size = mmc->max_req_size;

which ends up telling the block layer that we support a maximum segment
size of 65535*512, which exceeds the advertised DMA engine capabilities.

Fix this by clamping the maximum segment size to the lower of the
maximum request size and of the DMA engine device used for either DMA
channel.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mmc/host/omap_hsmmc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1964,7 +1964,6 @@ static int omap_hsmmc_probe(struct platf
 	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
 	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_req_size;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
@@ -2021,6 +2020,17 @@ static int omap_hsmmc_probe(struct platf
 		goto err_irq;
 	}
 
+	/*
+	 * Limit the maximum segment size to the lower of the request size
+	 * and the DMA engine device segment size limits.  In reality, with
+	 * 32-bit transfers, the DMA engine can do longer segments than this
+	 * but there is no way to represent that in the DMA model - if we
+	 * increase this figure here, we get warnings from the DMA API debug.
+	 */
+	mmc->max_seg_size = min3(mmc->max_req_size,
+			dma_get_max_seg_size(host->rx_chan->device->dev),
+			dma_get_max_seg_size(host->tx_chan->device->dev));
+
 	/* Request IRQ for MMC operations */
 	ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
 			mmc_hostname(mmc), host);

