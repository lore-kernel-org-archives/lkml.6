Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC38C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B4D20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyV8hPjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B4D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeJHWhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbeJHWhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:37:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 454DC2087C;
        Mon,  8 Oct 2018 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012332;
        bh=6VgWlnGGEW3FaZTIn6CRcVUXyH23EcSORV6XsXNKxzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyV8hPjQ0Djqpapj4q3iOfNcTZqyViNuf3guHVAabVOAAhSkxymk3ueApNbiSFg7A
         mprQzAxns97G/sL3Ok0sp7+mJL4UjyDucqg5VzHGDpae1mg/uEq/SW2QKYg6Xx9L7V
         Bhtkrrgbljl8GPiDEkuk9n69nYOKA2OdEMEMx3xs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 05/58] spi: gpio: Fix copy-and-paste error
Date:   Mon,  8 Oct 2018 11:24:30 -0400
Message-Id: <20181008152523.70705-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 1723c3155f117ee6e00f28fadf6e9eda4fc85806 ]

This fixes an embarrassing copy-and-paste error in the
errorpath of spi_gpio_request(): we were checking the wrong
struct member for error code right after retrieveing the
sck GPIO.

Fixes: 9b00bc7b901ff672 ("spi: spi-gpio: Rewrite to use GPIO descriptors")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 6ae92d4dca19..3b518ead504e 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -287,8 +287,8 @@ static int spi_gpio_request(struct device *dev,
 		*mflags |= SPI_MASTER_NO_RX;
 
 	spi_gpio->sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
-	if (IS_ERR(spi_gpio->mosi))
-		return PTR_ERR(spi_gpio->mosi);
+	if (IS_ERR(spi_gpio->sck))
+		return PTR_ERR(spi_gpio->sck);
 
 	for (i = 0; i < num_chipselects; i++) {
 		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs",
-- 
2.17.1

