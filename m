Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC6CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161FE20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zYGfEk18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161FE20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeKAIGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbeKAIGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E0420847;
        Wed, 31 Oct 2018 23:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027198;
        bh=WAXB0/E6x4DAvDqq1CJ3xnMFuKPtDE5Y1k20A+UwjEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYGfEk18zhe4zRVbnNm6ZsacRUg3qW7OHJ+2nLuFOhUKwz8KJq2u0iI5xqbn6oZgs
         6WBseVcoKycgZochrehrIQgOKsPjn2RoTJ+26wPDNBQOSy5uUQJRwHFkRPXV/8gm4R
         eqPtqkCVlfANcT40/9LGg8WDASlvu41ICSuo1DM4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 061/146] spi: gpio: No MISO does not imply no RX
Date:   Wed, 31 Oct 2018 19:04:16 -0400
Message-Id: <20181031230541.28822-61-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit abf5feef3ff0cefade0c76be53b59e55fdd46093 ]

There is a logical problem in spi-gpio with host just
assigning a MOSI line and no MISO: this is interpreted
as the host cannot do RX and the host is flagged with
SPI_MASTER_NO_RX.

This is wrong: since GPIO lines can switch direction,
in 3WIRE operation the host will simply reverse the
direction of the GPIO line and start reading from it,
there is even code for doing this in the driver, but
it went unnoticed because it was tested by using a
master with 4 wires but a device using just 3 wires.

Remove the offending flag.

Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-gpio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 421bfc7dda67..088772ebef9b 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -295,9 +295,11 @@ static int spi_gpio_request(struct device *dev,
 	spi_gpio->miso = devm_gpiod_get_optional(dev, "miso", GPIOD_IN);
 	if (IS_ERR(spi_gpio->miso))
 		return PTR_ERR(spi_gpio->miso);
-	if (!spi_gpio->miso)
-		/* HW configuration without MISO pin */
-		*mflags |= SPI_MASTER_NO_RX;
+	/*
+	 * No setting SPI_MASTER_NO_RX here - if there is only a MOSI
+	 * pin connected the host can still do RX by changing the
+	 * direction of the line.
+	 */
 
 	spi_gpio->sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
 	if (IS_ERR(spi_gpio->sck))
@@ -423,7 +425,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	spi_gpio->bitbang.chipselect = spi_gpio_chipselect;
 	spi_gpio->bitbang.set_line_direction = spi_gpio_set_direction;
 
-	if ((master_flags & (SPI_MASTER_NO_TX | SPI_MASTER_NO_RX)) == 0) {
+	if ((master_flags & SPI_MASTER_NO_TX) == 0) {
 		spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
 		spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
 		spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
-- 
2.17.1

