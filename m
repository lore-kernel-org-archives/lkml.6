Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbeCPKLK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:11:10 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52497 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbeCPKJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:09:08 -0400
X-Originating-IP: 2.224.242.101
Date: Fri, 16 Mar 2018 11:08:57 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 3/4] sh: ecovec24: convert backlight to use device
 properties
Message-ID: <20180316100857.GI16424@w540>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
 <20180315224202.96668-4-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Content-Disposition: inline
In-Reply-To: <20180315224202.96668-4-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Dmitry,

On Thu, Mar 15, 2018 at 03:42:01PM -0700, Dmitry Torokhov wrote:
> Instead of backlight legacy platform data, let's switch to using device
> properties and GPIO lookup tables.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/sh/boards/mach-ecovec24/setup.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> index 67633d2d42390..ad3d48b3ead19 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -11,11 +11,13 @@
>  #include <linux/init.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sh_mmcif.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/mfd/tmio.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> @@ -30,7 +32,6 @@
>  #include <linux/spi/mmc_spi.h>
>  #include <linux/input.h>
>  #include <linux/input/sh_keysc.h>
> -#include <linux/platform_data/gpio_backlight.h>
>  #include <linux/sh_eth.h>
>  #include <linux/sh_intc.h>
>  #include <linux/videodev2.h>
> @@ -367,17 +368,21 @@ static struct platform_device lcdc_device = {
>  	},
>  };
>
> -static struct gpio_backlight_platform_data gpio_backlight_data = {
> -	.gpio = GPIO_PTR1,
> -	.def_value = 1,
> -	.name = "backlight",
> +static struct gpiod_lookup_table gpio_backlight_gpios_table = {
> +	.dev_id = "gpio-backlight.0",
> +	.table = {
> +		GPIO_LOOKUP_IDX("sh7724_pfc", GPIO_PTR1, NULL, 0, GPIO_ACTIVE_HIGH);
> +		{ }

I understand this is an RFC, but this bit does not even compile.

../arch/sh/boards/mach-ecovec24/setup.c:374:70: error: expected '}'
before ';' token

Thanks
   j

> +	},
> +};
> +
> +static struct property_entry gpio_backlight_properties[] = {
> +	PROPERTY_ENTRY_BOOL("default-on"),
> +	{ }
>  };
>
>  static struct platform_device gpio_backlight_device = {
>  	.name = "gpio-backlight",
> -	.dev = {
> -		.platform_data = &gpio_backlight_data,
> -	},
>  };
>
>  /* CEU0 */
> @@ -1436,6 +1441,8 @@ static int __init arch_setup(void)
>  		return error;
>
>  	if (use_backlight) {
> +		device_add_properties(&gpio_backlight_device.dev,
> +				      gpio_backlight_properties);
>  		error = platform_device_add(&gpio_backlight_device);
>  		if (error)
>  			pr_warn("%s: failed to register backlight: %d\n",
> --
> 2.16.2.804.g6dcf76e118-goog
>

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaq5e5AAoJEHI0Bo8WoVY8zREP/idQrV53NHucreGiil96T2i8
Gchinly8owxcL9g0RdRclbB8PPNA5WR9qtroELMd/uTvUlNkkgn55O3KB/GxjvMp
KbinIdA8xLAJCItNzgBJKPIOT8u+cE0xB8AwzCLMSjxKSUiTV5LNGq6Fo+gqEFie
82r1MqwWASyirpwdOurOOFnV5dyW1PYVentRT+g1YUfo0zRUJM8RzFnNcxi70snY
eZqwETSsgWTxOeMwWUjaLbAnhYr2CwYopCk8xZZEM6dsYnbFNJjLAP0t2jD3I9Cp
UtBiy5lpOZQRb2x9NAHe/f63rIDEX5v5j+JATdb7vWdG46HwRGBZNIqDpRphmBdC
SXsV/AU+PXRHD7tvc5/wrWUQ6k5iGjQTcgf0tm91liOnDrcVhEBawI/o8qOYIE98
v0uUSciC1DegyANfF2DAvZWzF5WCP25GFW889/nUWFYRtBqgXVG2FzWJOrSFWJZa
3kl9KD8jX8p7/Bjd8fywWAW9+gWY54l0TlJa6lnW7x4kqGU1S7YgeNjKPSLIQRBf
LYu5cM1BI3omhu+enYSgJTkEcEshODk/cu/Ke+PXFU/+sa26A178Mf1RjJzeYzw0
TWTzbjoKiziT8YdW7t/xoztnyeyetbvQZQJf36G5aUV30jqu2TqXsllORZCbMWKr
qcvc4jE7b3a+jqCjE6MP
=hfs4
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--
