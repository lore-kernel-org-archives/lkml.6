Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC8C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3F32084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3F32084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeGSLXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:23:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44016 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeGSLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:23:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so6793583ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 03:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DCti8WnI4gPkMPqSpdp6Lj/6GN5AKctoKFikpuWaGps=;
        b=MFQYxzYi6/Su97almr0NHx3hV/SgkTI7YpB2eivpykJ+ahqy1+OHH5UF6c3MtjO0uX
         A979ynsmbJ/t8Lgfoqycf60oZTIZuacRCISxfIH9WyOZyfwewRIQMNmnFzMQ8oLbNSzH
         ie+m2LyPNNyyN5MdZwR4yB5mtA9gFmu2Niaz41I8sSgMtTH5wo98zpx7eXlpdB5Q8dbG
         pSudkVg3ny9S01OSnMcV086JjFOoeSyD2KdRg2EoQUW4o/00EQacob/Y7TPreaHiK9Dx
         0+Ws5mKKz6jD8y6SG5KSHUOu5j7HIFlU74iUgVcFYRFPK+jOi5c7ZwJ1PsIrC/EqU/Ml
         u07g==
X-Gm-Message-State: AOUpUlFAVfcad3OZWS+WRWp8y+QR6h7a4bAU8xHGZtiYZaZbehjPgQqg
        PGYT0MWvvAw6jxPj9D49lv4egej2
X-Google-Smtp-Source: AAOMgpfXmkb4E24k3pzBGQGg+FH/frTEZauGxTs8t7ZTRzHeG0y4EL5nlyVryeCWQUsRzuyyxZiMOQ==
X-Received: by 2002:a2e:954e:: with SMTP id t14-v6mr7196248ljh.68.1531996877748;
        Thu, 19 Jul 2018 03:41:17 -0700 (PDT)
Received: from [192.168.42.175] ([213.87.144.170])
        by smtp.gmail.com with ESMTPSA id o62-v6sm903176lfe.71.2018.07.19.03.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 03:41:17 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH 2/2] arm64: Clear the stack
To:     Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20180718211013.14512-1-labbott@redhat.com>
 <20180718211013.14512-3-labbott@redhat.com>
From:   Alexander Popov <alex.popov@linux.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 jXz/74kjFsyRgZA+d6a1pGtOwITEBxtxxg==
Message-ID: <f590b536-5b8a-0cc4-c697-31675661b351@linux.com>
Date:   Thu, 19 Jul 2018 13:41:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180718211013.14512-3-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laura,

Thanks again for your work.
Please see some comments below.

On 19.07.2018 00:10, Laura Abbott wrote:
> Implementation of stackleak based heavily on the x86 version
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> Since last time: Minor style cleanups. Re-wrote check_alloca to
> correctly handle all stack types. While doing that, I also realized
> current_top_of_stack was incorrect so I fixed that as well.
> ---
>  arch/arm64/Kconfig                    |  1 +
>  arch/arm64/include/asm/processor.h    | 17 ++++++++++++++
>  arch/arm64/kernel/entry.S             |  7 ++++++
>  arch/arm64/kernel/process.c           | 32 +++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/Makefile           |  3 ++-
>  drivers/firmware/efi/libstub/Makefile |  3 ++-
>  include/linux/stackleak.h             |  1 +
>  7 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090cf0292..216d36a49ab5 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -96,6 +96,7 @@ config ARM64
>  	select HAVE_ARCH_MMAP_RND_BITS
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index a73ae1e49200..4f3062ee22c6 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -266,5 +266,22 @@ extern void __init minsigstksz_setup(void);
>  #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
>  #define SVE_GET_VL()	sve_get_current_vl()
>  
> +/*
> + * For CONFIG_STACKLEAK

Our config option is called CONFIG_GCC_PLUGIN_STACKLEAK.

> + *
> + * These need to be macros because otherwise we get stuck in a nightmare
> + * of header definitions for the use of task_stack_page.
> + */
> +
> +#define current_top_of_stack()		\
> +({					\
> +	unsigned long _low = 0;		\
> +	unsigned long _high = 0;	\
> +					\
> +	current_stack_type(current, current_stack_pointer, &_low, &_high); \
> +	_high;	\
> +})

Do you really need _low here? Ah, I see this in the previous patch:
+	if (stack_low && stack_high) {
+		*stack_low = low;
+		*stack_high = high;
+	}

