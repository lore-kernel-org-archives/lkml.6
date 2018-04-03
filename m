Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeDCPsb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:48:31 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:54300 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeDCPs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:48:29 -0400
X-Google-Smtp-Source: AIpwx48P3vQCvHLuwDx4+htts79Y3+fdlYrCVlG9bkqVfDY67y7u6/5I7rxe7d0cefsF9X3DnLRXyWsHjJC/1I8JVyw=
MIME-Version: 1.0
In-Reply-To: <1522250043-8065-3-git-send-email-tharvey@gateworks.com>
References: <1522250043-8065-1-git-send-email-tharvey@gateworks.com> <1522250043-8065-3-git-send-email-tharvey@gateworks.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 3 Apr 2018 08:48:27 -0700
Message-ID: <CAJ+vNU3-gaTcMAzo5wB6oSfE-JQC3NBVRJS5zFMTE-nVpD4F5g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mfd: add Gateworks System Controller core driver
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 8:14 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> The Gateworks System Controller (GSC) is an I2C slave controller
> implemented with an MSP430 micro-controller whose firmware embeds the
> following features:
>  - I/O expander (16 GPIO's) using PCA955x protocol
>  - Real Time Clock using DS1672 protocol
>  - User EEPROM using AT24 protocol
>  - HWMON using custom protocol
>  - Interrupt controller with tamper detect, user pushbotton
>  - Watchdog controller capable of full board power-cycle
>  - Power Control capable of full board power-cycle
>
> see http://trac.gateworks.com/wiki/gsc for more details
>
<snip>
> +
> +/*
> + * gsc_powerdown - API to use GSC to power down board for a specific time
> + *
> + * secs - number of seconds to remain powered off
> + */
> +static int gsc_powerdown(struct gsc_dev *gsc, unsigned long secs)
> +{
> +       int ret;
> +       unsigned char regs[4];
> +
> +       dev_info(&gsc->i2c->dev, "GSC powerdown for %ld seconds\n",
> +                secs);
> +       regs[0] = secs & 0xff;
> +       regs[1] = (secs >> 8) & 0xff;
> +       regs[2] = (secs >> 16) & 0xff;
> +       regs[3] = (secs >> 24) & 0xff;
> +       ret = regmap_bulk_write(gsc->regmap, GSC_TIME_ADD, regs, 4);
> +
> +       return ret;
> +}

Any feedback on the 'powerdown' sysfs attribute that hooks to this
function? This allows the GSC to disable the board primary power
supply for 2^32 seconds and is often used to 'reset' the board
although it could also be used to put the board in a power down state
longer. I'm wondering if there is a more appropriate API for this in
the kernel that I don't know about.

I would also like to register a restart handler using this but I
believe that ARM restart handlers currently can not use I2C - is that
correct?

Regards,

Tim
