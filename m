Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC301ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28F9214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28F9214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbeGQPFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:05:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42455 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbeGQPFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:05:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9FE19206F3; Tue, 17 Jul 2018 16:32:15 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 81ED8207B4;
        Tue, 17 Jul 2018 16:31:58 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: [PATCH RESEND 4/5] spi: imx: remove unnecessary check in spi_imx_can_dma
Date:   Tue, 17 Jul 2018 16:31:53 +0200
Message-Id: <20180717143154.28241-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi_imx_can_dma function computes the watermark level so that
the transfer will fit in exactly N bursts (without a remainder).

The smallest watermark level possible being one FIFO entry per burst, we
can't never have a case where the transfer size isn't divsiible by 1.

Remove the extra check for the wml being different than 0.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/spi/spi-imx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 3ae706dac660..ef6d3648396a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -229,9 +229,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 			break;
 	}
 
-	if (i == 0)
-		return false;
-
 	spi_imx->wml = i;
 	spi_imx->dynamic_burst = 0;
 
-- 
2.11.0

