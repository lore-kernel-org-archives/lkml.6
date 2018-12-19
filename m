Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4199C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F7A214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4pS/xnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeLSQyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:54:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36714 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbeLSQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:54:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so6903621wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gEdOH1hhHcMuc7jN1tcptsI4Vlco2fe6qaHfh9a5KyE=;
        b=F4pS/xnZZb3dYE7ZTc1BjiVvrUsKOMxGAIeO/Kl3xgEiqMon7qD2ejhDCZ/MxwwPIk
         1OhiNKDifeNfmgxkr5C6qmgbVwWkeZD58rykWA0aFcnf9uB0fut97Vo8bG1ZF6NWrujA
         GGEhamddInb28tEymBTAfHoZQ6FIt3PocAO0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gEdOH1hhHcMuc7jN1tcptsI4Vlco2fe6qaHfh9a5KyE=;
        b=G9JW9gM2CG8vazh54K/VD7XoBQEziAHhu6lSslBlNZ67T64GWGX7+mjon5+VMNNWwV
         ET/RSrcL3hUzkMBy5gfaVHcPCaGuumNcftiDDJYuJitnOzSfLHC3kI21yIVXi1lUVhw/
         bfbWkpFWUYMk7eLUwm+bduRmKRA1j3fzK1WCldrC8HNPaQJiPBa7ytzl/tnCyeRUFGpr
         O4AuM2m6sOzQUfzFEoo1dXW7GzbhO9glEqH1BooqqVoED3AIp4RJx2P36eFlWBUP+fJG
         kkfJBQo62oojp4jQq5Hq2ppyWal3uVcbMLdQLD/O0ZBn8N/8Q+OGe4k0Y1NWNULnjArl
         bvPw==
X-Gm-Message-State: AA+aEWbdxPtCi3v1wwFBzaLqtzqGE2kow0KwVM91UX/SyKmqRz2RTd65
        0n1gJgG053TtIGBI+kWQz6XBTg==
X-Google-Smtp-Source: AFSGD/VcFtKd2nB6YBi6AteXkNSCVF1jFbylYCFbm1wROaoO8eIItT5d7+xamjQVCiku1nINqJjrEA==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr7867792wmc.20.1545238485545;
        Wed, 19 Dec 2018 08:54:45 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b12sm4584110wrt.17.2018.12.19.08.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 08:54:44 -0800 (PST)
Date:   Wed, 19 Dec 2018 16:54:41 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>,
        linux-snps-arc@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Huang Ying <ying.huang@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [REPOST PATCH v6 1/4] kgdb: Remove irq flags from roundup
Message-ID: <20181219165441.oeed3pqiedj4q5ae@holly.lan>
References: <20181205033828.6156-1-dianders@chromium.org>
 <20181205033828.6156-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205033828.6156-2-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 07:38:25PM -0800, Douglas Anderson wrote:
> The function kgdb_roundup_cpus() was passed a parameter that was
> documented as:
> 
> > the flags that will be used when restoring the interrupts. There is
> > local_irq_save() call before kgdb_roundup_cpus().
> 
> Nobody used those flags.  Anyone who wanted to temporarily turn on
> interrupts just did local_irq_enable() and local_irq_disable() without
> looking at them.  So we can definitely remove the flags.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

I've not heard any objections from the arch/ maintainers so...

Applied! Thanks.


