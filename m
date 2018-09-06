Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F46C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154A02075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154A02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeIFOzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:55:40 -0400
Received: from foss.arm.com ([217.140.101.70]:42720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeIFOzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:55:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56B3580D;
        Thu,  6 Sep 2018 03:20:53 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E34533F557;
        Thu,  6 Sep 2018 03:20:49 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:20:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH v3 12/12] RISC-V: Support cpu hotplug.
Message-ID: <20180906102039.725faspi47krldsl@salmiak>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
 <1536221135-182613-13-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536221135-182613-13-git-send-email-atish.patra@wdc.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 06, 2018 at 01:05:35AM -0700, Atish Patra wrote:
> This patch enable support for cpu hotplug in RISC-V.
> 
> In absence of generic cpu stop functions, WFI is used
> to put the cpu in low power state during offline. An IPI
> is sent to bring it out of WFI during online operation.

AFAICT, this doesn't actually return the CPU to firwmare, and the WFI and
return code are in-kernel. From experience on arm and arm64 I would *very*
strongly advise against this kind of pseudo-hotplug, as it causes many more
long-term problems than it solves.

For instance, this causes significant pain with kexec, since the prior kernel's
text must be kept around forever for the offline CPUs. Likewise with hibernate
suspend/resume.

Depending on how your architecture works, there can also be a number of
problems with cache/TLB maintenance for secondary CPUs which are unexpectedly
online.

I would suggest that someone should look at writing a FW standard for CPU
hotplug, akin to PSCI for arm/arm64. At minimum, you will want:

- A mechanism to determine the version of FW and/or features supported by the FW.

- a mechanism to hotplug-in a specific CPU to a runtime-specified address,
  ideally with some unique token (e.g. so you can pass a pointer to its stack
  or whatever).

- a mechanism to hotplug-out the calling CPU.

- a mechanism to determine when a specific CPU has been hotplugged out. This is
  necessary for kexec and other things to be robust.

Thanks,
Mark.

