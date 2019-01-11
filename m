Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77E8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9909921848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219639;
	bh=0bo/QvKv0hAL6e1gqYT124c3dEZ+uWPSbX95hocvWdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fn07CUB/nbkBM+Jzk+T2ceHi1z7/XSWCJ7NVf0+5oSay4R2Shsn0DqPVnHV81AqA4
	 3zOgfjL+tRjGu5ijVq5D2naWHF4wawRshsxdNHLvRqswwT3NUqAz4a4sOrGo7IZEaG
	 443j1zfqcLceIQjZKMpxJtek6PG+1wwGpz8nvMOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbfAKPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:13:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733069AbfAKOOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:14:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D47120874;
        Fri, 11 Jan 2019 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216075;
        bh=0bo/QvKv0hAL6e1gqYT124c3dEZ+uWPSbX95hocvWdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHjpicHxd/ug32AtPQ16nZESEyhWudUAA9BaaTxvsJJdnrUX0wey3B6pBeXznZ4Ly
         wQj87w1MtoUQojt0TNh56sGTeETmLstZNKv6PQBni27mAw9GwSYlwMC/t2jKzvgBZr
         xSg2yzgRxBb/rjJR3ZbOOjp6fZkiqs3qYdjrZSiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3.18 04/47] mmc: omap_hsmmc: fix DMA API warning
Date:   Fri, 11 Jan 2019 15:07:49 +0100
Message-Id: <20190111130956.733599374@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/omap_hsmmc.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2141,7 +2141,6 @@ static int omap_hsmmc_probe(struct platf
 	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
 	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_req_size;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
@@ -2198,6 +2197,17 @@ static int omap_hsmmc_probe(struct platf
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


