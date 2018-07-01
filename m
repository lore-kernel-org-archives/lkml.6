Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988CCC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5286025424
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5286025424
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966017AbeGAQqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:46:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965956AbeGAQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:46:10 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A66DACC;
        Sun,  1 Jul 2018 16:46:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 4.17 207/220] i2c: gpio: initialize SCL to HIGH again
Date:   Sun,  1 Jul 2018 18:23:51 +0200
Message-Id: <20180701160916.813301887@linuxfoundation.org>
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

commit 12b731dd46d9ee646318e6e9dc587314a3908a46 upstream.

It seems that during the conversion from gpio* to gpiod*, the initial
state of SCL was wrongly switched to LOW. Fix it to be HIGH again.

Fixes: 7bb75029ef34 ("i2c: gpio: Enforce open drain through gpiolib")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-gpio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -279,9 +279,9 @@ static int i2c_gpio_probe(struct platfor
 	 * required for an I2C bus.
 	 */
 	if (pdata->scl_is_open_drain)
-		gflags = GPIOD_OUT_LOW;
+		gflags = GPIOD_OUT_HIGH;
 	else
-		gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
+		gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
 	priv->scl = i2c_gpio_get_desc(dev, "scl", 1, gflags);
 	if (IS_ERR(priv->scl))
 		return PTR_ERR(priv->scl);


