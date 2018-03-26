Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCZOLA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:11:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37596 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbeCZOK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:10:56 -0400
X-Google-Smtp-Source: AG47ELuflQIoNxexxZTGSLFC4CsuFXSBEiVorlSxR7/EzgbbgaPkV7S/DB26k0a0k26Vshdnhs892g==
Subject: Re: [PATCH 2/2] clocksource/drivers/imx-tpm: add different counter
 width support
To: Anson Huang <Anson.Huang@nxp.com>, tglx@linutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com, aisheng.dong@nxp.com
Cc: Linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1522050461-19043-1-git-send-email-Anson.Huang@nxp.com>
 <1522050461-19043-2-git-send-email-Anson.Huang@nxp.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e6e6026c-37bb-35ff-bf1b-a00d47e0aa2e@linaro.org>
Date: Mon, 26 Mar 2018 16:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522050461-19043-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2018 09:47, Anson Huang wrote:
> Different TPM modules have different width counters which
> is 16-bit or 32-bit, the counter width can be read from
> TPM_PARAM register bit[23:16], this patch adds dynamic
> check for counter width to support both 16-bit and 32-bit
> TPM modules.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Are you sure you shouldn't use a prescalar with 16b and reduce its
rating? What will be the duration of the clocksource before wrapping up?

Also, can you do the change to prevent computing the mask at each
'read_count' call ?

> ---
>  drivers/clocksource/timer-imx-tpm.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
> index 7403e49..5063b77 100644
> --- a/drivers/clocksource/timer-imx-tpm.c
> +++ b/drivers/clocksource/timer-imx-tpm.c
> @@ -17,6 +17,9 @@
>  #include <linux/of_irq.h>
>  #include <linux/sched_clock.h>
>  
> +#define TPM_PARAM			0x4
> +#define TPM_PARAM_WIDTH_SHIFT		16
> +#define TPM_PARAM_WIDTH_MASK		(0xff << 16)
>  #define TPM_SC				0x10
>  #define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
>  #define TPM_SC_CMOD_DIV_DEFAULT		0x3
> @@ -33,6 +36,7 @@
>  #define TPM_C0SC_CHF_MASK		(0x1 << 7)
>  #define TPM_C0V				0x24
>  
> +static int counter_width;
>  static void __iomem *timer_base;
>  static struct clock_event_device clockevent_tpm;
>  
> @@ -66,7 +70,7 @@ static struct delay_timer tpm_delay_timer;
>  
>  static inline unsigned long tpm_read_counter(void)
>  {
> -	return readl(timer_base + TPM_CNT);
> +	return readl(timer_base + TPM_CNT) & GENMASK(counter_width - 1, 0);
>  }
>  
>  static unsigned long tpm_read_current_timer(void)
> @@ -85,10 +89,11 @@ static int __init tpm_clocksource_init(unsigned long rate)
>  	tpm_delay_timer.freq = rate;
>  	register_current_timer_delay(&tpm_delay_timer);
>  
> -	sched_clock_register(tpm_read_sched_clock, 32, rate);
> +	sched_clock_register(tpm_read_sched_clock, counter_width, rate);
>  
>  	return clocksource_mmio_init(timer_base + TPM_CNT, "imx-tpm",
> -				     rate, 200, 32, clocksource_mmio_readl_up);
> +				     rate, 200, counter_width,
> +				     clocksource_mmio_readl_up);
>  }
>  
>  static int tpm_set_next_event(unsigned long delta,
> @@ -153,8 +158,8 @@ static int __init tpm_clockevent_init(unsigned long rate, int irq)
>  
>  	clockevent_tpm.cpumask = cpumask_of(0);
>  	clockevent_tpm.irq = irq;
> -	clockevents_config_and_register(&clockevent_tpm,
> -					rate, 300, 0xfffffffe);
> +	clockevents_config_and_register(&clockevent_tpm, rate, 300,
> +					GENMASK(counter_width - 1, 1));
>  
>  	return ret;
>  }
> @@ -199,6 +204,8 @@ static int __init tpm_timer_init(struct device_node *np)
>  		goto err_per_clk_enable;
>  	}
>  
> +	counter_width = (readl(timer_base + TPM_PARAM) & TPM_PARAM_WIDTH_MASK)
> +		>> TPM_PARAM_WIDTH_SHIFT;
>  	/*
>  	 * Initialize tpm module to a known state
>  	 * 1) Counter disabled
> @@ -220,7 +227,7 @@ static int __init tpm_timer_init(struct device_node *np)
>  		     timer_base + TPM_SC);
>  
>  	/* set MOD register to maximum for free running mode */
> -	writel(0xffffffff, timer_base + TPM_MOD);
> +	writel(GENMASK(counter_width - 1, 0), timer_base + TPM_MOD);
>  
>  	rate = clk_get_rate(per) >> 3;
>  	ret = tpm_clocksource_init(rate);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
