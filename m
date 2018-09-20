Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D039ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E73206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoOQdeV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E73206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeITVuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:50:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39193 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeITVuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:50:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so4589262pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zfBdqKKTVYJ/BnRHuiJucAzsdBo3uMnJ5mR7Q7uw97M=;
        b=FoOQdeV86Za89UiUtdnHw1n8lwwHmp3CSL/VujcJzSQmeV5O9UbN+PfXeDMT8X/BLE
         mJB0kXfPjimAmDQsDablKXcecH4J/aqUVtEaDVD0i3MGdlnzwjMcmIwlnNf+EE2anPue
         IXPR+0ijxb5FtrHo4UeOmUt0Wbn5jYb6XSwFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zfBdqKKTVYJ/BnRHuiJucAzsdBo3uMnJ5mR7Q7uw97M=;
        b=YEr3tNxg6NKyOoASqOY2c1NDAZQ0iIwbIoYgUKQZCXoAzuWNjdpMydLnCBOvQYL3Vf
         PwAcPLxlgHC5iZtWpmt6j82OQzmSZR3YKSfDTefKOHEi12NwiaWaPfUxZ0nafesS2RV3
         osJPTAFl4dBShcV1I3SYIisUDMdD2gpRehUt3nhst5LQ67jSMiXPHPbrOPiSsa2CBgnC
         +nl9y0jxf8Eu0lLBfbAvD6cAFjQ+s91T6XyS5gKpCJE+TlHo2K0sI4qgYMTNKajUSAvp
         Ruy+BJr/HHTwWTlQWRwRDmXHfAEcwQ1RUIRgEuVw4uNMJ6Mh0sY4Y2OmWb+oyvmtv9xT
         ikow==
X-Gm-Message-State: APzg51Acl1sYVLIAto9R6p/JXdOnbR71bI/QgRTCVifUgtvwXfacnPOK
        hs+gwcUYfOH8IXTvYV3ZwRdY0A==
X-Google-Smtp-Source: ANB0VdZuDeMILJhZtoR7DaBSCM+P2cWOaeIDQQ2pFEWNyuzIyGikluJ788NXa/lFcF6pfe8nVqauvg==
X-Received: by 2002:a65:5144:: with SMTP id g4-v6mr36890402pgq.21.1537459580948;
        Thu, 20 Sep 2018 09:06:20 -0700 (PDT)
Received: from [10.21.2.196] ([209.121.128.187])
        by smtp.googlemail.com with ESMTPSA id v26-v6sm33809845pfe.57.2018.09.20.09.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:06:20 -0700 (PDT)
Subject: Re: [PATCH V8 1/2] clocksource: add gx6605s SOC system timer
To:     Guo Ren <ren_guo@c-sky.com>, tglx@linutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        c-sky_gcc_upstream@c-sky.com, green.hu@gmail.com
References: <cover.1537412072.git.ren_guo@c-sky.com>
 <4d409a1fdecf1c376e8cc6b55308cd3c522047b0.1537412072.git.ren_guo@c-sky.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6c31f9b2-d536-1cee-8024-b52eb862fd9d@linaro.org>
Date:   Thu, 20 Sep 2018 18:06:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4d409a1fdecf1c376e8cc6b55308cd3c522047b0.1537412072.git.ren_guo@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2018 10:03, Guo Ren wrote:
> Changelog:
>  - Add License and Copyright
>  - Use timer-of framework
>  - Change name with upstream feedback
>  - Use clksource_mmio framework
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  drivers/clocksource/Kconfig         |   8 ++
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-gx6605s.c | 150 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 159 insertions(+)
>  create mode 100644 drivers/clocksource/timer-gx6605s.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a11f4ba..6d0f18d 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -620,4 +620,12 @@ config RISCV_TIMER
>  	  is accessed via both the SBI and the rdcycle instruction.  This is
>  	  required for all RISC-V systems.
>  
> +config GX6605S_TIMER
> +	bool "Gx6605s SOC system timer driver"
> +	depends on CSKY
> +	select CLKSRC_MMIO
> +	select TIMER_OF
> +	help
> +	  This option enables support for gx6605s SOC's timer.
> +
>  endmenu

Please make the option not visible as default. There are currently two
approaches look at MTK_TIMER and SPRD_TIMER.

Apart the two nits below, the driver looks fine.

Thanks!
  -- Daniel

> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index db51b24..dc5621d 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -79,3 +79,4 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>  obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
>  obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
> +obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
> diff --git a/drivers/clocksource/timer-gx6605s.c b/drivers/clocksource/timer-gx6605s.c
> new file mode 100644
> index 0000000..10194c9
> --- /dev/null
> +++ b/drivers/clocksource/timer-gx6605s.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched_clock.h>
> +
> +#include "timer-of.h"
> +
> +#define CLKSRC_OFFSET	0x40
> +
> +#define TIMER_STATUS	0x00
> +#define TIMER_VALUE	0x04
> +#define TIMER_CONTRL	0x10
> +#define TIMER_CONFIG	0x20
> +#define TIMER_DIV	0x24
> +#define TIMER_INI	0x28
> +
> +#define GX6605S_STATUS_CLR	BIT(0)
> +#define GX6605S_CONTRL_RST	BIT(0)
> +#define GX6605S_CONTRL_START	BIT(1)
> +#define GX6605S_CONFIG_EN	BIT(0)
> +#define GX6605S_CONFIG_IRQ_EN	BIT(1)
> +
> +static irqreturn_t gx6605s_timer_interrupt(int irq, void *dev)
> +{
> +	struct clock_event_device *ce = (struct clock_event_device *) dev;

nit: no cast is needed.

> +	void __iomem *base = timer_of_base(to_timer_of(ce));
> +
> +	writel_relaxed(GX6605S_STATUS_CLR, base + TIMER_STATUS);
> +
> +	ce->event_handler(ce);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int gx6605s_timer_set_oneshot(struct clock_event_device *ce)
> +{
> +	void __iomem *base = timer_of_base(to_timer_of(ce));
> +
> +	/* reset and stop counter */
> +	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
> +
> +	/* enable with irq and start */
> +	writel_relaxed(GX6605S_CONFIG_EN | GX6605S_CONFIG_IRQ_EN, base + TIMER_CONFIG);
> +
> +	return 0;
> +}
> +
> +static int gx6605s_timer_set_next_event(unsigned long delta, struct clock_event_device *ce)
> +{
> +	void __iomem *base = timer_of_base(to_timer_of(ce));
> +
> +	/* use reset to pause timer */
> +	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
> +
> +	/* config next timeout value */
> +	writel_relaxed(ULONG_MAX - delta, base + TIMER_INI);
> +	writel_relaxed(GX6605S_CONTRL_START, base + TIMER_CONTRL);
> +
> +	return 0;
> +}
> +
> +static int gx6605s_timer_shutdown(struct clock_event_device *ce)
> +{
> +	void __iomem *base = timer_of_base(to_timer_of(ce));
> +
> +	writel_relaxed(0, base + TIMER_CONTRL);
> +	writel_relaxed(0, base + TIMER_CONFIG);
> +
> +	return 0;
> +}
> +
> +static struct timer_of to = {
> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> +	.clkevt = {
> +		.rating			= 300,
> +		.features		= CLOCK_EVT_FEAT_DYNIRQ |
> +					  CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_shutdown	= gx6605s_timer_shutdown,
> +		.set_state_oneshot	= gx6605s_timer_set_oneshot,
> +		.set_next_event		= gx6605s_timer_set_next_event,
> +		.cpumask		= cpu_possible_mask,
> +	},
> +	.of_irq = {
> +		.handler		= gx6605s_timer_interrupt,
> +		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
> +	},
> +};
> +
> +static u64 notrace gx6605s_sched_clock_read(void)
> +{
> +	void __iomem *base;
> +
> +	base = timer_of_base(&to) + CLKSRC_OFFSET;
> +
> +	return (u64) readl_relaxed(base + TIMER_VALUE);

nit: extra space after '(u64)'

> +}
> +
> +static void gx6605s_clkevt_init(void __iomem *base)
> +{
> +	writel_relaxed(0, base + TIMER_DIV);
> +	writel_relaxed(0, base + TIMER_CONFIG);
> +
> +	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 2, ULONG_MAX);
> +}
> +
> +static int gx6605s_clksrc_init(void __iomem *base)
> +{
> +	writel_relaxed(0, base + TIMER_DIV);
> +	writel_relaxed(0, base + TIMER_INI);
> +
> +	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
> +
> +	writel_relaxed(GX6605S_CONFIG_EN, base + TIMER_CONFIG);
> +
> +	writel_relaxed(GX6605S_CONTRL_START, base + TIMER_CONTRL);
> +
> +	sched_clock_register(gx6605s_sched_clock_read, 32, timer_of_rate(&to));
> +
> +	return clocksource_mmio_init(base + TIMER_VALUE, "gx6605s", timer_of_rate(&to),
> +				     200, 32, clocksource_mmio_readl_up);
> +}
> +
> +static int __init gx6605s_timer_init(struct device_node *np)
> +{
> +	int ret;
> +
> +	/*
> +	 * The timer driver is for nationalchip gx6605s SOC and there are two same timer
> +	 * in gx6605s. We use one for clkevt and another for clksrc.
> +	 *
> +	 * The timer is mmio map to access, so we need give mmio addres in dts.
> +	 *
> +	 * It provides a 32bit countup timer and interrupt will be caused by count-overflow.
> +	 * So we need set-next-event by ULONG_MAX - delta in TIMER_INI reg.
> +	 *
> +	 * The counter at 0x0  offset is clock event.
> +	 * The counter at 0x40 offset is clock source.
> +	 * They are the same in hardware, just different used by driver.
> +	 */
> +	ret = timer_of_init(np, &to);
> +	if (ret)
> +		return ret;
> +
> +	gx6605s_clkevt_init(timer_of_base(&to));
> +
> +	return gx6605s_clksrc_init(timer_of_base(&to) + CLKSRC_OFFSET);
> +}
> +TIMER_OF_DECLARE(csky_gx6605s_timer, "csky,gx6605s-timer", gx6605s_timer_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