> ---
> 
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> - Removing irq flags separated from fixing lockdep splat.
> 
>  arch/arc/kernel/kgdb.c     | 2 +-
>  arch/arm/kernel/kgdb.c     | 2 +-
>  arch/arm64/kernel/kgdb.c   | 2 +-
>  arch/hexagon/kernel/kgdb.c | 9 ++-------
>  arch/mips/kernel/kgdb.c    | 2 +-
>  arch/powerpc/kernel/kgdb.c | 2 +-
>  arch/sh/kernel/kgdb.c      | 2 +-
>  arch/sparc/kernel/smp_64.c | 2 +-
>  arch/x86/kernel/kgdb.c     | 9 ++-------
>  include/linux/kgdb.h       | 9 ++-------
>  kernel/debug/debug_core.c  | 2 +-
>  11 files changed, 14 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
> index 9a3c34af2ae8..0932851028e0 100644
> --- a/arch/arc/kernel/kgdb.c
> +++ b/arch/arc/kernel/kgdb.c
> @@ -197,7 +197,7 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), NULL);
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
> index caa0dbe3dc61..f21077b077be 100644
> --- a/arch/arm/kernel/kgdb.c
> +++ b/arch/arm/kernel/kgdb.c
> @@ -175,7 +175,7 @@ static void kgdb_call_nmi_hook(void *ignored)
>         kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>         local_irq_enable();
>         smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index a20de58061a8..12c339ff6e75 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -289,7 +289,7 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
> index 16c24b22d0b2..012e0e230ac2 100644
> --- a/arch/hexagon/kernel/kgdb.c
> +++ b/arch/hexagon/kernel/kgdb.c
> @@ -119,17 +119,12 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
>  
>  /**
>   * kgdb_roundup_cpus - Get other CPUs into a holding pattern
> - * @flags: Current IRQ state
>   *
>   * On SMP systems, we need to get the attention of the other CPUs
>   * and get them be in a known state.  This should do what is needed
>   * to get the other CPUs to call kgdb_wait(). Note that on some arches,
>   * the NMI approach is not used for rounding up all the CPUs. For example,
> - * in case of MIPS, smp_call_function() is used to roundup CPUs. In
> - * this case, we have to make sure that interrupts are enabled before
> - * calling smp_call_function(). The argument to this function is
> - * the flags that will be used when restoring the interrupts. There is
> - * local_irq_save() call before kgdb_roundup_cpus().
> + * in case of MIPS, smp_call_function() is used to roundup CPUs.
>   *
>   * On non-SMP systems, this is not called.
>   */
> @@ -139,7 +134,7 @@ static void hexagon_kgdb_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	local_irq_enable();
>  	smp_call_function(hexagon_kgdb_nmi_hook, NULL, 0);
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index eb6c0d582626..2b05effc17b4 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -219,7 +219,7 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	set_fs(old_fs);
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 59c578f865aa..b0e804844be0 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -124,7 +124,7 @@ static int kgdb_call_nmi_hook(struct pt_regs *regs)
>  }
>  
>  #ifdef CONFIG_SMP
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	smp_send_debugger_break();
>  }
> diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
> index 4f04c6638a4d..cc57630f6bf2 100644
> --- a/arch/sh/kernel/kgdb.c
> +++ b/arch/sh/kernel/kgdb.c
> @@ -319,7 +319,7 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index 4792e08ad36b..f45d876983f1 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -1014,7 +1014,7 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
>  }
>  
>  #ifdef CONFIG_KGDB
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	smp_cross_call(&xcall_kgdb_capture, 0, 0, 0);
>  }
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index 8e36f249646e..ac6291a4178d 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -422,21 +422,16 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
>  #ifdef CONFIG_SMP
>  /**
>   *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
> - *	@flags: Current IRQ state
>   *
>   *	On SMP systems, we need to get the attention of the other CPUs
>   *	and get them be in a known state.  This should do what is needed
>   *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
>   *	the NMI approach is not used for rounding up all the CPUs. For example,
> - *	in case of MIPS, smp_call_function() is used to roundup CPUs. In
> - *	this case, we have to make sure that interrupts are enabled before
> - *	calling smp_call_function(). The argument to this function is
> - *	the flags that will be used when restoring the interrupts. There is
> - *	local_irq_save() call before kgdb_roundup_cpus().
> + *	in case of MIPS, smp_call_function() is used to roundup CPUs.
>   *
>   *	On non-SMP systems, this is not called.
>   */
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	apic->send_IPI_allbutself(APIC_DM_NMI);
>  }
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index e465bb15912d..05e5b2eb0d32 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -178,21 +178,16 @@ kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  
>  /**
>   *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
> - *	@flags: Current IRQ state
>   *
>   *	On SMP systems, we need to get the attention of the other CPUs
>   *	and get them into a known state.  This should do what is needed
>   *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
>   *	the NMI approach is not used for rounding up all the CPUs. For example,
> - *	in case of MIPS, smp_call_function() is used to roundup CPUs. In
> - *	this case, we have to make sure that interrupts are enabled before
> - *	calling smp_call_function(). The argument to this function is
> - *	the flags that will be used when restoring the interrupts. There is
> - *	local_irq_save() call before kgdb_roundup_cpus().
> + *	in case of MIPS, smp_call_function() is used to roundup CPUs.
>   *
>   *	On non-SMP systems, this is not called.
>   */
> -extern void kgdb_roundup_cpus(unsigned long flags);
> +extern void kgdb_roundup_cpus(void);
>  
>  /**
>   *	kgdb_arch_set_pc - Generic call back to the program counter
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 65c0f1363788..f3cadda45f07 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -593,7 +593,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  
>  	/* Signal the other CPUs to enter kgdb_wait() */
>  	else if ((!kgdb_single_step) && kgdb_do_roundup)
> -		kgdb_roundup_cpus(flags);
> +		kgdb_roundup_cpus();
>  #endif
>  
>  	/*
> -- 
> 2.20.0.rc1.387.gf8505762e3-goog
> 
