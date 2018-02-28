Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935463AbeB1WI6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:08:58 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39517 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935284AbeB1WIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:08:55 -0500
X-Google-Smtp-Source: AG47ELskW3R0kdtRa9ll8r5qfYsTIKWP7tzf+c9/NcRHlcpNVt4/4KAxIoBlR1WbBfn36TYSiY0qoy+ylRDj6K+KnYk=
MIME-Version: 1.0
In-Reply-To: <20180228214725.ewu3zt3l2xyxtxb2@tarshish>
References: <20180228134822.2194009-1-arnd@arndb.de> <20180228214725.ewu3zt3l2xyxtxb2@tarshish>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Feb 2018 23:08:54 +0100
X-Google-Sender-Auth: qPNSyquVh2-S3tQIwyCkbfvEBow
Message-ID: <CAK8P3a0nQmCk-qZEuEU2p6w6NNztLnk9UkejsVW=V5bvxXG3rQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: raspberrypi-ext: fix firmware dependency
To: Baruch Siach <baruch@tkos.co.il>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:47 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Arnd,
>
> Thanks for the fix.
>
> On Wed, Feb 28, 2018 at 02:48:08PM +0100, Arnd Bergmann wrote:
>> When the firmware driver is a loadable module, the gpio driver cannot be
>> built-in:
>>
>> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_set':
>> gpio-raspberrypi-exp.c:(.text+0xb4): undefined reference to `rpi_firmware_property'
>> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get':
>> gpio-raspberrypi-exp.c:(.text+0x1ec): undefined reference to `rpi_firmware_property'
>> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get_direction':
>> gpio-raspberrypi-exp.c:(.text+0x360): undefined reference to `rpi_firmware_property'
>> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get_polarity':
>> gpio-raspberrypi-exp.c:(.text+0x4d4): undefined reference to `rpi_firmware_property'
>> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_dir_out':
>> gpio-raspberrypi-exp.c:(.text+0x670): undefined reference to `rpi_firmware_property'
>> drivers/gpio/gpio-raspberrypi-exp.o:gpio-raspberrypi-exp.c:(.text+0x7fc): more undefined references to `rpi_firmware_property' follow
>> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_dir_in':
>> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_probe':
>> gpio-raspberrypi-exp.c:(.text+0x93c): undefined reference to `rpi_firmware_get'
>>
>> We already have a Kconfig dependency for it, but when compile-testing, it
>> is disregarded.
>>
>> This changes the dependency so that compile-testing is only done when the
>> firmware driver is completely disabled.
>
> What about the CONFIG_ARCH_BCM2835=y case? The combination of
> CONFIG_GPIO_RASPBERRYPI_EXP=y and CONFIG_RASPBERRYPI_FIRMWARE=m is still
> valid. Wouldn't that break the build?
>
> Isn't there a way in Kconfig to force CONFIG_GPIO_RASPBERRYPI_EXP=m when
> CONFIG_RASPBERRYPI_FIRMWARE=m?

The problem I ran into only happens with CONFIG_ARCH_BCM2835=y to
start with. My fix handles that case correctly, it forces
CONFIG_GPIO_RASPBERRYPI_EXP to be either 'n' or 'm'
when CONFIG_RASPBERRYPI_FIRMWARE=m.

> What about 'depends on m || RASPBERRYPI_FIRMWARE=y'?

That would be (slightly) wrong, it would force CONFIG_GPIO_RASPBERRYPI_EXP
to be 'm' even if RASPBERRYPI_FIRMWARE=n.

> Grepping around I also found this:
>
> drivers/power/supply/Kconfig:   depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'

That is what I did here as well, except the !RASPBERRYPI_FIRMWARE
only applies for COMPILE_TEST.

> And this:
>
> drivers/infiniband/Kconfig:     depends on m || IPV6 != m

This is a less common way to express it. The idiomatic
Kconfig expression here would be 'depends on IPV6 || !IPV6'.

>> Fixes: a98d90e7d588 ("gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox service")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpio/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index 2ecd2adbaec6..52a8b0a6f4e1 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -126,7 +126,7 @@ config GPIO_RASPBERRYPI_EXP
>>       tristate "Raspberry Pi 3 GPIO Expander"
>>       default RASPBERRYPI_FIRMWARE
>>       depends on OF_GPIO
>> -     depends on (ARCH_BCM2835 && RASPBERRYPI_FIRMWARE) || COMPILE_TEST
>> +     depends on (ARCH_BCM2835 && RASPBERRYPI_FIRMWARE) || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
>
> This is really non-obvious. An inline comment here might help, IMO.

How about

       # RASPBERRYPI_FIRMWARE is only available for ARCH_BCM2835, but we want to
       # allow compile-testing when it is disabled

?

       Arnd
