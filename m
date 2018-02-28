Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935213AbeB1V4U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:56:20 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:55170 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935108AbeB1V4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:56:19 -0500
Date: Wed, 28 Feb 2018 23:47:25 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: raspberrypi-ext: fix firmware dependency
Message-ID: <20180228214725.ewu3zt3l2xyxtxb2@tarshish>
References: <20180228134822.2194009-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228134822.2194009-1-arnd@arndb.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for the fix.

On Wed, Feb 28, 2018 at 02:48:08PM +0100, Arnd Bergmann wrote:
> When the firmware driver is a loadable module, the gpio driver cannot be
> built-in:
> 
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_set':
> gpio-raspberrypi-exp.c:(.text+0xb4): undefined reference to `rpi_firmware_property'
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get':
> gpio-raspberrypi-exp.c:(.text+0x1ec): undefined reference to `rpi_firmware_property'
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get_direction':
> gpio-raspberrypi-exp.c:(.text+0x360): undefined reference to `rpi_firmware_property'
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get_polarity':
> gpio-raspberrypi-exp.c:(.text+0x4d4): undefined reference to `rpi_firmware_property'
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_dir_out':
> gpio-raspberrypi-exp.c:(.text+0x670): undefined reference to `rpi_firmware_property'
> drivers/gpio/gpio-raspberrypi-exp.o:gpio-raspberrypi-exp.c:(.text+0x7fc): more undefined references to `rpi_firmware_property' follow
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_dir_in':
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_probe':
> gpio-raspberrypi-exp.c:(.text+0x93c): undefined reference to `rpi_firmware_get'
> 
> We already have a Kconfig dependency for it, but when compile-testing, it
> is disregarded.
> 
> This changes the dependency so that compile-testing is only done when the
> firmware driver is completely disabled.

What about the CONFIG_ARCH_BCM2835=y case? The combination of 
CONFIG_GPIO_RASPBERRYPI_EXP=y and CONFIG_RASPBERRYPI_FIRMWARE=m is still 
valid. Wouldn't that break the build?

Isn't there a way in Kconfig to force CONFIG_GPIO_RASPBERRYPI_EXP=m when 
CONFIG_RASPBERRYPI_FIRMWARE=m?

What about 'depends on m || RASPBERRYPI_FIRMWARE=y'?

Grepping around I also found this:

drivers/power/supply/Kconfig:   depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'

And this:

drivers/infiniband/Kconfig:     depends on m || IPV6 != m

> Fixes: a98d90e7d588 ("gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox service")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 2ecd2adbaec6..52a8b0a6f4e1 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -126,7 +126,7 @@ config GPIO_RASPBERRYPI_EXP
>  	tristate "Raspberry Pi 3 GPIO Expander"
>  	default RASPBERRYPI_FIRMWARE
>  	depends on OF_GPIO
> -	depends on (ARCH_BCM2835 && RASPBERRYPI_FIRMWARE) || COMPILE_TEST
> +	depends on (ARCH_BCM2835 && RASPBERRYPI_FIRMWARE) || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)

This is really non-obvious. An inline comment here might help, IMO.

>  	help
>  	  Turn on GPIO support for the expander on Raspberry Pi 3 boards, using
>  	  the firmware mailbox to communicate with VideoCore on BCM283x chips.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
