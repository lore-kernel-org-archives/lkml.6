Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8811AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FD8208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Hz+J26dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FD8208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeHWINL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:13:11 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47260 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbeHWINK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:13:10 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w7N4ilM1021677;
        Thu, 23 Aug 2018 13:44:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w7N4ilM1021677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534999489;
        bh=3RFm8PqDdIMPfI9yBT9mzsZLOE48GRm+/5k59NIGrIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hz+J26dyCu0EJ5X4ghF3OJA+ZuKyXftGHSc3apxJ6vLXpCskOJRqx6+z/3wcuQ/Wl
         sYULhq6dRImvKaPVOqXX1ZRReXHVjv+oxGep89KdjFxBDitKxzXtjelofLHEfJe7u1
         jc39rBCrAtqUSjvsgXK5DkyK2hB8Mka5FsGCjT/Y1FVdiwHG/uL75iXr/ZNtMg5JFt
         oKLO4iX1zhGmeM0r+n6gQURStxrPcpRA4m18irfnZFcKOT9CeLGQNp8jtTuyY0cqia
         386it6NZsr1dDso4TSO1u4t9mYqbcNzU3OFD29x2mA8rt6pA/ca/ErXpdkV9726D6N
         jyqcKDrul2NIg==
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
Subject: [PATCH v3 1/6] mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
Date:   Thu, 23 Aug 2018 13:44:15 +0900
Message-Id: <1534999460-15111-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tmio_mmc_clk_stop(host) is equivalent to tmio_mmc_set_clock(host, 0).
This replacement is needed for the next commit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/tmio_mmc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 261b4d6..5717ffa 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1043,7 +1043,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		tmio_mmc_power_off(host);
-		tmio_mmc_clk_stop(host);
+		tmio_mmc_set_clock(host, 0);
 		break;
 	case MMC_POWER_UP:
 		tmio_mmc_power_on(host, ios->vdd);
@@ -1310,7 +1310,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 
-	tmio_mmc_clk_stop(_host);
+	tmio_mmc_set_clock(_host, 0);
 	tmio_mmc_reset(_host);
 
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
@@ -1394,7 +1394,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	if (host->clk_cache)
-		tmio_mmc_clk_stop(host);
+		tmio_mmc_set_clock(host, 0);
 
 	tmio_mmc_clk_disable(host);
 
-- 
2.7.4

