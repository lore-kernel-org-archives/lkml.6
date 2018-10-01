Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756B3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A80A2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cExRO72E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A80A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeJAPvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:51:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36449 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbeJAPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:51:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so4774111wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8sdbWQ5HdviEAQ2lz8Y8rv2IoFJkZgCpms8ZpImScIE=;
        b=cExRO72EnRe1oWtRJFCTZmhQJfgrwn5ZJGXuhiWRhDiw3m9Mu9zcQ05imv+yF83sbQ
         u9aSioe0CKH0Xs7B+JpAp+XBWbYZBu4zm3u/lXSzNHT1K8exJShkn4St/KGOfXikMOIM
         UBtsoliTpKX9VW4mpgLT34+/VTeNr8K7shYQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8sdbWQ5HdviEAQ2lz8Y8rv2IoFJkZgCpms8ZpImScIE=;
        b=TZWSNrpfCWqU9pb+RfoPVzHXfYTbGDnGSut/YcopUhBiubkHo5l7U1u1mfkzSWXJDx
         sJb1t7nO4R+UpeUEvcUfCiw3o8E07NA7OuJeKWONjcm+VZjLxdprkux2A3uFqPcv/dl0
         5ODyiUclyLn5dkLNy7YfWAdaX9L0TEDTBbr9IUrZrgWQlCjlGGJONbZVnyLbEJ5qno2t
         Fj+L9JjZkJ24xkDSOvKSwpaVIR6qodOM6783UOPx8wedLvbR3AJ4Z4C4sIukfxqpD33n
         hm5fLmI4vCT7rd9eRpMeKzaRQyoo9xVmB67647QcvXkwlaUpNihiqEHPsFJVfwTeSJ9k
         Ervw==
X-Gm-Message-State: ABuFfoiS6+hmEZvWPhnt/XEb7QzqYjl3kpliM9/O9p4yIT+pM0kMTabi
        rt0sZjPIKDQrCNKyf5o7h5fAlg==
X-Google-Smtp-Source: ACcGV63XWe1jhvco5ZIpfT97wILpWgQ7gAI3wVO4hsSSdOfoud52hj5TvIU/BgcGLt/VR/nb8+FwwQ==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr6533224wrj.3.1538385256563;
        Mon, 01 Oct 2018 02:14:16 -0700 (PDT)
Received: from [192.168.0.41] (210.183.88.92.rev.sfr.net. [92.88.183.210])
        by smtp.googlemail.com with ESMTPSA id r13-v6sm8124045wmf.35.2018.10.01.02.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 02:14:15 -0700 (PDT)
Subject: Re: [PATCH V9 3/8] clocksource: add C-SKY SMP timer
To:     Guo Ren <ren_guo@c-sky.com>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, f.fainelli@gmail.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1538355281.git.ren_guo@c-sky.com>
 <eee964dd57d12bc630280ab84235b5356799b1fb.1538355281.git.ren_guo@c-sky.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <88e320f2-8cf0-fdb9-c9b0-ee25d7a4d00f@linaro.org>
Date:   Mon, 1 Oct 2018 11:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <eee964dd57d12bc630280ab84235b5356799b1fb.1538355281.git.ren_guo@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2018 03:35, Guo Ren wrote:
> This timer is used by SMP system and use mfcr/mtcr instruction
> to access the regs.
> 
> Changelog:
>  - Remove #define CPUHP_AP_CSKY_TIMER_STARTING
>  - Add CPUHP_AP_CSKY_TIMER_STARTING in cpuhotplug.h
>  - Support csky mp timer alpha version.
>  - Just use low-counter with 32bit width as clocksource.
>  - Coding convention with upstream feed-back.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  drivers/clocksource/Kconfig        |   8 ++
>  drivers/clocksource/Makefile       |   1 +
>  drivers/clocksource/csky_mptimer.c | 176 +++++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h         |   1 +
>  4 files changed, 186 insertions(+)
>  create mode 100644 drivers/clocksource/csky_mptimer.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a11f4ba..a28043f 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -620,4 +620,12 @@ config RISCV_TIMER
>  	  is accessed via both the SBI and the rdcycle instruction.  This is
>  	  required for all RISC-V systems.
>  
> +config CSKY_MPTIMER
> +	bool "C-SKY Multi Processor Timer"
> +	depends on CSKY
> +	select TIMER_OF
> +	help
> +	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
> +	  system.
> +
>  endmenu

