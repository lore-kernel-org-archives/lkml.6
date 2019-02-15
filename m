Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DB7C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAFC2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnKSRHdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390141AbfBOHhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:37:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34601 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfBOHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:37:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so4421514pgd.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 23:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ss0OJ5BCI4F+c8Tn3mN8EpXhDNG3dZjBEBOVvg5GYo=;
        b=QnKSRHdI7j/4NE1JJs1G/HgSEfjKlc04T3AMk3v7angqLRKNNkSt10cHmnQaafY9oc
         p7giF1HAYDoK5L7wF5TqQOMG2XzIS3J4UWauIMWAO7fCXVt0JFWk/U/oftdhi0vZ5hZW
         nyaB2y5NGOuAe88BOfdbqTTna0a13LYCrZHklvJEZJvM53U+dclhYhrdlMGcfd4PdBNv
         CpVFqEZ6isCq2m7o+ggohnanQQ78PWV/a3WwSuJ4YzsdFGAxYrgOZkX8v37V6hmWoYxw
         K38uPtF46aLbkFerxgQByKH1I3MvA7lMGchgjNIak7TQlDis1STVzXzAPxXJ21xmdm8Z
         SW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ss0OJ5BCI4F+c8Tn3mN8EpXhDNG3dZjBEBOVvg5GYo=;
        b=f1dsSjXF1FTevZWFMZnoaiNTtSl92eb5DV7bNa/ELjUnjKQtXSQRePfAj+ogk9alO4
         ohRBN5U3ACucg7uzcLnFQM2cQynXFlNunDayUL1xRG7ueQA8t20mBvOt4DHLbP+iinT4
         OKwok65ks9OgJ0jJ1DEigQjD1whHlIqsMF3vuKDgYGZXLRbUn0NQLMwbHD1VJOHPeuBk
         InP/8Poi1pjc6HRwnljF14aXjKqUcczmj3N01cV5jRmhRZBlo2qmVlkFmU1NH9h6hXJo
         02kz/PZ7SaSRrDL0bhy9RZW7Lzq3JS8d0fvPRJMYJf2vlgP3ysSSROCOTjVe6V2tyn8r
         4dow==
X-Gm-Message-State: AHQUAubKUqpF7VaSPockI5bR6uzdJzGt2Om8OcAP5tnbkjrreAsR4W/u
        pr+bw5Am4oB7SeJgTvD9QF8=
X-Google-Smtp-Source: AHgI3IbmIs9kstanvYsfH89FM86un6uslYJO+zS1lu31Z/b3ycAp7EDRCu70RdouroNHmG0e/3aeiA==
X-Received: by 2002:a63:5922:: with SMTP id n34mr4124308pgb.435.1550216268956;
        Thu, 14 Feb 2019 23:37:48 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k128sm5974558pfc.34.2019.02.14.23.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 23:37:48 -0800 (PST)
Date:   Thu, 14 Feb 2019 23:37:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 01/37] input: davinci_keyscan: remove unnecessary
 includes
Message-ID: <20190215073746.GA187705@dtor-ws>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214145231.8750-2-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:51:55PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The mach/ and asm/ includes are not needed in davinci_keyscan, but they
> will cause build problems once we make mach/irqs.h a private header for
> mach-davinci.
> 
> Remove all unused header includes.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/keyboard/davinci_keyscan.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
> index b20a5d044caa..b4db72f833ca 100644
> --- a/drivers/input/keyboard/davinci_keyscan.c
> +++ b/drivers/input/keyboard/davinci_keyscan.c
> @@ -32,10 +32,6 @@
>  #include <linux/errno.h>
>  #include <linux/slab.h>
>  
> -#include <asm/irq.h>
> -
> -#include <mach/hardware.h>
> -#include <mach/irqs.h>
>  #include <linux/platform_data/keyscan-davinci.h>
>  
>  /* Key scan registers */
> -- 
> 2.20.1
> 

-- 
Dmitry
