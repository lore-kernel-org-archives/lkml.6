Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC7BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD2720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD2720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404677AbeHATEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:04:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404073AbeHATEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:04:04 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1FF12C96;
        Wed,  1 Aug 2018 17:17:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Renesas BSP team via Yoshihiro Shimoda 
        <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 105/246] spi: sh-msiof: Fix setting SIRMDR1.SYNCAC to match SITMDR1.SYNCAC
Date:   Wed,  1 Aug 2018 18:50:15 +0200
Message-Id: <20180801165016.741344537@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 0921e11e1e12802ae0a3c19cb02e33354ca51967 ]

According to section 59.2.4 MSIOF Receive Mode Register 1 (SIRMDR1) in
the R-Car Gen3 datasheet Rev.1.00, the value of the SIRMDR1.SYNCAC bit
must match the value of the SITMDR1.SYNCAC bit.  However,
sh_msiof_spi_setup() changes only the latter.

Fix this by updating the SIRMDR1 register like the SITMDR1 register,
taking into account register bits that exist in SITMDR1 only.

Reported-by: Renesas BSP team via Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Fixes: 7ff0b53c4051145d ("spi: sh-msiof: Avoid writing to registers from spi_master.setup()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sh-msiof.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -555,14 +555,16 @@ static int sh_msiof_spi_setup(struct spi
 
 	/* Configure native chip select mode/polarity early */
 	clr = MDR1_SYNCMD_MASK;
-	set = MDR1_TRMD | TMDR1_PCON | MDR1_SYNCMD_SPI;
+	set = MDR1_SYNCMD_SPI;
 	if (spi->mode & SPI_CS_HIGH)
 		clr |= BIT(MDR1_SYNCAC_SHIFT);
 	else
 		set |= BIT(MDR1_SYNCAC_SHIFT);
 	pm_runtime_get_sync(&p->pdev->dev);
 	tmp = sh_msiof_read(p, TMDR1) & ~clr;
-	sh_msiof_write(p, TMDR1, tmp | set);
+	sh_msiof_write(p, TMDR1, tmp | set | MDR1_TRMD | TMDR1_PCON);
+	tmp = sh_msiof_read(p, RMDR1) & ~clr;
+	sh_msiof_write(p, RMDR1, tmp | set);
 	pm_runtime_put(&p->pdev->dev);
 	p->native_cs_high = spi->mode & SPI_CS_HIGH;
 	p->native_cs_inited = true;


