Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCONgm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:36:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38928 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeCONgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:36:32 -0400
Message-ID: <5AAA7640.3010506@arm.com>
Date: Thu, 15 Mar 2018 13:33:52 +0000
From: James Morse <james.morse@arm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
MIME-Version: 1.0
To: York Sun <york.sun@nxp.com>
CC: bp@alien8.de, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
In-Reply-To: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi York,

You have a DT binding in here, please CC the devicetree list. You're touching
code under arch/arm64, so you need the arm list too. get_maintainer.pl will take
your patch and give you the list of which lists and maintainers to CC.

(I've added those lists, the full patch is here:
https://patchwork.kernel.org/patch/10283783/
)

Some comments below, I haven't looked in to edac or the manuals for A53/A57.

On 15/03/18 00:17, York Sun wrote:
> Add error detection for A53 and A57 cores. Hardware error injection
> is supported on A53. Software error injection is supported on both.
> For hardware error injection on A53 to work, proper access to
> L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This
> is done by making an SMC call in the driver. Failure to enable access
> disables hardware error injection. For error interrupt to work,
> another SMC call enables access to L2ECTLR_EL1. Failure to enable
> access disables interrupt for error reporting.

This is tricky as there are shipped systems out there without these SMC calls.
They need to be discovered in some way. We can't even assume firmware has PSCI,
it has to be discovered via APCI/DT.

I think it will be cleaner for the presence of this device/compatible to
indicate that the registers are enabled for the normal-world, instead of having
the OS try to call into firmware to enable it.


> Signed-off-by: York Sun <york.sun@nxp.com>
> ---
>  .../devicetree/bindings/edac/cortex-arm64-edac.txt |  37 +
>  arch/arm64/include/asm/cacheflush.h                |   1 +
>  arch/arm64/mm/cache.S                              |  35 +
>  drivers/edac/Kconfig                               |   6 +
>  drivers/edac/Makefile                              |   1 +
>  drivers/edac/cortex_arm64_l1_l2.c                  | 741 +++++++++++++++++++++
>  drivers/edac/cortex_arm64_l1_l2.h                  |  55 ++
>  7 files changed, 876 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.h
> 
> diff --git a/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
> new file mode 100644
> index 0000000..74a1c2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
> @@ -0,0 +1,37 @@
> +ARM Cortex A57 and A53 L1/L2 cache error reporting
> +
> +CPU Memory Error Syndrome and L2 Memory Error Syndrome registers can be used
> +for checking L1 and L2 memory errors. However, only A53 supports double-bit
> +error injection to L1 and L2 memory. This driver uses the hardware error
> +injection when available, but also provides a way to inject errors by
> +software. Both A53 and A57 supports interrupt when multi-bit errors happen.

> +To use hardware error injection and the interrupt, proper access needs to be
> +granted in ACTLR_EL3 (and/or ACTLR_EL2) register by EL3 firmware SMC call.

How can Linux know whether firmware toggled these bits? How can it know if it
needs to make an SMC call to do the work?

This looks like platform policy, I'm not sure how this gets described...


> +Correctable errors do not trigger such interrupt. This driver uses dynamic
> +polling internal to check for errors. The more errors detected, the more
> +frequently it polls. Combining with interrupt, this driver can detect
> +correctable and uncorrectable errors. However, if the uncorrectable errors
> +cause system abort exception, this drivr is not able to report errors in time.
> +
> +The following section describes the Cortex A57/A53 EDAC DT node binding.
> +
> +Required properties:
> +- compatible: Should be "arm,cortex-a57-edac" or "arm,cortex-a53-edac"
> +- cpus: Should be a list of compatible cores
> +
> +Optional properties:
> +- interrupts: Interrupt number if supported
> +
> +Example:
> +	edac {
> +		compatible = "arm,cortex-a53-edac";
> +		cpus = <&cpu0>,
> +		       <&cpu1>,
> +		       <&cpu2>,
> +		       <&cpu3>;
> +		interrupts = <0 108 0x4>;
> +
> +	};
> +

> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 76d1cc8..f1cd090 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -73,6 +73,7 @@ extern void __clean_dcache_area_pop(void *addr, size_t len);
>  extern void __clean_dcache_area_pou(void *addr, size_t len);
>  extern long __flush_cache_user_range(unsigned long start, unsigned long end);
>  extern void sync_icache_aliases(void *kaddr, unsigned long len);
> +extern void __flush_l1_dcache_way(phys_addr_t ptr);
>  
>  static inline void flush_cache_mm(struct mm_struct *mm)
>  {

> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index 7f1dbe9..5e65c20 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -221,3 +221,38 @@ ENTRY(__dma_unmap_area)
>  	b.ne	__dma_inv_area
>  	ret
>  ENDPIPROC(__dma_unmap_area)
> +
> +/*
> + *	Flush L1 dcache by way, using physical address to find sets
> + *
> + *	__flush_l1_dcache_way(ptr)
> + *	- ptr	- physical address to be flushed
> + */

We don't have set/way maintenance in the kernel because its impossible to do
correctly outside EL3's CPU power-on code.

The ARM-ARM has a half page 'note' explaining the issues, under 'Performing
cache maintenance instructions' in section "D3.4.8 A64 Cache maintenance
instructions". If you have DDI0487B.b, its on Page D3-2020.

These may also help:
https://lkml.org/lkml/2016/3/21/190
https://events.static.linuxfound.org/sites/events/files/slides/slides_17.pdf
https://www.linux.com/news/taming-chaos-modern-caches

Why do you need to do this? There is no way to guarantee an address isn't in the
cache.


> +ENTRY(__flush_l1_dcache_way)
> +	msr	csselr_el1, xzr		/* select cache level 1 */
> +	isb
> +	mrs	x6, ccsidr_el1
> +	and	x2, x6, #7
> +	add	x2, x2, #4		/* x2 has log2(cache line size) */
> +	mov	x3, #0x3ff
> +	and	x3, x3, x6, lsr #3	/* x3 has number of ways - 1 */
> +	clz	w5, w3			/* bit position of ways */
> +	mov	x4, #0x7fff
> +	and	x4, x4, x6, lsr #13	/* x4 has number of sets - 1 */
> +	clz	x7, x4
> +	lsr	x0, x0, x2
> +	lsl	x0, x0, x7
> +	lsr	x0, x0, x7		/* x0 has the set for ptr */
> +
> +	mov	x6, x3
> +loop_way:
> +	lsl	x9, x3, x5
> +	lsl	x7, x0, x2
> +	orr	x9, x9, x7
> +	dc	cisw, x9
> +	subs	x6, x6, #1
> +	b.ge	loop_way
> +	dsb	ish
> +	ret
> +
> +ENDPIPROC(__flush_l1_dcache_way)


> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 0fd9ffa..6c21941 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_THUNDERX)		+= thunderx_edac.o
>  obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
>  obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
> +obj-$(CONFIG_EDAC_CORTEX_ARM64_L1_L2)	+= cortex_arm64_l1_l2.o
> diff --git a/drivers/edac/cortex_arm64_l1_l2.c b/drivers/edac/cortex_arm64_l1_l2.c
> new file mode 100644
> index 0000000..9bcc8e9
> --- /dev/null
> +++ b/drivers/edac/cortex_arm64_l1_l2.c
> @@ -0,0 +1,741 @@
> +/*
> + * Cortex A57 and A53 EDAC L1 and L2 cache error detection
> + *
> + * Copyright (c) 2018, NXP Semiconductor
> + * Author: York Sun <york.sun@nxp.com>
> + *
> + * Partially take from a similar driver by
> + * Brijesh Singh <brijeshkumar.singh@amd.com>
> + * Copyright (c) 2015, Advanced Micro Devices
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_device.h>
> +#include <linux/arm-smccc.h>
> +#include <asm/barrier.h>
> +#include <asm/cacheflush.h>
> +#include <asm/smp_plat.h>
> +
> +#include "edac_module.h"
> +#include "cortex_arm64_l1_l2.h"
> +
> +static int poll_msec = 1024;
> +static long l1_ce_sw_inject_count, l1_ue_sw_inject_count;
> +static long l2_ce_sw_inject_count, l2_ue_sw_inject_count;
> +static struct cpumask compat_mask;
> +static struct cpumask l1_ce_cpu_mask, l1_ue_cpu_mask;
> +static struct cpumask l2_ce_cpu_mask, l2_ue_cpu_mask;
> +static DEFINE_PER_CPU(unsigned long, actlr_en);
> +static DEFINE_PER_CPU(unsigned long, l2ectlr_en);
> +static DEFINE_PER_CPU(u64, cpumerr);
> +static DEFINE_PER_CPU(u64, cpuactlr);
> +static DEFINE_PER_CPU(u64, l2actlr);
> +static DEFINE_PER_CPU(u64, l2merr);
> +static DEFINE_PER_CPU(call_single_data_t, csd_check);
> +static DEFINE_SPINLOCK(cortex_edac_lock);
> +
> +static inline void read_cpuactlr(void *info)
> +{
> +	u64 val;
> +	int cpu = smp_processor_id();
> +
> +	asm volatile("mrs %0, S3_1_C15_C2_0" : "=r" (val));

I make ACTLR_EL1's encoding S3_0_1_0_1. What's this thing?

Please create a define in your driver for these registers and use the
read_sysreg_s() helpers. e.g:
| #define A53_SYS_SOMETHING_EL1		sys_reg(3, 1, 15, 2, 0)
| val = read_sysreg_s(A53_SYS_SOMETHING_EL1);



> +	per_cpu(cpuactlr, cpu) = val;

this_cpu_write() ?


> +}
> +
> +static inline void write_cpuactlr(int *mem)
> +{
> +	u64 val;
> +	int cpu;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cortex_edac_lock, flags);
> +	cpu = smp_processor_id();
> +
> +	__flush_dcache_area(mem, 8);

What is 8?


> +	asm volatile("mrs %0, S3_1_C15_C2_0" : "=r" (val));
> +	val |= L1_ERR_INJ_EN;
> +	asm volatile("dsb sy");
> +	asm volatile("msr S3_1_C15_C2_0, %0" :: "r" (val));
> +	asm volatile("isb sy");

Please use the macros, they're better than this asm-volatile:
| dsb(sy);
| isb();

...and, they will also give you the compiler barrier you want here...


> +	/* make cache dirty */
> +	*mem = 0xDEADBEEF;	/* write to L1 data causes error right away */

