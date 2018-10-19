Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654ECECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097EE2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRLmnZEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097EE2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJSV4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:56:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34796 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJSV4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:56:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id o17-v6so38371721qtr.1;
        Fri, 19 Oct 2018 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufWBQfM2kbZrdDzh9HvQ+8set22R/DcaspBmj9YUF8I=;
        b=QRLmnZEqeLKvF8AZbOgfvuJugXFxI3y5HKwYhSPjNSfKEzwnjQ82uNOuuyuj+YWmxG
         ZwBEDRP42NjVvfgA8QZfTsFfYKnHUUK0PG08J2YdlavK7/gqYwp0fHBqMKbaGq0Q15LW
         76uiBbe94DewGE9i+VCuF4T2n7dsH6CLmzNm8xrj73p5v0pSiQOw1TsaObX5TOjpVTJx
         GRue7SCIpRSTEhK9+GuKOxr1ROFmRRKVoWC5ua/A/FNOxKfV/kifu6TM9BTS2EXQwI+z
         soUgi/+6zphESh+83LC0WspoGn0q4AO9Pl4euejnzhEVFhxJT2eDkOZsSuEqU1aQicJw
         lCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufWBQfM2kbZrdDzh9HvQ+8set22R/DcaspBmj9YUF8I=;
        b=lMKofWN4yW63DyKncfH0ZJ1xouS1xY82rUXSslUwG98WykaHqQZlYz5C2tDLLOzUff
         d0WsJWyDO4ms4rwrLJ9MNbtUC2QygF02HJYsfUAas5gvllnV9CidXKJ8xwhVla/zPxpA
         v4fnRtvLFa83bb9IggCGt4BFDwjAGFmbCz3OYUjXPt1N7gUMx+qoybRREgJ7FfeIDLh0
         TnjkVi35bR99qhXsm/J+p4yn49OUT57rwt8nOIMVPlF6ovBZePdhdFvwrjcWJu7BO71Y
         lorPMtyG0VojgWevpZIERqzhQfWeQRAyNz+asoQaldOL4FSCGDNue1o9LRULtOhjW0by
         toQg==
X-Gm-Message-State: AGRZ1gK2weCb1uJ/OWxOwy/ZK4CIEwT9f5pZsWsbAl/KQeU/tDvznWk5
        VoNsIQ+KmprUrrqcV+m1sMTjj73wDm2PwMGfVuI=
X-Google-Smtp-Source: ACcGV61zHqE1iNyeJqMZudL/+hdAt/RcKe8ivYvstqjrKY042WRTRruLDCCN1ohNxdccLxOh4EQwafnwifMjeXj1FaI=
X-Received: by 2002:ac8:191a:: with SMTP id t26-v6mr1417499qtj.327.1539957027503;
 Fri, 19 Oct 2018 06:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-15-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-15-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:50:16 +0300
Message-ID: <CAHp75VcQVv-WToo-Lf1uUG0YOhusDqRN3x6HAGt-ccSbp5B+xg@mail.gmail.com>
Subject: Re: [PATCH 14/15] power: supply: olpc_battery: Avoid using platform_info
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:24 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> This wouldn't work on the DT-based ARM platform. Let's read the EC version
> directly from the EC driver instead.
>
> This makes the driver no longer x86 specific.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/power/supply/Kconfig        |  2 +-
>  drivers/power/supply/olpc_battery.c | 35 +++++++++++++++++++++--------
>  2 files changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index ff6dab0bf0dd..f0361e4dd457 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -151,7 +151,7 @@ config BATTERY_PMU
>
>  config BATTERY_OLPC
>         tristate "One Laptop Per Child battery"
> -       depends on X86_32 && OLPC
> +       depends on OLPC
>         help
>           Say Y to enable support for the battery on the OLPC laptop.
>
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index 2a2d7cc995f0..dde9863e5c4a 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -20,8 +20,6 @@
>  #include <linux/sched.h>
>  #include <linux/olpc-ec.h>

>  #include <linux/of.h>

Btw, Kconfig might miss
depends on OF
part.

> -#include <asm/olpc.h>
> -
>
>  #define EC_BAT_VOLTAGE 0x10    /* uint16_t,    *9.76/32,    mV   */
>  #define EC_BAT_CURRENT 0x11    /* int16_t,     *15.625/120, mA   */
> @@ -57,6 +55,7 @@ struct olpc_battery_data {
>         struct power_supply *olpc_ac;
>         struct power_supply *olpc_bat;
>         char bat_serial[17];
> +       int new_proto;
>  };
>
>  /*********************************************************************
> @@ -100,7 +99,7 @@ static const struct power_supply_desc olpc_ac_desc = {
>  static int olpc_bat_get_status(struct olpc_battery_data *data,
>                 union power_supply_propval *val, uint8_t ec_byte)
>  {
> -       if (olpc_platform_info.ecver > 0x44) {
> +       if (data->new_proto) {
>                 if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
>                         val->intval = POWER_SUPPLY_STATUS_CHARGING;
>                 else if (ec_byte & BAT_STAT_DISCHARGING)
> @@ -608,14 +607,32 @@ static int olpc_battery_probe(struct platform_device *pdev)
>         struct power_supply_config psy_cfg = {};
>         struct olpc_battery_data *data;
>         uint8_t status;

> +       unsigned char ecver[1];

isn't it simple
 uint8_t ecver;
?

> +       int ret;
> +
> +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +       platform_set_drvdata(pdev, data);
> +
> +       /* See if the EC is already there and get the EC revision */
> +       ret = olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, ecver, ARRAY_SIZE(ecver));

> +       if (ret) {

> +               if (ret == -ENODEV)
> +                       return -EPROBE_DEFER;

Yeah, exactly a question I asked somewhere in the first part of the series.

> +               return ret;
> +       }
>
> -       /*
> -        * We've seen a number of EC protocol changes; this driver requires
> -        * the latest EC protocol, supported by 0x44 and above.
> -        */
> -       if (olpc_platform_info.ecver < 0x44) {
> +       if (ecver[0] > 0x44) {
> +               /* XO 1 or 1.5 with a new EC firmware. */
> +               data->new_proto = 1;
> +       } else if (ecver[0] < 0x44) {
> +               /*
> +                * We've seen a number of EC protocol changes; this driver
> +                * requires the latest EC protocol, supported by 0x44 and above.
> +                */
>                 printk(KERN_NOTICE "OLPC EC version 0x%02x too old for "
> -                       "battery driver.\n", olpc_platform_info.ecver);
> +                       "battery driver.\n", ecver[0]);
>                 return -ENXIO;
>         }
>
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
