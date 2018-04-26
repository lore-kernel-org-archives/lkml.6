Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbeDZHe1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:34:27 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36486 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbeDZHeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:34:25 -0400
X-Google-Smtp-Source: AIpwx48XDq5gTogQYeiQaOO6x8RdrAfXCFNXrp/GaYqyezIr0MNNlSaKBb5m5oelGtIZUbuVNLQ3ZQ==
Date: Thu, 26 Apr 2018 08:34:05 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Javier Arteaga <javier@emutex.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 2/3] leds: upboard: Add LED support
Message-ID: <20180426073314.g2ccjjkx6vgbknhm@dell>
References: <20180421085009.28773-1-javier@emutex.com>
 <20180421085009.28773-3-javier@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180421085009.28773-3-javier@emutex.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2018, Javier Arteaga wrote:

> Allow userspace to use the on-board LEDs as "upboard:<color>:".
> 
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> ---
>  drivers/leds/Kconfig        | 10 +++++
>  drivers/leds/Makefile       |  1 +
>  drivers/leds/leds-upboard.c | 87 +++++++++++++++++++++++++++++++++++++

>  drivers/mfd/upboard.c       | 19 ++++++++

This change needs to be placed into a separate patch.

>  include/linux/mfd/upboard.h |  5 +++
>  5 files changed, 122 insertions(+)
>  create mode 100644 drivers/leds/leds-upboard.c

[...]

> diff --git a/drivers/mfd/upboard.c b/drivers/mfd/upboard.c
> index 8bae450cb83d..6e4767e4dc41 100644
> --- a/drivers/mfd/upboard.c
> +++ b/drivers/mfd/upboard.c
> @@ -79,6 +79,14 @@ struct upboard_data {
>  	size_t ncells;
>  };
>  
> +#define UPBOARD_LED_CELL(led_data, n)                   \
> +	{                                               \
> +		.name = "upboard-led",                  \
> +		.id = (n),                              \
> +		.platform_data = &led_data[(n)],        \
> +		.pdata_size = sizeof(*(led_data)),      \
> +	}
> +

There is a subsystem-level MACRO currently being reviewed on the list.

Just use the full format in your structs for now.

>  /* UP Squared */
>  
>  static const struct regmap_range upboard_up2_readable_ranges[] = {
> @@ -116,7 +124,18 @@ static const struct regmap_config upboard_up2_regmap_config = {
>  	.wr_table = &upboard_up2_writable_table,
>  };
>  
> +static struct upboard_led_data upboard_up2_led_data[] = {
> +	{ .id = 0, .color = "blue" },
> +	{ .id = 1, .color = "yellow" },
> +	{ .id = 2, .color = "green" },
> +	{ .id = 3, .color = "red" },
> +};

How is this data used?

Does it ever change, from board to board?

>  static const struct mfd_cell upboard_up2_mfd_cells[] = {
> +	UPBOARD_LED_CELL(upboard_up2_led_data, 0),
> +	UPBOARD_LED_CELL(upboard_up2_led_data, 1),
> +	UPBOARD_LED_CELL(upboard_up2_led_data, 2),
> +	UPBOARD_LED_CELL(upboard_up2_led_data, 3),
>  };
>  
>  static const struct upboard_data upboard_up2_data = {
> diff --git a/include/linux/mfd/upboard.h b/include/linux/mfd/upboard.h
> index d9dd214f4d29..eed68caa23ce 100644
> --- a/include/linux/mfd/upboard.h
> +++ b/include/linux/mfd/upboard.h
> @@ -62,4 +62,9 @@ struct upboard {
>  	struct gpio_desc *dataout_gpio;
>  };
>  
> +struct upboard_led_data {
> +	unsigned int id;
> +	const char *color;
> +};

If this is going to stick around, which I'm not sure it should, you
need to document it (using kerneldoc format), since 'id' is quite
ambiguous.

>  #endif /*  __LINUX_MFD_UPBOARD_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
