Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5euwIKKAGltRQwAAmS7hNA
	; Fri, 08 Jun 2018 13:12:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B7CCF608B8; Fri,  8 Jun 2018 13:12:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8C1BB606FA;
	Fri,  8 Jun 2018 13:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C1BB606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeFHNLj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:11:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33672 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752774AbeFHNLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:11:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D669D1529;
        Fri,  8 Jun 2018 06:11:37 -0700 (PDT)
Received: from [10.1.211.36] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89BCF3F59D;
        Fri,  8 Jun 2018 06:11:35 -0700 (PDT)
Subject: Re: [PATCHv4 06/10] arm64: add basic pointer authentication support
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com,
        christoffer.dall@arm.com, drjones@redhat.com, marc.zyngier@arm.com,
        ramana.radhakrishnan@arm.com, suzuki.poulose@arm.com,
        will.deacon@arm.com, awallis@codeaurora.org
References: <20180503132031.25705-1-mark.rutland@arm.com>
 <20180503132031.25705-7-mark.rutland@arm.com>
From: Kristina Martsenko <kristina.martsenko@arm.com>
Message-ID: <e4630a08-db4e-7c4d-5d92-393ad99a629e@arm.com>
Date: Fri, 8 Jun 2018 14:11:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180503132031.25705-7-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 03/05/18 14:20, Mark Rutland wrote:
> This patch adds basic support for pointer authentication, allowing
> userspace to make use of APIAKey. The kernel maintains an APIAKey value
> for each process (shared by all threads within), which is initialised to
> a random value at exec() time.
> 
> To describe that address authentication instructions are available, the
> ID_AA64ISAR0.{APA,API} fields are exposed to userspace. A new hwcap,
> APIA, is added to describe that the kernel manages APIAKey.
> 
> Instructions using other keys (APIBKey, APDAKey, APDBKey) are disabled,
> and will behave as NOPs. These may be made use of in future patches.
> 
> No support is added for the generic key (APGAKey), though this cannot be
> trapped or made to behave as a NOP. Its presence is not advertised with
> a hwcap.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/mmu.h          |  5 +++
>  arch/arm64/include/asm/mmu_context.h  | 11 ++++-
>  arch/arm64/include/asm/pointer_auth.h | 75 +++++++++++++++++++++++++++++++++++
>  arch/arm64/include/uapi/asm/hwcap.h   |  1 +
>  arch/arm64/kernel/cpufeature.c        |  9 +++++
>  arch/arm64/kernel/cpuinfo.c           |  1 +
>  6 files changed, 101 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/pointer_auth.h
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index dd320df0d026..f6480ea7b0d5 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -25,10 +25,15 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <asm/pointer_auth.h>
> +
>  typedef struct {
>  	atomic64_t	id;
>  	void		*vdso;
>  	unsigned long	flags;
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +	struct ptrauth_keys	ptrauth_keys;
> +#endif
>  } mm_context_t;
>  
>  /*
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 39ec0b8a689e..83eadbc6b946 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -168,7 +168,14 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
>  #define destroy_context(mm)		do { } while(0)
>  void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
>  
> -#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
> +static inline int init_new_context(struct task_struct *tsk,
> +				   struct mm_struct *mm)
> +{
> +	atomic64_set(&mm->context.id, 0);
> +	mm_ctx_ptrauth_init(&mm->context);
> +
> +	return 0;
> +}>
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>  static inline void update_saved_ttbr0(struct task_struct *tsk,
> @@ -216,6 +223,8 @@ static inline void __switch_mm(struct mm_struct *next)
>  		return;
>  	}
>  
> +	mm_ctx_ptrauth_switch(&next->context);
> +
>  	check_and_switch_context(next, cpu);
>  }

It seems you've removed arch_dup_mmap here (as Catalin suggested [1]),
but forgotten to move the key initialization from init_new_context to
arch_bprm_mm_init. In my tests I'm seeing child processes get different
keys than the parent after a fork().

Kristina

[1] https://lkml.org/lkml/2018/4/25/506
