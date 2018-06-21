Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363B9C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E0F20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LemMK+Ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E0F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFUGjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:39:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbeFUGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6UH3oU4c80d9ugL0Q2ed05L3TLL9PTD7C9HTLQVyXzY=; b=LemMK+EkN5XASQFMjwTtXGqSn
        15jtZcgCeyBkWaBc2by5zMPjwJFN2wBr2zQZztOpmPN0n/0XL68kcWAZdDqHiHaGA4z97bBUqnCdy
        22qYIClcG7grO2aIbdHggKNXEJT8iZ74VXN/OnywJHcxsdQmVIQiD/Au6lgfilc4X2Ax4MJVopRdr
        Ew+YxluXJCCrG/AW4DbNz870l84nQn12sqqJXzpEiqJ3ly2TXlSMbukOcMDuWZLjFwUAtzzyXkE23
        ugbWqmQsshbqlI7BGLNsdEFmYEIZnYZ7lu3+ieyEQYfR2gVk5ENhMuCGaU+ADhZm7VUATAPzHl2fT
        nCnFd54ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVtFr-0002TQ-5U; Thu, 21 Jun 2018 06:39:39 +0000
Date:   Wed, 20 Jun 2018 23:39:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zong@andestech.com>,
        Greentime Hu <greentime@andestech.com>
Subject: Re: [PATCH] riscv: Add support to no-FPU systems
Message-ID: <20180621063938.GB19319@infradead.org>
References: <1529544276-28103-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529544276-28103-1-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +ifeq ($(CONFIG_FPU),y)
>  KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
> +else
> +KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)$(KBUILD_ARCH_C)
> +endif

Can we refactor that KBUILD_ARCH code into something like

riscv-march-y				:=
riscv-march-$(CONFIG_ARCH_RV32I)	+= rv32im
riscv-march-$(CONFIG_ARCH_RV64I)	+= rv64im
riscv-march-$(CONFIG_RISCV_ISA_A)	+= a
riscv-march-$(CONFIG_FPU)		+= fd
riscv-march-$(CONFIG_RISCV_ISA_C)	+= c

KBUILD_CFLAGS += -march=$(riscv-march-y)

> +#ifdef CONFIG_FPU
>  	regs->sstatus = SR_SPIE /* User mode, irqs on */ | SR_FS_INITIAL;
> +#else
> +	regs->sstatus = SR_SPIE | SR_FS_OFF;
> +#endif

Having the comment in one branch, but not the other is odd.  I'd be
tempted to just remove t entirely, but if not it should be move up
or duplicated.

>  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  {
> +#ifdef CONFIG_FPU
>  	fstate_save(src, task_pt_regs(src));
> +#endif

Please provide a !CONFIG_FPU stub for fstate_save, please.

>  }
> +#endif
>  
>  static long restore_sigcontext(struct pt_regs *regs,
>  	struct sigcontext __user *sc)
> @@ -63,6 +65,7 @@ static long restore_sigcontext(struct pt_regs *regs,
>  	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
>  	if (unlikely(err))
>  		return err;
> +#ifdef CONFIG_FPU
>  	/* Restore the floating-point state. */
>  	err = restore_d_state(regs, &sc->sc_fpregs.d);
>  	if (unlikely(err))
> @@ -76,6 +79,7 @@ static long restore_sigcontext(struct pt_regs *regs,
>  		if (value != 0)
>  			return -EINVAL;
>  	}
> +#endif

Same here.

> @@ -127,11 +131,13 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
>  	size_t i;
>  	/* sc_regs is structured the same as the start of pt_regs */
>  	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
> +#ifdef CONFIG_FPU
>  	/* Save the floating-point state. */
>  	err |= save_d_state(regs, &sc->sc_fpregs.d);
>  	/* We support no other extension state at this time. */
>  	for (i = 0; i < ARRAY_SIZE(sc->sc_fpregs.q.reserved); i++)
>  		err |= __put_user(0, &sc->sc_fpregs.q.reserved[i]);
> +#endif

Same here.
