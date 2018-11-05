Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FE7C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF1120825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AIKhB2yU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF1120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeKEV0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:26:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53072 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbeKEV0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KoqDGL25jrp36nm/XMpVPSB4lGYWCQhZgazEvNqw0yY=; b=AIKhB2yUjDG4
        iqNSQvdaIMVrYsgNPhz9kfMNWNiqWfVaW7ddh0QozJM0F0T4b3s8dQHV75VLQTnJ+ORpF6H/T5Wcw
        a7f0iUMzABZ6IKQ7IbVIspVDB6pNzvg9eKgc55t+QKw+1X9yBu5C9IOZn8kJjvYXpSaC49S29Ohah
        JV2H0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJde5-0008N9-G0; Mon, 05 Nov 2018 12:06:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 35F9F1124D98; Mon,  5 Nov 2018 12:06:17 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: precompute rx sample delay" to the spi tree
In-Reply-To:  <20181031105711.19575-12-esmil@mailme.dk>
Message-Id: <20181105120617.35F9F1124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:17 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: precompute rx sample delay

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

From 74b7efa82b11914c21e30d987ed61d3daa57ff21 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:08 +0100
Subject: [PATCH] spi: rockchip: precompute rx sample delay

Now that we no longer potentially change spi clock
at runtime we can precompute the rx sample delay
at probe time rather than for each transfer.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index d1b3ba2b1532..5fe6099ff366 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -94,6 +94,7 @@
 #define CR0_BHT_8BIT				0x1
 
 #define CR0_RSD_OFFSET				14
+#define CR0_RSD_MAX				0x3
 
 #define CR0_FRF_OFFSET				16
 #define CR0_FRF_SPI					0x0
@@ -179,7 +180,7 @@ struct rockchip_spi {
 	u32 freq;
 
 	u8 n_bytes;
-	u32 rsd_nsecs;
+	u8 rsd;
 
 	const void *tx;
 	const void *tx_end;
@@ -450,13 +451,13 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		bool use_dma)
 {
 	u32 dmacr = 0;
-	int rsd = 0;
 
 	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
 	        | CR0_BHT_8BIT << CR0_BHT_OFFSET
 	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
 	        | CR0_EM_BIG   << CR0_EM_OFFSET;
 
+	cr0 |= rs->rsd << CR0_RSD_OFFSET;
 	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 
@@ -474,20 +475,6 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 			dmacr |= RF_DMA_EN;
 	}
 
-	/* Rx sample delay is expressed in parent clock cycles (max 3) */
-	rsd = DIV_ROUND_CLOSEST(rs->rsd_nsecs * (rs->freq >> 8),
-				1000000000 >> 8);
-	if (!rsd && rs->rsd_nsecs) {
-		pr_warn_once("rockchip-spi: %u Hz are too slow to express %u ns delay\n",
-			     rs->freq, rs->rsd_nsecs);
-	} else if (rsd > 3) {
-		rsd = 3;
-		pr_warn_once("rockchip-spi: %u Hz are too fast to express %u ns delay, clamping at %u ns\n",
-			     rs->freq, rs->rsd_nsecs,
-			     rsd * 1000000000U / rs->freq);
-	}
-	cr0 |= rsd << CR0_RSD_OFFSET;
-
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 
 	if (rs->n_bytes == 1)
@@ -620,8 +607,21 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	rs->freq = clk_get_rate(rs->spiclk);
 
 	if (!of_property_read_u32(pdev->dev.of_node, "rx-sample-delay-ns",
-				  &rsd_nsecs))
-		rs->rsd_nsecs = rsd_nsecs;
+				  &rsd_nsecs)) {
+		/* rx sample delay is expressed in parent clock cycles (max 3) */
+		u32 rsd = DIV_ROUND_CLOSEST(rsd_nsecs * (rs->freq >> 8),
+				1000000000 >> 8);
+		if (!rsd) {
+			dev_warn(rs->dev, "%u Hz are too slow to express %u ns delay\n",
+					rs->freq, rsd_nsecs);
+		} else if (rsd > CR0_RSD_MAX) {
+			rsd = CR0_RSD_MAX;
+			dev_warn(rs->dev, "%u Hz are too fast to express %u ns delay, clamping at %u ns\n",
+					rs->freq, rsd_nsecs,
+					CR0_RSD_MAX * 1000000000U / rs->freq);
+		}
+		rs->rsd = rsd;
+	}
 
 	rs->fifo_len = get_fifo_len(rs);
 	if (!rs->fifo_len) {
-- 
2.19.0.rc2

