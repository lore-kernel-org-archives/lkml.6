Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186DBC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDDB27B80
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kafpx4L/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDDB27B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeF2HWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:22:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753026AbeF2HWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B1+2y5MAhmi8YZg61gEE9mhHc0HMPkUJWwOUw8EumkY=; b=kafpx4L/EAV1E1wgqbh8XO1US
        CzwC3m5aSPvHgRHZFIpZJ81rtN9MuSM7597FFc09WHMVqFfRQ726k9xn5WQfUB1gKK73x2BXQbjgF
        9ahs2aGXhqHTUS7A9slk21HvsLSCXH0KuemSDcvyo+cYAg0IW2U5Vk6SQeA0AOBJkXaV/WYfzlz1E
        0+ubskX0qprqVVkeIONgjHBJn01PcslriXaVU8mADuNwPf+0rbrOJQxAARaFkL6hx19Bjw1mZl6/x
        /aBv6q2ACSCKd+q78JO5C18Yb+isiu9H4NUAL3xXz3paWMa+zgTP75JmwiSTz2bosQBNHMDDLoqL+
        ej5hBNF9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYnjh-0000wr-VQ; Fri, 29 Jun 2018 07:22:29 +0000
Date:   Fri, 29 Jun 2018 00:22:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Darius Rad <darius@bluespec.com>, Zong Li <zong@andestech.com>,
        Greentime <greentime@andestech.com>
Subject: Re: [PATCH v2] riscv: Add support to no-FPU systems
Message-ID: <20180629072229.GE12956@infradead.org>
References: <1530073346-5341-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530073346-5341-1-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 6d4a5f6c3f4f..ad3033739430 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -26,7 +26,6 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
>  
>  	KBUILD_CFLAGS += -mabi=lp64
>  	KBUILD_AFLAGS += -mabi=lp64
> -	KBUILD_MARCH = rv64im
>  	LDFLAGS += -melf64lriscv
>  else
>  	BITS := 32
> @@ -34,22 +33,20 @@ else
>  
>  	KBUILD_CFLAGS += -mabi=ilp32
>  	KBUILD_AFLAGS += -mabi=ilp32
> -	KBUILD_MARCH = rv32im
>  	LDFLAGS += -melf32lriscv
>  endif
>  
>  KBUILD_CFLAGS += -Wall
>  
> -ifeq ($(CONFIG_RISCV_ISA_A),y)
> -	KBUILD_ARCH_A = a
> -endif
> -ifeq ($(CONFIG_RISCV_ISA_C),y)
> -	KBUILD_ARCH_C = c
> -endif
> -
> -KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
> +# ISA string setting
> +riscv-march-$(CONFIG_ARCH_RV32I)      := rv32im
> +riscv-march-$(CONFIG_ARCH_RV64I)      := rv64im
> +riscv-march-$(CONFIG_RISCV_ISA_A)     := $(riscv-march-y)a
> +riscv-march-$(CONFIG_FPU)             := $(riscv-march-y)fd
> +riscv-march-$(CONFIG_RISCV_ISA_C)     := $(riscv-march-y)c
> +KBUILD_CFLAGS += -march=$(riscv-march-y)
> +KBUILD_AFLAGS += -march=$(riscv-march-y)
>  
> -KBUILD_CFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)$(KBUILD_ARCH_C)

I think the cleanup part here should be split into a separate patch
with a changelog for it.  Just do iscv-march-y += fd for now, and then
change it in the actual nofpu patch.

> +#ifdef CONFIG_FPU
>  ENTRY(__fstate_save)
>  	li  a2,  TASK_THREAD_F0
>  	add a0, a0, a2
> @@ -442,7 +443,7 @@ ENTRY(__fstate_restore)
>  	csrc sstatus, t1
>  	ret
>  ENDPROC(__fstate_restore)
> -
> +#endif

I'm tempted to move the fpu save/restore routines into a new
conditionally compiled fpu.S file.  Palmer, what do you think?

> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index cb209139ba53..99d20283bb62 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -83,7 +83,12 @@ void show_regs(struct pt_regs *regs)
>  void start_thread(struct pt_regs *regs, unsigned long pc,
>  	unsigned long sp)
>  {
> -	regs->sstatus = SR_SPIE /* User mode, irqs on */ | SR_FS_INITIAL;
> +	/* User mode, irqs on */
> +#ifdef CONFIG_FPU
> +	regs->sstatus = SR_SPIE | SR_FS_INITIAL;
> +#else
> +	regs->sstatus = SR_SPIE | SR_FS_OFF;
> +#endif

Just provide two different DEFAULT_SSTATUS values in switch_to.h based
on the CONFIG_FPU ifdef there.  And I'd be really tempted to remove
the comment..

> -static long restore_d_state(struct pt_regs *regs,
> -	struct __riscv_d_ext_state __user *state)
> +#ifdef CONFIG_FPU
> +static inline long __restore_d_state(struct pt_regs *regs,
> +				     struct __riscv_d_ext_state __user *state)

FYI, I find function delcarations much more readable if the continuing
line is indented using two tabs always, especially if we have such very
long paramewter declarations.  But your style is also fairly common,
so this is not a hard requirement.

Also the refactoring in signal.c should probably be a separate prep
patch as well, so that the nofpu patch just adds the ifdef and nofpu
stubs.

> +	/* Restore the floating-point state. */
> +	err = restore_d_state(regs, &sc->sc_fpregs);
> +
>  	return err;

This could be:

	return restore_d_state(regs, &sc->sc_fpregs);

But then again I think we could just remove restore_sigcontext
and setup_sigcontext and opencode them in their only callers.
