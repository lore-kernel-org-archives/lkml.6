Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAFDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E2E20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lRvYbu2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E2E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeIFXCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:02:03 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26402 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIFXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536258323; x=1567794323;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0ECzECMFuJCNOp5QHhnRTzUXPe/+mAWbBgdI4vyoOY0=;
  b=lRvYbu2z4XQdyYScJi+NhOqfIVgw6ZBTyDtwTFdl+BwlgCPZ/Q8vCl4F
   wuw5TZk5UOgeOd3lGUjnV+lPDk0YDZWJgukzIyvVGwu6PSyHz0L/ld84r
   TtQ6I12j3B2I884uSexEEFx5ExdgPeOSqzdxjs53vciEzx0Qo81D5KYVZ
   D3B8iXZ48snRtmEntn1xAyr9WMuRVSHVwx1MzT0tQF+1L0DDNW8o72+SJ
   34eTNqNK61j/AUdXNiZXS6vYKAOze2xZcuLCetQ68fGgT66w7DrUgReni
   l6NcoisLZIU/T66gK1C91SV8iHkLzI0PkUKrmwpr019sBGxCT3LEVoJ0O
   w==;
X-IronPort-AV: E=Sophos;i="5.53,339,1531756800"; 
   d="scan'208";a="90778514"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2018 02:25:22 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 06 Sep 2018 11:12:03 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.203]) ([10.111.66.203])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2018 11:25:21 -0700
Subject: Re: [PATCH v3 12/12] RISC-V: Support cpu hotplug.
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
 <1536221135-182613-13-git-send-email-atish.patra@wdc.com>
 <20180906102039.725faspi47krldsl@salmiak>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <f1aa2a5a-95c9-dc41-bfc9-0be12a5781c6@wdc.com>
Date:   Thu, 6 Sep 2018 11:25:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906102039.725faspi47krldsl@salmiak>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/18 3:21 AM, Mark Rutland wrote:
> Hi,
> 
> On Thu, Sep 06, 2018 at 01:05:35AM -0700, Atish Patra wrote:
>> This patch enable support for cpu hotplug in RISC-V.
>>
>> In absence of generic cpu stop functions, WFI is used
>> to put the cpu in low power state during offline. An IPI
>> is sent to bring it out of WFI during online operation.
> 
> AFAICT, this doesn't actually return the CPU to firwmare, and the WFI and
> return code are in-kernel. From experience on arm and arm64 I would *very*
> strongly advise against this kind of pseudo-hotplug, as it causes many more
> long-term problems than it solves.
> 
I completely agree with you. The idea was here to have a working 
cpu-hotplug solution until we have a concrete implementation of cpu 
stop/start via firmware. Once we have that, we just need to replace the 
wakeup and wait_for_software_interrupt calls. The current implementation 
via WFI was never meant to be a long term solution.


> For instance, this causes significant pain with kexec, since the prior kernel's
> text must be kept around forever for the offline CPUs. Likewise with hibernate
> suspend/resume.
> 
> Depending on how your architecture works, there can also be a number of
> problems with cache/TLB maintenance for secondary CPUs which are unexpectedly
> online.
> 
> I would suggest that someone should look at writing a FW standard for CPU
> hotplug, akin to PSCI for arm/arm64. At minimum, you will want:
> 

I have already started working on it in parallel. As of now, I am 
planning to strengthen SBI spec by making it more flexible/extensible 
with some of the below features you mentioned. But we can come up with a 
new spec altogether if that makes more sense.

> - A mechanism to determine the version of FW and/or features supported by the FW.
> 
> - a mechanism to hotplug-in a specific CPU to a runtime-specified address,
>    ideally with some unique token (e.g. so you can pass a pointer to its stack
>    or whatever).
> 
> - a mechanism to hotplug-out the calling CPU.
> 
> - a mechanism to determine when a specific CPU has been hotplugged out. This is
>    necessary for kexec and other things to be robust.
>