> 
> Tested both on QEMU and HighFive Unleashed board with
> 4 cpus. Test result follows.
> 
> $ echo 0 > /sys/devices/system/cpu/cpu2/online
> [   31.828562] CPU2: shutdown
> $ cat /proc/cpuinfo
> hart    : 0
> isa     : rv64imafdc
> mmu     : sv39
> uarch   : sifive,rocket0
> 
> hart    : 1
> isa     : rv64imafdc
> mmu     : sv39
> uarch   : sifive,rocket0
> 
> hart    : 3
> isa     : rv64imafdc
> mmu     : sv39
> uarch   : sifive,rocket0
> 
> $ echo 0 > /sys/devices/system/cpu/cpu3/online
> [   52.968495] CPU3: shutdown
> $ cat /proc/cpuinfo
> hart    : 0
> isa     : rv64imafdc
> mmu     : sv39
> uarch   : sifive,rocket0
> 
> hart    : 2
> isa     : rv64imafdc
> mmu     : sv39
> uarch   : sifive,rocket0
> 
> $ echo 1 > /sys/devices/system/cpu/cpu3/online
> [   64.298250] CPU3: online
> $ cat /proc/cpuinfo
> hart    : 0
> isa     : rv64imafdc
> mmu     : sv39
> uarch   : sifive,rocket0
> 
> hart    : 1
> isa     : rv64imafdc
> mmu     : sv39
> uarch   : sifive,rocket0
> 
> hart    : 3
> isa     : rv64imafdc
> mmu     : sv39
> uarch   : sifive,rocket0
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig              | 12 ++++++-
>  arch/riscv/include/asm/irq.h    |  1 +
>  arch/riscv/include/asm/smp.h    | 28 ++++++++++++++++
>  arch/riscv/kernel/Makefile      |  1 +
>  arch/riscv/kernel/cpu-hotplug.c | 72 +++++++++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/head.S        | 13 ++++++++
>  arch/riscv/kernel/irq.c         | 24 ++++++++++++++
>  arch/riscv/kernel/setup.c       | 17 +++++++++-
>  arch/riscv/kernel/smp.c         |  8 +----
>  arch/riscv/kernel/smpboot.c     |  7 ++--
>  arch/riscv/kernel/traps.c       |  6 ++--
>  11 files changed, 175 insertions(+), 14 deletions(-)
>  create mode 100644 arch/riscv/kernel/cpu-hotplug.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a3449802..ea2e617e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -21,7 +21,6 @@ config RISCV
>  	select COMMON_CLK
>  	select DMA_DIRECT_OPS
>  	select GENERIC_CLOCKEVENTS
> -	select GENERIC_CPU_DEVICES
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_PCI_IOMAP
>  	select GENERIC_STRNCPY_FROM_USER
> @@ -167,6 +166,17 @@ config SMP
>  
>  	  If you don't know what to do here, say N.
>  
> +config HOTPLUG_CPU
> +	bool "Support for hot-pluggable CPUs"
> +	depends on SMP
> +	select GENERIC_IRQ_MIGRATION
> +	help
> +
> +	  Say Y here to experiment with turning CPUs off and on.  CPUs
> +	  can be controlled through /sys/devices/system/cpu.
> +
> +	  Say N if you want to disable CPU hotplug.
> +
>  config NR_CPUS
>  	int "Maximum number of CPUs (2-32)"
>  	range 2 32
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index 996b6fbe..a873a72d 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -19,6 +19,7 @@
>  
>  void riscv_timer_interrupt(void);
>  void riscv_software_interrupt(void);
> +void wait_for_software_interrupt(void);
>  
>  #include <asm-generic/irq.h>
>  
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index fce312ce..8145b865 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -25,8 +25,29 @@
>  extern unsigned long __cpuid_to_hardid_map[NR_CPUS];
>  #define cpuid_to_hardid_map(cpu)    __cpuid_to_hardid_map[cpu]
>  
> +#if defined CONFIG_SMP && defined CONFIG_HOTPLUG_CPU
> +void arch_send_call_wakeup_ipi(int cpu);
> +bool can_hotplug_cpu(void);
> +#else
> +static inline bool can_hotplug_cpu(void)
> +{
> +	return 0;
> +}
> +static inline void arch_send_call_wakeup_ipi(int cpu) { }
> +#endif
> +
>  #ifdef CONFIG_SMP
>  
> +enum ipi_message_type {
> +	IPI_RESCHEDULE,
> +	IPI_CALL_FUNC,
> +	IPI_CALL_WAKEUP,
> +	IPI_MAX
> +};
> +
> +void send_ipi_message(const struct cpumask *to_whom,
> +		      enum ipi_message_type operation);
> +
>  /* SMP initialization hook for setup_arch */
>  void __init setup_smp(void);
>  
> @@ -45,6 +66,13 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>   */
>  #define raw_smp_processor_id() (current_thread_info()->cpu)
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +int __cpu_disable(void);
> +void __cpu_die(unsigned int cpu);
> +void cpu_play_dead(void);
> +void boot_sec_cpu(void);
> +#endif /* CONFIG_HOTPLUG_CPU */
> +
>  #else
>  
>  static inline int riscv_hartid_to_cpuid(int hartid)
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index e1274fc0..62043204 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_SMP)		+= smpboot.o
>  obj-$(CONFIG_SMP)		+= smp.o
>  obj-$(CONFIG_MODULES)		+= module.o
>  obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
> +obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
>  
>  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
> diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
> new file mode 100644
> index 00000000..7a152972
> --- /dev/null
> +++ b/arch/riscv/kernel/cpu-hotplug.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/err.h>
> +#include <linux/irq.h>
> +#include <linux/cpu.h>
> +#include <linux/sched/hotplug.h>
> +#include <asm/irq.h>
> +#include <asm/sbi.h>
> +
> +bool can_hotplug_cpu(void)
> +{
> +	return true;
> +}
> +
> +void arch_cpu_idle_dead(void)
> +{
> +	cpu_play_dead();
> +}
> +
> +/*
> + * __cpu_disable runs on the processor to be shutdown.
> + */
> +int __cpu_disable(void)
> +{
> +	int ret = 0;
> +	unsigned int cpu = smp_processor_id();
> +
> +	set_cpu_online(cpu, false);
> +	irq_migrate_all_off_this_cpu();
> +
> +	return ret;
> +}
> +/*
> + * called on the thread which is asking for a CPU to be shutdown -
> + * waits until shutdown has completed, or it is timed out.
> + */
> +void __cpu_die(unsigned int cpu)
> +{
> +	if (!cpu_wait_death(cpu, 5)) {
> +		pr_err("CPU %u: didn't die\n", cpu);
> +		return;
> +	}
> +	pr_notice("CPU%u: shutdown\n", cpu);
> +	/*TODO: Do we need to verify is cpu is really dead */
> +}
> +
> +/*
> + * Called from the idle thread for the CPU which has been shutdown.
> + *
> + */
> +void cpu_play_dead(void)
> +{
> +	idle_task_exit();
> +
> +	(void)cpu_report_death();
> +
> +	/* Do not disable software interrupt to restart cpu after WFI */
> +	csr_clear(sie, SIE_STIE | SIE_SEIE);
> +	wait_for_software_interrupt();
> +	boot_sec_cpu();
> +}
> +
> +void arch_send_call_wakeup_ipi(int cpu)
> +{
> +	send_ipi_message(cpumask_of(cpu), IPI_CALL_WAKEUP);
> +}
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 711190d4..07d9fb38 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -153,6 +153,19 @@ relocate:
>  	j .Lsecondary_park
>  END(_start)
>  
> +#ifdef CONFIG_SMP
> +.section .text
> +.global boot_sec_cpu
> +
> +boot_sec_cpu:
> +	/* clear all pending flags */
> +	csrw sip, zero
> +	/* Mask all interrupts */
> +	csrw sie, zero
> +	fence
> +
> +	tail smp_callin
> +#endif
>  __PAGE_ALIGNED_BSS
>  	/* Empty zero page */
>  	.balign PAGE_SIZE
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 0cfac48a..7e14b0d9 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -53,6 +53,30 @@ asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
>  	set_irq_regs(old_regs);
>  }
>  
> +/*
> + * This function doesn't return until a software interrupt is sent via IPI.
> + * Obviously, all the interrupts except software interrupt should be disabled
> + * before this function is called.
> + */
> +void wait_for_software_interrupt(void)
> +{
> +	unsigned long sipval, sieval, scauseval;
> +
> +	/* clear all pending flags */
> +	csr_write(sip, 0);
> +	/* clear any previous scause data */
> +	csr_write(scause, 0);
> +
> +	do {
> +		wait_for_interrupt();
> +		sipval = csr_read(sip);
> +		sieval = csr_read(sie);
> +		scauseval = csr_read(scause) & ~INTERRUPT_CAUSE_FLAG;
> +	/* only break if wfi returns for an enabled interrupt */
> +	} while ((sipval & sieval) == 0 &&
> +		 scauseval != INTERRUPT_CAUSE_SOFTWARE);
> +}
> +
>  void __init init_IRQ(void)
>  {
>  	irqchip_init();
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index a5fac1b7..612f0c21 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -30,11 +30,11 @@
>  #include <linux/of_platform.h>
>  #include <linux/sched/task.h>
>  #include <linux/swiotlb.h>
> +#include <linux/smp.h>
>  
>  #include <asm/setup.h>
>  #include <asm/sections.h>
>  #include <asm/pgtable.h>
> -#include <asm/smp.h>
>  #include <asm/sbi.h>
>  #include <asm/tlbflush.h>
>  #include <asm/thread_info.h>
> @@ -82,6 +82,7 @@ EXPORT_SYMBOL(empty_zero_page);
>  /* The lucky hart to first increment this variable will boot the other cores */
>  atomic_t hart_lottery;
>  unsigned long boot_cpu_hartid;
> +static DEFINE_PER_CPU(struct cpu, cpu_devices);
>  
>  unsigned long __cpuid_to_hardid_map[NR_CPUS] = {
>  	[0 ... NR_CPUS-1] = INVALID_HARTID
> @@ -257,3 +258,17 @@ void __init setup_arch(char **cmdline_p)
>  	riscv_fill_hwcap();
>  }
>  
> +static int __init topology_init(void)
> +{
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		struct cpu *cpu = &per_cpu(cpu_devices, i);
> +
> +		cpu->hotpluggable = can_hotplug_cpu();
> +		register_cpu(cpu, i);
> +	}
> +
> +	return 0;
> +}
> +subsys_initcall(topology_init);
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 89d95866..629456bb 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -32,12 +32,6 @@ static struct {
>  	unsigned long bits ____cacheline_aligned;
>  } ipi_data[NR_CPUS] __cacheline_aligned;
>  
> -enum ipi_message_type {
> -	IPI_RESCHEDULE,
> -	IPI_CALL_FUNC,
> -	IPI_MAX
> -};
> -
>  int riscv_hartid_to_cpuid(int hartid)
>  {
>  	int i = -1;
> @@ -94,7 +88,7 @@ void riscv_software_interrupt(void)
>  	}
>  }
>  
> -static void
> +void
>  send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
>  {
>  	int cpuid, hartid;
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index f44ae780..a9138431 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -92,9 +92,12 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  		  task_stack_page(tidle) + THREAD_SIZE);
>  	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
>  
> +	arch_send_call_wakeup_ipi(cpu);
>  	while (!cpu_online(cpu))
>  		cpu_relax();
>  
> +	pr_notice("CPU%u: online\n", cpu);
> +
>  	return 0;
>  }
>  
> @@ -105,7 +108,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  /*
>   * C entry point for a secondary processor.
>   */
> -asmlinkage void __init smp_callin(void)
> +asmlinkage void smp_callin(void)
>  {
>  	struct mm_struct *mm = &init_mm;
>  
> @@ -115,7 +118,7 @@ asmlinkage void __init smp_callin(void)
>  
>  	trap_init();
>  	notify_cpu_starting(smp_processor_id());
> -	set_cpu_online(smp_processor_id(), 1);
> +	set_cpu_online(smp_processor_id(), true);
>  	/*
>  	 * Remote TLB flushes are ignored while the CPU is offline, so emit
>  	 * a local TLB flush right now just in case.
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 24a9333d..8b331619 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -153,7 +153,7 @@ int is_valid_bugaddr(unsigned long pc)
>  }
>  #endif /* CONFIG_GENERIC_BUG */
>  
> -void __init trap_init(void)
> +void trap_init(void)
>  {
>  	/*
>  	 * Set sup0 scratch register to 0, indicating to exception vector
> @@ -162,6 +162,6 @@ void __init trap_init(void)
>  	csr_write(sscratch, 0);
>  	/* Set the exception vector address */
>  	csr_write(stvec, &handle_exception);
> -	/* Enable all interrupts */
> -	csr_write(sie, -1);
> +	/* Enable all interrupts but timer interrupt*/
> +	csr_set(sie, SIE_SSIE | SIE_SEIE);
>  }
> -- 
> 2.7.4
> 
