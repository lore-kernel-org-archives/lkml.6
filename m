Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA66DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C8D20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="klyHhdBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C8D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbeGZUKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:10:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55484 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbeGZUKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532631117; x=1564167117;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xYbaojUJWKF6nUFzUBagFd0ZOsG3d3WKzTjS6qQpo5o=;
  b=klyHhdBdy0xdsRiJjFb0kHMGOOtRH0rdCZkYnxcHGomMJvchJSuN86o7
   PyAYA5d10NbpG6MM8tvRJSr4aMBHZERFq9nWcYJysbcl32kQ0ZkOxu9/K
   WGvTl5rBPt4iwhA1QTrj/fUc7uQy7XOo/YfPVw9tvh9yPeZ6Z94FlqQ7w
   zu+Iwi08GbPYMzAjykJQefsYjoTHe9irSYbpK1fdjAvL2eTJ1EgTuQFAI
   FXbGVN/RWWDGt0mmr8Ekcso5XOCxeEVdHdKB6V7yj0b2qHx1JS6Lmsf96
   JLDKp+sJujwjywoEqvOedbyGdkC9IaMQtYsCZnmLPwChHcvGr1n9KrYxY
   A==;
X-IronPort-AV: E=Sophos;i="5.51,406,1526313600"; 
   d="scan'208";a="86505722"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2018 02:51:57 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jul 2018 11:40:32 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jul 2018 11:51:57 -0700
Subject: Re: [PATCH 9/9] clocksource: new RISC-V SBI timer driver
To:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <20180726143723.16585-1-hch@lst.de>
 <20180726143723.16585-10-hch@lst.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <972dacda-75d6-83cd-45e0-c7526a4e02ba@wdc.com>
Date:   Thu, 26 Jul 2018 11:51:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726143723.16585-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


minor nits.

