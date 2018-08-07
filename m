Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C521CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DABB21A12
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QNWdhTNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DABB21A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbeHGIa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:30:59 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:39276 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388232AbeHGIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:30:57 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w776HYgd009463;
        Tue, 7 Aug 2018 15:17:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w776HYgd009463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533622656;
        bh=axiRk/auNLIILoxR066vuZblruWMrcKW6nODEHtIVxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNWdhTNiqZ68oJPzh+6OGe5InQZdXnBE4c0j9H1Tk2F/J55l7GeO98Rc9ux/qxGBh
         e/qceztMXnfwzjWjyGx6YRqAnedic6aZ7nMWynRTtIyLfDKDsd62yJ5Sgpgp1PDzuc
         1J2AeEBCWUfdEZkL+ITngDbqboLN5r9o5UKcDcfmkf5IJRDxVZ/ARRCWYh3kPsdzg1
         MEyvpS6kkrPpkLCX+ESCCGQRtVCGwRmGf+dNQdcQzeD5Uvmq51jjhbuuHx1x0Fn3P6
         MVzMm3a8V5R1J5N2+uk/66tdantGNaVVAn585cIV9z7Vd4BVrJp4BIy/g76xPIqGJn
         8jr0ROh3Y5fbw==
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
Subject: [v0.1 PATCH 1/7] mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
Date:   Tue,  7 Aug 2018 15:17:16 +0900
Message-Id: <1533622642-13989-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tmio_mmc_clk_stop(host) is equivalent to tmio_mmc_set_clock(host, 0).
This replacement is needed for the next commit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 3cb554c..991b340 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1032,7 +1032,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		tmio_mmc_power_off(host);
-		tmio_mmc_clk_stop(host);
+		tmio_mmc_set_clock(host, 0);
 		break;
 	case MMC_POWER_UP:
 		tmio_mmc_power_on(host, ios->vdd);
@@ -1269,7 +1269,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 
-	tmio_mmc_clk_stop(_host);
+	tmio_mmc_set_clock(_host, 0);
 	tmio_mmc_reset(_host);
 
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
@@ -1353,7 +1353,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	if (host->clk_cache)
-		tmio_mmc_clk_stop(host);
+		tmio_mmc_set_clock(host, 0);
 
 	tmio_mmc_clk_disable(host);
 
-- 
2.7.4

