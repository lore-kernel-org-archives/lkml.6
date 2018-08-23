Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4258420C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vx2ZpZst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4258420C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeHWINc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:13:32 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47875 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeHWINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:13:31 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w7N4ilM5021677;
        Thu, 23 Aug 2018 13:44:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w7N4ilM5021677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534999492;
        bh=aZPuDo0cJpVKtlXh3mnagFYyO0uUQwqRbzpkWf/IazM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vx2ZpZstArU3l1FxY8k+D+Yj7prI836YNV4KJBqJfkl7EgVG/SknI3ZgR0cU17MGE
         KL5odK7AX6FfBmZhFXqEvjDoxmapFWfQr6rl3DrRixxeMtLsG8D6xUNpeLxFwQtOEw
         74/zSQ3Z4BquDF/7AgXrPlE7QCIdqsj3xB8dNTOXYu+9dWJD7pqYjO8hKlQM2GAuZP
         V0pr7kqkQwOY+FNzRU+jPLz0/JhFrROlmV1a5fYClgn7eIWcwZuhdxpQ99d+XVVIx/
         h8lhGBZPIkubtxBGuBu2wi9v3KAHFQC6RvLF39qTn0wmBLsmYv1itR3plTJZrwwdI6
         cY/EH3f4e8kGw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] mmc: renesas_sdhi: merge clk_{start,stop} functions to set_clock
Date:   Thu, 23 Aug 2018 13:44:19 +0900
Message-Id: <1534999460-15111-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

renesas_sdhi_clk_start() and renesas_sdhi_clk_stop() are now only
called from renesas_sdhi_set_clock().  Merge them.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/renesas_sdhi_core.c | 38 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index cb6e889..0e88737 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -155,35 +155,17 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	return ret == 0 ? best_freq : clk_get_rate(priv->clk);
 }
 
-static void renesas_sdhi_clk_start(struct tmio_mmc_host *host)
+static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
+				   unsigned int new_clock)
 {
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-
-	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-}
+	u32 clk = 0, clock;
 
-static void renesas_sdhi_clk_stop(struct tmio_mmc_host *host)
-{
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
-	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-}
-
-static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
-				   unsigned int new_clock)
-{
-	u32 clk = 0, clock;
+	if (new_clock == 0)
+		goto out;
 
-	if (new_clock == 0) {
-		renesas_sdhi_clk_stop(host);
-		return;
-	}
 	/*
 	 * Both HS400 and HS200/SD104 set 200MHz, but some devices need to
 	 * set 400MHz to distinguish the CPG settings in HS400.
@@ -206,13 +188,17 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 			clk &= ~0xff;
 	}
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
 		usleep_range(10000, 11000);
 
-	renesas_sdhi_clk_start(host);
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+out:
+	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
 }
 
 static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
-- 
2.7.4

