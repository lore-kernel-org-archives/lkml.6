Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F4EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB6421473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7adaQBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB6421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeJSCAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeJSCAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:00:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AF96204FD;
        Thu, 18 Oct 2018 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885497;
        bh=KpkIhfUWWI2STJw5E1neyY0B7yhgx5EGjKS/7ohjtjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7adaQBNVCtPNFlpkIL/ELFFbUb6+Obc57ap3KnuEeFrceMRszermlQcKkZ76hfd0
         TS7TdcJf5503VV2sFjU276jQYr7wJ5ywk1Kzf2GQ9kEwatihvGph/w2W0PAwiMDJ2a
         tb0tO6610zc4ziumeYkMHIMgH8oph36ws9QkwTF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 05/53] spi: gpio: Fix copy-and-paste error
Date:   Thu, 18 Oct 2018 19:53:58 +0200
Message-Id: <20181018175417.531136990@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-gpio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -287,8 +287,8 @@ static int spi_gpio_request(struct devic
 		*mflags |= SPI_MASTER_NO_RX;
 
 	spi_gpio->sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
-	if (IS_ERR(spi_gpio->mosi))
-		return PTR_ERR(spi_gpio->mosi);
+	if (IS_ERR(spi_gpio->sck))
+		return PTR_ERR(spi_gpio->sck);
 
 	for (i = 0; i < num_chipselects; i++) {
 		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs",


