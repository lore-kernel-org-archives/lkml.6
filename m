Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B8EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EAF2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Z6rABJMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfBRJBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:01:33 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14549 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfBRJBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:01:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6a746e0000>; Mon, 18 Feb 2019 01:01:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 01:01:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 01:01:29 -0800
Received: from DRHQMAIL101.nvidia.com (10.27.9.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 09:01:26 +0000
Received: from [10.19.108.132] (10.124.1.5) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 09:01:23 +0000
Subject: Re: [PATCH V6 2/7] clocksource: tegra: add Tegra210 timer support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
References: <20190201161654.18315-1-josephl@nvidia.com>
 <20190201161654.18315-3-josephl@nvidia.com>
 <3849a41f-ab36-d7e0-b2ce-1aa5c4e34aec@linaro.org>
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <87731d61-10f6-0842-a90f-0c78ffba9ef7@nvidia.com>
Date:   Mon, 18 Feb 2019 17:01:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3849a41f-ab36-d7e0-b2ce-1aa5c4e34aec@linaro.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 DRHQMAIL101.nvidia.com (10.27.9.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550480494; bh=gdeGp+7F1da5XhRVBHV92J2zxc10m7bbBVaUwykl8w4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Z6rABJMdGz9GG4rWOKyAAcBxbO63lDq8HgN3RBw2m1L2mFQ2uHpiBqbQ3hpkJF6YG
         jmUamw2EW3FampqUxfwdb1nvcy2EtkE6QP1ZWkGKDQVm8jlV6SrH4AIaPfMvLb0VsV
         kJtZOLFDWj+UrNGSiez2hQZ9NDIt99l6kRKh+q9mkJzY0HZoDN7gnS/Zh63nDRgAhx
         acVgPhJlWXJQeKHKkj7IYzE48oJET0GYJmJhZbUcShicxPpE2C3NwOO33jhWEysY5M
         MnCNmYQzMr9e4jtHQVuZF2Bs3Uwg2g678YiLvCApDzYvUZ7yjNMEoPQAT1itLVfX8t
         Ylw3WxOErhVog==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 11:14 PM, Daniel Lezcano wrote:
> On 01/02/2019 17:16, Joseph Lo wrote:
>> Add support for the Tegra210 timer that runs at oscillator clock
>> (TMR10-TMR13). We need these timers to work as clock event device and to
>> replace the ARMv8 architected timer due to it can't survive across the
>> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
>> source when CPU suspends in power down state.
>>
>> Also convert the original driver to use timer-of API.
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>> v6:
>>   * refine the timer defines
>>   * add ack tag from Jon.
>> v5:
>>   * add ack tag from Thierry
>> v4:
>>   * merge timer-tegra210.c in previous version into timer-tegra20.c
>> v3:
>>   * use timer-of API
>> v2:
>>   * add error clean-up code
>> ---
>>   drivers/clocksource/Kconfig         |   2 +-
>>   drivers/clocksource/timer-tegra20.c | 371 ++++++++++++++++++++--------
>>   include/linux/cpuhotplug.h          |   1 +
>>   3 files changed, 270 insertions(+), 104 deletions(-)
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index a9e26f6a81a1..6af78534a285 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -131,7 +131,7 @@ config SUN5I_HSTIMER
>>   config TEGRA_TIMER
>>   	bool "Tegra timer driver" if COMPILE_TEST
>>   	select CLKSRC_MMIO
>> -	depends on ARM
> 
> This will break because the delay functions are defined in
> arch/arm/include/asm/delay.h and the 01.org will try to compile the
> driver on x86.
> 
> You may want to add 'depends on ARM && ARM64'
> 

OK, I think it's 'depends on ARM || ARM64'.
Will fix.

>> +	select TIMER_OF
>>   	help
>>   	  Enables support for the Tegra driver.
>>   
[snip]
>> -
>>   static struct timespec64 persistent_ts;
>>   static u64 persistent_ms, last_persistent_ms;
> 
> Did you check the above changes are still relevant after commit
> 39232ed5a1793f67 and after doing a change similar to
> commit 1569557549697207e523 ?
> 

Yes, just check both commits. I think it's okay to use the same. But 
need another patch to do that, this patch only adds new support for 
Tegra210. Doesn't touch the original code.

> 
>>   static struct delay_timer tegra_delay_timer;
[snip]
>> +#ifdef CONFIG_ARM64
>> +static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
>> +	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
>> +
>> +	.clkevt = {
>> +		.name = "tegra_timer",
>> +		.rating = 460,
>> +		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> 
> 			CLOCK_EVT_FEAT_DYNIRQ ?
Yes, good catch.
> 
>> +		.set_next_event = tegra_timer_set_next_event,
>> +		.set_state_shutdown = tegra_timer_shutdown,
>> +		.set_state_periodic = tegra_timer_set_periodic,
>> +		.set_state_oneshot = tegra_timer_shutdown,
>> +		.tick_resume = tegra_timer_shutdown,
>> +	},
>> +};
[snip]
>> -static unsigned long tegra_delay_timer_read_counter_long(void)
>> +static int tegra_timer_suspend(void)
>>   {
>> -	return readl(timer_reg_base + TIMERUS_CNTR_1US);
>> +#ifdef CONFIG_ARM64
> 
> Please do not add those #ifdef but function stubs.
> 
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
>> +		void __iomem *reg_base = timer_of_base(to);
>> +
>> +		writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
>> +	}
>> +#else
>> +	void __iomem *reg_base = timer_of_base(&tegra_to);
>> +
>> +	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
>> +#endif
>> +
>> +	return 0;
>>   }
>>   
>> -static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
>> +static void tegra_timer_resume(void)
>>   {
>> -	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
>> -	timer_writel(1<<30, TIMER3_BASE + TIMER_PCR);
>> -	evt->event_handler(evt);
>> -	return IRQ_HANDLED;
>> +	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
>>   }
>>   
>> -static struct irqaction tegra_timer_irq = {
>> -	.name		= "timer0",
>> -	.flags		= IRQF_TIMER | IRQF_TRIGGER_HIGH,
>> -	.handler	= tegra_timer_interrupt,
>> -	.dev_id		= &tegra_clockevent,
>> +static struct syscore_ops tegra_timer_syscore_ops = {
>> +	.suspend = tegra_timer_suspend,
>> +	.resume = tegra_timer_resume,
>>   };
> 
> It will be nicer to use the suspend/resume callbacks defined in the
> clockevent structure, so you can use generic as there are multiple
> clockevents defined for the tegra210, thus multiple timer-of
> encapsulating them. When the suspend/resume callbacks are called, they
> have the clock_event pointer and you can use it to retrieve the timer-of
> and then the base address. At the end, the callbacks will end up the
> same for tegra20 and tegra210.
> 

Very good suggestion, will follow up.

>> -static int __init tegra20_init_timer(struct device_node *np)
>> +static int tegra_timer_init(struct device_node *np, struct timer_of *to)
[snip]
>> +	for_each_possible_cpu(cpu) {
>> +		struct timer_of *cpu_to;
>> +
>> +		cpu_to = per_cpu_ptr(&tegra_to, cpu);
>> +		cpu_to->of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(cpu);
>> +		cpu_to->of_clk.rate = timer_of_rate(to);
>> +		cpu_to->clkevt.cpumask = cpumask_of(cpu);
>> +
>> +		cpu_to->clkevt.irq =
>> +			irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
>> +		if (!cpu_to->clkevt.irq) {
>> +			pr_err("%s: can't map IRQ for CPU%d\n",
>> +			       __func__, cpu);
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
>> +		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr,
>> +				  IRQF_TIMER | IRQF_NOBALANCING,
>> +				  cpu_to->clkevt.name, &cpu_to->clkevt);
>> +		if (ret) {
>> +			pr_err("%s: cannot setup irq %d for CPU%d\n",
>> +				__func__, cpu_to->clkevt.irq, cpu);
>> +			ret = -EINVAL;
>> +			goto out_irq;
>> +		}
>> +	}
> 
> You should configure the timer in the tegra_timer_setup() function
> instead of using this cpu loop.
> 

I think I still need to leave 'irq_of_parse_and_map' and 'request_irq' 
here. Is that ok?

>> +
>> +	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
>> +			  "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
>> +			  tegra_timer_stop);
>> +
>> +	return ret;
>> +
>> +out_irq:
>> +	for_each_possible_cpu(cpu) {
>> +		struct timer_of *cpu_to;
>> +
>> +		cpu_to = per_cpu_ptr(&tegra_to, cpu);
>> +		if (cpu_to->clkevt.irq) {
>> +			free_irq(cpu_to->clkevt.irq, &cpu_to->clkevt);
>> +			irq_dispose_mapping(cpu_to->clkevt.irq);
>> +		}
>>   	}
>> +out:
>> +	timer_of_cleanup(to);
>> +	return ret;
>> +}
>> +TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_timer_init);
>> +#else /* CONFIG_ARM */
> 
> Don't use the macro to select one or another. Just define the functions
> and let the init postcalls to free the memory.
> 

