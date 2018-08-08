Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F06C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83892178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di7hTdLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83892178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeHHUSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:18:53 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37850 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeHHUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:18:53 -0400
Received: by mail-ua0-f193.google.com with SMTP id y10-v6so3356733uao.4;
        Wed, 08 Aug 2018 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ruMmZ6ayWYll/SPsmZj99uG0U1nHL/FmOks8EaMER2E=;
        b=di7hTdLFpmEpvnzyEApTGHJnSsbCoxciwm3KpotUf4NemDzpYQP2a3QPD+t3L/eO5g
         UvUZR2YgErIB8UKworttEGK7kTijvrQENx3y1xQoScqdEcX6JT5s1XXp4IFHBI1CgHMy
         cCYFRE4/PmGqpjGiQMxuAikinV24rWQl3L9nGZS+snle2UF57ofdCg4uwpG1/haHukFt
         Hf5Z43+4IHXw+i2I5bMC6zzgEurhB20cIc5nypj6KryaTSCzE78Ggz1GgJzWpKhG7nWr
         6b2ZprvTzTerqfBtkLiFaVu9Ntj3KpqB6oEIiFjBi//Gb6YgegJa3ppUgn9z0T5vxn/L
         gCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ruMmZ6ayWYll/SPsmZj99uG0U1nHL/FmOks8EaMER2E=;
        b=LW4PlehWrqn3iJvzUs5y+t66kN5xy4e/iJI37hOHUpJCxz6jVZwgLC2DqTZhGEuP/W
         3PAizKXB2i4bDykvD9MSbvLbc0dB/4kkScFYHxgzIckxJVj/jHfJUEqmF5BL0AXTUQV1
         JusDXNR8gRCn631+j5kVxZdBmwmSHeDIkxiaFFNf5OY2IQvf90lg5bhfE7jhBjotzhcn
         L89iXR23MxIJFmKnzlFYIw0wYicYrDOeAgNYeUKO24G+9ivLWReq8CwihmvRCYYy9J4W
         HPx8P2Fp987OFcLuD8LfBPJueAmBmMS4NOfZmhsvroNC+T/p5EQ2OwEQd3Inbn3Qwb/B
         7fmQ==
X-Gm-Message-State: AOUpUlHgg5+eJqULUu3y+n0GkJUveH5RgDnY33knJ01R+9t02cJJr4T2
        rBDnim/BSAHNp8R0GXqqKUqdtJb2aSZi6N+43qA=
X-Google-Smtp-Source: AA+uWPwMjZCo6U83sUH/dTJ8D6B3cy1JWaDhx0oT5FjzSxxED1XyUSfNJh+xcsYRTIU1FT5QXj5MoJHBGkHFNjjfG4U=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr2864710uac.49.1533751085403;
 Wed, 08 Aug 2018 10:58:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 10:58:04 -0700 (PDT)
In-Reply-To: <20180808153150.23444-28-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-28-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 20:58:04 +0300
Message-ID: <CAHp75VdBkSHtqXkzRJgOHwaL5UhgV+TgySjEs57bisbKTpO4SQ@mail.gmail.com>
Subject: Re: [PATCH 27/28] ARM: davinci: mityomapl138: use device properties
 for at24 eeprom
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
>
> Remove the at24_platform_data structure and replace it with an array
> of property entries. Drop the byte_len/size property, as the model name
> already implies the EEPROM's size.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-mityomapl138.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index 17b67e26bc0e..be0fb7d17e25 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -14,11 +14,11 @@
>  #include <linux/init.h>
>  #include <linux/console.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/notifier.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/i2c.h>
> -#include <linux/platform_data/at24.h>
>  #include <linux/etherdevice.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/flash.h>
> @@ -185,10 +185,9 @@ static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
>         }
>  };
>
> -static struct at24_platform_data mityomapl138_fd_chip = {
> -       .byte_len       = 256,
> -       .page_size      = 8,
> -       .flags          = AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
> +static const struct property_entry mityomapl138_fd_chip_properties[] = {
> +       PROPERTY_ENTRY_U32("pagesize", 8),
> +       PROPERTY_ENTRY_BOOL("read-only"),
>  };
>
>  static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
> @@ -317,7 +316,7 @@ static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
>         },
>         {
>                 I2C_BOARD_INFO("24c02", 0x50),
> -               .platform_data = &mityomapl138_fd_chip,
> +               .properties = mityomapl138_fd_chip_properties,
>         },
>  };
>
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
