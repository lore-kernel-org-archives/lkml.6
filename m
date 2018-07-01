Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B108C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022C62563B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022C62563B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031495AbeGAR1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:27:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031428AbeGAQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:37:29 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E63AACC;
        Sun,  1 Jul 2018 16:37:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.17 023/220] mmc: renesas_sdhi: really fix WP logic regressions
Date:   Sun,  1 Jul 2018 18:20:47 +0200
Message-Id: <20180701160909.322850655@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit ef5332c10d4f332a2ac79e9ad5452f4e89d1815a upstream.

This reverts commit e060d376cc61 ("mmc: renesas_sdhi: fix WP detection")
and adds some code to really fix the regressions.

It was missed so far that Renesas R-Car instantiations of SDHI chose to
disable internal WP and used the existence of "wp-gpios" to en/disable
WP at all.

With the first refactoring by Yamada-san with commit 2ad1db059b9a ("mmc:
renesas_sdhi: use MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own flag"),
WP was always disabled even when GPIOs were present. With Wolfram's
first fix which gets now reverted, GPIOs were honored. But when not
available, the fallback was to internal WP and not to disabled WP. This
caused wrong WP status on uSD card slots.

Restore the old behaviour now. By default, WP is disabled. When a GPIO
is found, the GPIO re-enables WP. We will think about possible better
ways to handle this in the future.

Tested on a previously regressing Renesas Lager board (H2) and a still
working Renesas Salvator-X board (M3-W).

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/renesas_sdhi_core.c          |    5 +++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |    1 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |    3 +++
 3 files changed, 9 insertions(+)

--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -28,6 +28,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_dma.h>
 #include <linux/delay.h>
@@ -534,6 +535,10 @@ int renesas_sdhi_probe(struct platform_d
 	host->multi_io_quirk	= renesas_sdhi_multi_io_quirk;
 	host->dma_ops		= dma_ops;
 
+	/* For some SoC, we disable internal WP. GPIO may override this */
+	if (mmc_can_gpio_ro(host->mmc))
+		mmc_data->capabilities2 &= ~MMC_CAP2_NO_WRITE_PROTECT;
+
 	/* SDR speeds are only available on Gen2+ */
 	if (mmc_data->flags & TMIO_MMC_MIN_RCAR2) {
 		/* card_busy caused issues on r8a73a4 (pre-Gen2) CD-less SDHI */
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -87,6 +87,7 @@ static const struct renesas_sdhi_of_data
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 	.bus_shift	= 2,
 	.scc_offset	= 0x1000,
 	.taps		= rcar_gen3_scc_taps,
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -42,6 +42,7 @@ static const struct renesas_sdhi_of_data
 static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 };
 
 /* Definitions for sampling clocks */
@@ -61,6 +62,7 @@ static const struct renesas_sdhi_of_data
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.dma_rx_offset	= 0x2000,
 	.scc_offset	= 0x0300,
@@ -81,6 +83,7 @@ static const struct renesas_sdhi_of_data
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 	.bus_shift	= 2,
 	.scc_offset	= 0x1000,
 	.taps		= rcar_gen3_scc_taps,


