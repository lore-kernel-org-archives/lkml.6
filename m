Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34FFC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB0F21A18
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bvOcbINp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB0F21A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbeHGIa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:30:58 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:39262 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeHGIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:30:57 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w776HYgi009463;
        Tue, 7 Aug 2018 15:17:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w776HYgi009463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533622660;
        bh=qIOmIprJkVi21IP1uiV+8Gl0nf5/lZ12zXJKRFzTnGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bvOcbINp7Do8Jv0JSmQkdtyqT4eT8Hj3WTQkqVa/fn3G9Pr9H3rC2ZlZD1vZRs9iR
         J9Z2VoY1xWLBemgUAitUi1Cc02LbLMWb7gNYFvceeEnXoF6ywpQnSgrcmjTs8XsXo5
         xO3nLJqUAM+XmfIr7wJ8bgsUVr6i7PrtCONx9pc2EdrpGY3W2GqWTGbNBf7w3AnIH+
         CnSLgfAY9O6EU076+YG0ssEHdizLusjDmqOU6tb5edAd5fYUXEgiNusiLJwb0iJsVz
         /1Sm5BrluZMDJZrNVX1EzlyZPvhW2p352Qlupx5zsnZYwVISrUf4jU3cwU/D+zOQzA
         aGv1IwmDezXPQ==
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
Subject: [v0.1 PATCH 6/7] mmc: renesas_sdhi: refactor CLK_CTL bit calculation
Date:   Tue,  7 Aug 2018 15:17:21 +0900
Message-Id: <1533622642-13989-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
          clock <<= 1;

... is too tricky, hence I replaced with

  roundup_pow_of_two(divisor) >> 2

'(clk >> 22) & 0x1' is the bit test for the 1/1 divisor, but
it is not clear.  'divisor <= 1' is easier to understand.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index a15fb2e..98391e9 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -158,7 +158,8 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 				   unsigned int new_clock)
 {
-	u32 clk = 0, clock;
+	unsigned int clock, divisor;
+	u32 clk = 0;
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
@@ -166,14 +167,18 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	if (new_clock == 0)
 		goto out;
 
-	clock = renesas_sdhi_clk_update(host, new_clock) / 512;
+	clock = renesas_sdhi_clk_update(host, new_clock);
 
-	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
-		clock <<= 1;
+	divisor = clock / new_clock;
 
-	/* 1/1 clock is option */
-	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1))
-		clk |= 0xff;
+	/*
+	 * bit7 set: 1/512, ... bit0 set:1/4, all bits clear: 1/2
+	 * all bits set: 1/1 (Renesas-specific extension?)
+	 */
+	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && divisor <= 1)
+		clk = 0xff;
+	else
+		clk = roundup_pow_of_two(divisor) >> 2;
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-- 
2.7.4

