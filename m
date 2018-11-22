Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E11C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBE820684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="da6EXoqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBE820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436782AbeKWAAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:00:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37729 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeKWAAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:00:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so9246138wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Bk8fqwx+vwpKrFa9BEYtiZKtKYoJ100RWpAY0SA3pE=;
        b=da6EXoqc7UZhFlGU7rOvQ0plK9+KnepG7/AaFUMpV/+ldJZeQiPY8xkIXPPBBOk2bg
         FqVAlwBG3O9CGkbsCkuQKZypVmxvt+Nkr3FYtx3ewS2sQaXKZtt2X7Y/mUY4uD3YyLoa
         BvVvY50g3Khj7TYBWutCItIKXZ5eZ+Y4GPgb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Bk8fqwx+vwpKrFa9BEYtiZKtKYoJ100RWpAY0SA3pE=;
        b=XskBCqspQGGFNnJzMs16UfM1Uvaje1ooxTndgjuiCeqEyRi8b8R+rHJ7gYmi0QkPiz
         e0KSvQ2/X+1F/t5S+c2zSudpcdcqX84cWrytkmfuAkTx0XjS+fjwdJSyX2xHCrbXHQEg
         IwAfh/1MyH5KG2U9XvQH7iiYFWY9XA+Y5Nrv3yYrpsaThzRwB7sYPUU+c78qMnucVxsM
         teFsrSFUL6VAMnVhC1jTox4hpEHc/k7egPLVYJrFaRXUGLUQyVNiIqOkc8fJQHH/PEk5
         e0VZTtEZZ+ENfYhOtRfi3q7LtH1sYVbtHYiBWngCyoK+KV9W87OMetU9uKnwsi7bg56H
         CUmw==
X-Gm-Message-State: AA+aEWYDYTfla4fGTJErkwCVYcLZZyC0/2JQkmasgSa93b68fH1/Pa94
        /Z53OloOksjo/NjZkuY/Jmd2eA==
X-Google-Smtp-Source: AFSGD/WrRK9+7/ZOfqufYHdZivNUZ3BE/+nuj4vq8d1xA00PB3oRpfbvV3vaIRmkOgNLxJgSMFvdtQ==
X-Received: by 2002:adf:9dd2:: with SMTP id q18mr9734146wre.12.1542892879753;
        Thu, 22 Nov 2018 05:21:19 -0800 (PST)
Received: from [192.168.0.40] (189.35.136.77.rev.sfr.net. [77.136.35.189])
        by smtp.googlemail.com with ESMTPSA id m65sm6227145wmb.4.2018.11.22.05.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:21:19 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/timer-imx-tpm: convert the driver to
 timer-of
To:     Anson Huang <anson.huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1541481054-25186-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ce65714b-8145-ca77-f019-d189184dffdd@linaro.org>
Date:   Thu, 22 Nov 2018 14:21:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541481054-25186-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Anson,


On 06/11/2018 06:15, Anson Huang wrote:
> Convert the driver to use the timer_of helpers.
> This allows to handle timer base, clock and irq using
> common timer_of driver and it simplifies the code.

Can you do an extra move by passing the timer_of structure around for:
 - tpm_timer_disable
 - tpm_timer_enable
 - tpm_irq_acknowledge

and use to_timer_of(clkevt) to retrieve the timer_base value for other
clockevent callbacks ?

The clockevent code will be self-encapsulated.



> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clocksource/timer-imx-tpm.c | 136 +++++++++++++++---------------------
>  1 file changed, 55 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
> index b7aa2b8..c3dd4d2 100644
> --- a/drivers/clocksource/timer-imx-tpm.c
> +++ b/drivers/clocksource/timer-imx-tpm.c
> @@ -12,6 +12,8 @@
>  #include <linux/of_irq.h>
>  #include <linux/sched_clock.h>
>  
> +#include "timer-of.h"
> +
>  #define TPM_PARAM			0x4
>  #define TPM_PARAM_WIDTH_SHIFT		16
>  #define TPM_PARAM_WIDTH_MASK		(0xff << 16)
> @@ -33,9 +35,7 @@
>  #define TPM_C0V				0x24
>  
>  static int counter_width;
> -static int rating;
>  static void __iomem *timer_base;
> -static struct clock_event_device clockevent_tpm;
>  
>  static inline void tpm_timer_disable(void)
>  {
> @@ -80,19 +80,6 @@ static u64 notrace tpm_read_sched_clock(void)
>  	return tpm_read_counter();
>  }
>  
> -static int __init tpm_clocksource_init(unsigned long rate)
> -{
> -	tpm_delay_timer.read_current_timer = &tpm_read_current_timer;
> -	tpm_delay_timer.freq = rate;
> -	register_current_timer_delay(&tpm_delay_timer);
> -
> -	sched_clock_register(tpm_read_sched_clock, counter_width, rate);
> -
> -	return clocksource_mmio_init(timer_base + TPM_CNT, "imx-tpm",
> -				     rate, rating, counter_width,
> -				     clocksource_mmio_readl_up);
> -}
> -
>  static int tpm_set_next_event(unsigned long delta,
>  				struct clock_event_device *evt)
>  {
> @@ -137,74 +124,77 @@ static irqreturn_t tpm_timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct clock_event_device clockevent_tpm = {
> -	.name			= "i.MX7ULP TPM Timer",
> -	.features		= CLOCK_EVT_FEAT_ONESHOT,
> -	.set_state_oneshot	= tpm_set_state_oneshot,
> -	.set_next_event		= tpm_set_next_event,
> -	.set_state_shutdown	= tpm_set_state_shutdown,
> +static struct timer_of to_tpm = {
> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> +	.clkevt = {
> +		.name			= "i.MX7ULP TPM Timer",
> +		.rating			= 200,
> +		.features		= CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_shutdown	= tpm_set_state_shutdown,
> +		.set_state_oneshot	= tpm_set_state_oneshot,
> +		.set_next_event		= tpm_set_next_event,
> +		.cpumask		= cpu_possible_mask,
> +	},
> +	.of_irq = {
> +		.handler		= tpm_timer_interrupt,
> +		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
> +	},
>  };
>  
> -static int __init tpm_clockevent_init(unsigned long rate, int irq)
> +static int __init tpm_clocksource_init(void)
>  {
> -	int ret;
> +	tpm_delay_timer.read_current_timer = &tpm_read_current_timer;
> +	tpm_delay_timer.freq = timer_of_rate(&to_tpm) >> 3;
> +	register_current_timer_delay(&tpm_delay_timer);
>  
> -	ret = request_irq(irq, tpm_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
> -			  "i.MX7ULP TPM Timer", &clockevent_tpm);
> +	sched_clock_register(tpm_read_sched_clock, counter_width,
> +			     timer_of_rate(&to_tpm) >> 3);
>  
> -	clockevent_tpm.rating = rating;
> -	clockevent_tpm.cpumask = cpumask_of(0);
> -	clockevent_tpm.irq = irq;
> -	clockevents_config_and_register(&clockevent_tpm, rate, 300,
> -					GENMASK(counter_width - 1, 1));
> +	return clocksource_mmio_init(timer_base + TPM_CNT,
> +				     "imx-tpm",
> +				     timer_of_rate(&to_tpm) >> 3,
> +				     to_tpm.clkevt.rating,
> +				     counter_width,
> +				     clocksource_mmio_readl_up);
> +}
>  
> -	return ret;
> +static void __init tpm_clockevent_init(void)
> +{
> +	clockevents_config_and_register(&to_tpm.clkevt,
> +					timer_of_rate(&to_tpm) >> 3,
> +					300,
> +					GENMASK(counter_width - 1,
> +					1));
>  }
>  
>  static int __init tpm_timer_init(struct device_node *np)
>  {
> -	struct clk *ipg, *per;
> -	int irq, ret;
> -	u32 rate;
> -
> -	timer_base = of_iomap(np, 0);
> -	if (!timer_base) {
> -		pr_err("tpm: failed to get base address\n");
> -		return -ENXIO;
> -	}
> -
> -	irq = irq_of_parse_and_map(np, 0);
> -	if (!irq) {
> -		pr_err("tpm: failed to get irq\n");
> -		ret = -ENOENT;
> -		goto err_iomap;
> -	}
> +	struct clk *ipg;
> +	int ret;
>  
>  	ipg = of_clk_get_by_name(np, "ipg");
> -	per = of_clk_get_by_name(np, "per");
> -	if (IS_ERR(ipg) || IS_ERR(per)) {
> -		pr_err("tpm: failed to get ipg or per clk\n");
> -		ret = -ENODEV;
> -		goto err_clk_get;
> +	if (IS_ERR(ipg)) {
> +		pr_err("tpm: failed to get ipg clk\n");
> +		return -ENODEV;
>  	}
> -
>  	/* enable clk before accessing registers */
>  	ret = clk_prepare_enable(ipg);
>  	if (ret) {
>  		pr_err("tpm: ipg clock enable failed (%d)\n", ret);
> -		goto err_clk_get;
> +		clk_put(ipg);
> +		return ret;
>  	}
>  
> -	ret = clk_prepare_enable(per);
> -	if (ret) {
> -		pr_err("tpm: per clock enable failed (%d)\n", ret);
> -		goto err_per_clk_enable;
> -	}
> +	ret = timer_of_init(np, &to_tpm);
> +	if (ret)
> +		return ret;
> +
> +	timer_base = timer_of_base(&to_tpm);
>  
> -	counter_width = (readl(timer_base + TPM_PARAM) & TPM_PARAM_WIDTH_MASK)
> -		>> TPM_PARAM_WIDTH_SHIFT;
> +	counter_width = (readl(timer_base + TPM_PARAM)
> +		& TPM_PARAM_WIDTH_MASK) >> TPM_PARAM_WIDTH_SHIFT;
>  	/* use rating 200 for 32-bit counter and 150 for 16-bit counter */
> -	rating = counter_width == 0x20 ? 200 : 150;
> +	to_tpm.clkevt.rating = counter_width == 0x20 ? 200 : 150;
>  
>  	/*
>  	 * Initialize tpm module to a known state
> @@ -229,29 +219,13 @@ static int __init tpm_timer_init(struct device_node *np)
>  	writel(TPM_SC_CMOD_INC_PER_CNT |
>  		(counter_width == 0x20 ?
>  		TPM_SC_CMOD_DIV_DEFAULT : TPM_SC_CMOD_DIV_MAX),
> -		     timer_base + TPM_SC);
> +		timer_base + TPM_SC);
>  
>  	/* set MOD register to maximum for free running mode */
>  	writel(GENMASK(counter_width - 1, 0), timer_base + TPM_MOD);
>  
> -	rate = clk_get_rate(per) >> 3;
> -	ret = tpm_clocksource_init(rate);
> -	if (ret)
> -		goto err_per_clk_enable;
> -
> -	ret = tpm_clockevent_init(rate, irq);
> -	if (ret)
> -		goto err_per_clk_enable;
> -
> -	return 0;
> +	tpm_clockevent_init();
>  
> -err_per_clk_enable:
> -	clk_disable_unprepare(ipg);
> -err_clk_get:
> -	clk_put(per);
> -	clk_put(ipg);
> -err_iomap:
> -	iounmap(timer_base);
> -	return ret;
> +	return tpm_clocksource_init();
>  }
>  TIMER_OF_DECLARE(imx7ulp, "fsl,imx7ulp-tpm", tpm_timer_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

