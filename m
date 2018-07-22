Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768A2ECDFBD
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EDC20880
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EDC20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbeGVWSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:18:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:38792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387772AbeGVWSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:18:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 301FBAFD5;
        Sun, 22 Jul 2018 21:20:23 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 12/15] spi: img-spfi: Use device 0 configuration for all devices
Date:   Sun, 22 Jul 2018 23:20:07 +0200
Message-Id: <20180722212010.3979-13-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ionela Voinescu <ionela.voinescu@imgtec.com>

Given that we control the chip select line externally,
we can use only one parameter register (device 0 parameter
register) and one set of configuration bits (port configuration
bits for device 0) for all devices (all chip select lines).

Signed-off-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/spi/spi-img-spfi.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 0d73d31a6a2b..231b59c1ab60 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -437,18 +437,23 @@ static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
 	struct img_spfi *spfi = spi_master_get_devdata(master);
 	u32 val;
 
+	/*
+	 * The chip select line is controlled externally so
+	 * we can use the CS0 configuration for all devices
+	 */
 	val = spfi_readl(spfi, SPFI_PORT_STATE);
+
+	/* 0 for device selection */
 	val &= ~(SPFI_PORT_STATE_DEV_SEL_MASK <<
 		 SPFI_PORT_STATE_DEV_SEL_SHIFT);
-	val |= msg->spi->chip_select << SPFI_PORT_STATE_DEV_SEL_SHIFT;
 	if (msg->spi->mode & SPI_CPHA)
-		val |= SPFI_PORT_STATE_CK_PHASE(msg->spi->chip_select);
+		val |= SPFI_PORT_STATE_CK_PHASE(0);
 	else
-		val &= ~SPFI_PORT_STATE_CK_PHASE(msg->spi->chip_select);
+		val &= ~SPFI_PORT_STATE_CK_PHASE(0);
 	if (msg->spi->mode & SPI_CPOL)
-		val |= SPFI_PORT_STATE_CK_POL(msg->spi->chip_select);
+		val |= SPFI_PORT_STATE_CK_POL(0);
 	else
-		val &= ~SPFI_PORT_STATE_CK_POL(msg->spi->chip_select);
+		val &= ~SPFI_PORT_STATE_CK_POL(0);
 	spfi_writel(spfi, val, SPFI_PORT_STATE);
 
 	return 0;
@@ -548,11 +553,15 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 	div = DIV_ROUND_UP(clk_get_rate(spfi->spfi_clk), xfer->speed_hz);
 	div = clamp(512 / (1 << get_count_order(div)), 1, 128);
 
-	val = spfi_readl(spfi, SPFI_DEVICE_PARAMETER(spi->chip_select));
+	/*
+	 * The chip select line is controlled externally so
+	 * we can use the CS0 parameters for all devices
+	 */
+	val = spfi_readl(spfi, SPFI_DEVICE_PARAMETER(0));
 	val &= ~(SPFI_DEVICE_PARAMETER_BITCLK_MASK <<
 		 SPFI_DEVICE_PARAMETER_BITCLK_SHIFT);
 	val |= div << SPFI_DEVICE_PARAMETER_BITCLK_SHIFT;
-	spfi_writel(spfi, val, SPFI_DEVICE_PARAMETER(spi->chip_select));
+	spfi_writel(spfi, val, SPFI_DEVICE_PARAMETER(0));
 
 	if (!list_is_last(&xfer->transfer_list, &master->cur_msg->transfers) &&
 		/*
-- 
2.16.4

