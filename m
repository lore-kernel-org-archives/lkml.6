Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA9CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847872084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qce3eiB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847872084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeKYWUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:20:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45419 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:20:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so12490518plm.12;
        Sun, 25 Nov 2018 03:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JrmUXIhEdvyW3/PDf9Qjnqq6eYljvs81GxqFgkMOUjo=;
        b=qce3eiB9xqRmxyHvYEaT+RNRBo2Ui+8VAUlkH8OgGBsCvB0ZFKMdeOMKpVroR9djDM
         ke4n2TBrYI6Woy5i1cBXWBCdZFBPGWysD9qtDiFgWkIvhsqRlNB6fHBhE6j6qwe6B7Ra
         UaL+rUm0Y6XLMBpnWXX+XDBWGaTv8BRLBUynhjGNx5fxNBeWWbH/V0taqt357QJXVuMK
         LlT40CENDemEDshBE5YK90SXEbAEz6J4E0152wIGEhozapGTHDTc25Kg612y6zh5hFaB
         ZRJSKnWvw6mkVydMxYpa2vzDkA/JsaMYtDhODHMGutrt0HKmOgaA9Wr4Gkcve9O3ElcJ
         fsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JrmUXIhEdvyW3/PDf9Qjnqq6eYljvs81GxqFgkMOUjo=;
        b=uG5fV/R129eoICr4VfCJKrJD8Oq4OKr01vbCpmY4anu+Gt9E9nJacjFWC6zLPOHlIG
         yhagaMcJyh6LutGs6P150ElSg4t0CLAodhb9N3GNjBpqozqdr6L6gWoe8CCRUlBRL15u
         Aao6tQL0DlWpBQYl7Al5sTidvbgapnBqf4bHWe+fnMktra+/GylJMMAj0LsV2+1JKGVU
         u3dEGe/kV+6Wepdv3gb9C2TX1lOyrBv4zX3ASWWgTWv55XC5zkkH+3vUKVnKAAX4QRa/
         LB7RPnqBZDm3aiHJnIKCIO4qoH+I+BrTTLk+eU5yznJfSeDGeeeHEg396GfbCQwYX7Lc
         SDsQ==
X-Gm-Message-State: AA+aEWZdbcFvj3Aez7PmOWtaYLn/KGKu7xl40VgLYYe6wcXMxv5xs9G+
        WS6BO9mWaqMarTOK4l4gN+g=
X-Google-Smtp-Source: AFSGD/UBug36aWCimuHDrNIAWO1p89jYRZXLbbC/WpcJniG1zzme4nBc/B7JfTRjZV89NiJBX3s0jQ==
X-Received: by 2002:a17:902:4c08:: with SMTP id a8mr23380200ple.74.1543145396360;
        Sun, 25 Nov 2018 03:29:56 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id d2-v6sm16946778pfj.106.2018.11.25.03.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:29:55 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:59:50 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 08/26] Staging: fbtft: fb_uc1611: Switch to the gpio
 descriptor interface
Message-ID: <d82350e345de07d6dee448a3199cfa0f0b568171.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_uc1611.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_uc1611.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_uc1611.c b/drivers/staging/fbtft/fb_uc1611.c
index dfaf8bc70f73..65681d0fe200 100644
--- a/drivers/staging/fbtft/fb_uc1611.c
+++ b/drivers/staging/fbtft/fb_uc1611.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -251,7 +251,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			}
 			break;
 		}
-		gpio_set_value(par->gpio.dc, 1);
+		gpiod_set_value(par->gpio.dc, 1);
 
 		/* Write data */
 		ret = par->fbtftops.write(par, par->txbuf.buf, len / 2);
-- 
2.17.1

