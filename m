Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1DFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F1420865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4wSs4eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F1420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeKYW3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:29:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44664 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKYW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:29:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so4837787pgr.11;
        Sun, 25 Nov 2018 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fdhjR1JE2FdUYSHtK0S6vtUqhtXtYzhy3g4QOnsuv0w=;
        b=e4wSs4eGL8MwfK6CpxLqHc5DqfGPne1vXODGFX04LhQXpIRc6nHPfQEHMqlFxGVwyx
         uEHmh2NFb+vIyB5cWoveG7nZ3YJSzY2R6kJOfHblcBiwiPl9K17FeMSW6fbjUYbdd9wb
         AWtrIfNL0keuYncxfXzANmhgDIIFZIHV9qjApC+x2WsMZSxl7n4N5tWLNGw+ColznuhB
         WhrqxLlm0bWWxz+eayBNQbqDYgU3okKveciPV/kOGxZPt0ZnnC5uvFz+ECnlP+ec9MBf
         aPrNGhFI9WmSUYv8upJjSdVXOB/2bcBA0X0j1Bwz2rEEWKHMdY6waE+oUGrES9UsuP46
         v2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fdhjR1JE2FdUYSHtK0S6vtUqhtXtYzhy3g4QOnsuv0w=;
        b=t38Ho9A8DNnokVnfIQZjm/YPYPOrL9IBfgKy+b6UB33i3ZVdejf1joqm9oedQp9trO
         Y9BH3dT4ubXZitHlMQTdHaBq8UnK3bbDiTVAdrd2mbIRTDxifLNoWz8/5sb+8ThhFyzd
         aVlWv+XitulfxihupDtLDw7Xp26AnpTPsBPQc+RunvGmUPluIWEwJhAX79y+XTHaiNzc
         KOGbUS2GUJuCSD29s4Mw1OOpCadPJI6Q/fj9lrHxYpe//kIq8o8Xi9nf/DQT2SdqmatW
         Vca8UVtUOd0FPGebyY41dOvwump5KgUd6I+kTY29JvXnNBZrMk4pc81mi+FB/8sIF1sL
         R4Og==
X-Gm-Message-State: AA+aEWYmtqgc9QdYX6d8npJGh7fqZzReOctucQzqQtFZw6QM5cuNJsEy
        i5ryfRJNzAQuN8ooCQOdt0s=
X-Google-Smtp-Source: AFSGD/U0YD9CvTKmxyV0ci2jJKYQOoC/gqzCNHN7dSSKjtNCdAcZapdQmjw7JFjyR0gs74Om0tJyEg==
X-Received: by 2002:a63:3287:: with SMTP id y129mr20734784pgy.337.1543145909898;
        Sun, 25 Nov 2018 03:38:29 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id r80sm5974464pfa.111.2018.11.25.03.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:38:29 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:08:23 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 18/26] Staging: fbtft: fb_bd663474: Switch to the gpio
 descriptor interface
Message-ID: <af953b8096c89f8248fabd7b728628005b5069eb.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_bd663474.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_bd663474.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_bd663474.c b/drivers/staging/fbtft/fb_bd663474.c
index a58c514f4721..b6c6d66e4eb1 100644
--- a/drivers/staging/fbtft/fb_bd663474.c
+++ b/drivers/staging/fbtft/fb_bd663474.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -24,8 +24,8 @@
 
 static int init_display(struct fbtft_par *par)
 {
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	par->fbtftops.reset(par);
 
-- 
2.17.1

