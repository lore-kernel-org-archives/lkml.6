Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeBCDCN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 22:02:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751646AbeBCDCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 22:02:09 -0500
Subject: Re: [PATCH v2 5/6] arm64: Detect current view of GIC priorities
To: Julien Thierry <julien.thierry@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <1516190084-18978-6-git-send-email-julien.thierry@arm.com>
CC: <mark.rutland@arm.com>, <daniel.thompson@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5A752625.7030903@huawei.com>
Date: Sat, 3 Feb 2018 11:01:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1516190084-18978-6-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Julien

On 2018/1/17 19:54, Julien Thierry wrote:
> The values non secure EL1 needs to use for priority registers depends on
> the value of SCR_EL3.FIQ.
>
> Since we don't have access to SCR_EL3, we fake an interrupt and compare the
> GIC priority with the one present in the [re]distributor.
>
> Also, add firmware requirements related to SCR_EL3.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   Documentation/arm64/booting.txt     |  5 +++
>   arch/arm64/include/asm/arch_gicv3.h |  5 +++
>   arch/arm64/include/asm/irqflags.h   |  6 +++
>   arch/arm64/include/asm/sysreg.h     |  1 +
>   drivers/irqchip/irq-gic-v3.c        | 86 +++++++++++++++++++++++++++++++++++++
>   5 files changed, 103 insertions(+)
>
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index 8d0df62..e387938 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -188,6 +188,11 @@ Before jumping into the kernel, the following conditions must be met:
>     the kernel image will be entered must be initialised by software at a
>     higher exception level to prevent execution in an UNKNOWN state.
>
> +  - SCR_EL3.FIQ must have the same value across all CPUs the kernel is
> +    executing on.
> +  - The value of SCR_EL3.FIQ must be the same as the one present at boot
> +    time whenever the kernel is executing.
> +
>     For systems with a GICv3 interrupt controller to be used in v3 mode:
>     - If EL3 is present:
>       ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
> index 490bb3a..ac7b7f6 100644
> --- a/arch/arm64/include/asm/arch_gicv3.h
> +++ b/arch/arm64/include/asm/arch_gicv3.h
> @@ -124,6 +124,11 @@ static inline void gic_write_bpr1(u32 val)
>   	write_sysreg_s(val, SYS_ICC_BPR1_EL1);
>   }
>
> +static inline u32 gic_read_rpr(void)
> +{
> +	return read_sysreg_s(SYS_ICC_RPR_EL1);
> +}
> +
>   #define gic_read_typer(c)		readq_relaxed(c)
>   #define gic_write_irouter(v, c)		writeq_relaxed(v, c)
>   #define gic_read_lpir(c)		readq_relaxed(c)
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 3d5d443..d25e7ee 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -217,6 +217,12 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
>   		!(ARCH_FLAGS_GET_PMR(flags) & ICC_PMR_EL1_EN_BIT);
>   }
>
> +/* Mask IRQs at CPU level instead of GIC level */
> +static inline void arch_irqs_daif_disable(void)
> +{
> +	asm volatile ("msr daifset, #2" : : : "memory");
> +}
> +
>   void maybe_switch_to_sysreg_gic_cpuif(void);
>
>   #endif /* CONFIG_IRQFLAGS_GIC_MASKING */
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 08cc885..46fa869 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -304,6 +304,7 @@
>   #define SYS_ICC_SRE_EL1			sys_reg(3, 0, 12, 12, 5)
>   #define SYS_ICC_IGRPEN0_EL1		sys_reg(3, 0, 12, 12, 6)
>   #define SYS_ICC_IGRPEN1_EL1		sys_reg(3, 0, 12, 12, 7)
> +#define SYS_ICC_RPR_EL1			sys_reg(3, 0, 12, 11, 3)
>
>   #define SYS_CONTEXTIDR_EL1		sys_reg(3, 0, 13, 0, 1)
>   #define SYS_TPIDR_EL1			sys_reg(3, 0, 13, 0, 4)
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index df51d96..58b5e89 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -63,6 +63,10 @@ struct gic_chip_data {
>   static struct gic_chip_data gic_data __read_mostly;
>   static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
>
> +#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
> +DEFINE_STATIC_KEY_FALSE(have_non_secure_prio_view);
> +#endif
> +
>   static struct gic_kvm_info gic_v3_kvm_info;
>   static DEFINE_PER_CPU(bool, has_rss);
>
> @@ -997,6 +1001,84 @@ static int partition_domain_translate(struct irq_domain *d,
>   	.select = gic_irq_domain_select,
>   };
>
> +#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
> +/*
> + * The behaviours of RPR and PMR registers differ depending on the value of
> + * SCR_EL3.FIQ, while the behaviour of priority registers of the distributor
> + * and redistributors is always the same.
> + *
> + * If SCR_EL3.FIQ == 1, the values used for RPR and PMR are the same as the ones
> + * programmed in the distributor and redistributors registers.
> + *
> + * Otherwise, the value presented by RPR as well as the value which will be
> + * compared against PMR is: (GIC_(R)DIST_PRI[irq] >> 1) | 0x80;
> + *
> + * see GICv3/GICv4 Architecture Specification (IHI0069D):
> + * - section 4.8.1 Non-secure accesses to register fields for Secure interrupt
> + *   priorities.
> + * - Figure 4-7 Secure read of the priority field for a Non-secure Group 1
> + *   interrupt.
> + */
I think we can use write/read PMR to check if SCR_EL3.FIQ == 1.
Like this:

gic_write_pmr(0xf0);
if (gic_read_pmr() == 0xf0)    // if SCR_EL3.FIQ == 0, the read value is 
0xf8 here
     static_branch_enable(&have_non_secure_prio_view);

Thanks,
Yang
> +static void __init gic_detect_prio_view(void)
> +{
> +	/*
> +	 * Randomly picked SGI, must be <= 8 as other SGIs might be
> +	 * used by the firmware.
> +	 */
> +	const u32 fake_irqnr = 7;
> +	const u32 fake_irqmask = BIT(fake_irqnr);
> +	void __iomem * const rdist_base = gic_data_rdist_sgi_base();
> +	unsigned long irq_flags;
> +	u32 acked_irqnr;
> +	bool was_enabled;
> +
> +	irq_flags = arch_local_save_flags();
> +
> +	arch_irqs_daif_disable();
> +
> +	was_enabled = (readl_relaxed(rdist_base + GICD_ISENABLER) &
> +		       fake_irqmask);
> +
> +	if (!was_enabled)
> +		writel_relaxed(fake_irqmask, rdist_base + GICD_ISENABLER);
> +
> +	/* Need to unmask to acknowledge the IRQ */
> +	gic_write_pmr(ICC_PMR_EL1_UNMASKED);
> +	dsb(sy);
> +
> +	/* Fake a pending SGI */
> +	writel_relaxed(fake_irqmask, rdist_base + GICD_ISPENDR);
> +	dsb(sy);
> +
> +	do {
> +		acked_irqnr = gic_read_iar();
> +
> +		if (acked_irqnr == fake_irqnr) {
> +			if (gic_read_rpr() == gic_get_irq_prio(acked_irqnr,
> +							       rdist_base))
> +				static_branch_enable(&have_non_secure_prio_view);
> +		} else {
> +			pr_warn("Unexpected IRQ for priority detection: %u\n",
> +				acked_irqnr);
> +		}
> +
> +		if (acked_irqnr < 1020) {
> +			gic_write_eoir(acked_irqnr);
> +			if (static_key_true(&supports_deactivate))
> +				gic_write_dir(acked_irqnr);
> +		}
> +	} while (acked_irqnr == ICC_IAR1_EL1_SPURIOUS);
> +
> +	/* Restore enabled state */
> +	if (!was_enabled) {
> +		writel_relaxed(fake_irqmask, rdist_base + GICD_ICENABLER);
> +		gic_redist_wait_for_rwp();
> +	}
> +
> +	arch_local_irq_restore(irq_flags);
> +}
> +#endif
> +
>   static int __init gic_init_bases(void __iomem *dist_base,
>   				 struct redist_region *rdist_regs,
>   				 u32 nr_redist_regions,
> @@ -1057,6 +1139,10 @@ static int __init gic_init_bases(void __iomem *dist_base,
>   	gic_cpu_init();
>   	gic_cpu_pm_init();
>
> +#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
> +	gic_detect_prio_view();
> +#endif
> +
>   	return 0;
>
>   out_free:
> --
> 1.9.1
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>
