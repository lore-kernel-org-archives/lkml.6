Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeC3IU5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 04:20:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38342 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeC3IUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 04:20:53 -0400
X-Google-Smtp-Source: AIpwx4/7KD5rpzhKG0418QqlChzzEhB5VXnxrCfMGeDtcZLlQaSvMS1O40fMvH34aMImTE/1Fc+Tzg==
Message-ID: <1522398050.3871.12.camel@baylibre.com>
Subject: Re: [PATCH v5 08/10] clk: fix CLK_SET_RATE_GATE with clock rate
 protection
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 30 Mar 2018 10:20:50 +0200
In-Reply-To: <20171201215200.23523-9-jbrunet@baylibre.com>
References: <20171201215200.23523-1-jbrunet@baylibre.com>
         <20171201215200.23523-9-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2017-12-01 at 22:51 +0100, Jerome Brunet wrote:
> Using clock rate protection, we can now enforce CLK_SET_RATE_GATE along the
> clock tree

Hi Mike, Stephen,

Gentle ping.
This patch has been waiting for while now.
As far as I know, the only blocking point to merging this patch is the qcom mmc
driver. The clocks used in this driver rely on the broken implementation of
CLK_SET_RATE_GATE, effectively ignoring the flag.

Since the flag is ignored, removing it from this particular clock won't make any
difference. Can we just do that until a better fix is available for this qcom
mmc clock ?

--- A bit of history ----

I managed to have a run on kci - based on v4.12-rc6:
https://kernelci.org/boot/all/job/khilman/branch/to-build/kernel/v4.12-rc6-10-ge
a373ddef830/

There was no build regression but kci did find one boot regression on qcom
platforms:
* qcom-apq8064-cm-qs600
* qcom-apq8064-ifc6410

it seems the problem is coming from the clock used by the mmc driver
(drivers/mmc/host/mmci.c)

the driver does following sequence:
* get_clk
* prepare_enable
* get_rate
* set_rate
* ...

with clock SDCx_clk (qcom_apq8064.dtsi:1037). This clock has CLK_SET_RATE_PARENT
flag so it will transmit the request to its parent.
The parent of this clock is SDCx_src which has the CLK_SET_RATE_GATE flag.

So obviously, is CLK_SET_RATE_GATE was enforced, the sequence used by mmci
driver would never had worked.

This particular driver rely on the fact that the clock can while the clock is
on. Either it actually works and we can remove CLK_SET_RATE_GATE until a better
solution comes.
OR, it does not work which means nobody has been using this driver for a long
time.

> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/clk.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f6fe5e5595ca..1af843ae20ff 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -605,6 +605,9 @@ static void clk_core_unprepare(struct clk_core *core)
>  	if (WARN_ON(core->prepare_count == 1 && core->flags & CLK_IS_CRITICAL))
>  		return;
>  
> +	if (core->flags & CLK_SET_RATE_GATE)
> +		clk_core_rate_unprotect(core);
> +
>  	if (--core->prepare_count > 0)
>  		return;
>  
> @@ -679,6 +682,16 @@ static int clk_core_prepare(struct clk_core *core)
>  
>  	core->prepare_count++;
>  
> +	/*
> +	 * CLK_SET_RATE_GATE is a special case of clock protection
> +	 * Instead of a consumer claiming exclusive rate control, it is
> +	 * actually the provider which prevents any consumer from making any
> +	 * operation which could result in a rate change or rate glitch while
> +	 * the clock is prepared.
> +	 */
> +	if (core->flags & CLK_SET_RATE_GATE)
> +		clk_core_rate_protect(core);
> +
>  	return 0;
>  unprepare:
>  	clk_core_unprepare(core->parent);
> @@ -1780,9 +1793,6 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>  	if (clk_core_rate_is_protected(core))
>  		return -EBUSY;
>  
> -	if ((core->flags & CLK_SET_RATE_GATE) && core->prepare_count)
> -		return -EBUSY;
> -
>  	/* calculate new rates and get the topmost changed clock */
>  	top = clk_calc_new_rates(core, req_rate);
>  	if (!top)
