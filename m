Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03150C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93FE217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfBCP4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:56:32 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33188 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfBCP4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:56:32 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 970E05F92C; Sun,  3 Feb 2019 23:56:28 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chris Blake <chrisrblake93@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 1/3] mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default
Date:   Sun,  3 Feb 2019 23:56:26 +0800
Message-Id: <20190203155628.16767-2-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203155628.16767-1-wens@csie.org>
References: <20190203155628.16767-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some H5 boards seem to not have proper trace lengths for eMMC to be able
to use the default setting for the delay chains under HS-DDR mode. These
include the Bananapi M2+ H5 and NanoPi NEO Core2. However the Libre
Computer ALL-H3-CC-H5 works just fine.

For the H5 (at least for now), default to not enabling HS-DDR modes in
the driver, and expect the device tree to signal HS-DDR capability on
boards that work.

Reported-by: Chris Blake <chrisrblake93@gmail.com>
Fixes: 07bafc1e3536 ("mmc: sunxi: Use new timing mode for A64 eMMC controller")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 279e326e397e..7415af8c8ff6 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1399,7 +1399,16 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
-	if (host->cfg->clk_delays || host->use_new_timings)
+	/*
+	 * Some H5 devices do not have signal traces precise enough to
+	 * use HS DDR mode for their eMMC chips.
+	 *
+	 * We still enable HS DDR modes for all the other controller
+	 * variants that support them.
+	 */
+	if ((host->cfg->clk_delays || host->use_new_timings) &&
+	    !of_device_is_compatible(pdev->dev.of_node,
+				     "allwinner,sun50i-h5-emmc"))
 		mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 
 	ret = mmc_of_parse(mmc);
-- 
2.20.1

