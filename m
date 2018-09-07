Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D99EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEC820869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YYqKEV0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEC820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeIGUuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:50:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53256 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeIGUuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=a8bp1e7XIhDiVwMyHa7eWyPFj9MIf1oOhWtFUv757zY=; b=YYqKEV0BfTXy
        d+1CJjxWZgkYqWqa/OSC/DXDD5xALaeYuj9wPPl3tOO2lgKaF7oR5rp9ofnrq6IlJ+w/FOE/pMxBh
        wv6c9lZCmhj4MkTqXfWhSzgqkbOM3W/VzBOIdVAE2WJjsERLL1hNd+UVlhF7ZKkKBnOtvoXrbJd4z
        QolB4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fyJJg-0005Y4-DS; Fri, 07 Sep 2018 16:09:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2783D1122A6D; Fri,  7 Sep 2018 17:09:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, linux-spi@vger.kernel.org
Subject: Applied "spi: pic32: remove unnecessary of_node_get()" to the spi tree
In-Reply-To:  <1536272214-26219-1-git-send-email-khoroshilov@ispras.ru>
Message-Id: <20180907160904.2783D1122A6D@debutante.sirena.org.uk>
Date:   Fri,  7 Sep 2018 17:09:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pic32: remove unnecessary of_node_get()

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

From b9a947dd756b7af84ababa57e0524788f91a5382 Mon Sep 17 00:00:00 2001
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Fri, 7 Sep 2018 01:16:54 +0300
Subject: [PATCH] spi: pic32: remove unnecessary of_node_get()

Almost all spi drivers assign spi master->dev.of_node from
its parent platform device without additional refcounting.
It seems of_node_get() in pic32_spi_probe() is unnecessary
and there is no corresponding of_node_put().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index f8a45af1fa9f..46ff76193ee1 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -774,7 +774,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_master;
 
-	master->dev.of_node	= of_node_get(pdev->dev.of_node);
+	master->dev.of_node	= pdev->dev.of_node;
 	master->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_CS_HIGH;
 	master->num_chipselect	= 1; /* single chip-select */
 	master->max_speed_hz	= clk_get_rate(pic32s->clk);
-- 
2.19.0.rc1

