Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFB9C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE462077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE462077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJMD7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:59:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeJMD7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:59:36 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gB3zq-0007k7-KU; Fri, 12 Oct 2018 22:25:18 +0200
Date:   Fri, 12 Oct 2018 22:25:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 11/11] x86/fpu: defer FPU state load until return to
 userspace
Message-ID: <20181012202518.2gnmpgwxesvkna6i@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-12-bigeasy@linutronix.de>
 <CALCETrV01t-4gya0WEY0=R7XvuDA4dkf_pssfPZKDm9=1fCBmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrV01t-4gya0WEY0=R7XvuDA4dkf_pssfPZKDm9=1fCBmg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-04 09:14:33 [-0700], Andy Lutomirski wrote:
> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > index 3b2490b819181..3dad5c3b335eb 100644
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -196,6 +197,14 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
> >         if (unlikely(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
> >                 exit_to_usermode_loop(regs, cached_flags);
> >
> > +       /* Reload ti->flags; we may have rescheduled above. */
> > +       cached_flags = READ_ONCE(ti->flags);
> > +
> > +       if (unlikely(cached_flags & _TIF_LOAD_FPU))
> > +               switch_fpu_return();
> > +       else
> > +               fpregs_is_state_consistent();
> 
> Shouldn't this be:
> 
> fpregs_assert_state_consistent();  /* see below */
> 
> if (unlikely(cached_flags & _TIF_LOAD_FPU))
>   switch_fpu_return();

hmm. This should work. 

> > diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> > index a9caac9d4a729..e3077860f7333 100644
> > --- a/arch/x86/include/asm/fpu/api.h
> > +++ b/arch/x86/include/asm/fpu/api.h
> > @@ -27,6 +27,17 @@ extern void kernel_fpu_begin(void);
> >  extern void kernel_fpu_end(void);
> >  extern bool irq_fpu_usable(void);
> >
> > +#ifdef CONFIG_X86_DEBUG_FPU
> > +extern void fpregs_is_state_consistent(void);
> > +#else
> > +static inline void fpregs_is_state_consistent(void) { }
> > +#endif
> 
> Can you name this something like fpregs_assert_state_consistent()?
sure.

Sebastian
