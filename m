Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7372075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qFiBBpKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7372075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJJLMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:12:40 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:61191 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeJJLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:12:39 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w9A3pfeu028281;
        Wed, 10 Oct 2018 12:51:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w9A3pfeu028281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539143503;
        bh=wSqxcIFcRqXvWNzedzUL+SCh887MLy6RtgTSy6/06Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFiBBpKxDJXh5EuXU5YuE55stZkjo0GNqsLx1h2zwcMooZV3X7gGvVAtpgGelzyxY
         9kNhuylkQcejWQJJP0RlVAgWCq7Y8q0tGVeRteFfvDRHZtpRKCP7sJS6+PJmQ/QyCf
         ezgQ1DMhFbkunfzNvu9whl+yauIJlrtI+BadRLGYqD2lTMtXvsGSAdYgBlc0KT33tl
         ZcEt6xYzn6X4yGLzYzv0h2kmBWmRMabP9sYDWmtfkepC418k9CeeB+b7+HTpl3Y5JL
         019pluZZmtcVCTAEP6FNN1y6fwbVUCvV3JkH42fPGu44FP4nfQaadHXRVJNhbq/T1t
         12NI57i/FkN9Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mmc: tmio: move MFD variant reset to a platform hook
Date:   Wed, 10 Oct 2018 12:51:31 +0900
Message-Id: <1539143492-32605-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTL_RESET_SDIO register is specific to the TMIO MFD (tmio_mmc.c).

Add a new hook host->reset() for performing a platform-specific
reset sequence, and move CTL_RESET_SDIO over there.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - Replace all tmio_mmc_reset() calls with host->reset()

Changes in v2:
  - Preserve the current sequence for tmio_mmc.c

 drivers/mmc/host/tmio_mmc.c      | 17 +++++++++++++++++
 drivers/mmc/host/tmio_mmc.h      |  1 +
 drivers/mmc/host/tmio_mmc_core.c | 14 ++++++--------
 3 files changed, 24 insertions(+), 8 deletions(-)

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
index 0611824..a571106 100644
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
@@ -217,7 +212,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	tmio_mmc_reset(host);
+	host->reset(host);
 
 	/* Ready for new calls */
 	host->mrq = NULL;
@@ -1212,6 +1207,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  !mmc_card_is_removable(mmc));
 
+	if (!_host->reset)
+		_host->reset = tmio_mmc_reset;
+
 	/*
 	 * On Gen2+, eMMC with NONREMOVABLE currently fails because native
 	 * hotplug gets disabled. It seems RuntimePM related yet we need further
@@ -1233,7 +1231,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 
 	_host->set_clock(_host, 0);
-	tmio_mmc_reset(_host);
+	_host->reset(_host);
 
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
@@ -1333,7 +1331,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
-	tmio_mmc_reset(host);
+	host->reset(host);
 	tmio_mmc_clk_enable(host);
 
 	if (host->clk_cache)
-- 
2.7.4