How about checking them against NULL separately? That would allow
+	current_stack_type(current, current_stack_pointer, NULL, &_high);

Also a minor comment - how about aligning backslashes?

> +#define on_thread_stack()	(on_task_stack(current, current_stack_pointer, NULL, NULL))
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_PROCESSOR_H */
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 28ad8799406f..67d12016063d 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -431,6 +431,11 @@ tsk	.req	x28		// current thread_info
>  
>  	.text
>  
> +	.macro	stackleak_erase
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +	bl	stackleak_erase
> +#endif
> +	.endm
>  /*
>   * Exception vectors.
>   */
> @@ -910,6 +915,7 @@ ret_fast_syscall:
>  	and	x2, x1, #_TIF_WORK_MASK
>  	cbnz	x2, work_pending
>  	enable_step_tsk x1, x2
> +	stackleak_erase
>  	kernel_exit 0
>  ret_fast_syscall_trace:
>  	enable_daif
> @@ -936,6 +942,7 @@ ret_to_user:
>  	cbnz	x2, work_pending
>  finish_ret_to_user:
>  	enable_step_tsk x1, x2
> +	stackleak_erase
>  	kernel_exit 0
>  ENDPROC(ret_to_user)
>  
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index e10bc363f533..904defa36689 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -493,3 +493,35 @@ void arch_setup_new_exec(void)
>  {
>  	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
>  }
> +
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +void __used stackleak_check_alloca(unsigned long size)
> +{
> +	unsigned long stack_left;
> +	enum stack_type type;
> +	unsigned long current_sp = current_stack_pointer;
> +	unsigned long low, high;
> +
> +	type = current_stack_type(current, current_sp, &low, &high);
> +	BUG_ON(type == STACK_TYPE_UNKNOWN);
> +
> +	stack_left = current_sp - low;
> +
> +	if (size >= stack_left) {
> +		/*
> +		 * Kernel stack depth overflow is detected, let's report that.
> +		 * If CONFIG_VMAP_STACK is enabled, we can safely use BUG().
> +		 * If CONFIG_VMAP_STACK is disabled, BUG() handling can corrupt
> +		 * the neighbour memory. CONFIG_SCHED_STACK_END_CHECK calls
> +		 * panic() in a similar situation, so let's do the same if that
> +		 * option is on. Otherwise just use BUG() and hope for the best.
> +		 */
> +#if !defined(CONFIG_VMAP_STACK) && defined(CONFIG_SCHED_STACK_END_CHECK)
> +		panic("alloca() over the kernel stack boundary\n");
> +#else
> +		BUG();
> +#endif

This comment and #if logic should be dropped, we should always use panic() here
on arm64. Mark Rutland and I have worked out the solution for arm64 in this thread:
http://openwall.com/lists/kernel-hardening/2018/05/11/12

Rationale: on arm64 with CONFIG_VMAP_STACK, a stack overflow results in panic()
anyway.

> +	}
> +}
> +EXPORT_SYMBOL(stackleak_check_alloca);
> +#endif
> diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> index 4313f7475333..2fabc2dc1966 100644
> --- a/arch/arm64/kvm/hyp/Makefile
> +++ b/arch/arm64/kvm/hyp/Makefile
> @@ -3,7 +3,8 @@
>  # Makefile for Kernel-based Virtual Machine module, HYP part
>  #
>  
> -ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING
> +ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
> +		$(DISABLE_STACKLEAK_PLUGIN)
>  
>  KVM=../../../../virt/kvm
>  
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index a34e9290a699..25dd2a14560d 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
>  KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>  				   -D__NO_FORTIFY \
>  				   $(call cc-option,-ffreestanding) \
> -				   $(call cc-option,-fno-stack-protector)
> +				   $(call cc-option,-fno-stack-protector) \
> +				   $(DISABLE_STACKLEAK_PLUGIN)
>  
>  GCOV_PROFILE			:= n
>  KASAN_SANITIZE			:= n
> diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
> index b911b973d328..08420ec6b7c3 100644
> --- a/include/linux/stackleak.h
> +++ b/include/linux/stackleak.h
> @@ -5,6 +5,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
>  
> +#include <asm/stacktrace.h>
>  /*
>   * Check that the poison value points to the unused hole in the
>   * virtual memory map for your platform.
> 

