Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5AFC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D1E2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hax4y3mD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D1E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeJ3UjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:39:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44580 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeJ3UjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:39:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17-v6so11922737wre.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 04:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nyUdj/jgJG18G2aqow97y64npdsJ6/wLVuETOZYxL38=;
        b=hax4y3mD/3nJV8X09/7FXpojhRmLvPx6XWnWFlKcuHW0O2HUq88wIajwbYoG6oEHLe
         hQPuqRqGUhmpEyJiXxqdAfoGUX7AnaItY5V8kiCcUPid8pSnmTIv10Ho9AU3DNQ3jyVY
         Pyof751cFhsJLRSnFz+w3eHI/psp8hceRGzUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nyUdj/jgJG18G2aqow97y64npdsJ6/wLVuETOZYxL38=;
        b=HH2uM63G4n3fhc32Rb8tkeW3Xim5ptE2g7wq+bsBlsh2Gn2ewReBQ6fLG/6R8+7Usu
         5CkuWCs0t2hT3F4tJbNeVuQ9uPXmEfXN4guddV4qbybjACWQWgKnyDV9VBEqWzz5RvqE
         I8Mpa8dqF1awzkuU8tnyM+ruT2UOEmfGp+p7tV0a9+Jain1khTSr83eF/jDPFWnlwfjv
         ytcrhVNuL/L0NOsBWMw4640P9yYUorswVanjEqxot9JIKrRObxcW18lSsp4wUZzTze0s
         zRXeAyYrsrgPNUpkZUnslM/Qi40HT/O2BYiRnxKJj8gVXGZ9R3Ua38HoMPFvuvGGAJC5
         ze/w==
X-Gm-Message-State: AGRZ1gK3PGcNIBdyrYajFDOo0ApzNSZLxKrsa/RH2bQeR4oEZzftjIQ1
        bMS49/T+fGYHmbClhMLlpS8XQA==
X-Google-Smtp-Source: AJdET5dVclnxF9ZpjMJfO/PpSPTaiT1Lhq5191KBeQvopw9/Mx/Q8QvWD7UL/H1JF9+TcnXhS+l7sQ==
X-Received: by 2002:adf:84c1:: with SMTP id 59-v6mr19357388wrg.144.1540899967300;
        Tue, 30 Oct 2018 04:46:07 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b5-v6sm3334071wrf.15.2018.10.30.04.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 04:46:06 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:46:03 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, kstewart@linuxfoundation.org,
        linux-mips@linux-mips.org, dalias@libc.org,
        linux-sh@vger.kernel.org, benh@kernel.crashing.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
        paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
        linux-hexagon@vger.kernel.org, sfr@canb.auug.org.au,
        ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, catalin.marinas@arm.com,
        jhogan@kernel.org, linux-snps-arc@lists.infradead.org,
        ying.huang@intel.com, rppt@linux.vnet.ibm.com, bp@alien8.de,
        linux-arm-kernel@lists.infradead.org, christophe.leroy@c-s.fr,
        pombredanne@nexb.com, ralf@linux-mips.org, rkuo@codeaurora.org,
        paul.burton@mips.com, vgupta@synopsys.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        davem@davemloft.net
Subject: Re: [PATCH 7/7] kgdb: Remove irq flags and local_irq_enable/disable
 from roundup
Message-ID: <20181030114603.xdvyvayzw2an5c3q@holly.lan>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-8-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029180707.207546-8-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:07:07AM -0700, Douglas Anderson wrote:
> The function kgdb_roundup_cpus() was passed a parameter that was
> documented as:
> 
> > the flags that will be used when restoring the interrupts. There is
> > local_irq_save() call before kgdb_roundup_cpus().
> 
> Nobody used those flags.  Anyone who wanted to temporarily turn on
> interrupts just did local_irq_enable() and local_irq_disable() without
> looking at them.  So we can definitely remove the flags.

On the whole I'd rather that this change...


> Speaking of calling local_irq_enable(), it seems like a bad idea and
> it caused a nice splat on my system with lockdep turned on.
> Specifically it hit:
>   DEBUG_LOCKS_WARN_ON(current->hardirq_context)

... and fixes for this this were in separate patches. They don't appear
especially related.


Daniel.

 
> See the previous patch in this series ("smp: Don't yell about IRQs
> disabled in kgdb_roundup_cpus()") for more details, but the last few
> things on the stack were this on my arm64 board:
>   lockdep_hardirqs_on+0xf0/0x160
>   trace_hardirqs_on+0x188/0x1ac
>   kgdb_roundup_cpus+0x14/0x3c
> 
> As agrued in the the commit text of ("smp: Don't yell about IRQs
> disabled in kgdb_roundup_cpus()"), it seems better to make
> smp_call_function() lenient about kgdb than to locally turn on IRQs
> here.  Thus let's totally remove all the local_irq_enable() and
> local_irq_disable() calls from all of the kgdb_roundup_cpus() calls.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arc/kernel/kgdb.c     |  4 +---
>  arch/arm/kernel/kgdb.c     |  4 +---
>  arch/arm64/kernel/kgdb.c   |  4 +---
>  arch/hexagon/kernel/kgdb.c | 11 ++---------
>  arch/mips/kernel/kgdb.c    |  4 +---
>  arch/powerpc/kernel/kgdb.c |  2 +-
>  arch/sh/kernel/kgdb.c      |  4 +---
>  arch/sparc/kernel/smp_64.c |  2 +-
>  arch/x86/kernel/kgdb.c     |  9 ++-------
>  include/linux/kgdb.h       |  9 ++-------
>  kernel/debug/debug_core.c  |  2 +-
>  11 files changed, 14 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
> index 9a3c34af2ae8..d94d3cb7f9e8 100644
> --- a/arch/arc/kernel/kgdb.c
> +++ b/arch/arc/kernel/kgdb.c
> @@ -197,11 +197,9 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), NULL);
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
> -	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -	local_irq_disable();
>  }
>  
>  struct kgdb_arch arch_kgdb_ops = {
> diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
> index caa0dbe3dc61..a80e9259f7e9 100644
> --- a/arch/arm/kernel/kgdb.c
> +++ b/arch/arm/kernel/kgdb.c
> @@ -175,11 +175,9 @@ static void kgdb_call_nmi_hook(void *ignored)
>         kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
> -       local_irq_enable();
>         smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -       local_irq_disable();
>  }
>  
>  static int __kgdb_notify(struct die_args *args, unsigned long cmd)
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index a20de58061a8..5d171c26788f 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -289,11 +289,9 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
> -	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -	local_irq_disable();
>  }
>  
>  static int __kgdb_notify(struct die_args *args, unsigned long cmd)
> diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
> index 16c24b22d0b2..30fbc491cf45 100644
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
> @@ -139,11 +134,9 @@ static void hexagon_kgdb_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
> -	local_irq_enable();
>  	smp_call_function(hexagon_kgdb_nmi_hook, NULL, 0);
> -	local_irq_disable();
>  }
>  #endif
>  
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index eb6c0d582626..6671a279966f 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -219,11 +219,9 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	set_fs(old_fs);
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
> -	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -	local_irq_disable();
>  }
>  
>  static int compute_signal(int tt)
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
> index 4f04c6638a4d..86b3ea927e42 100644
> --- a/arch/sh/kernel/kgdb.c
> +++ b/arch/sh/kernel/kgdb.c
> @@ -319,11 +319,9 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
> -	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -	local_irq_disable();
>  }
>  
>  static int __kgdb_notify(struct die_args *args, unsigned long cmd)
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
> 2.19.1.568.g152ad8e336-goog
> 
