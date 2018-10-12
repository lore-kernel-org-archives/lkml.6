Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8789EC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E84121470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Tx4lS0Di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E84121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJMAev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:34:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48182 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMAev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=e0tKQoPjX6arYivFw4R58uuODCvkWhHb/g/bVX9Umjk=; b=Tx4lS0Dic7gm
        domjuQyKdqfAPKENRHnmb3Xnw471rOTd9shibXnDIYaFppe5RWwQxzf8evhYfpitILS+EaymSC9IA
        sI94kl1kV+OjEk7IQZu9dE+mNjSvU2amMEZ0HcjC7j8bbJ9p2Ta05ZY6rdgb6IX0Kpf9wSaK1sBDB
        Mwrr0=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB0oV-0006eQ-9A; Fri, 12 Oct 2018 17:01:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C66EC440078; Fri, 12 Oct 2018 19:01:22 +0200 (CEST)
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, linux-spi@vger.kernel.org
Subject: Applied "spi: imx: use PIO mode if size is small" to the spi tree
In-Reply-To:  <1539196453-8704-4-git-send-email-yibin.gong@nxp.com>
Message-Id: <20181012170122.C66EC440078@finisterre.ee.mobilebroadband>
Date:   Fri, 12 Oct 2018 19:01:22 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: imx: use PIO mode if size is small

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

From 133eb8e38b02c6c63a039523fca12737009a6686 Mon Sep 17 00:00:00 2001
From: Robin Gong <yibin.gong@nxp.com>
Date: Wed, 10 Oct 2018 10:32:48 +0000
Subject: [PATCH] spi: imx: use PIO mode if size is small

Use PIO mode instead if size is smaller than fifo size, since
dma may be less efficient.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 037abbb852a4..dd1ce12aa386 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -224,6 +224,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return false;
 
+	if (transfer->len < spi_imx->devtype_data->fifo_size)
+		return false;
+
 	spi_imx->dynamic_burst = 0;
 
 	return true;
-- 
2.19.0