The same rule applies here for COMPILE_TEST.

And please rename the file: timer-mp-csky.c

> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index db51b24..848c676 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -79,3 +79,4 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>  obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
>  obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
> +obj-$(CONFIG_CSKY_MPTIMER)		+= csky_mptimer.o
> diff --git a/drivers/clocksource/csky_mptimer.c b/drivers/clocksource/csky_mptimer.c
> new file mode 100644
> index 0000000..9dc3cfb
> --- /dev/null
> +++ b/drivers/clocksource/csky_mptimer.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched_clock.h>
> +#include <linux/cpu.h>
> +#include <asm/reg_ops.h>
> +
> +#include "timer-of.h"
> +
> +#define PTIM_CCVR	"cr<3, 14>"
> +#define PTIM_CTLR	"cr<0, 14>"
> +#define PTIM_LVR	"cr<6, 14>"
> +#define PTIM_TSR	"cr<1, 14>"
> +
> +static int csky_mptimer_set_next_event(unsigned long delta, struct clock_event_device *ce)
> +{
> +	mtcr(PTIM_LVR, delta);
> +
> +	return 0;
> +}
> +
> +static int csky_mptimer_shutdown(struct clock_event_device *ce)
> +{
> +	mtcr(PTIM_CTLR, 0);
> +
> +	return 0;
> +}
> +
> +static int csky_mptimer_oneshot(struct clock_event_device *ce)
> +{
> +	mtcr(PTIM_CTLR, 1);
> +
> +	return 0;
> +}
> +
> +static int csky_mptimer_oneshot_stopped(struct clock_event_device *ce)
> +{
> +	mtcr(PTIM_CTLR, 0);
> +
> +	return 0;
> +}
> +
> +static DEFINE_PER_CPU(struct timer_of, csky_to) = {
> +	.flags					= TIMER_OF_CLOCK,
> +	.clkevt = {
> +		.rating				= 300,
> +		.features			= CLOCK_EVT_FEAT_PERCPU |
> +						  CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_shutdown		= csky_mptimer_shutdown,
> +		.set_state_oneshot		= csky_mptimer_oneshot,
> +		.set_state_oneshot_stopped	= csky_mptimer_oneshot_stopped,
> +		.set_next_event			= csky_mptimer_set_next_event,
> +	},
> +	.of_irq = {
> +		.flags				= IRQF_TIMER,
> +		.percpu				= 1,
> +	},

See comment in the init function.

> +};
> +
> +static irqreturn_t timer_interrupt(int irq, void *dev)
> +{
> +	struct timer_of *to = this_cpu_ptr(&csky_to);
> +
> +	mtcr(PTIM_TSR, 0);
> +
> +	to->clkevt.event_handler(&to->clkevt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * clock event for percpu
> + */
> +static int csky_mptimer_starting_cpu(unsigned int cpu)
> +{
> +	struct timer_of *to = per_cpu_ptr(&csky_to, cpu);
> +
> +	to->clkevt.cpumask = cpumask_of(cpu);
> +
> +	clockevents_config_and_register(&to->clkevt, timer_of_rate(to), 2, ULONG_MAX);
> +
> +	enable_percpu_irq(timer_of_irq(to), 0);
> +
> +	return 0;
> +}
> +
> +static int csky_mptimer_dying_cpu(unsigned int cpu)
> +{
> +	struct timer_of *to = per_cpu_ptr(&csky_to, cpu);
> +
> +	disable_percpu_irq(timer_of_irq(to));
> +
> +	return 0;
> +}
> +
> +/*
> + * clock source
> + */
> +static u64 sched_clock_read(void)
> +{
> +	return (u64) mfcr(PTIM_CCVR);

extra space

> +}
> +
> +static u64 clksrc_read(struct clocksource *c)
> +{
> +	return (u64) mfcr(PTIM_CCVR);

extra space

> +}
> +
> +struct clocksource csky_clocksource = {
> +	.name	= "csky",
> +	.rating	= 400,
> +	.mask	= CLOCKSOURCE_MASK(32),
> +	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.read	= clksrc_read,
> +};
> +
> +static int __init csky_mptimer_init(struct device_node *np)
> +{
> +	int ret, cpu;
> +	struct timer_of *to;
> +	int rate = 0;
> +	int irq	 = 0;
> +
> +	/*
> +	 * Csky_mptimer is designed for C-SKY SMP multi-processors and
> +	 * every core has it's own private irq and regs for clkevt and
> +	 * clksrc.
> +	 *
> +	 * The regs is accessed by cpu instruction: mfcr/mtcr instead of
> +	 * mmio map style. So we needn't mmio-address in dts, but we still
> +	 * need to give clk and irq number.
> +	 *
> +	 * We use private irq for the mptimer and irq number is the same
> +	 * for every core. So we use request_percpu_irq() in timer_of_init.
> +	 */
> +

extra line

> +	for_each_possible_cpu(cpu) {
> +		to = per_cpu_ptr(&csky_to, cpu);
> +
> +		if (cpu == 0) {
> +			to->flags	  |= TIMER_OF_IRQ;
> +			to->of_irq.handler = timer_interrupt;
> +
> +			ret = timer_of_init(np, to);
> +			if (ret)
> +				return ret;
> +
> +			rate	= timer_of_rate(to);
> +			irq	= to->of_irq.irq;
> +		} else {
> +			ret = timer_of_init(np, to);
> +			if (ret)
> +				return ret;
> +
> +			to->of_clk.rate	= rate;
> +			to->of_irq.irq	= irq;
> +		}
> +	}


Isn't possible to replace this loop which is a bit confusing by:

 - no irq flag specified for timer-of
 - request irq before

So we end up with:

	irq = irq_of_parse_and_map(np, 0);
	if (irq <= 0)
		return -EINVAL;

	ret = request_irq(irq, csky_timer_interrupt,
			IRQF_TIMER | IRQF_PERCPU,
                        "csky_mp_timer", &csky_to));
	if (ret)
		return ret;

	for_each_possible_cpu(cpu) {
		to = per_cpu_ptr(&csky_to, cpu);
		ret = timer_of_init(np, to);
		if (ret)
			goto rollback;
	}

Alternatively, you can remove the timer_of struct and instantiate the
percpu stuff in cpuhp callbacks (cf. jcore_pit).


> +	ret = cpuhp_setup_state(CPUHP_AP_CSKY_TIMER_STARTING,
> +				"clockevents/csky/timer:starting",
> +				csky_mptimer_starting_cpu,
> +				csky_mptimer_dying_cpu);
> +	if (ret) {
> +		pr_err("%s: Failed to cpuhp_setup_state.\n", __func__);
> +		return ret;
> +	}
> +
> +	clocksource_register_hz(&csky_clocksource, rate);
> +	sched_clock_register(sched_clock_read, 32, rate);
> +
> +	return 0;
> +}
> +TIMER_OF_DECLARE(csky_mptimer, "csky,mptimer", csky_mptimer_init);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index caf40ad..e0cd2ba 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -126,6 +126,7 @@ enum cpuhp_state {
>  	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
>  	CPUHP_AP_ARC_TIMER_STARTING,
>  	CPUHP_AP_RISCV_TIMER_STARTING,
> +	CPUHP_AP_CSKY_TIMER_STARTING,
>  	CPUHP_AP_KVM_STARTING,
>  	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
>  	CPUHP_AP_KVM_ARM_VGIC_STARTING,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

