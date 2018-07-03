Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F920C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C27208A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C27208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbeGCH3P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:29:15 -0400
Received: from olimex.com ([184.105.72.32]:53984 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753591AbeGCH3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:29:13 -0400
Received: from localhost.localdomain ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AES(128):Mac=SHA256) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 00:29:12 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 1/1] mmc: sunxi: Disable irq during pm_suspend
Date:   Tue,  3 Jul 2018 10:28:43 +0300
Message-Id: <1530602925-7714-1-git-send-email-stefan@olimex.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mmc host controller enters suspend state, the clocks are
disabled, but irqs are not. For some reason the irqchip emmits
false interrupts, which causes system lock loop.

Debug log is:
  ...
  sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 51200000
  sunxi-mmc 1c11000.mmc: enabling the clock
  sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
  sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
  sunxi-mmc 1c11000.mmc: cmd 6(80000146) arg 3210101 ie 0x0000bbc6 len 0
  sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
  sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
  sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
  mmc1: new DDR MMC card at address 0001
  mmcblk1: mmc1:0001 AGND3R 14.6 GiB
  mmcblk1boot0: mmc1:0001 AGND3R partition 1 4.00 MiB
  mmcblk1boot1: mmc1:0001 AGND3R partition 2 4.00 MiB
  sunxi-mmc 1c11000.mmc: cmd 18(80003352) arg 0 ie 0x0000fbc2 len 409
  sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00004000 idi 00000002
   mmcblk1: p1
  sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
  sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
  sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
  sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
and so on...

This issue apears on eMMC cards, routed on MMC2 slot. The patch is
tested with A20-OLinuXino-MICRO/LIME/LIME2 boards.

Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/mmc/host/sunxi-mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index e747259..acae7a8 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1446,6 +1446,7 @@ static int sunxi_mmc_runtime_resume(struct device *dev)
 	sunxi_mmc_init_host(host);
 	sunxi_mmc_set_bus_width(host, mmc->ios.bus_width);
 	sunxi_mmc_set_clk(host, &mmc->ios);
+	enable_irq(host->irq);
 
 	return 0;
 }
@@ -1455,6 +1456,7 @@ static int sunxi_mmc_runtime_suspend(struct device *dev)
 	struct mmc_host	*mmc = dev_get_drvdata(dev);
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
 
+	disable_irq(host->irq);
 	sunxi_mmc_reset_host(host);
 	sunxi_mmc_disable(host);
 
-- 
2.7.4

