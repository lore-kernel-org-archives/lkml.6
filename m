Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7E6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77967205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="I3qIuawD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77967205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeH2BCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:02:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH2BCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iI6Jo981TwTDpbtdPlLeDknObMnjACPoLIG0zLUkMw8=; b=I3qIuawD83BA
        m9ZY0mS5zKvUzeBMaYDk6OzNYYJBKNCTaI1+tkrCk1jgh+xx7sJRb9fdtOe+bB6dPNniOBvA4ou+3
        UVdrn5GNFmT2bHkdLn2LAgPnq040X+Go7V+gEuvvvVev2G5kONTdI5GDrB1q1PGrRoowa+kAIQ+LK
        bPwtI=;
Received: from 94.197.121.204.threembb.co.uk ([94.197.121.204] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fulE0-0007ld-5O; Tue, 28 Aug 2018 21:08:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D4A934400A1; Tue, 28 Aug 2018 21:58:56 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Kirill Kapranov <kirill.kapranov@compulab.co.il>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: Fix double IDR allocation with DT aliases" to the spi tree
In-Reply-To:  <20180821095303.27664-1-geert+renesas@glider.be>
Message-Id: <20180828205856.D4A934400A1@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:58:56 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Fix double IDR allocation with DT aliases

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

From 04b2d03a75652bda989de1595048f0501dc0c0a0 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 21 Aug 2018 11:53:03 +0200
Subject: [PATCH] spi: Fix double IDR allocation with DT aliases

If the SPI bus number is provided by a DT alias, idr_alloc() is called
twice, leading to:

    WARNING: CPU: 1 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x11c/0x5d8
    couldn't get idr

Fix this by moving the handling of fixed SPI bus numbers up, before the
DT handling code fills in ctlr->bus_num.

Fixes: 1a4327fbf4554d5b ("spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a00d006d4c3a..9da0bc5a036c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2143,8 +2143,17 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 */
 	if (ctlr->num_chipselect == 0)
 		return -EINVAL;
-	/* allocate dynamic bus number using Linux idr */
-	if ((ctlr->bus_num < 0) && ctlr->dev.of_node) {
+	if (ctlr->bus_num >= 0) {
+		/* devices with a fixed bus num must check-in with the num */
+		mutex_lock(&board_lock);
+		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
+			ctlr->bus_num + 1, GFP_KERNEL);
+		mutex_unlock(&board_lock);
+		if (WARN(id < 0, "couldn't get idr"))
+			return id == -ENOSPC ? -EBUSY : id;
+		ctlr->bus_num = id;
+	} else if (ctlr->dev.of_node) {
+		/* allocate dynamic bus number using Linux idr */
 		id = of_alias_get_id(ctlr->dev.of_node, "spi");
 		if (id >= 0) {
 			ctlr->bus_num = id;
@@ -2170,15 +2179,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (WARN(id < 0, "couldn't get idr"))
 			return id;
 		ctlr->bus_num = id;
-	} else {
-		/* devices with a fixed bus num must check-in with the num */
-		mutex_lock(&board_lock);
-		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
-			ctlr->bus_num + 1, GFP_KERNEL);
-		mutex_unlock(&board_lock);
-		if (WARN(id < 0, "couldn't get idr"))
-			return id == -ENOSPC ? -EBUSY : id;
-		ctlr->bus_num = id;
 	}
 	INIT_LIST_HEAD(&ctlr->queue);
 	spin_lock_init(&ctlr->queue_lock);
-- 
2.18.0

