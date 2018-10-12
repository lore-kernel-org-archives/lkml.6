Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4681DC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA96120835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA96120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeJLV67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:58:59 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34169 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeJLV66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:58:58 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 91A2E1BF20E;
        Fri, 12 Oct 2018 14:26:13 +0000 (UTC)
Date:   Fri, 12 Oct 2018 16:26:12 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] regulator/gpio: Allow nonexclusive GPIO access
Message-ID: <20181012142612.GJ7677@w540>
References: <20181012125412.21324-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <20181012125412.21324-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,
   + Laurent, as he reviewed most of that driver code

Sorry, I'm going slightly OT with this, but please read below.

On Fri, Oct 12, 2018 at 02:54:12PM +0200, Linus Walleij wrote:
> This allows nonexclusive (simultaneous) access to a single
> GPIO line for the fixed regulator enable line. This happens
> when several regulators use the same GPIO for enabling and
> disabling a regulator, and all need a handle on their GPIO
> descriptor.
>
> This solution with a special flag is not entirely elegant
> and should ideally be replaced by something more careful as
> this makes it possible for several consumers to
> enable/disable the same GPIO line to the left and right
> without any consistency. The current use inside the regulator
> core should however be fine as it takes special care to
> handle this.
>
> For the state of the GPIO backend, this is still the
> lesser evil compared to going back to global GPIO
> numbers.
>

I might have a use case for shared GPIO lines used as 'simple' reset
signal for camera devices and not for regulators.

See drivers/media/i2c/ov772x.c FIXME note in power_on() function at:
https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/ov772x.c#L832

The reset line is in this case is passed to the driver by board file:
https://elixir.bootlin.com/linux/latest/source/arch/sh/boards/mach-migor/setup.c#L350

As you can see PTT3 is used for both sensors (I know, questionable
HW design...)

Do you think extending gpiod_lookup_flags with this newly introduced
NONEXCLUSIVE one is an acceptable solution to avoid handling this in
the sensor driver like we're doing today?

Please note this is an ancient architecture that boots from board
files, but the same might happen in modern designs with OF support. Is
there any clean way to handle shared GPIOs I might not be aware of for
those systems?

Thanks
   j


> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Fixes: efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix the print string to use ternary operator and alternative
>   text.
> - Collect Tested-by's from affected systems.
> - Mark: I tested to apply this on the regulator tree pulled
>   in my for-next branches for GPIO and pin control on top and
>   it seems to work! Could you apply it?
> ---
>  drivers/gpio/gpiolib.c        | 19 +++++++++++++++++--
>  drivers/regulator/fixed.c     | 13 +++++++++++++
>  include/linux/gpio/consumer.h |  1 +
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 7c222df8f834..56178af4ecd9 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4144,8 +4144,23 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
>  	 * the device name as label
>  	 */
>  	status = gpiod_request(desc, con_id ? con_id : devname);
> -	if (status < 0)
> -		return ERR_PTR(status);
> +	if (status < 0) {
> +		if (status == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
> +			/*
> +			 * This happens when there are several consumers for
> +			 * the same GPIO line: we just return here without
> +			 * further initialization. It is a bit if a hack.
> +			 * This is necessary to support fixed regulators.
> +			 *
> +			 * FIXME: Make this more sane and safe.
> +			 */
> +			dev_info(dev, "nonexclusive access to GPIO for %s\n",
> +				 con_id ? con_id : devname);
> +			return desc;
> +		} else {
> +			return ERR_PTR(status);
> +		}
> +	}
>
>  	status = gpiod_configure_flags(desc, con_id, lookupflags, flags);
>  	if (status < 0) {
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index 7d639ad953b6..ccc29038f19a 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -170,6 +170,19 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
>  			gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
>  	}
>
> +	/*
> +	 * Some fixed regulators share the enable line between two
> +	 * regulators which makes it necessary to get a handle on the
> +	 * same descriptor for two different consumers. This will get
> +	 * the GPIO descriptor, but only the first call will initialize
> +	 * it so any flags such as inversion or open drain will only
> +	 * be set up by the first caller and assumed identical on the
> +	 * next caller.
> +	 *
> +	 * FIXME: find a better way to deal with this.
> +	 */
> +	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
> +
>  	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, gflags);
>  	if (IS_ERR(cfg.ena_gpiod))
>  		return PTR_ERR(cfg.ena_gpiod);
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 0f350616d372..f2f887795d43 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -39,6 +39,7 @@ struct gpio_descs {
>  #define GPIOD_FLAGS_BIT_DIR_OUT		BIT(1)
>  #define GPIOD_FLAGS_BIT_DIR_VAL		BIT(2)
>  #define GPIOD_FLAGS_BIT_OPEN_DRAIN	BIT(3)
> +#define GPIOD_FLAGS_BIT_NONEXCLUSIVE	BIT(4)
>
>  /**
>   * Optional flags that can be passed to one of gpiod_* to configure direction
> --
> 2.17.2
>
>

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbwK8DAAoJEHI0Bo8WoVY8s0oQAI7UWI99lrc+iLhQnu6oOdrm
BOGYGzNGjXEeoz9Zet8/xm10drIQNjQQaZcebKXOG1I2OCTKsVar3B0naNDy3gdP
gItO+6dDgWRO9qYwm3I/lzlKe/+KEyefgXJQZKFBTHYy5dqUYIX7zFNKPv/v2WPT
E/B+NAvKO4+K5v2PjVtmQNZ9sOqfo46Ki8uZ3ApzlF8LfbibzyK7qlUvCQV/pabj
SCxNQn/4PoN+2DOsocyGSBRtzMmwHGS7EDWZ7pAIqKBrVPddxeo6NcCLJ+6GSnpA
qKKqotq82V4yXw+tmJ4Xot9LFB/mZtkh0/NJewTD4kvDDTtMYfptM0eCj/xHYziS
05FeHIz805ZGyzhLYgOyule51PyNsgR1OyuRNdcUwW5Eyioyt4nK2/iKP5RgjNGN
jwb7pvHrUNsiIYAUt2LwYUqOxLl293WT2TDXL9aI46S/oDYPQ53RljzKVQay1BtU
ZDQnlzsDmbNlKTHICqZGqvLUlNPFVaQtr1FdILg6oqcS2wVBU7aZdHPXHInL03E6
OeBtS9kdLZIwymzAQ1C6fR5cUt1W1qYVE7QNsrRlagmzee9inI13CMsRDbRDUQFb
d2PaD264MAaxQD3e9g+Xp5xwmZqPvCjxmi2kTEvNtc3Z4+i1fpFl6E7d3i3llSev
MOlZbQSqeUAHqoLxDMsI
=8Yp+
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
