Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E2C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959582084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK3hkyaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959582084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbeKLJZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:25:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388328AbeKLIUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:04 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9AE22241E;
        Sun, 11 Nov 2018 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975407;
        bh=uEE+maX4anxWe832eRc8HTTe6GeP0P4NUxUhUoHv17o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XK3hkyaG4cvV7BJCyLNTnGbFpa9Y3wktIMqs8c7t5Ftbu2oInL/FPV+YSQCXxi+W6
         BD04i3KbY9EzUwGNA7EgQ11Xw5JQXh7TPrfvPlu62vERVrckUgrjB0r+rBtS/CTCHt
         kNT+ZRDBhus6tJjbpBtI3vycOuhKQ3jNqqXbVyIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 114/350] spi: gpio: No MISO does not imply no RX
Date:   Sun, 11 Nov 2018 14:19:38 -0800
Message-Id: <20181111221711.865404438@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-gpio.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -282,9 +282,11 @@ static int spi_gpio_request(struct devic
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
@@ -408,7 +410,7 @@ static int spi_gpio_probe(struct platfor
 	spi_gpio->bitbang.master = master;
 	spi_gpio->bitbang.chipselect = spi_gpio_chipselect;
 
-	if ((master_flags & (SPI_MASTER_NO_TX | SPI_MASTER_NO_RX)) == 0) {
+	if ((master_flags & SPI_MASTER_NO_TX) == 0) {
 		spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
 		spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
 		spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;