Thanks for the pointers. I had not looked into 2&4 earlier. I will go 
over PSCI docs again.

Regards,
Atish

> Thanks,
> Mark.
> 
>>
>> Tested both on QEMU and HighFive Unleashed board with
>> 4 cpus. Test result follows.
>>
>> $ echo 0 > /sys/devices/system/cpu/cpu2/online
>> [   31.828562] CPU2: shutdown
>> $ cat /proc/cpuinfo
>> hart    : 0
>> isa     : rv64imafdc
>> mmu     : sv39
>> uarch   : sifive,rocket0
>>
>> hart    : 1
>> isa     : rv64imafdc
>> mmu     : sv39
>> uarch   : sifive,rocket0
>>
>> hart    : 3
>> isa     : rv64imafdc
>> mmu     : sv39
>> uarch   : sifive,rocket0
>>
>> $ echo 0 > /sys/devices/system/cpu/cpu3/online
>> [   52.968495] CPU3: shutdown
>> $ cat /proc/cpuinfo
>> hart    : 0
>> isa     : rv64imafdc
>> mmu     : sv39
>> uarch   : sifive,rocket0
>>
>> hart    : 2
>> isa     : rv64imafdc
>> mmu     : sv39
>> uarch   : sifive,rocket0
>>
>> $ echo 1 > /sys/devices/system/cpu/cpu3/online
>> [   64.298250] CPU3: online
>> $ cat /proc/cpuinfo
>> hart    : 0
>> isa     : rv64imafdc
>> mmu     : sv39
>> uarch   : sifive,rocket0
>>
>> hart    : 1
>> isa     : rv64imafdc
>> mmu     : sv39
>> uarch   : sifive,rocket0
>>
>> hart    : 3
>> isa     : rv64imafdc
>> mmu     : sv39
>> uarch   : sifive,rocket0
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/Kconfig              | 12 ++++++-
>>   arch/riscv/include/asm/irq.h    |  1 +
>>   arch/riscv/include/asm/smp.h    | 28 ++++++++++++++++
>>   arch/riscv/kernel/Makefile      |  1 +
>>   arch/riscv/kernel/cpu-hotplug.c | 72 +++++++++++++++++++++++++++++++++++++++++
>>   arch/riscv/kernel/head.S        | 13 ++++++++
>>   arch/riscv/kernel/irq.c         | 24 ++++++++++++++
>>   arch/riscv/kernel/setup.c       | 17 +++++++++-
>>   arch/riscv/kernel/smp.c         |  8 +----
>>   arch/riscv/kernel/smpboot.c     |  7 ++--
>>   arch/riscv/kernel/traps.c       |  6 ++--
>>   11 files changed, 175 insertions(+), 14 deletions(-)
>>   create mode 100644 arch/riscv/kernel/cpu-hotplug.c
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index a3449802..ea2e617e 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -21,7 +21,6 @@ config RISCV
>>   	select COMMON_CLK
>>   	select DMA_DIRECT_OPS
>>   	select GENERIC_CLOCKEVENTS
>> -	select GENERIC_CPU_DEVICES
>>   	select GENERIC_IRQ_SHOW
>>   	select GENERIC_PCI_IOMAP
>>   	select GENERIC_STRNCPY_FROM_USER
>> @@ -167,6 +166,17 @@ config SMP
>>   
>>   	  If you don't know what to do here, say N.
>>   
>> +config HOTPLUG_CPU
>> +	bool "Support for hot-pluggable CPUs"
>> +	depends on SMP
>> +	select GENERIC_IRQ_MIGRATION
>> +	help
>> +
>> +	  Say Y here to experiment with turning CPUs off and on.  CPUs
>> +	  can be controlled through /sys/devices/system/cpu.
>> +
>> +	  Say N if you want to disable CPU hotplug.
>> +
>>   config NR_CPUS
>>   	int "Maximum number of CPUs (2-32)"
>>   	range 2 32
>> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
>> index 996b6fbe..a873a72d 100644
>> --- a/arch/riscv/include/asm/irq.h
>> +++ b/arch/riscv/include/asm/irq.h
>> @@ -19,6 +19,7 @@
>>   
>>   void riscv_timer_interrupt(void);
>>   void riscv_software_interrupt(void);
>> +void wait_for_software_interrupt(void);
>>   
>>   #include <asm-generic/irq.h>
>>   
>> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
>> index fce312ce..8145b865 100644
>> --- a/arch/riscv/include/asm/smp.h
>> +++ b/arch/riscv/include/asm/smp.h
>> @@ -25,8 +25,29 @@
>>   extern unsigned long __cpuid_to_hardid_map[NR_CPUS];
>>   #define cpuid_to_hardid_map(cpu)    __cpuid_to_hardid_map[cpu]
>>   
>> +#if defined CONFIG_SMP && defined CONFIG_HOTPLUG_CPU
>> +void arch_send_call_wakeup_ipi(int cpu);
>> +bool can_hotplug_cpu(void);
>> +#else
>> +static inline bool can_hotplug_cpu(void)
>> +{
>> +	return 0;
>> +}
>> +static inline void arch_send_call_wakeup_ipi(int cpu) { }
>> +#endif
>> +
>>   #ifdef CONFIG_SMP
>>   
>> +enum ipi_message_type {
>> +	IPI_RESCHEDULE,
>> +	IPI_CALL_FUNC,
>> +	IPI_CALL_WAKEUP,
>> +	IPI_MAX
>> +};
>> +
>> +void send_ipi_message(const struct cpumask *to_whom,
>> +		      enum ipi_message_type operation);
>> +
>>   /* SMP initialization hook for setup_arch */
>>   void __init setup_smp(void);
>>   
>> @@ -45,6 +66,13 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>>    */
>>   #define raw_smp_processor_id() (current_thread_info()->cpu)
>>   
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +int __cpu_disable(void);
>> +void __cpu_die(unsigned int cpu);
>> +void cpu_play_dead(void);
>> +void boot_sec_cpu(void);
>> +#endif /* CONFIG_HOTPLUG_CPU */
>> +
>>   #else
>>   
>>   static inline int riscv_hartid_to_cpuid(int hartid)
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index e1274fc0..62043204 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -35,6 +35,7 @@ obj-$(CONFIG_SMP)		+= smpboot.o
>>   obj-$(CONFIG_SMP)		+= smp.o
>>   obj-$(CONFIG_MODULES)		+= module.o
>>   obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
>> +obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
>>   
>>   obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
>>   obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
>> diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
>> new file mode 100644
>> index 00000000..7a152972
>> --- /dev/null
>> +++ b/arch/riscv/kernel/cpu-hotplug.c
>> @@ -0,0 +1,72 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Western Digital Corporation or its affiliates.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/mm.h>
>> +#include <linux/sched.h>
>> +#include <linux/err.h>
>> +#include <linux/irq.h>
>> +#include <linux/cpu.h>
>> +#include <linux/sched/hotplug.h>
>> +#include <asm/irq.h>
>> +#include <asm/sbi.h>
>> +
>> +bool can_hotplug_cpu(void)
>> +{
>> +	return true;
>> +}
>> +
>> +void arch_cpu_idle_dead(void)
>> +{
>> +	cpu_play_dead();
>> +}
>> +
>> +/*
>> + * __cpu_disable runs on the processor to be shutdown.
>> + */
>> +int __cpu_disable(void)
>> +{
>> +	int ret = 0;
>> +	unsigned int cpu = smp_processor_id();
>> +
>> +	set_cpu_online(cpu, false);
>> +	irq_migrate_all_off_this_cpu();
>> +
>> +	return ret;
>> +}
>> +/*
>> + * called on the thread which is asking for a CPU to be shutdown -
>> + * waits until shutdown has completed, or it is timed out.
>> + */
>> +void __cpu_die(unsigned int cpu)
>> +{
>> +	if (!cpu_wait_death(cpu, 5)) {
>> +		pr_err("CPU %u: didn't die\n", cpu);
>> +		return;
>> +	}
>> +	pr_notice("CPU%u: shutdown\n", cpu);
>> +	/*TODO: Do we need to verify is cpu is really dead */
>> +}
>> +
>> +/*
>> + * Called from the idle thread for the CPU which has been shutdown.
>> + *
>> + */
>> +void cpu_play_dead(void)
>> +{
>> +	idle_task_exit();
>> +
>> +	(void)cpu_report_death();
>> +
>> +	/* Do not disable software interrupt to restart cpu after WFI */
>> +	csr_clear(sie, SIE_STIE | SIE_SEIE);
>> +	wait_for_software_interrupt();
>> +	boot_sec_cpu();
>> +}
>> +
>> +void arch_send_call_wakeup_ipi(int cpu)
>> +{
>> +	send_ipi_message(cpumask_of(cpu), IPI_CALL_WAKEUP);
>> +}
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index 711190d4..07d9fb38 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -153,6 +153,19 @@ relocate:
>>   	j .Lsecondary_park
>>   END(_start)
>>   
>> +#ifdef CONFIG_SMP
>> +.section .text
>> +.global boot_sec_cpu
>> +
>> +boot_sec_cpu:
>> +	/* clear all pending flags */
>> +	csrw sip, zero
>> +	/* Mask all interrupts */
>> +	csrw sie, zero
>> +	fence
>> +
>> +	tail smp_callin
>> +#endif
>>   __PAGE_ALIGNED_BSS
>>   	/* Empty zero page */
>>   	.balign PAGE_SIZE
>> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
>> index 0cfac48a..7e14b0d9 100644
>> --- a/arch/riscv/kernel/irq.c
>> +++ b/arch/riscv/kernel/irq.c
>> @@ -53,6 +53,30 @@ asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
>>   	set_irq_regs(old_regs);
>>   }
>>   
>> +/*
>> + * This function doesn't return until a software interrupt is sent via IPI.
>> + * Obviously, all the interrupts except software interrupt should be disabled
>> + * before this function is called.
>> + */
>> +void wait_for_software_interrupt(void)
>> +{
>> +	unsigned long sipval, sieval, scauseval;
>> +
>> +	/* clear all pending flags */
>> +	csr_write(sip, 0);
>> +	/* clear any previous scause data */
>> +	csr_write(scause, 0);
>> +
>> +	do {
>> +		wait_for_interrupt();
>> +		sipval = csr_read(sip);
>> +		sieval = csr_read(sie);
>> +		scauseval = csr_read(scause) & ~INTERRUPT_CAUSE_FLAG;
>> +	/* only break if wfi returns for an enabled interrupt */
>> +	} while ((sipval & sieval) == 0 &&
>> +		 scauseval != INTERRUPT_CAUSE_SOFTWARE);
>> +}
>> +
>>   void __init init_IRQ(void)
>>   {
>>   	irqchip_init();
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index a5fac1b7..612f0c21 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -30,11 +30,11 @@
>>   #include <linux/of_platform.h>
>>   #include <linux/sched/task.h>
>>   #include <linux/swiotlb.h>
>> +#include <linux/smp.h>
>>   
>>   #include <asm/setup.h>
>>   #include <asm/sections.h>
>>   #include <asm/pgtable.h>
>> -#include <asm/smp.h>
>>   #include <asm/sbi.h>
>>   #include <asm/tlbflush.h>
>>   #include <asm/thread_info.h>
>> @@ -82,6 +82,7 @@ EXPORT_SYMBOL(empty_zero_page);
>>   /* The lucky hart to first increment this variable will boot the other cores */
>>   atomic_t hart_lottery;
>>   unsigned long boot_cpu_hartid;
>> +static DEFINE_PER_CPU(struct cpu, cpu_devices);
>>   
>>   unsigned long __cpuid_to_hardid_map[NR_CPUS] = {
>>   	[0 ... NR_CPUS-1] = INVALID_HARTID
>> @@ -257,3 +258,17 @@ void __init setup_arch(char **cmdline_p)
>>   	riscv_fill_hwcap();
>>   }
>>   
>> +static int __init topology_init(void)
>> +{
>> +	int i;
>> +
>> +	for_each_possible_cpu(i) {
>> +		struct cpu *cpu = &per_cpu(cpu_devices, i);
>> +
>> +		cpu->hotpluggable = can_hotplug_cpu();
>> +		register_cpu(cpu, i);
>> +	}
>> +
>> +	return 0;
>> +}
>> +subsys_initcall(topology_init);
>> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
>> index 89d95866..629456bb 100644
>> --- a/arch/riscv/kernel/smp.c
>> +++ b/arch/riscv/kernel/smp.c
>> @@ -32,12 +32,6 @@ static struct {
>>   	unsigned long bits ____cacheline_aligned;
>>   } ipi_data[NR_CPUS] __cacheline_aligned;
>>   
>> -enum ipi_message_type {
>> -	IPI_RESCHEDULE,
>> -	IPI_CALL_FUNC,
>> -	IPI_MAX
>> -};
>> -
>>   int riscv_hartid_to_cpuid(int hartid)
>>   {
>>   	int i = -1;
>> @@ -94,7 +88,7 @@ void riscv_software_interrupt(void)
>>   	}
>>   }
>>   
>> -static void
>> +void
>>   send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
>>   {
>>   	int cpuid, hartid;
>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>> index f44ae780..a9138431 100644
>> --- a/arch/riscv/kernel/smpboot.c
>> +++ b/arch/riscv/kernel/smpboot.c
>> @@ -92,9 +92,12 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>   		  task_stack_page(tidle) + THREAD_SIZE);
>>   	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
>>   
>> +	arch_send_call_wakeup_ipi(cpu);
>>   	while (!cpu_online(cpu))
>>   		cpu_relax();
>>   
>> +	pr_notice("CPU%u: online\n", cpu);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -105,7 +108,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
>>   /*
>>    * C entry point for a secondary processor.
>>    */
>> -asmlinkage void __init smp_callin(void)
>> +asmlinkage void smp_callin(void)
>>   {
>>   	struct mm_struct *mm = &init_mm;
>>   
>> @@ -115,7 +118,7 @@ asmlinkage void __init smp_callin(void)
>>   
>>   	trap_init();
>>   	notify_cpu_starting(smp_processor_id());
>> -	set_cpu_online(smp_processor_id(), 1);
>> +	set_cpu_online(smp_processor_id(), true);
>>   	/*
>>   	 * Remote TLB flushes are ignored while the CPU is offline, so emit
>>   	 * a local TLB flush right now just in case.
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index 24a9333d..8b331619 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -153,7 +153,7 @@ int is_valid_bugaddr(unsigned long pc)
>>   }
>>   #endif /* CONFIG_GENERIC_BUG */
>>   
>> -void __init trap_init(void)
>> +void trap_init(void)
>>   {
>>   	/*
>>   	 * Set sup0 scratch register to 0, indicating to exception vector
>> @@ -162,6 +162,6 @@ void __init trap_init(void)
>>   	csr_write(sscratch, 0);
>>   	/* Set the exception vector address */
>>   	csr_write(stvec, &handle_exception);
>> -	/* Enable all interrupts */
>> -	csr_write(sie, -1);
>> +	/* Enable all interrupts but timer interrupt*/
>> +	csr_set(sie, SIE_SSIE | SIE_SEIE);
>>   }
>> -- 
>> 2.7.4
>>
> 

