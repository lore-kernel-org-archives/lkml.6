Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDCBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92FA2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfBGQ3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:29:36 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56435 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfBGQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:29:15 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 4BC2D1BF208;
        Thu,  7 Feb 2019 16:29:12 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 3/5] gpio: use new gpio_set_config() helper in more places
Date:   Thu,  7 Feb 2019 17:28:57 +0100
Message-Id: <20190207162859.26252-4-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
References: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Linus Walleij, let's use the new gpio_set_config()
helper in gpiod_set_debounce() and gpiod_set_transitory().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/gpio/gpiolib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cf8a4402fef1..9762a836fec9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2762,7 +2762,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 	}
 
 	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
-	return chip->set_config(chip, gpio_chip_hwgpio(desc), config);
+	return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 
@@ -2799,7 +2799,7 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
 	packed = pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
 					  !transitory);
 	gpio = gpio_chip_hwgpio(desc);
-	rc = chip->set_config(chip, gpio, packed);
+	rc = gpio_set_config(chip, gpio, packed);
 	if (rc == -ENOTSUPP) {
 		dev_dbg(&desc->gdev->dev, "Persistence not supported for GPIO %d\n",
 				gpio);
-- 
2.20.1

