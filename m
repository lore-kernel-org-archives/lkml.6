Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A27020675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999554;
	bh=iH34csVshxT0clUSATYd0b4CJ6kbq0MfULm0z/o7imc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XG9OW7paroBMty01H+Yxynm5MTKowm8q+umZEtz9qiynNm78zqJe1uI0owZH+7nHT
	 lCaWbwV7/WTK+ZPt94z0YabEjKAuOA51LmjS8OyxQXm45BTAi+3hVbTspLUL8QlXXC
	 FsmO5YGXvmi4uvuYQ161WY7RrV4HpxNDt6Gxn1BA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbeL1MRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732926AbeL1MR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:17:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29FBE20675;
        Fri, 28 Dec 2018 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999445;
        bh=iH34csVshxT0clUSATYd0b4CJ6kbq0MfULm0z/o7imc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+Vo9GEXBs2hfZGpBgo8d8LlZ7UneJhDNV6B82KC4PQkbUlESbKAcmLjKJBlZhQWW
         tj1hKbTn/nEt0mq0K29WkJsbEeo/kYSfbttaoO0u1ofe5f5oAfhkxxqclLKaDprOOO
         KtIAN6/AsrCtqvG6IN6+9VupfXjpim8jhc8iSfWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.9 14/22] mmc: omap_hsmmc: fix DMA API warning
Date:   Fri, 28 Dec 2018 12:52:51 +0100
Message-Id: <20181228113127.130782910@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
References: <20181228113126.144310132@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2105,7 +2105,6 @@ static int omap_hsmmc_probe(struct platf
 	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
 	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_req_size;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
@@ -2135,6 +2134,17 @@ static int omap_hsmmc_probe(struct platf
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


