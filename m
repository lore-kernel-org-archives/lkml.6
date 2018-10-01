Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C311C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365E0208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="l2ePuxY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365E0208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeJATJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:09:27 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:19059 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJATJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:09:27 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w91CVGk9019301;
        Mon, 1 Oct 2018 21:31:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w91CVGk9019301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538397078;
        bh=Sjv0GqAg1u9MaHqXEyE3e7KrbWnbyDjHI+QmDJzfk9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2ePuxY49+91wZjt8aCx6rWICoTaVV0RD4bSaOHda5/7OgU//AKm9MxhVPTbzaWeT
         D8CDtE2jxXDz+Vs98x0nLygXWRUDtevSHf1MItWE3ut0ELE2UdwFloPp0Iy3fYE8vT
         VlPdkRdWJ1Hlu16tl3UB8mtppVQKvtEmYjUNJ/Eb54XBC6tm6GrClRmKSQJrlbBgZ0
         ZjngOT9uFKZT37r/NSoL/kW72FyzVPs7OEaNjNTZI7Zp9RMwf2Xc/zaDhQaPzHQqO1
         ugjI+PI0/cZSbMxURmTj7XBW7630L0LKRLf/HVrjctKDCOHqioqrdRbwlQ/fRUrv3g
         3JI5emzxqwFqw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: tmio: move MFD variant reset to a platform hook
Date:   Mon,  1 Oct 2018 21:31:01 +0900
Message-Id: <1538397062-19162-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTL_RESET_SDIO register is specific to the TMIO MFD (tmio_mmc.c).

Add a new hook host->reset for performing a platform-specific reset
sequence, and move CTL_RESET_SDIO over there.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc.c      | 9 +++++++++
 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 7 +++----
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e04c322..c8e90cf 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -78,6 +78,14 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	tmio_mmc_clk_start(host);
 }
 
+static void tmio_mmc_reset(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
+	usleep_range(10000, 11000);
+	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
+	usleep_range(10000, 11000);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int tmio_mmc_suspend(struct device *dev)
 {
@@ -156,6 +164,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
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
index 0611824..fad840a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -164,14 +164,13 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
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
 
+	if (host->reset)
+		host->reset(host);
+
 	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
-- 
2.7.4

