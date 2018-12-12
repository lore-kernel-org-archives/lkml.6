Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1766C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B567C2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B567C2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeLLPWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:22:20 -0500
Received: from foss.arm.com ([217.140.101.70]:43252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbeLLPWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:22:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD9780D;
        Wed, 12 Dec 2018 07:22:19 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2D493F575;
        Wed, 12 Dec 2018 07:22:16 -0800 (PST)
Date:   Wed, 12 Dec 2018 15:22:14 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jacob Bramley <jacob.bramley@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Adam Wallis <awallis@codeaurora.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, Cyrill Gorcunov <gorcunov@gmail.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 10/13] arm64: add prctl control for resetting ptrauth
 keys
Message-ID: <20181212152214.GX3505@e103592.cambridge.arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-11-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207183931.4285-11-kristina.martsenko@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 06:39:28PM +0000, Kristina Martsenko wrote:
> Add an arm64-specific prctl to allow a thread to reinitialize its
> pointer authentication keys to random values. This can be useful when
> exec() is not used for starting new processes, to ensure that different
> processes still have different keys.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>  arch/arm64/include/asm/pointer_auth.h |  3 +++
>  arch/arm64/include/asm/processor.h    |  4 +++
>  arch/arm64/kernel/Makefile            |  1 +
>  arch/arm64/kernel/pointer_auth.c      | 47 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/prctl.h            |  8 ++++++
>  kernel/sys.c                          |  8 ++++++
>  6 files changed, 71 insertions(+)
>  create mode 100644 arch/arm64/kernel/pointer_auth.c
> 
> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> index 89190d93c850..7797bc346c6b 100644
> --- a/arch/arm64/include/asm/pointer_auth.h
> +++ b/arch/arm64/include/asm/pointer_auth.h
> @@ -59,6 +59,8 @@ static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
>  		__ptrauth_key_install(APGA, keys->apga);
>  }
>  
> +extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
> +
>  /*
>   * The EL0 pointer bits used by a pointer authentication code.
>   * This is dependent on TBI0 being enabled, or bits 63:56 would also apply.
> @@ -82,6 +84,7 @@ do {									\
>  	ptrauth_keys_switch(&(tsk)->thread_info.keys_user)
>  
>  #else /* CONFIG_ARM64_PTR_AUTH */
> +#define ptrauth_prctl_reset_keys(tsk, arg)	(-EINVAL)
>  #define ptrauth_strip_insn_pac(lr)	(lr)
>  #define ptrauth_thread_init_user(tsk)
>  #define ptrauth_thread_switch(tsk)
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 6b0d4dff5012..40ccfb7605b6 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -46,6 +46,7 @@
>  #include <asm/hw_breakpoint.h>
>  #include <asm/lse.h>
>  #include <asm/pgtable-hwdef.h>
> +#include <asm/pointer_auth.h>
>  #include <asm/ptrace.h>
>  #include <asm/types.h>
>  
> @@ -270,6 +271,9 @@ extern void __init minsigstksz_setup(void);
>  #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
>  #define SVE_GET_VL()	sve_get_current_vl()
>  
> +/* PR_PAC_RESET_KEYS prctl */
> +#define PAC_RESET_KEYS(tsk, arg)	ptrauth_prctl_reset_keys(tsk, arg)
> +
>  /*
>   * For CONFIG_GCC_PLUGIN_STACKLEAK
>   *
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 4c8b13bede80..096740ab81d2 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -57,6 +57,7 @@ arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
>  arm64-obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
>  arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
>  arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
> +arm64-obj-$(CONFIG_ARM64_PTR_AUTH)	+= pointer_auth.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/ probes/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
> new file mode 100644
> index 000000000000..b9f6f5f3409a
> --- /dev/null
> +++ b/arch/arm64/kernel/pointer_auth.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/errno.h>
> +#include <linux/prctl.h>
> +#include <linux/random.h>
> +#include <linux/sched.h>
> +#include <asm/cpufeature.h>
> +#include <asm/pointer_auth.h>
> +
> +int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
> +{
> +	struct ptrauth_keys *keys = &tsk->thread_info.keys_user;
> +	unsigned long addr_key_mask = PR_PAC_APIAKEY | PR_PAC_APIBKEY |
> +				      PR_PAC_APDAKEY | PR_PAC_APDBKEY;
> +	unsigned long key_mask = addr_key_mask | PR_PAC_APGAKEY;
> +
> +	if (!system_supports_address_auth() && !system_supports_generic_auth())
> +		return -EINVAL;
> +
> +	if (!arg) {
> +		ptrauth_keys_init(keys);
> +		ptrauth_keys_switch(keys);
> +		return 0;
> +	}
> +
> +	if (arg & ~key_mask)
> +		return -EINVAL;
> +
> +	if (((arg & addr_key_mask) && !system_supports_address_auth()) ||
> +	    ((arg & PR_PAC_APGAKEY) && !system_supports_generic_auth()))
> +		return -EINVAL;
> +
> +	if (arg & PR_PAC_APIAKEY)
> +		get_random_bytes(&keys->apia, sizeof(keys->apia));
> +	if (arg & PR_PAC_APIBKEY)
> +		get_random_bytes(&keys->apib, sizeof(keys->apib));
> +	if (arg & PR_PAC_APDAKEY)
> +		get_random_bytes(&keys->apda, sizeof(keys->apda));
> +	if (arg & PR_PAC_APDBKEY)
> +		get_random_bytes(&keys->apdb, sizeof(keys->apdb));
> +	if (arg & PR_PAC_APGAKEY)
> +		get_random_bytes(&keys->apga, sizeof(keys->apga));
> +
> +	ptrauth_keys_switch(keys);
> +
> +	return 0;
> +}
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index b17201edfa09..b4875a93363a 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -220,4 +220,12 @@ struct prctl_mm_map {
>  # define PR_SPEC_DISABLE		(1UL << 2)
>  # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
>  
> +/* Reset arm64 pointer authentication keys */
> +#define PR_PAC_RESET_KEYS		54
> +# define PR_PAC_APIAKEY			(1UL << 0)
> +# define PR_PAC_APIBKEY			(1UL << 1)
> +# define PR_PAC_APDAKEY			(1UL << 2)
> +# define PR_PAC_APDBKEY			(1UL << 3)
> +# define PR_PAC_APGAKEY			(1UL << 4)
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 123bd73046ec..64b5a230f38d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -121,6 +121,9 @@
>  #ifndef SVE_GET_VL
>  # define SVE_GET_VL()		(-EINVAL)
>  #endif
> +#ifndef PAC_RESET_KEYS
> +# define PAC_RESET_KEYS(a, b)	(-EINVAL)
> +#endif
>  
>  /*
>   * this is where the system-wide overflow UID and GID are defined, for
> @@ -2476,6 +2479,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
>  		break;
> +	case PR_PAC_RESET_KEYS:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = PAC_RESET_KEYS(me, arg2);
> +		break;

If this only ever operated on current, can we drop the task argument?

(Last time I looked, the task argument is useless for all existing
prctls -- I have some outstanding refactoring to get rid of it entirely.)

Since arg2 contains unused flag bits and we already return -EINVAL if
any of those are set, we can define a new flag in arg2 in the future if
we want to extend this interface.

So I think we can drop the checks on arg3..arg5 and avoid the need
for the caller to supply , 0, 0, 0) in every call to this prctl.

(But if someone else objects to this approach I'm happy to concede on
this point).

Cheers
---Dave