On 7/26/18 7:38 AM, Christoph Hellwig wrote:
> From: Palmer Dabbelt <palmer@dabbelt.com>
> 
> The RISC-V ISA defines a per-hart real-time clock and timer, which is
> present on all systems.  The clock is accessed via the 'rdtime'
> pseudo-instruction (which reads a CSR), and the timer is set via an SBI
> call.
> 
> Contains various improvements from Atish Patra <atish.patra@wdc.com>.
> 
> Signed-off-by: Dmitriy Cherkasov <dmitriy@oss-tech.org>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> [hch: remove dead code, add SPDX tags, minor cleanups, merged
>   hotplug cpu and other improvements from Atish]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/riscv/include/asm/smp.h      |   3 -
>   arch/riscv/kernel/irq.c           |   3 +
>   arch/riscv/kernel/smpboot.c       |   1 -
>   arch/riscv/kernel/time.c          |   8 +-
>   drivers/clocksource/Kconfig       |  10 +++
>   drivers/clocksource/Makefile      |   1 +
>   drivers/clocksource/riscv_timer.c | 121 ++++++++++++++++++++++++++++++
>   include/linux/cpuhotplug.h        |   1 +
>   8 files changed, 137 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/clocksource/riscv_timer.c
> 
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index c9395fff246f..36016845461d 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -24,9 +24,6 @@
>   
>   #ifdef CONFIG_SMP
>   
> -/* SMP initialization hook for setup_arch */
> -void __init init_clockevent(void);
> -
>   /* SMP initialization hook for setup_arch */
>   void __init setup_smp(void);
>   
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index ab5f3e22c7cc..0cfac48a1272 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -30,6 +30,9 @@ asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
>   
>   	irq_enter();
>   	switch (cause & ~INTERRUPT_CAUSE_FLAG) {
> +	case INTERRUPT_CAUSE_TIMER:
> +		riscv_timer_interrupt();
> +		break;
>   #ifdef CONFIG_SMP
>   	case INTERRUPT_CAUSE_SOFTWARE:
>   		/*
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index f741458c5a3f..56abab6a9812 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -104,7 +104,6 @@ asmlinkage void __init smp_callin(void)
>   	current->active_mm = mm;
>   
>   	trap_init();
> -	init_clockevent();
>   	notify_cpu_starting(smp_processor_id());
>   	set_cpu_online(smp_processor_id(), 1);
>   	local_flush_tlb_all();
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index 1bb01dc2d0f1..94e9ca18f5fa 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -18,12 +18,6 @@
>   
>   unsigned long riscv_timebase;
>   
> -void __init init_clockevent(void)
> -{
> -	timer_probe();
> -	csr_set(sie, SIE_STIE);
> -}
> -
>   static long __init timebase_frequency(void)
>   {
>   	struct device_node *cpu;
> @@ -43,5 +37,5 @@ void __init time_init(void)
>   {
>   	riscv_timebase = timebase_frequency();
>   	lpj_fine = riscv_timebase / HZ;
> -	init_clockevent();
> +	timer_probe();
>   }
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index dec0dd88ec15..a57083efaae8 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -609,4 +609,14 @@ config ATCPIT100_TIMER
>   	help
>   	  This option enables support for the Andestech ATCPIT100 timers.
>   
> +config RISCV_TIMER
> +	bool "Timer for the RISC-V platform"
> +	depends on RISCV || COMPILE_TEST
> +	select TIMER_PROBE
> +	select TIMER_OF
> +	help
> +	  This enables the per-hart timer built into all RISC-V systems, which
> +	  is accessed via both the SBI and the rdcycle instruction.  This is
> +	  required for all RISC-V systems.
> +
>   endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 00caf37e52f9..ded31f720bd9 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
>   obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>   obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>   obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
> +obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
> new file mode 100644
> index 000000000000..146156448bdd
> --- /dev/null
> +++ b/drivers/clocksource/riscv_timer.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2012 Regents of the University of California
> + * Copyright (C) 2017 SiFive
> + */
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <linux/cpu.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <asm/sbi.h>
> +
> +/*
> + * All RISC-V systems have a timer attached to every hart.  These timers can be
> + * read by the 'rdcycle' pseudo instruction, and can use the SBI to setup
> + * events.  In order to abstract the architecture-specific timer reading and
> + * setting functions away from the clock event insertion code, we provide
> + * function pointers to the clockevent subsystem that perform two basic
> + * operations: rdtime() reads the timer on the current CPU, and
> + * next_event(delta) sets the next timer event to 'delta' cycles in the future.
> + * As the timers are inherently a per-cpu resource, these callbacks perform
> + * operations on the current hart.  There is guaranteed to be exactly one timer
> + * per hart on all RISC-V systems.
> + */
> +
> +#define MINDELTA 100
> +#define MAXDELTA 0x7fffffff
> +
> +static int riscv_clock_next_event(unsigned long delta,
> +		struct clock_event_device *ce)
> +{
> +	csr_set(sie, SIE_STIE);
> +	sbi_set_timer(get_cycles64() + delta);
> +	return 0;
> +}
> +
> +static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
> +	.name			= "riscv_timer_clockevent",
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
> +	.rating			= 100,
> +	.set_next_event		= riscv_clock_next_event,
> +};
> +
> +/*
> + * It is guarnteed that all the timers across all the harts are synchronized

/s/guarnteed/guaranteed

> + * within one tick of each other, so while this could technically go
> + * backwards when hopping between CPUs, practically it won't happen.
> + */
> +static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
> +{
> +	return get_cycles64();
> +}
> +
> +static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
> +	.name		= "riscv_clocksource",
> +	.rating		= 300,
> +	.mask		= CLOCKSOURCE_MASK(BITS_PER_LONG),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.read		= riscv_clocksource_rdtime,
> +};
> +
> +static int timer_riscv_starting_cpu(unsigned int cpu)
> +{
> +	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
> +
> +	ce->cpumask = cpumask_of(cpu);
> +	clockevents_config_and_register(ce, riscv_timebase, MINDELTA, MAXDELTA);
> +	csr_set(sie, SIE_STIE);
> +	return 0;
> +}
> +
> +static int timer_riscv_dying_cpu(unsigned int cpu)
> +{
> +	csr_clear(sie, SIE_STIE);
> +	return 0;
> +}
> +
> +/* called directly from the low-level interrupt handler */
> +void riscv_timer_interrupt(void)
> +{

Should we follow the same prefix for these functions?
either timer_riscv* or riscv_timer* ?

Apologies for overlooking this in my timer patch as well.

> +	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
> +

The comment about the purpose of clearing the interrupt in the original 
patch is removed here. If that's intentional, it's fine.

I thought having that comment helps understanding the distinction 
between clearing the timer interrupt in SBI call & here.
> +	csr_clear(sie, SIE_STIE);
> +	evdev->event_handler(evdev);
> +}
> +
> +static int hart_of_timer(struct device_node *dev)
> +{
> +	u32 hart;
> +
> +	if (!dev)
> +		return -1;
> +	if (!of_device_is_compatible(dev, "riscv"))
> +		return -1;
> +	if (of_property_read_u32(dev, "reg", &hart))
> +		return -1;
> +
> +	return hart;
> +}
> +
> +static int __init timer_riscv_init_dt(struct device_node *n)
> +{
> +	int cpu_id = hart_of_timer(n), error;
> +	struct clocksource *cs;
> +
> +	if (cpu_id != smp_processor_id())
> +		return 0;
> +
> +	cs = per_cpu_ptr(&riscv_clocksource, cpu_id);
> +	clocksource_register_hz(cs, riscv_timebase);
> +
> +	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
> +			 "clockevents/riscv/timer:starting",
> +			 timer_riscv_starting_cpu, timer_riscv_dying_cpu);
> +	if (error)
> +		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> +		       error, cpu_id);
> +	return error;
> +}
> +
> +TIMER_OF_DECLARE(riscv_timer, "riscv", timer_riscv_init_dt);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 8796ba387152..554c27f6cfbd 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -125,6 +125,7 @@ enum cpuhp_state {
>   	CPUHP_AP_MARCO_TIMER_STARTING,
>   	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
>   	CPUHP_AP_ARC_TIMER_STARTING,
> +	CPUHP_AP_RISCV_TIMER_STARTING,
>   	CPUHP_AP_KVM_STARTING,
>   	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
>   	CPUHP_AP_KVM_ARM_VGIC_STARTING,
> 

