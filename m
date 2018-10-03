Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53364C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1765220835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iHi/zBBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1765220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJCSZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:25:26 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:27453 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeJCSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:25:25 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w93BaXuR004652;
        Wed, 3 Oct 2018 20:36:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w93BaXuR004652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538566595;
        bh=3xT6ayLsUJs6m+vBGK/6yogwPyPjq131/KnWwukGn8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iHi/zBBfxTuh9TJFsQVhBjkxU4sQIS+HFwnScrXUxJkQyN4nW/8vFCpLhFkwpKCuq
         0c0EarXNPPAK8rhaNkyVfTrg0wCwfu7ODqr7zi8ra0RW/81YV0/N7yVr5CPzURPaks
         ON2coe1DvigWK4qyEQyZ/9usVkcuEMIKx2T7w3SAMu+VlWj0pW8maBay0uoe+4YP3v
         f0SXKym/0aM13GtYjdsCrBOXApHzdTkgu9OEFJ7Ggtc8tHeVKKvVnrkHhAHy9yi35J
         Rn12ekZ5WP/DpBzsaA26Lyw3M4QUw5N8mgHWUoyLAQBxDZuAZ9YRSozTOTo9d6lyjX
         l/YVH4dPustPg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mmc: tmio: move MFD variant reset to a platform hook
Date:   Wed,  3 Oct 2018 20:36:26 +0900
Message-Id: <1538566587-29452-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538566587-29452-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538566587-29452-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTL_RESET_SDIO register is specific to the TMIO MFD (tmio_mmc.c).

Add a new hook host->reset for performing a platform-specific reset
sequence, and move CTL_RESET_SDIO over there.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Preserve the current sequence for tmio_mmc.c

 drivers/mmc/host/tmio_mmc.c      | 17 +++++++++++++++++
 drivers/mmc/host/tmio_mmc.h      |  1 +
 drivers/mmc/host/tmio_mmc_core.c |  8 +++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e04c322..00d291c 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -78,6 +78,22 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	tmio_mmc_clk_start(host);
 }
 
+static void tmio_mmc_reset(struct tmio_mmc_host *host)
+{
+	/* FIXME - should we set stop clock reg here */
+	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
+	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
+	usleep_range(10000, 11000);
+	sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
+	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
+	usleep_range(10000, 11000);
+
+	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
+		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
+		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
+	}
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int tmio_mmc_suspend(struct device *dev)
 {
@@ -156,6 +172,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	host->bus_shift = resource_size(res) >> 10;
 	host->set_clock = tmio_mmc_set_clock;
+	host->reset = tmio_mmc_reset;
 
 	host->mmc->f_max = pdata->hclk;
 	host->mmc->f_min = pdata->hclk / 512;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index e6aa13a..a1a661b 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -176,6 +176,7 @@ struct tmio_mmc_host {
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
+	void (*reset)(struct tmio_mmc_host *host);
 	void (*hw_reset)(struct tmio_mmc_host *host);
 	void (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
 	bool (*check_scc_error)(struct tmio_mmc_host *host);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 0611824..9bcc760 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -164,19 +164,14 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
-		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
 	usleep_range(10000, 11000);
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
-		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
 	usleep_range(10000, 11000);
 
 	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
 	}
-
 }
 
 static void tmio_mmc_reset_work(struct work_struct *work)
@@ -1212,6 +1207,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  !mmc_card_is_removable(mmc));
 
+	if (!_host->reset)
+		_host->reset = tmio_mmc_reset;
+
 	/*
 	 * On Gen2+, eMMC with NONREMOVABLE currently fails because native
 	 * hotplug gets disabled. It seems RuntimePM related yet we need further
-- 
2.7.4

