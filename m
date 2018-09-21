Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A32ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804682154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qG2QA29o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804682154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbeIUHpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:45:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47802 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeIUHpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SE0LAd9bkgUOGHzag7DwyQO86gYgIQk6KRh4FYj6vKI=; b=qG2QA29oxLBb
        uU0Km43XXCuXSTuh0Wj+rQGzgbpXSQqVWj7bDFy/5t7hj/Zh3fNR0RmmRaUU+9K+x6+p4q4oTDMBx
        eplppJclYPHm1rLenma/sx25qH3OrJEBAYHYBxIHG3gmO/sHgJdAR46ormxuMmrKB0ntLfDgk4m1Z
        v2UWY=;
Received: from [209.82.80.116] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g3AiX-0008HH-US; Fri, 21 Sep 2018 01:58:50 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4AEE4440078; Fri, 21 Sep 2018 02:58:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: pic32: Use proper enum in dmaengine_prep_slave_rg" to the spi tree
In-Reply-To:  <20180920231337.24603-1-natechancellor@gmail.com>
Message-Id: <20180921015848.4AEE4440078@finisterre.ee.mobilebroadband>
Date:   Fri, 21 Sep 2018 02:58:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pic32: Use proper enum in dmaengine_prep_slave_rg

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 8cfde7847d5ed0bb77bace41519572963e43cd17 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 20 Sep 2018 16:13:37 -0700
Subject: [PATCH] spi: pic32: Use proper enum in dmaengine_prep_slave_rg

Clang warns when one enumerated type is converted implicitly to another:

drivers/spi/spi-pic32.c:323:8: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
                                          DMA_FROM_DEVICE,
                                          ^~~~~~~~~~~~~~~
drivers/spi/spi-pic32.c:333:8: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
                                          DMA_TO_DEVICE,
                                          ^~~~~~~~~~~~~
2 warnings generated.

Use the proper enums from dma_transfer_direction (DMA_FROM_DEVICE =
DMA_DEV_TO_MEM = 2, DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1) to satify Clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/159
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pic32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 46ff76193ee1..131849adc570 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -320,7 +320,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 	desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
 					  xfer->rx_sg.sgl,
 					  xfer->rx_sg.nents,
-					  DMA_FROM_DEVICE,
+					  DMA_DEV_TO_MEM,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_rx) {
 		ret = -EINVAL;
@@ -330,7 +330,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 	desc_tx = dmaengine_prep_slave_sg(master->dma_tx,
 					  xfer->tx_sg.sgl,
 					  xfer->tx_sg.nents,
-					  DMA_TO_DEVICE,
+					  DMA_MEM_TO_DEV,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
 		ret = -EINVAL;
-- 
2.19.0

