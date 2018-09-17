Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3440ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B16721508
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hbLXIhIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B16721508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeIRCwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:52:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43210 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeIRCwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XeY7aGDFEcLZt9shdfDTRCTH9Rqn1sAeAKEdFrnRoy0=; b=hbLXIhIheZMO
        Qevvtdu/Jf6c07WuEC0boDFt5uUnyM/OJ/bGGMdJa45yjxWQTwzpQcLljX58dXmMPotspzZdb9584
        YReoshlWpJIEH4eHzo6XL+8zqn5Ti2S0p0ra1pBpn2k2bSqGWZGWKYSB7jApJo0vfivwusCKKcSq2
        8cmLU=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g20zK-0000lK-6w; Mon, 17 Sep 2018 21:23:22 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9AD3A440079; Mon, 17 Sep 2018 22:23:20 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, linux-spi@vger.kernel.org
Subject: Applied "spi: pic32-sqi: remove unnecessary of_node_get()" to the spi tree
In-Reply-To:  <1536955534-22978-1-git-send-email-khoroshilov@ispras.ru>
Message-Id: <20180917212320.9AD3A440079@finisterre.ee.mobilebroadband>
Date:   Mon, 17 Sep 2018 22:23:20 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pic32-sqi: remove unnecessary of_node_get()

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

From 3356d9f4cb45b1aef3dd4b1a6ea9ceaca0f68a53 Mon Sep 17 00:00:00 2001
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Fri, 14 Sep 2018 23:05:34 +0300
Subject: [PATCH] spi: pic32-sqi: remove unnecessary of_node_get()

Almost all spi drivers assign spi master->dev.of_node from
its parent platform device without additional refcounting.
It seems of_node_get() in pic32_sqi_probe() is unnecessary
and there is no corresponding of_node_put().

Found by Linux Driver Verification project (linuxtesting.org)

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pic32-sqi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index bd1c6b53283f..62e6bf1f50b1 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -656,7 +656,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	master->max_speed_hz	= clk_get_rate(sqi->base_clk);
 	master->dma_alignment	= 32;
 	master->max_dma_len	= PESQI_BD_BUF_LEN_MAX;
-	master->dev.of_node	= of_node_get(pdev->dev.of_node);
+	master->dev.of_node	= pdev->dev.of_node;
 	master->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_TX_DUAL |
 				  SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
 	master->flags		= SPI_MASTER_HALF_DUPLEX;
-- 
2.19.0

