Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5132081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VLayMreK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5132081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeK2DIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:08:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38342 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbeK2DIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WddPQ876YEPqyxCaYDTZSI9JeZLygwWprc6QI3dJIKE=; b=VLayMreKA6Vc
        K4qwZK70P1hVuajfWNhqPgfxLsi6ztuj8bpNrlovArB6ZHTZ1SVlo753Ywbe07/CcvcrhUocraBjp
        XbLGGs/vwPziVrsUgqWgg95VM5gtR95cVWPIk5vimnKOflcau3S1YOocVTE1zhk/g9wimPFt6Rc6y
        DcaQs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gS2Lc-0005xs-By; Wed, 28 Nov 2018 16:05:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0D951112521B; Wed, 28 Nov 2018 16:05:56 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        opembmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: npcm: Fix uninitialized variable warning" to the spi tree
In-Reply-To:  <20181117035504.95804-1-olof@lixom.net>
Message-Id: <20181128160556.0D951112521B@debutante.sirena.org.uk>
Date:   Wed, 28 Nov 2018 16:05:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: npcm: Fix uninitialized variable warning

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

From 1d2319efb6a970d5f5740a60828244e6c309df2b Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Fri, 16 Nov 2018 19:55:04 -0800
Subject: [PATCH] spi: npcm: Fix uninitialized variable warning

The compiler has no way to know that rsize 1 or 2 are the only valid
values. Also simplify the code a bit with early return.

The warning was:

drivers/spi/spi-npcm-pspi.c:215:6: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-npcm-pspi.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index fed05b02007c..dda91c19af93 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -217,15 +217,23 @@ static void npcm_pspi_recv(struct npcm_pspi *priv)
 	rsize = min(bytes_per_word(priv->bits_per_word), priv->rx_bytes);
 	priv->rx_bytes -= rsize;
 
-	if (priv->rx_buf) {
-		if (rsize == 1)
-			val = ioread8(priv->base + NPCM_PSPI_DATA);
-		if (rsize == 2)
-			val = ioread16(priv->base + NPCM_PSPI_DATA);
+	if (!priv->rx_buf)
+		return;
 
-		*priv->rx_buf = val;
-		priv->rx_buf += rsize;
+	switch (rsize) {
+	case 1:
+		val = ioread8(priv->base + NPCM_PSPI_DATA);
+		break;
+	case 2:
+		val = ioread16(priv->base + NPCM_PSPI_DATA);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
 	}
+
+	*priv->rx_buf = val;
+	priv->rx_buf += rsize;
 }
 
 static int npcm_pspi_transfer_one(struct spi_master *master,
-- 
2.19.0.rc2

