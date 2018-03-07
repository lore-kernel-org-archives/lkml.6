Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933976AbeCGR23 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:28:29 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34585 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933903AbeCGR2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:28:24 -0500
X-Google-Smtp-Source: AG47ELuALuRMOZzcLL0A+xo3FnQpINV9HdQ3oveAhSzDjZ56n8ue5uGVzpPfEIIq0e4vhkQ9qN2tBQ==
Subject: Re: [PATCH v4 2/2] clocksource: npcm: add NPCM7xx timer driver
To: Tomer Maimon <tmaimon77@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, tglx@linutronix.de, avifishman70@gmail.com,
        brendanhiggins@google.com, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <1519655769-25836-1-git-send-email-tmaimon77@gmail.com>
 <1519655769-25836-3-git-send-email-tmaimon77@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f0330114-1704-a464-94ce-aeafb43115ea@linaro.org>
Date: Wed, 7 Mar 2018 18:28:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519655769-25836-3-git-send-email-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tomer,

change the subject to: clocksource/drivers/npcm: Add NPCM7xx timer driver

On 26/02/2018 15:36, Tomer Maimon wrote:
> Add Nuvoton BMC NPCM7xx timer driver.
> 
> the clocksource Enable 24-bit TIMER0 and TIMER1 counters,
> while TIMER0 serve as clockevent and TIMER1 serve as clocksource.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@xxxxxxxxxx>


[ ... ]

> +config NPCM7XX_TIMER
> +	bool "NPCM7xx timer driver" if COMPILE_TEST
> +	depends on HAS_IOMEM
> +	select CLKSRC_MMIO
> +	help
> +	  Enable 24-bit TIMER0 and TIMER1 counters in the NPCM7xx arcithcture,

architecture

> +	  While TIMER0 serves as clockevent and TIMER1 serves as clocksource.
> +
>  config CADENCE_TTC_TIMER
>  	bool "Cadence TTC timer driver" if COMPILE_TEST
>  	depends on COMMON_CLK
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index d6dec4489d66..b16c1a2b9e0d 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
>  obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
>  obj-$(CONFIG_OWL_TIMER)		+= owl-timer.o
>  obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
> +obj-$(CONFIG_NPCM7XX_TIMER)	+= npcm7xx-timer.o

Not mandatory but if you can change to timer-npcm7xx that would be nice.

>  obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o

[ ... ]

> +static int npcm7xx_clockevent_setnextevent(unsigned long evt,
> +		struct clock_event_device *clk)

npcm7xx_timer_set_next_event()

[ ... ]

> +static int __init npcm7xx_timer_init(struct device_node *np)
> +{
> +	struct clk *clk;
> +	int ret;
> +	u32 rate;
> +
> +	clk = of_clk_get(np, 0);
> +
> +	if (IS_ERR(clk)) {
> +		ret = of_property_read_u32(np, "clock-frequency", &rate);
> +		if (ret)
> +			return ret;
> +	} else {
> +		clk_prepare_enable(clk);
> +		rate = clk_get_rate(clk);
> +		npcm7xx_to.of_clk.clk = clk;
> +	}

[ ... ]

See comment on DT binding patch 1/2

> +err_timer_of_init:
> +	if (!IS_ERR(clk)) {
> +		clk_disable_unprepare(clk);
> +		clk_put(clk);
> +	}
> +
> +	return ret;
> +}
> +
> +TIMER_OF_DECLARE(npcm7xx, "nuvoton,npcm750-timer", npcm7xx_timer_init);
> +
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
