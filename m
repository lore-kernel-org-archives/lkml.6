Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910DEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3DB20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3DB20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391087AbeGLBxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:53:04 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36849 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbeGLBxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:53:04 -0400
Received: by mail-qt0-f196.google.com with SMTP id f1-v6so22854044qti.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 18:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eELiUjPJwkRvlbMu1jOUWrHjt6KFd0hhSpu394G0GBY=;
        b=Kzmi2WnS+4sz3lXst0bYqRjlFEa227CwDYVo/ZiVt9m8iZpyY/cUxOJRGxX6NJCDUv
         HzPuuio+kMFz45m1UrrITVSx3Y0amdqMPRKacT3d811YFQtp+iAJd8nAbVjKtyoUGgGS
         64G6ISIq2XbI18vIXeUH1yiRlUHTP5V1+ZH6otPYrsyKUpoTBTI/ttcifs5huCEd/JJB
         4AywedRRbWchY76DThgMAK10tWrloddTmZObOxxfZN6PnWh8HKJWP9ha/9aUJ9pR0qTl
         y3mQzy0Hw5qaE6m+7udcVBXUlriUhoH41pg3hgrWHYU5nwyFc+URqY3ZOmgSxBgsHLrS
         qsfQ==
X-Gm-Message-State: AOUpUlHuQZDv7QCsz9gMLl4AkLRJhHjlo+euUDP6yFSh0oUpcRuFhIYw
        CB1owwa4b+RRFpbPtZnWIwb/XQ==
X-Google-Smtp-Source: AAOMgpdDXKNgca2uF8sI/4SqsCQNMIjWe8+9dGxq8YAKhwpawYNKePW39K2Ho+dzLdySG/+pS+Ro8g==
X-Received: by 2002:a0c:9448:: with SMTP id i8-v6mr245076qvi.231.1531359957911;
        Wed, 11 Jul 2018 18:45:57 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::1941? ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id s9-v6sm16913579qkl.65.2018.07.11.18.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 18:45:56 -0700 (PDT)
Subject: Re: [PATCH] arm64: Add support for STACKLEAK gcc plugin
To:     Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20180712000337.GA4022@beast>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <08f1c1d4-52a8-6d42-fe56-241c255ba934@redhat.com>
Date:   Wed, 11 Jul 2018 18:45:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712000337.GA4022@beast>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 05:03 PM, Kees Cook wrote:
> From: Laura Abbott <labbott@redhat.com>
> 
> This adds support for the STACKLEAK gcc plugin to arm64 by implementing
> stackleak_check_alloca(), based heavily on the x86 version, and adding the
> two helpers used by the stackleak common code: current_top_of_stack() and
> on_thread_stack(). The stack erasure calls are made at syscall returns.
> Additionally, this disables the plugin in hypervisor and EFI stub code,
> which are out of scope for the protection.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> [kees: add cast to current_top_of_stack(), tweak commit log & comments]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is tweaked to be stand-alone from Alexander's series so it can land
> via the arm64 tree. (Alexander's v14 pulled one change out already, and
> I've lifted the last remaining: the newly needed include in stackleak.h)
> ---
>   arch/arm64/Kconfig                    |  1 +
>   arch/arm64/include/asm/processor.h    | 10 ++++++++++
>   arch/arm64/kernel/entry.S             |  7 +++++++
>   arch/arm64/kernel/process.c           | 16 ++++++++++++++++
>   arch/arm64/kvm/hyp/Makefile           |  3 ++-
>   drivers/firmware/efi/libstub/Makefile |  3 ++-
>   6 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090cf0292..216d36a49ab5 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -96,6 +96,7 @@ config ARM64
>   	select HAVE_ARCH_MMAP_RND_BITS
>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>   	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_STACKLEAK
>   	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>   	select HAVE_ARCH_TRACEHOOK
>   	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index a73ae1e49200..ca856bda2051 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -266,5 +266,15 @@ extern void __init minsigstksz_setup(void);
>   #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
>   #define SVE_GET_VL()	sve_get_current_vl()
>   
> +/*
> + * For the STACKLEAK gcc plugin.
> + *
> + * These need to be macros because otherwise we get stuck in a nightmare
> + * of header definitions for the use of task_stack_page.
> + */
> +#define current_top_of_stack()	((unsigned long)task_stack_page(current) + \
> +				 THREAD_SIZE)
> +#define on_thread_stack()	(on_task_stack(current, current_stack_pointer))
> +
>   #endif /* __ASSEMBLY__ */
>   #endif /* __ASM_PROCESSOR_H */
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 28ad8799406f..80bc93d971f7 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -431,6 +431,11 @@ tsk	.req	x28		// current thread_info
>   
>   	.text
>   
> +	.macro	stackleak_erase
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +	bl	stackleak_erase_kstack
> +#endif
> +	.endm
>   /*
>    * Exception vectors.
>    */
> @@ -910,6 +915,7 @@ ret_fast_syscall:
>   	and	x2, x1, #_TIF_WORK_MASK
>   	cbnz	x2, work_pending
>   	enable_step_tsk x1, x2
> +	stackleak_erase
>   	kernel_exit 0
>   ret_fast_syscall_trace:
>   	enable_daif
> @@ -936,6 +942,7 @@ ret_to_user:
>   	cbnz	x2, work_pending
>   finish_ret_to_user:
>   	enable_step_tsk x1, x2
> +	stackleak_erase
>   	kernel_exit 0
>   ENDPROC(ret_to_user)
>   
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index e10bc363f533..d99281b476b0 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -493,3 +493,19 @@ void arch_setup_new_exec(void)
>   {
>   	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
>   }
> +
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +#define MIN_STACK_LEFT	256
> +
> +void __used stackleak_check_alloca(unsigned long size)
> +{
> +	unsigned long sp, stack_left;
> +
> +	sp = current_stack_pointer;
> +
> +	stack_left = sp & (THREAD_SIZE - 1);
> +	BUG_ON(stack_left < MIN_STACK_LEFT ||
> +		size >= stack_left - MIN_STACK_LEFT);
> +}
> +EXPORT_SYMBOL(stackleak_check_alloca);
> +#endif

I think the conclusion was this needs to be re-written to account
for the different stack sizes in the same way as x86.

> diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> index 4313f7475333..2fabc2dc1966 100644
> --- a/arch/arm64/kvm/hyp/Makefile
> +++ b/arch/arm64/kvm/hyp/Makefile
> @@ -3,7 +3,8 @@
>   # Makefile for Kernel-based Virtual Machine module, HYP part
>   #
>   
> -ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING
> +ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
> +		$(DISABLE_STACKLEAK_PLUGIN)
>   
>   KVM=../../../../virt/kvm
>   
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index a34e9290a699..25dd2a14560d 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
>   KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>   				   -D__NO_FORTIFY \
>   				   $(call cc-option,-ffreestanding) \
> -				   $(call cc-option,-fno-stack-protector)
> +				   $(call cc-option,-fno-stack-protector) \
> +				   $(DISABLE_STACKLEAK_PLUGIN)
>   
>   GCOV_PROFILE			:= n
>   KASAN_SANITIZE			:= n
> 

