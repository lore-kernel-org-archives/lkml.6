Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8ABECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CE720850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="I8NhfDcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CE720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeGRNHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:07:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51026 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbeGRNHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FhNAREeCufTZ/LBzl6UMhvrd56pQYUsgT/UoM8CAhlc=; b=I8NhfDcucfH9
        VFsvtbh2iUJ6vhkrk3c1zwDfhg+NaGOi42urRrlKJxfhEUY1HBgiYeyApDPwEmJ48BirXASRfghIQ
        Qvi0hnxpJuNq09hvhrzYnp5ZsxDqFp0OlARpFRFe6inFPDsU4vzXnlXfjW5KcME1Y8gd5AUEZLxhx
        bds0k=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflaZ-0003Wr-Ab; Wed, 18 Jul 2018 12:29:51 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflaY-0007Wj-SM; Wed, 18 Jul 2018 13:29:50 +0100
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
Subject: Applied "spi: dw: allow providing own set_cs callback" to the spi tree
In-Reply-To:  <20180717142314.32337-3-alexandre.belloni@bootlin.com>
Message-Id: <E1fflaY-0007Wj-SM@debutante>
Date:   Wed, 18 Jul 2018 13:29:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: allow providing own set_cs callback

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

From 62dbbae483b6452e688b8e26c4d024d484117697 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 17 Jul 2018 16:23:11 +0200
Subject: [PATCH] spi: dw: allow providing own set_cs callback

Allow platform specific drivers to provide their own set_cs callback when
the IP integration requires it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 +++
 drivers/spi/spi-dw.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f693bfe95ab9..0d8ccb8be5ec 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -505,6 +505,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->dev.of_node = dev->of_node;
 	master->flags = SPI_MASTER_GPIO_SS;
 
+	if (dws->set_cs)
+		master->set_cs = dws->set_cs;
+
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2cde2473b3e9..446013022849 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -112,6 +112,7 @@ struct dw_spi {
 	u32			reg_io_width;	/* DR I/O width in bytes */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
+	void (*set_cs)(struct spi_device *spi, bool enable);
 
 	/* Current message transfer state info */
 	size_t			len;
-- 
2.18.0