You're doing this in C code. The compiler is allowed to re-order this write. As
you don't read *mem, it can put it anywhere between
spin_lock_irqsave()/spin_unlock_irqrestore(). It can even do it in two halves,
or do it twice if it wants to.

WRITE_ONCE() tells the compiler not split this write up, and you need compiler
barriers as well as the CPU instruction barriers you have. The compiler doesn't
know what 'isb' means. (this is why we already have those macros)

But! You're doing all this to try and make '*mem =' the first write to the
cache? We can't do this in C: the compiler may write registers to the stack.
Even if it didn't, I don't think we can do this at all as we may take a
firmware-interrupt, or a real-interrupt to a hypervisor here.

What happens if a CPU (not necessarily this one) decides to read *mem?


> +	__flush_dcache_area(mem, 8);
> +	val &= ~L1_ERR_INJ_EN;
> +	asm volatile("dsb sy");
> +	asm volatile("msr S3_1_C15_C2_0, %0" :: "r" (val));
> +	asm volatile("isb sy");
> +	spin_unlock_irqrestore(&cortex_edac_lock, flags);
> +}
> +
> +static inline void read_l2actlr(void *info)
> +{
> +	u64 val;
> +	int cpu = smp_processor_id();
> +
> +	asm volatile("mrs %0, S3_1_C15_C0_0" : "=r" (val));

> +	per_cpu(l2actlr, cpu) = val;
> +}
> +
> +static inline void write_l2actlr(int *mem)
> +{
> +	u64 val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cortex_edac_lock, flags);
> +	__flush_dcache_area(mem, 8);
> +	__flush_l1_dcache_way(virt_to_phys(mem));
> +	asm volatile("mrs %0, S3_1_C15_C0_0" : "=r" (val));
> +	val |= L2D_ERR_INJ_EN;
> +	asm volatile("dsb sy");
> +	asm volatile("msr S3_1_C15_C0_0, %0" :: "r" (val));
> +	asm volatile("isb sy");
> +	/* make cache dirty */
> +	*mem = 0xDEADBEEF;	/* Error will be reported when L2 is accessed. */

