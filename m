Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4081AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A402054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WYmWSzsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A402054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeJaTYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:24:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33218 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbeJaTYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DShj3lYy0lOxaqLWbogrHh/1WBYUa1w4c7SdrLgZsZo=; b=WYmWSzschGWK
        b+/uSPJpoJIwC3CxjI9cM3iijqeeO6uAbS8EWGqniPj5XSulwSURHpdDGCy6Ewx5ZD+DSVnqHuDQf
        ByCjBZ4lnibQ+8FxvqNGuMzWf1cx9VMiRI4qG0hWoRwRcFkgPoq2GvxlpeH5lpegNx/G7jIwk3keg
        +DUco=;
Received: from [87.246.78.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gHni2-00043w-DH; Wed, 31 Oct 2018 10:26:46 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E196E440078; Wed, 31 Oct 2018 10:26:45 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        xinping.qian@mediatek.com, linux-spi@vger.kernel.org
Subject: Applied "spi: mediatek: use correct mata->xfer_len when in fifo transfer" to the spi tree
In-Reply-To:  <1540975756-2021-1-git-send-email-leilk.liu@mediatek.com>
Message-Id: <20181031102645.E196E440078@finisterre.ee.mobilebroadband>
Date:   Wed, 31 Oct 2018 10:26:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: mediatek: use correct mata->xfer_len when in fifo transfer

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

From a4d8f64f7267a88d4688f5c216926f5f6cafbae6 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Wed, 31 Oct 2018 16:49:16 +0800
Subject: [PATCH] spi: mediatek: use correct mata->xfer_len when in fifo
 transfer

when xfer_len is greater than 64 bytes and use fifo mode
to transfer, the actual length from the third time is mata->xfer_len
but not len in mtk_spi_interrupt().

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 3dc31627c655..0c2867deb36f 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -522,11 +522,11 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(master);
 
-		cnt = len / 4;
+		cnt = mdata->xfer_len / 4;
 		iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
 				trans->tx_buf + mdata->num_xfered, cnt);
 
-		remainder = len % 4;
+		remainder = mdata->xfer_len % 4;
 		if (remainder > 0) {
 			reg_val = 0;
 			memcpy(&reg_val,
-- 
2.19.0