Okay, I think I can move 'TIMER_OF_DECLARE' out of the ifdef. They will 
be something like below. And change tegraxxx_init_timer to tegra_init_timer.

TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra_timer_init);
TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra_timer_init);

Is that ok?

Thanks for reviewing,
Joseph

>> +static int __init tegra20_init_timer(struct device_node *np)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = tegra_timer_init(np, &tegra_to);
>> +	if (ret < 0)
>> +		goto out;
>>   
>> -	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
>> +	tegra_to.of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(0);
>> +	tegra_to.of_clk.rate = 1000000; /* microsecond timer */
>>   
>> +	sched_clock_register(tegra_read_sched_clock, 32,
>> +			     timer_of_rate(&tegra_to));
>>   	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
>> -				    "timer_us", 1000000, 300, 32,
>> -				    clocksource_mmio_readl_up);
>> +				    "timer_us", timer_of_rate(&tegra_to),
>> +				    300, 32, clocksource_mmio_readl_up);
>>   	if (ret) {
>>   		pr_err("Failed to register clocksource\n");
>> -		return ret;
>> +		goto out;
>>   	}
>>   
>>   	tegra_delay_timer.read_current_timer =
>>   			tegra_delay_timer_read_counter_long;
>> -	tegra_delay_timer.freq = 1000000;
>> +	tegra_delay_timer.freq = timer_of_rate(&tegra_to);
>>   	register_current_timer_delay(&tegra_delay_timer);
>>   
>> -	ret = setup_irq(tegra_timer_irq.irq, &tegra_timer_irq);
>> -	if (ret) {
>> -		pr_err("Failed to register timer IRQ: %d\n", ret);
>> -		return ret;
>> -	}
>> +	clockevents_config_and_register(&tegra_to.clkevt,
>> +					timer_of_rate(&tegra_to),
>> +					0x1,
>> +					0x1fffffff);
>>   
>> -	tegra_clockevent.cpumask = cpu_possible_mask;
>> -	tegra_clockevent.irq = tegra_timer_irq.irq;
>> -	clockevents_config_and_register(&tegra_clockevent, 1000000,
>> -					0x1, 0x1fffffff);
>> +	return ret;
>> +out:
>> +	timer_of_cleanup(&tegra_to);
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
>>   
>> @@ -261,3 +425,4 @@ static int __init tegra20_init_rtc(struct device_node *np)
>>   	return register_persistent_clock(tegra_read_persistent_clock64);
>>   }
>>   TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
>> +#endif
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index fd586d0301e7..e78281d07b70 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -121,6 +121,7 @@ enum cpuhp_state {
>>   	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>>   	CPUHP_AP_ARM_TWD_STARTING,
>>   	CPUHP_AP_QCOM_TIMER_STARTING,
>> +	CPUHP_AP_TEGRA_TIMER_STARTING,
>>   	CPUHP_AP_ARMADA_TIMER_STARTING,
>>   	CPUHP_AP_MARCO_TIMER_STARTING,
>>   	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
>>
> 
> 