As above I don't think we can do this. What happens if another CPU accesses L2?


> +	__flush_l1_dcache_way(virt_to_phys(mem));
> +	__flush_dcache_area(mem, 8);
> +	val &= ~L2D_ERR_INJ_EN;
> +	asm volatile("dsb sy");
> +	asm volatile("msr S3_1_C15_C0_0, %0" :: "r" (val));
> +	asm volatile("isb sy");
> +	spin_unlock_irqrestore(&cortex_edac_lock, flags);
> +}
> +
> +static inline void write_l2ectlr_el1(void *info)
> +{
> +	u64 val;
> +	int cpu = smp_processor_id();
> +
> +	asm volatile("mrs %0, S3_1_C11_C0_3" : "=r" (val));
> +	if (val & L2_ERR_INT) {
> +		pr_debug("l2ectlr_el1 on cpu %d reads 0x%llx\n", cpu, val);
> +		val &= ~L2_ERR_INT;
> +		asm volatile("msr S3_1_C11_C0_3, %0" :: "r" (val));
> +	}
> +}

Isn't this more like a reset L2_ERR_INT bit than 'write_l2ectlr_el1();?


> +
> +static inline void write_cpumerrsr_el1(u64 val)
> +{
> +	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (val));
> +}
> +
> +static void a53_allow_l1l2_err_inj(void *info)
> +{
> +	int cpu = smp_processor_id();
> +	struct arm_smccc_res res;
> +	unsigned long flags;
> +
> +	pr_debug("%s: cpu is %d\n", __func__, cpu);
> +	spin_lock_irqsave(&cortex_edac_lock, flags);

> +	arm_smccc_smc(SIP_ALLOW_L1L2_ERR_32, 0, 0, 0, 0, 0, 0, 0, &res);

Where is this call defined? (Its standardised somewhere right?)
How do we know firmware implements it?
How do we know 'SMC' is the SMCCC conduit to use? This will undef if its run in
a virtual machine...


> +	per_cpu(actlr_en, cpu) = res.a0;
> +	spin_unlock_irqrestore(&cortex_edac_lock, flags);
> +	pr_debug("%s: return is %ld\n", __func__, res.a0);
> +}
> +
> +static void a53_allow_l1l2_err_irq_clr(void *info)
> +{
> +	int cpu = smp_processor_id();
> +	struct arm_smccc_res res;
> +	unsigned long flags;
> +
> +	pr_debug("%s: cpu is %d\n", __func__, cpu);
> +	spin_lock_irqsave(&cortex_edac_lock, flags);
> +	arm_smccc_smc(SIP_ALLOW_L2_CLR_32, 0, 0, 0, 0, 0, 0, 0, &res);
> +	per_cpu(l2ectlr_en, cpu) = res.a0;
> +	spin_unlock_irqrestore(&cortex_edac_lock, flags);
> +	pr_debug("%s: return is %ld\n", __func__, res.a0);
> +}
> +
> +static inline void read_cpumerrsr_el1(void *info)
> +{
> +	u64 val;
> +	int cpu = smp_processor_id();
> +
> +	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (val));
> +	per_cpu(cpumerr, cpu) = val;
> +	if (val & ~CPUMERRSR_RAMID_MASK) {	/* Skip RAMID */
> +		pr_debug("cpu %d reads cpumerrsr_el1 0x%llx\n", cpu, val);
> +		/* clear the register since we already stored it */
> +		write_cpumerrsr_el1(0);
> +	} else if (l1_ce_sw_inject_count > 0) {
> +		l1_ce_sw_inject_count--;
> +		pr_debug("inject correctable errors to cpu %d\n", cpu);
> +		per_cpu(cpumerr, cpu) = (1UL << 31);	/* valid bit */
> +	} else if (l1_ue_sw_inject_count > 0) {
> +		l1_ue_sw_inject_count--;
> +		pr_debug("inject Uncorrectable errors to cpu %d\n", cpu);
> +		per_cpu(cpumerr, cpu) = (1UL << 63) | (1UL << 31);
> +	}
> +}
> +
> +static inline void write_l2merrsr_el1(u64 val)
> +{
> +	asm volatile("msr s3_1_c15_c2_3, %0" :: "r" (val));
> +}
> +
> +static inline void read_l2merrsr_el1(void *info)
> +{
> +	u64 val;
> +	int cpu = smp_processor_id();
> +
> +	asm volatile("mrs %0, s3_1_c15_c2_3" : "=r" (val));
> +	per_cpu(l2merr, cpu) = val;
> +	if (val & ~L2MERRSR_RAMID_MASK) {	/* Skip RAMID */
> +		pr_debug("cpu %d reads l2merrsr_el1 0x%llx\n", cpu, val);
> +		/* clear the register since we already stored it */
> +		write_l2merrsr_el1(0);
> +	} else if (l2_ce_sw_inject_count > 0) {
> +		l2_ce_sw_inject_count--;
> +		pr_debug("inject correctable errors to L2 on cpu %d\n", cpu);

> +		per_cpu(l2merr, cpu) = (1UL << 31);	/* valid bit */

Please create named macros for these bits:
| #define A53_L2MERR_VALID	BIT(31)

> +	} else if (l2_ue_sw_inject_count > 0) {
> +		l2_ue_sw_inject_count--;
> +		pr_debug("inject Uncorrectable errors to L2 on cpu %d\n", cpu);

> +		per_cpu(l2merr, cpu) = (1UL << 63) | (1UL << 31);

> +	}
> +}
> +static void read_errors(void *info)
> +{
> +	read_cpumerrsr_el1(info);
> +	read_l2merrsr_el1(info);
> +	write_l2ectlr_el1(info);
> +}
> +
> +
> +/* Returns 0 for no error
> + *	  -1 for uncorrectable error(s)
> + *	   1 for correctable error(s)

Is both a possibility?

> + */
> +static int parse_cpumerrsr(unsigned int cpu)
> +{
> +	u64 val = per_cpu(cpumerr, cpu);
> +
> +	/* check if we have valid error before continuing */
> +	if (!CPUMERRSR_EL1_VALID(val))
> +		return 0;
> +
> +	cortex_printk(KERN_INFO, "CPU %d ", cpu);
> +
> +	switch (CPUMERRSR_EL1_RAMID(val)) {
> +	case L1_I_TAG_RAM:
> +		pr_cont("L1-I Tag RAM");
> +		break;
> +	case L1_I_DATA_RAM:
> +		pr_cont("L1-I Data RAM");
> +		break;
> +	case L1_D_TAG_RAM:
> +		pr_cont("L1-D Tag RAM");
> +		break;
> +	case L1_D_DATA_RAM:
> +		pr_cont("L1-D Data RAM");
> +		break;
> +	case L1_D_DIRTY_RAM:
> +		pr_cont("L1 Dirty RAM");
> +		break;
> +	case TLB_RAM:
> +		pr_cont("TLB RAM");
> +		break;
> +	default:
> +		pr_cont("unknown");
> +		break;
> +	}
> +	pr_cont(" error(s) detected\n");
> +
> +	if (CPUMERRSR_EL1_FATAL(val)) {
> +		cortex_printk(KERN_INFO,
> +			      "CPU %d L1 fatal error(s) detected (0x%llx)\n",
> +			      cpu, val);
> +		return -1;
> +	}
> +
> +	return 1;
> +}
> +
> +static int parse_l2merrsr(unsigned int cpu)
> +{
> +	u64 val = per_cpu(l2merr, cpu);
> +
> +	/* check if we have valid error before continuing */
> +	if (!L2MERRSR_EL1_VALID(val))
> +		return 0;
> +
> +	cortex_printk(KERN_INFO, "CPU %d L2 %s error(s) detected (0x%llx)\n",
> +		      cpu, L2MERRSR_EL1_FATAL(val) ? "fatal" : "", val);
> +
> +	return L2MERRSR_EL1_FATAL(val) ? -1 : 1;
> +}
> +
> +#define MESSAGE_SIZE 40
> +static void cortex_arm64_edac_check(struct edac_device_ctl_info *edac_ctl)
> +{
> +	int cpu;
> +	char msg[MESSAGE_SIZE];
> +	call_single_data_t *csd;
> +
> +	get_online_cpus();
> +	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
> +		csd = &per_cpu(csd_check, cpu);
> +		csd->func = read_errors;
> +		csd->info = NULL;
> +		csd->flags = 0;
> +		/* Read CPU L1 error */
> +		smp_call_function_single_async(cpu, csd);

> +		/* Wait until flags cleared */
> +		smp_cond_load_acquire(&csd->flags, !VAL);

So this CPU waits in IRQ context for each CPU in compat_mask to do the work.
What happens if another driver does the same? Won't this deadlock?

I think the whole point of this smp_call_function_single_async() call is you
don't wait in IRQ context for it to finish.


The problem here is the IRQ isn't a per-cpu PPI, but the register for
acknowledging the interrupt is a per-cpu system register. Can we ask the irqchip
to disable the IRQ until we've done the per-cpu work to clear it?



> +	}
> +	put_online_cpus();
> +
> +	cpumask_clear(&l1_ce_cpu_mask);
> +	cpumask_clear(&l1_ue_cpu_mask);
> +	cpumask_clear(&l2_ce_cpu_mask);
> +	cpumask_clear(&l2_ue_cpu_mask);
> +	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
> +		switch (parse_cpumerrsr(cpu)) {
> +			case -1:
> +				/* fatal error */
> +				cpumask_set_cpu(cpu, &l1_ue_cpu_mask);
> +				break;
> +			case 1:
> +				/* correctable error(s) */
> +				cpumask_set_cpu(cpu, &l1_ce_cpu_mask);
> +				break;
> +			case 0:
> +				/* fall through */
> +			default:
> +				break;
> +		}
> +		switch (parse_l2merrsr(cpu)) {
> +			case -1:
> +				/* fatal error */
> +				cpumask_set_cpu(cpu, &l2_ue_cpu_mask);
> +				break;
> +			case 1:
> +				/* correctable error(s) */
> +				cpumask_set_cpu(cpu, &l2_ce_cpu_mask);
> +				break;
> +			case 0:
> +				/* fall through */
> +			default:
> +				break;
> +		}
> +	}
> +
> +	for_each_cpu(cpu, &l1_ue_cpu_mask) {
> +		snprintf(msg, MESSAGE_SIZE, "Fatal error(s) on CPU %d\n", cpu);
> +		edac_device_handle_ue(edac_ctl, 0, 0, msg);
> +	}
> +
> +	for_each_cpu(cpu, &l1_ce_cpu_mask) {
> +		snprintf(msg, MESSAGE_SIZE, "Correctable error(s) on CPU %d\n", cpu);
> +		edac_device_handle_ce(edac_ctl, 0, 0, msg);
> +	}
> +
> +	for_each_cpu(cpu, &l2_ue_cpu_mask) {
> +		snprintf(msg, MESSAGE_SIZE, "Fatal error(s) on CPU %d\n", cpu);
> +		edac_device_handle_ue(edac_ctl, 0, 1, msg);
> +	}
> +
> +	for_each_cpu(cpu, &l2_ce_cpu_mask) {
> +		snprintf(msg, MESSAGE_SIZE, "Correctable error(s) on CPU %d\n", cpu);
> +		edac_device_handle_ce(edac_ctl, 0, 1, msg);
> +	}
> +
> +	if (!cpumask_empty(&l1_ce_cpu_mask) ||
> +	    !cpumask_empty(&l2_ce_cpu_mask) ||
> +	    !cpumask_empty(&l1_ue_cpu_mask) ||
> +	    !cpumask_empty(&l2_ue_cpu_mask)) {
> +		if (poll_msec > MIN_POLL_MSEC) {
> +			poll_msec >>= 1;
> +			edac_device_reset_delay_period(edac_ctl, poll_msec);
> +		} else {
> +			cortex_printk(KERN_CRIT,
> +				      "Excessive correctable errors\n");
> +		}
> +	} else {
> +		if (poll_msec < MAX_POLL_MSEC) {
> +			poll_msec <<= 1;
> +			edac_device_reset_delay_period(edac_ctl, poll_msec);
> +		}
> +	}
> +}

