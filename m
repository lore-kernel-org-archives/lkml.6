Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5622C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802702086B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JGMj8kTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802702086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbeKEV0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:26:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53732 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbeKEV0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=j4WhlVy+BFCj/6P2cuVWkTrLSISayI93pAx1nson1Ds=; b=JGMj8kTG61ic
        XnXu8aftnwRT2zbzCpb2Z97xJV9+h0GBLCH+2JIG8GeZGfm9Ebzh94pvVTRvS90Ps4V7i6ALk6COz
        NvgH0ZqS7wgoHA2navqae7csV3h9W+WMQ0knOymhLhWQidqZx4XDD0RmUd/M0K6z93wwQ9X02QUNW
        xVZqE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJded-0008OO-GT; Mon, 05 Nov 2018 12:06:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 28D0E1124D98; Mon,  5 Nov 2018 12:06:51 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: always use SPI mode" to the spi tree
In-Reply-To:  <20181031105711.19575-4-esmil@mailme.dk>
Message-Id: <20181105120651.28D0E1124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:51 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: always use SPI mode

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

From 2410d6a3c3070e205169a1a741aa78898e30a642 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:00 +0100
Subject: [PATCH] spi: rockchip: always use SPI mode

The hardware supports 3 different variants of SPI
and there were some code around it, but nothing
to actually set it to anything but "Motorola SPI".
Just drop that code and always use that mode.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 87d1b9837d94..7fac4253075e 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -156,12 +156,6 @@
 
 #define ROCKCHIP_SPI_MAX_CS_NUM			2
 
-enum rockchip_ssi_type {
-	SSI_MOTO_SPI = 0,
-	SSI_TI_SSP,
-	SSI_NS_MICROWIRE,
-};
-
 struct rockchip_spi_dma_data {
 	struct dma_chan *ch;
 	dma_addr_t addr;
@@ -179,8 +173,6 @@ struct rockchip_spi {
 	u32 fifo_len;
 	/* max bus freq supported */
 	u32 max_freq;
-	/* supported slave numbers */
-	enum rockchip_ssi_type type;
 
 	u16 mode;
 	u8 tmode;
@@ -525,14 +517,14 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	u32 dmacr = 0;
 	int rsd = 0;
 
-	u32 cr0 = (CR0_BHT_8BIT << CR0_BHT_OFFSET)
-		| (CR0_SSD_ONE << CR0_SSD_OFFSET)
-		| (CR0_EM_BIG << CR0_EM_OFFSET);
+	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
+	        | CR0_BHT_8BIT << CR0_BHT_OFFSET
+	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
+	        | CR0_EM_BIG   << CR0_EM_OFFSET;
 
 	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= ((rs->mode & 0x3) << CR0_SCPH_OFFSET);
 	cr0 |= (rs->tmode << CR0_XFM_OFFSET);
-	cr0 |= (rs->type << CR0_FRF_OFFSET);
 
 	if (rs->use_dma) {
 		if (rs->tx)
@@ -709,7 +701,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	spi_enable_chip(rs, false);
 
-	rs->type = SSI_MOTO_SPI;
 	rs->master = master;
 	rs->dev = &pdev->dev;
 	rs->max_freq = clk_get_rate(rs->spiclk);
-- 
2.19.0.rc2

