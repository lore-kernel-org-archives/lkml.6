Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439D0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C5220865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STK/sI4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C5220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeKYWeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:34:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41524 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKYWeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:34:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so5207752pfi.8;
        Sun, 25 Nov 2018 03:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s7KDGS2g9945OJKxXyEkR9XJTJ3Zw/MyL0Uox1bVuE0=;
        b=STK/sI4CtjMu4N7m/lmxoM/K5gXfk6P1BQOeGtzIOiSLuJdWljmUKYEQ/FR8ZbyRmQ
         yVHfQyw4LykwCAuXYFOv+pZceN8irBPGD5paHzCFNiFk/r+oAZ/SGvl2RYiNB8zF6ILp
         7K7N8nv9aALR+Jq4WzwfIU5UjMEKW6WmnTOSR0UdeNCuEaGHVQDFMqA/aVO5OMyRW6MT
         746zPcgiYQUmV84v0xSZYu/WK/K6iKvklmvbaIIqvjVgeZ8CHg76ivV5aaXQVuYm0xSD
         ac4/77B8cVDv93B4o8A7Jn5xwqtR5Ez4EMUEJdF++xQmeHH4/KEgATO5wckb8T3tEGF9
         bD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s7KDGS2g9945OJKxXyEkR9XJTJ3Zw/MyL0Uox1bVuE0=;
        b=S+9e1RpfKCkjBEguv1nb1hKK/d/CEgAuVDy6je3cm3SRKcHt8exuxc8C4lxfbTWEt+
         9pXvl1hRyX50kXQNgsSDXuE8jzEW9QiD5Ena0ljhJE6gB64gxLM7BT8MXjt8nNr5FcWO
         jOXZV7DeNrlN2Pc3+ZpVT4Lu0tkaZDLNGmsP0W/5yMtbG0t4Bg91nIS4wA4EEnW30B5H
         IqsSOEKQnqU7lWNiYZwpcaMo94X6xBeqNAUFR/5Q6xTpV8Zk8vfimZVMLJmzGucmnDcd
         DewWAqUV4e7muJ73cIAjxoz68T7IGZWgQVkGVLc/99ZwOGjUX+RXfZSI4mHEIMg1xwCd
         2yIw==
X-Gm-Message-State: AGRZ1gJ+DO4KTQGYJEM9BCgJk5IP1mEruMngB9t6mSf8pcSzWi1YAIyS
        4XQIA7ExqUrYr3g8n/kzI8UY7JNnCMJP4Q==
X-Google-Smtp-Source: AFSGD/UA2H+urTk+pRNFSdA125n2AUJphud+8JBRXLzuXwuVowqmskefm0omP0NxwK8pU31tKjCsrQ==
X-Received: by 2002:a63:4187:: with SMTP id o129mr19288350pga.370.1543146188172;
        Sun, 25 Nov 2018 03:43:08 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id t12sm61966149pfi.45.2018.11.25.03.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:43:07 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:13:01 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 24/26] Staging: fbtft: fb_tls8204: Switch to the gpio
 descriptor interface
Message-ID: <413693a296f8f890731369ccd755081466f81df7.1543142441.git.nishadkamdar@gmail.com>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the fb_tls8204.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_tls8204.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_tls8204.c b/drivers/staging/fbtft/fb_tls8204.c
index 277b6ed9c725..bec6dd0ffb01 100644
--- a/drivers/staging/fbtft/fb_tls8204.c
+++ b/drivers/staging/fbtft/fb_tls8204.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -94,7 +94,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 		/* The display is 102x68 but the LCD is 84x48.
 		 * Set the write pointer at the start of each row.
 		 */
-		gpio_set_value(par->gpio.dc, 0);
+		gpiod_set_value(par->gpio.dc, 0);
 		write_reg(par, 0x80 | 0);
 		write_reg(par, 0x40 | y);
 
@@ -109,7 +109,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			*buf++ = ch;
 		}
 		/* Write the row */
-		gpio_set_value(par->gpio.dc, 1);
+		gpiod_set_value(par->gpio.dc, 1);
 		ret = par->fbtftops.write(par, par->txbuf.buf, WIDTH);
 		if (ret < 0) {
 			dev_err(par->info->device,
-- 
2.17.1

