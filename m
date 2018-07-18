Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5A4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AA020850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AlCuFMEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AA020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbeGRNHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:07:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51056 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbeGRNHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=N2vL6pUs/MFDoeBhOS+LM7Lz+QtEx2+rbV0NB02L92k=; b=AlCuFMEFLx0m
        Y7cel02cChIBzwQnEfG63GWxiGhtd28s3Ux5PsGrrlT9pi8KqPk1q2Z+wAH/SKsGOT1jfJDHrr/8m
        n3sQBVG4WGC3J75LuJpgKWMG8M4zT83NRGlX1niHw4ojB+/LvKZOxc5JqEUuPrkR7NsjCKy7R5Off
        77NFs=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflab-0003Ww-GR; Wed, 18 Jul 2018 12:29:53 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflab-0007Xk-2r; Wed, 18 Jul 2018 13:29:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: dw: fix possible race condition" to the spi tree
In-Reply-To:  <20180717142314.32337-2-alexandre.belloni@bootlin.com>
Message-Id: <E1fflab-0007Xk-2r@debutante>
Date:   Wed, 18 Jul 2018 13:29:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: fix possible race condition

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

From 66b19d762378785d1568b5650935205edfeb0503 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 17 Jul 2018 16:23:10 +0200
Subject: [PATCH] spi: dw: fix possible race condition

It is possible to get an interrupt as soon as it is requested.  dw_spi_irq
does spi_controller_get_devdata(master) and expects it to be different than
NULL. However, spi_controller_set_devdata() is called after request_irq(),
resulting in the following crash:

CPU 0 Unable to handle kernel paging request at virtual address 00000030, epc == 8058e09c, ra == 8018ff90
[...]
Call Trace:
[<8058e09c>] dw_spi_irq+0x8/0x64
[<8018ff90>] __handle_irq_event_percpu+0x70/0x1d4
[<80190128>] handle_irq_event_percpu+0x34/0x8c
[<801901c4>] handle_irq_event+0x44/0x80
[<801951a8>] handle_level_irq+0xdc/0x194
[<8018f580>] generic_handle_irq+0x38/0x50
[<804c6924>] ocelot_irq_handler+0x104/0x1c0

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f693bfe95ab9..a087464efdd7 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -485,6 +485,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	dws->dma_inited = 0;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
 
+	spi_controller_set_devdata(master, dws);
+
 	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
 			  master);
 	if (ret < 0) {
@@ -518,7 +520,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		}
 	}
 
-	spi_controller_set_devdata(master, dws);
 	ret = devm_spi_register_controller(dev, master);
 	if (ret) {
 		dev_err(&master->dev, "problem registering spi master\n");
-- 
2.18.0

