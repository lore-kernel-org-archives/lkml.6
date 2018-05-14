Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeENLG4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:06:56 -0400
Received: from foss.arm.com ([217.140.101.70]:40114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbeENLGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:06:54 -0400
Date: Mon, 14 May 2018 12:06:50 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/18] arm64: move sve_user_{enable, disable} to
 <asm/fpsimd.h>
Message-ID: <20180514110649.GC7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-7-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-7-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:46:28AM +0100, Mark Rutland wrote:
> In subsequent patches, we'll want to make use of sve_user_enable() and
> sve_user_disable() outside of kernel/fpsimd.c. Let's move these to
> <asm/fpsimd.h> where we can make use of them.
> 
> To avoid ifdeffery in sequences like:
> 
> if (system_supports_sve() && some_condition
> 	sve_user_disable();
> 
> ... empty stubs are provided when support for SVE is not enabled.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/fpsimd.h | 17 ++++++++++++++++-
>  arch/arm64/kernel/fpsimd.c      | 11 -----------
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index aa7162ae93e3..7377d7593c06 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -16,11 +16,13 @@
>  #ifndef __ASM_FP_H
>  #define __ASM_FP_H
>  
> -#include <asm/ptrace.h>
>  #include <asm/errno.h>
> +#include <asm/ptrace.h>
> +#include <asm/sysreg.h>
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/build_bug.h>
>  #include <linux/cache.h>
>  #include <linux/init.h>
>  #include <linux/stddef.h>
> @@ -81,6 +83,16 @@ extern int sve_set_vector_length(struct task_struct *task,
>  extern int sve_set_current_vl(unsigned long arg);
>  extern int sve_get_current_vl(void);
>  
> +static inline void sve_user_disable(void)
> +{
> +	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
> +}
> +
> +static inline void sve_user_enable(void)
> +{
> +	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
> +}
> +
>  /*
>   * Probing and setup functions.
>   * Calls to these functions must be serialised with one another.
> @@ -107,6 +119,9 @@ static inline int sve_get_current_vl(void)
>  	return -EINVAL;
>  }
>  
> +static inline void sve_user_disable(void) { }
> +static inline void sve_user_enable(void) { }
> +

Alternatively, just move the full definitions outside the #ifdef
CONFIG_ARM64_SVE.

All calls to these should be shadowed by an if
(system_supports_sve()) in any case, and setting/clearing ZEN_EL0EN
in the CPACR_EL1 ought to be harmless now that the meaning of these
bits architecturally committed.

Ideally we would have a BUG_ON(!system_supports_sve()) in those
functions, but we won't won't to pay the cost in a production kernel.

>  static inline void sve_init_vq_map(void) { }
>  static inline void sve_update_vq_map(void) { }
>  static inline int sve_verify_vq_map(void) { return 0; }
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 088940387a4d..79a81c7d85c6 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -159,7 +159,6 @@ static void sve_free(struct task_struct *task)
>  	__sve_free(task);
>  }
>  
> -

Hmmm, Ack.  Check for conflicts with the KVM FPSIMD rework [1] (though
trivial).

[...]

Cheers
---Dave


[1]

[PATCH v7 10/16] arm64/sve: Switch sve_pffr() argument from task to thread
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/576601.html

[PATCH v7 11/16] arm64/sve: Move sve_pffr() to fpsimd.h and make inline
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/576606.html