[...]

> +static irqreturn_t cortex_edac_isr(int irq, void *dev_id)
> +{
> +	struct edac_device_ctl_info *edac_ctl = dev_id;
> +
> +	pr_debug("Got IRQ\n");
> +	cortex_arm64_edac_check(edac_ctl);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int cortex_arm64_edac_probe(struct platform_device *pdev)
> +{
> +	int i, rc, cpu, num_attr;
> +	struct edac_device_ctl_info *edac_ctl;
> +	struct device *dev = &pdev->dev;
> +	struct cortex_pdata *pdata;
> +	struct device_node *np, *dn = pdev->dev.of_node;
> +	struct of_phandle_iterator it;
> +	struct edac_dev_sysfs_attribute *attr;
> +	const __be32 *cell;
> +	u64 mpidr;
> +
> +	cpumask_clear(&compat_mask);
> +	of_for_each_phandle(&it, rc, dn, "cpus", NULL, 0) {
> +		np = it.node;
> +		cell = of_get_property(np, "reg", NULL);
> +		if (!cell) {
> +			pr_err("%pOF: missing reg property\n", np);
> +			continue;
> +		}
> +		mpidr = of_read_number(cell, of_n_addr_cells(np));
> +		cpu = get_logical_index(mpidr);
> +		if (cpu < 0) {
> +			pr_err("Bad CPU number for mpidr 0x%llx", mpidr);
> +			continue;
> +		}
> +		cpumask_set_cpu(cpu, &compat_mask);
> +	}
> +
> +	pr_debug("compat_mask is %*pbl\n", cpumask_pr_args(&compat_mask));
> +
> +	if (of_device_is_compatible(dn, "arm,cortex-a53-edac")) {
> +		num_attr = ARRAY_SIZE(device_sysfs_attr);
> +		get_online_cpus();
> +		for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
> +			smp_call_function_single(cpu, a53_allow_l1l2_err_inj, NULL, 1);
> +			if (per_cpu(actlr_en, cpu)) {
> +				pr_err("Failed to enable hardware error injection (%ld)\n",
> +				       per_cpu(actlr_en, cpu));
> +				num_attr -= 2;
> +				break;
> +			}
> +		}
> +		put_online_cpus();
> +	} else {
> +		num_attr = ARRAY_SIZE(device_sysfs_attr) - 2;
> +	}
> +
> +	/* POLL mode is used to detect correctable errors */
> +	edac_op_state = EDAC_OPSTATE_POLL;
> +
> +	edac_ctl = edac_device_alloc_ctl_info(sizeof(*pdata), "cpu_cache",
> +					      1, "L", 2, 1, NULL, 0,
> +					      edac_device_alloc_index());
> +	if (IS_ERR(edac_ctl))
> +		return -ENOMEM;
> +
> +	pdata = edac_ctl->pvt_info;
> +	attr = devm_kzalloc(dev,
> +			    sizeof(struct edac_dev_sysfs_attribute) * num_attr,
> +			    GFP_KERNEL);
> +	if (!attr) {
> +		rc = -ENOMEM;
> +		goto out_dev;
> +	}
> +
> +	for (i = 0; i < num_attr - 1; i++) {
> +		attr[i].attr.name = device_sysfs_attr[i].attr.name;
> +		attr[i].attr.mode = device_sysfs_attr[i].attr.mode;
> +		attr[i].show = device_sysfs_attr[i].show;
> +		attr[i].store = device_sysfs_attr[i].store;
> +	}
> +	edac_ctl->sysfs_attributes = attr;
> +
> +	rc = of_count_phandle_with_args(dn, "cpus", NULL);
> +	if (rc <= 0) {
> +		pr_err("Invalid number of phandles in 'cpus'\n");
> +		rc = -EINVAL;
> +		goto out_dev;
> +	}
> +	pdata->irq = platform_get_irq(pdev, 0);
> +	pr_debug("irq is %d\n", pdata->irq);
> +
> +	edac_ctl->poll_msec = poll_msec;
> +	edac_ctl->edac_check = cortex_arm64_edac_check;
> +	edac_ctl->dev = dev;
> +	edac_ctl->mod_name = dev_name(dev);
> +	edac_ctl->dev_name = dev_name(dev);
> +	edac_ctl->ctl_name = EDAC_MOD_STR;
> +	dev_set_drvdata(dev, edac_ctl);
> +
> +	rc = edac_device_add_device(edac_ctl);
> +	if (rc)
> +		goto out_dev;
> +
> +	pdata->mem = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
> +	if (!pdata->mem)
> +		goto out_mem;
> +
> +	if (pdata->irq) {
> +		get_online_cpus();
> +		for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
> +			smp_call_function_single(cpu,
> +						 a53_allow_l1l2_err_irq_clr,
> +						 NULL,
> +						 1);

How do you know this is only called on the A53s? You added all the CPUs to
compat_mask.

It may be worth having separate probe calls for A53 and A57.


Thanks,

James


> +			if (per_cpu(l2ectlr_en, cpu)) {
> +				pr_err("Failed to enable interrupt clearing (%ld)\n",
> +				       per_cpu(l2ectlr_en, cpu));
> +				rc = -EACCES;
> +				break;
> +			}
> +		}
> +		put_online_cpus();
> +
> +		if (!rc) {
> +			rc = devm_request_irq(dev, pdata->irq, cortex_edac_isr,
> +				      0, "cortex_edac error", edac_ctl);
> +			if (rc < 0) {
> +				pr_err("%s: Unable to request irq %d for cortex edac error\n",
> +				       __func__, pdata->irq);
> +				goto out_irq;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +
> +out_mem:
> +out_irq:
> +	edac_device_del_device(edac_ctl->dev);
> +
> +out_dev:
> +	edac_device_free_ctl_info(edac_ctl);
> +
> +	return rc;
> +}
> +
> +static int cortex_arm64_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_ctl = dev_get_drvdata(&pdev->dev);
> +
> +	edac_device_del_device(edac_ctl->dev);
> +	edac_device_free_ctl_info(edac_ctl);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id cortex_arm64_edac_of_match[] = {
> +	{ .compatible = "arm,cortex-a57-edac" },
> +	{ .compatible = "arm,cortex-a53-edac" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);
> +
> +static struct platform_driver cortex_arm64_edac_driver = {
> +	.probe = cortex_arm64_edac_probe,
> +	.remove = cortex_arm64_edac_remove,
> +	.driver = {
> +		.name = EDAC_MOD_STR,
> +		.of_match_table = cortex_arm64_edac_of_match,
> +	},
> +};
> +module_platform_driver(cortex_arm64_edac_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("York Sun <york.sun@nxp.com>");
> +MODULE_DESCRIPTION("Cortex A57 and A53 L1 and L2 cache EDAC driver");
