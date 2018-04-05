Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeDEMOJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:14:09 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:16976 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEMOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:14:07 -0400
Subject: Re: [PATCH v8 20/42] ARM: davinci: pass clock as parameter to
 davinci_timer_init()
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-21-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <43434ed4-162c-cb39-70ef-a458e3999f8b@ti.com>
Date: Thu, 5 Apr 2018 17:42:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521168778-27236-21-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 March 2018 08:22 AM, David Lechner wrote:
> This changes davinci_timer_init() so that we pass the clock as a
> parameter instead of using clk_get(). This is done in preparation
> for converting to the common clock framework.
> 
> It removes the requirement that we have to have a clock with con_id
> of "timer0", which will be good for DT bindings since clock-names =
> "timer0" doesn't really make sense.
> 
> Additionally, when we convert to the common clock framework, most of
> the clocks will be platform devices, which will not be available at
> this point during the boot process, so we will need to pass a clock
> that is available (i.e. ref_clk) instead of the "timer0" clock.
> 
> NB: The comment added in time.c is not entirely true when this patch
> is applied, but it will be correct once the conversion to the common
> clock framework is complete in subsequent patches.

I think its better to add the comment when its actually applicable, even
if it needs to be a separate patch.

> 
> Also, drop use of extern in header file since we are touching the
> definition.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

> -
> -void __init davinci_timer_init(void)
> +void __init davinci_timer_init(struct clk *timer_clk)
>  {
> -	struct clk *timer_clk;
>  	struct davinci_soc_info *soc_info = &davinci_soc_info;
>  	unsigned int clockevent_id;
>  	unsigned int clocksource_id;
> @@ -373,7 +371,14 @@ void __init davinci_timer_init(void)
>  		}
>  	}
>  
> -	timer_clk = clk_get(NULL, "timer0");
> +	/*
> +	 * REVISIT: Currently, timer_clk will be "ref_clk". However, the actual
> +	 * clock for this device comes from a PLL AUXCLK or a PSC clock
> +	 * (depending on the SoC). The PLL and PSC clocks are not registered
> +	 * until later in boot because they are platform devices. We should try
> +	 * again later to get the real clock so that the real clock is not
> +	 * turned off when disabling unused clocks, which would stop the timer.

This disabling later should not happen because you have the timer clocks
marked as LPSC_ALWAYS_ENABLED which translates to CLK_IS_CRITICAL and
that should make sure they are never disabled.

The issue should be documented is that we depend on bootloader leaving
the timer0 enabled on DM355, DM365, DM644x and DM646x. Of these, I have
tested only DM644x so far. I will check others and see the status of
timer0 there.

Its not really a great situation here, but I don't have a good
alternative to suggest as well if having genpd support in PSC means we
cannot be using CLK_OF_DECLARE().

Thanks,
Sekhar
