Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8092CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280432084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/2j1GM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280432084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeJYXjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:39:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38970 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJYXjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:39:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id e3-v6so934759oiy.6;
        Thu, 25 Oct 2018 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JUnRTqMEfKcn0lcCeaLiL6wcpcd5y5EPPrZIipkB1Iw=;
        b=d/2j1GM/EiaBIDlUpqpYUAwYnZzfqmAnzu6jYKV9NagcgSm/06/FNkm4rEDaZaXluR
         HM4+VLRPviZ1n6PVVToNGZZuNIpWk1k8ogb/i7BwS2/Ez2esavF5qw0aKjxEuH7dWQJg
         QaiiVOghP+QPNdfFFSPFljOSYlTEBRuVTHArRaQxcx30FhLe2/S8hCQ2cSWFDtBX7jrV
         aztjFwSsePKMDTYztF/Hmjh49cZSLEkgOcw/y0AQcnZ2JSBgW5pnpzL3nMh4bHY2Dk2E
         d7cb2b/j3niTjA/LdHCAdpIiNw7yL5wX7TP5DptorbcOAs0PCUDuvX8m8F1np1I4NQp6
         Gu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JUnRTqMEfKcn0lcCeaLiL6wcpcd5y5EPPrZIipkB1Iw=;
        b=MpNT+9Rv1c7geKfdZ/sN0JDKDrfT42NRd27wSy0NKHfGBeD5RuOIu9Ii2xUXcJcHB7
         3/LLSyGii0FM1/jLz9Dm3ma4Ry/JXbc9Ivdgiywe6UDsrFvq1ejcpZxcNu1zyjrG7FD8
         kjyttjlvws8hl8PLUMoNj4MhJZOUDfMEM4aYKW/6sTB9ArFouQFMGWj6sbhoVpRZbEm1
         XKbK9F2+hEZYPmgI+99lz4SCfN4k4AxTvwbdBnCyqbbsnhE2sl993k1RKFELgYSI9SGN
         1b/eKunE8RlFeXMjbzJB0KoOCK84YlcY2QYGH0WhOBMamsb5gz47U16WeL4/NJG011he
         X9oA==
X-Gm-Message-State: AGRZ1gKzJpVK4coH4x4/5kb6/NfJrJijaYyqUH1od1ZwHSiBdiXXXuy4
        YZgGOetd9J+6Dy+ptX749EmxzCmZeikJT/wcxyc=
X-Google-Smtp-Source: AJdET5c2wnf8lbfyBH7TMJg9ihJ0hm8oRhg+2Dw14wNW1D6V57LZIyvOneuxgw92TBU0khJkgcWjyRby+Fu5OwCbZW0=
X-Received: by 2002:aca:ac4:: with SMTP id k65-v6mr669177oiy.265.1540479973532;
 Thu, 25 Oct 2018 08:06:13 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Sneddon <dan.sneddon@gmail.com>
Date:   Thu, 25 Oct 2018 08:06:01 -0700
Message-ID: <CACceFXdF9XQS6WeSWvO=EKUEGnKwG_VkqUOECA3kJY-Hy72fjQ@mail.gmail.com>
Subject: [PATCH] leds: gpio: Fix gpiod for DT based devices
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
failes to set the gpio descriptor for DT based machines.  Since the
value being passed in is always 0 the descriptor fails the validation
check but does so silently.  This means the driver probes successfully
even though it can't actually control the gpio line.  This patch sets
the gpio descriptor in the path taken by DT based devices.

Fixes: 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
Signed-off-by: Dan Sneddon <dan.sneddon@gmail.com>
---
 drivers/leds/leds-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 32fa752..e0e57c2 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -162,6 +162,7 @@ static struct gpio_leds_priv
*gpio_leds_create(struct platform_device *pdev)
            fwnode_handle_put(child);
            return ERR_CAST(led.gpiod);
        }
+       led_dat->gpiod = led.gpiod;

        fwnode_property_read_string(child, "linux,default-trigger",
                        &led.default_trigger);
-- 
2.7.4
