Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033576AbeEXQUF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:20:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47322 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030948AbeEXQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:20:04 -0400
Subject: Re: [PATCH v3 3/6] arm64: irqflags: Use ICC sysregs to implement IRQ
 masking
To: Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, joelaf@google.com,
        joel.opensrc@gmail.com, daniel.thompson@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
 <1526902515-13769-4-git-send-email-julien.thierry@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <6c568926-b70f-ad96-7200-1d427ce148f3@arm.com>
Date: Thu, 24 May 2018 17:19:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526902515-13769-4-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 21/05/18 12:35, Julien Thierry wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Currently irqflags is implemented using the PSR's I bit. It is possible
> to implement irqflags by using the co-processor interface to the GIC.
> Using the co-processor interface makes it feasible to simulate NMIs
> using GIC interrupt prioritization.
> 
> This patch changes the irqflags macros to modify, save and restore
> ICC_PMR_EL1. This has a substantial knock on effect for the rest of
> the kernel. There are four reasons for this:
> 
> 1. The state of the PMR becomes part of the interrupt context and must be
>    saved and restored during exceptions. It is saved on the stack as part
>    of the saved context when an interrupt/exception is taken.
> 
> 2. The hardware automatically masks the I bit (at boot, during traps, etc).
>    When the I bit is set by hardware we must add code to switch from I
>    bit masking and PMR masking:
>        - For IRQs, this is done after the interrupt has been acknowledged
>        	 avoiding the need to unmask.
>        - For other exceptions, this is done right after saving the context.
> 
> 3. Some instructions, such as wfi, require that the PMR not be used
>    for interrupt masking. Before calling these instructions we must
>    switch from PMR masking to I bit masking.
>    This is also the case when KVM runs a guest, if the CPU receives
>    an interrupt from the host, interrupts must not be masked in PMR
>    otherwise the GIC will not signal it to the CPU.
> 
> 4. We use the alternatives system to allow a single kernel to boot and
>    be switched to the alternative masking approach at runtime.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> [julien.thierry@arm.com: changes reflected in commit,
> 			 message, fixes, renaming]
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/Kconfig                     |  15 ++++
>  arch/arm64/include/asm/arch_gicv3.h    |  20 ++++++
>  arch/arm64/include/asm/assembler.h     |  25 ++++++-
>  arch/arm64/include/asm/daifflags.h     |  36 +++++++---
>  arch/arm64/include/asm/efi.h           |   5 ++
>  arch/arm64/include/asm/irqflags.h      | 125 +++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/kvm_host.h      |  14 ++++
>  arch/arm64/include/asm/processor.h     |   4 ++
>  arch/arm64/include/asm/ptrace.h        |  14 +++-
>  arch/arm64/kernel/asm-offsets.c        |   1 +
>  arch/arm64/kernel/entry.S              |  28 ++++++--
>  arch/arm64/kernel/head.S               |  37 ++++++++++
>  arch/arm64/kernel/process.c            |   6 ++
>  arch/arm64/kernel/smp.c                |   8 +++
>  arch/arm64/kvm/hyp/switch.c            |  25 +++++++
>  arch/arm64/mm/fault.c                  |   5 +-
>  arch/arm64/mm/proc.S                   |  23 ++++++
>  drivers/irqchip/irq-gic-v3-its.c       |   2 +-
>  drivers/irqchip/irq-gic-v3.c           |  82 +++++++++++----------
>  include/linux/irqchip/arm-gic-common.h |   6 ++
>  include/linux/irqchip/arm-gic.h        |   5 --
>  21 files changed, 423 insertions(+), 63 deletions(-)
I've commented about this particular patch offline, but let me state it
on the list:

As it is, this patch is almost impossible to review. It turns the
interrupt masking upside down, messes with the GIC, hacks KVM... Too
many things change at once, and I find it very hard to build a mental
picture of the changes just by staring at it.

Can you please try to split it into related chunks, moving the enabling
of the feature right at the end, so that the reviewers can have a chance
to understand it? It should make it much easier to review.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
