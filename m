Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeCOPHH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:07:07 -0400
Received: from foss.arm.com ([217.140.101.70]:40652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752595AbeCOPHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:07:06 -0400
Date: Thu, 15 Mar 2018 15:07:02 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: York Sun <york.sun@nxp.com>
Cc: bp@alien8.de, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        marc.zyngier@arm.com
Subject: Re: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Message-ID: <20180315150702.5yqauxj3z6exdl65@lakrids.cambridge.arm.com>
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi York,

On Wed, Mar 14, 2018 at 05:17:46PM -0700, York Sun wrote:
> Add error detection for A53 and A57 cores. Hardware error injection
> is supported on A53. Software error injection is supported on both.
> For hardware error injection on A53 to work, proper access to
> L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This
> is done by making an SMC call in the driver. Failure to enable access
> disables hardware error injection. For error interrupt to work,
> another SMC call enables access to L2ECTLR_EL1. Failure to enable
> access disables interrupt for error reporting.

Further to James's comments, I'm very wary of the prospect of using
IMPLEMENTATION DEFINED functionality in the kernel, since by definition
this varies from CPU to CPU, and we have no architected guarantees to
rely upon.

I'm concerned that allowing the Non-secure world to access these
IMPLEMENTATION DEFINED registers poses a security risk (as it allows the
Non-secure world to change properties that the secure world may be
relying upon, among other things).

I'm also concerned by the SMC interface, which uses a SIP-specific ID
(i.e. it's NXP-specific). Thus, this driver can only possibly work on
particular CPUs as integrated by NXP.

The general expectation is that IMPLEMENTATION DEFINED functionality is
for the use of firmware, which can provide common abstract interfaces.

>From ARMv8.2 onwards, EDAC functionality is architected as part of the
RAS extensions, and in future, that's what I'd expect we'd support in
the kernel.

Given all that, I don't think that we should be poking this
functionality directly within Linux, and I think that firmware should be
in charge of managing EDAC errors on these systems.

I've left some general comments below, but the above stands regardless.

[...]

> +/*
> + *	Flush L1 dcache by way, using physical address to find sets
> + *
> + *	__flush_l1_dcache_way(ptr)
> + *	- ptr	- physical address to be flushed
> + */
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

Generally, Set/Way maintenance doesn't provide guarantees people expect
from it, so I would very strongly prefer to avoid it entirely within
Linux, as we currently do. I do not wish to see it return.

[...]

> +config EDAC_CORTEX_ARM64_L1_L2
> +	tristate "ARM Cortex A57/A53"
> +	depends on ARM64
> +	help
> +	  Support for error detection on ARM Cortex A57 and A53.
> +

... as integrated by NXP, with NXP firmware.

[...]

> +static inline void write_l2actlr(int *mem)
> +{
> +	u64 val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cortex_edac_lock, flags);
> +	__flush_dcache_area(mem, 8);
> +	__flush_l1_dcache_way(virt_to_phys(mem));

I don't follow why this Set/Way maintenance is necessary.

[...]

> +	arm_smccc_smc(SIP_ALLOW_L1L2_ERR_32, 0, 0, 0, 0, 0, 0, 0, &res);

> +	arm_smccc_smc(SIP_ALLOW_L2_CLR_32, 0, 0, 0, 0, 0, 0, 0, &res);

These are NXP-specific, and have nothing to do with Cortex-A53. These
will clash with other SIP-specific SMC calls.

The DT binding did not mention NXP at all.

[...]

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

In future, please don't parse the CPU nodes like this. We have
of_cpu_node_to_id() to go from a CPU node to its Linux logical ID.

[...]

> +#define SIP_ALLOW_L1L2_ERR_32		0x8200FF15
> +#define SIP_ALLOW_L2_CLR_32		0x8200FF16

In future, please encode _which_ SIP in the mnemonic name. i.e. use
NXP_SIP_* for NXP-specific SIP calls.

Thanks,
Mark.
