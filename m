Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CAFC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFDA20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFDA20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeGVNvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 09:51:08 -0400
Received: from hermes.aosc.io ([199.195.250.187]:56330 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbeGVNvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 09:51:08 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 04DFE9F3AA;
        Sun, 22 Jul 2018 12:54:27 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] mmc: sunxi: allow 3.3V DDR when DDR is available
Date:   Sun, 22 Jul 2018 20:54:07 +0800
Message-Id: <20180722125407.43107-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Allwinner boards feature an on-board eMMC with fixed 3.3V voltage
(e.g. Banana Pi M2+), and in this case both the eMMC and the SoC are
capable of doing 3.3V DDR transmission.

Add capability of 3.3V DDR when DDR is available (extra clock or new
timing).

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 8e7f3e35ee3d..4ea8e2611079 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1388,7 +1388,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
 	if (host->cfg->clk_delays || host->use_new_timings)
-		mmc->caps      |= MMC_CAP_1_8V_DDR;
+		mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-- 
2.18.0

