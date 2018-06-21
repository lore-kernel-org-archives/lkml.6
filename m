Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A577BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463EF208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463EF208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754277AbeFUHUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:20:11 -0400
Received: from exmail.andestech.com ([59.124.169.137]:11558 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754204AbeFUHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:20:10 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5L7Irrw083498;
        Thu, 21 Jun 2018 15:18:53 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 21 Jun 2018
 15:19:15 +0800
Date:   Thu, 21 Jun 2018 15:19:16 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Greentime Hu <greentime@andestech.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        <linux-kernel@vger.kernel.org>, Zong Li <zong@andestech.com>,
        Albert Ou <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] riscv: Add support to no-FPU systems
Message-ID: <20180621071915.GA5053@andestech.com>
References: <1529544276-28103-1-git-send-email-alankao@andestech.com>
 <20180621063938.GB19319@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180621063938.GB19319@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5L7Irrw083498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:39:38PM -0700, Christoph Hellwig wrote:
> > +ifeq ($(CONFIG_FPU),y)
> >  KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
> > +else
> > +KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)$(KBUILD_ARCH_C)
> > +endif
> 
> Can we refactor that KBUILD_ARCH code into something like
> 
> riscv-march-y				:=
> riscv-march-$(CONFIG_ARCH_RV32I)	+= rv32im
> riscv-march-$(CONFIG_ARCH_RV64I)	+= rv64im
> riscv-march-$(CONFIG_RISCV_ISA_A)	+= a
> riscv-march-$(CONFIG_FPU)		+= fd
> riscv-march-$(CONFIG_RISCV_ISA_C)	+= c
> 
> KBUILD_CFLAGS += -march=$(riscv-march-y)
> 

That's neat, sure.

> > +#ifdef CONFIG_FPU
> >  	regs->sstatus = SR_SPIE /* User mode, irqs on */ | SR_FS_INITIAL;
> > +#else
> > +	regs->sstatus = SR_SPIE | SR_FS_OFF;
> > +#endif
> 
> Having the comment in one branch, but not the other is odd.  I'd be
> tempted to just remove t entirely, but if not it should be move up
> or duplicated.
> 

I'll move that comment up.

> >  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
> >  {
> > +#ifdef CONFIG_FPU
> >  	fstate_save(src, task_pt_regs(src));
> > +#endif
> 
> Please provide a !CONFIG_FPU stub for fstate_save, please.
> 
> >  }

It's OK to do this to fstate_save/restore, and

> > +#endif
> >  
> >  static long restore_sigcontext(struct pt_regs *regs,
> >  	struct sigcontext __user *sc)
> > @@ -63,6 +65,7 @@ static long restore_sigcontext(struct pt_regs *regs,
> >  	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
> >  	if (unlikely(err))
> >  		return err;
> > +#ifdef CONFIG_FPU
> >  	/* Restore the floating-point state. */
> >  	err = restore_d_state(regs, &sc->sc_fpregs.d);
> >  	if (unlikely(err))
> > @@ -76,6 +79,7 @@ static long restore_sigcontext(struct pt_regs *regs,
> >  		if (value != 0)
> >  			return -EINVAL;
> >  	}
> > +#endif
> 
> Same here.
> 

it's also OK to do so to restore_d_state/save_d_state.  But what to do with the
following __get_user/__put_user calls?

Can I rename existing restore_d_state to __restore_d_state, and create a new
function restore_d_state which includes the original restore_d_state/__get_user
pair, and the same to save_d_state?

> > @@ -127,11 +131,13 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
> >  	size_t i;
> >  	/* sc_regs is structured the same as the start of pt_regs */
> >  	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
> > +#ifdef CONFIG_FPU
> >  	/* Save the floating-point state. */
> >  	err |= save_d_state(regs, &sc->sc_fpregs.d);
> >  	/* We support no other extension state at this time. */
> >  	for (i = 0; i < ARRAY_SIZE(sc->sc_fpregs.q.reserved); i++)
> >  		err |= __put_user(0, &sc->sc_fpregs.q.reserved[i]);
> > +#endif
> 
> Same here.
> 

Thanks,
Alan
