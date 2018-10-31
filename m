Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C36ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A679120821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cboV/Zrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A679120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbeKAIIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbeKAIIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A002F20840;
        Wed, 31 Oct 2018 23:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027323;
        bh=0vLOTSa95C260lCg9o/3z1dplJDXNzhfGv3hOOLryuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cboV/ZrzWzqk6HbpHGIH6G9AVAAjk7qYDKRJoxC2SnkMjtcAMSZvHXO1iwIlgbb/o
         bB08EwqbPachJfGiNyYIpeC0ZTYJkhg+C380A+1KlpwxOlfpUOKUYWsWtFlHQHqm/x
         W35Vg92sLR0yZ9SGaXxkaHwSJpsLHi2Ddj3Ls95c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 053/126] spi: gpio: No MISO does not imply no RX
Date:   Wed, 31 Oct 2018 19:06:41 -0400
Message-Id: <20181031230754.29029-53-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
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
index 3b518ead504e..b82b47152b18 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -282,9 +282,11 @@ static int spi_gpio_request(struct device *dev,
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
@@ -408,7 +410,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	spi_gpio->bitbang.master = master;
 	spi_gpio->bitbang.chipselect = spi_gpio_chipselect;
 
-	if ((master_flags & (SPI_MASTER_NO_TX | SPI_MASTER_NO_RX)) == 0) {
+	if ((master_flags & SPI_MASTER_NO_TX) == 0) {
 		spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
 		spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
 		spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
-- 
2.17.1

