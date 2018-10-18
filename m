Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1D8ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F0D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F0D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJRIMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:12:52 -0400
Received: from dliviu.plus.com ([80.229.23.120]:40424 "EHLO smtp.dudau.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJRIMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:12:52 -0400
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 1993651E5478;
        Thu, 18 Oct 2018 01:14:37 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Thu, 18 Oct 2018 01:14:37 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu@dudau.co.uk>
Subject: [PATCH] leds: gpio: set led_dat->gpiod pointer for OF defined GPIO leds
Date:   Thu, 18 Oct 2018 01:14:32 +0100
Message-Id: <20181018001432.710-1-liviu@dudau.co.uk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
removed the common code path that set the led_dat->gpiod pointer in
create_gpio_led(), but only added it back for the devices that have
a valid gpio_led_platform_data structure. Calling gpio_leds_create()
in gpio_led_probe() is not enough to get a valid gpiod pointer.

Fortunately enough, gpio_leds_create() already gets the needed pointer,
we just need to assign it to the relevant gpio_led_data structure.

Fixes: 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
---

Hi,

I found this issue while testing linux-next-20181017, I don't know how
stable the leds for-next tree is in terms of commit IDs, if that gets
rebased then the Fixes commit ID needs updating.

Best regards,
Liviu

 drivers/leds/leds-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 32fa752565bc..45e012093865 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -163,6 +163,8 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 			return ERR_CAST(led.gpiod);
 		}
 
+		led_dat->gpiod = led.gpiod;
+
 		fwnode_property_read_string(child, "linux,default-trigger",
 					    &led.default_trigger);
 
-- 
2.19.0

