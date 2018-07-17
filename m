Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA4A20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA4A20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeGQOQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:16:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40858 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731497AbeGQOQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:16:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1B173207B4; Tue, 17 Jul 2018 15:43:30 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id D78FE2093C;
        Tue, 17 Jul 2018 15:43:19 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com
Subject: [PATCH 4/5] spi: imx: remove unnecessary check in spi_imx_can_dma
Date:   Tue, 17 Jul 2018 15:43:10 +0200
Message-Id: <20180717134311.26780-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717134311.26780-1-maxime.chevallier@bootlin.com>
References: <20180717134311.26780-1-maxime.chevallier@bootlin.com>
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

