Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB90CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8612821905
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBGKna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:43:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37690 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBGKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:43:30 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1grh9R-0006cb-Cy; Thu, 07 Feb 2019 11:43:25 +0100
Date:   Thu, 7 Feb 2019 11:43:25 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 09/22] x86/fpu: Add (__)make_fpregs_active helpers
Message-ID: <20190207104325.ai5fzaxa7xy7yydv@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-10-bigeasy@linutronix.de>
 <20190128182349.GG20487@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190128182349.GG20487@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-28 19:23:49 [+0100], Borislav Petkov wrote:
> > diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> > index b56d504af6545..31b66af8eb914 100644
> > --- a/arch/x86/include/asm/fpu/api.h
> > +++ b/arch/x86/include/asm/fpu/api.h
> > @@ -10,6 +10,7 @@
> >  
> >  #ifndef _ASM_X86_FPU_API_H
> >  #define _ASM_X86_FPU_API_H
> > +#include <linux/preempt.h>
> >  
> >  /*
> >   * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
> > @@ -22,6 +23,16 @@ extern void kernel_fpu_begin(void);
> >  extern void kernel_fpu_end(void);
> >  extern bool irq_fpu_usable(void);
> >  
> > +static inline void __fpregs_changes_begin(void)
> > +{
> > +	preempt_disable();
> > +}
> > +
> > +static inline void __fpregs_changes_end(void)
> 
> How am I to understand that "fpregs_changes" thing? That FPU registers
> changes will begin and end respectively?

correct.

> I probably would call them fpregs_lock and fpregs_unlock even if
> it isn't doing any locking to denote that FPU regs are locked and
> inaccessible inside the region.

They are accessible inside the region. But they should not be touched by
context switch code (and later BH).
Is that what you meant?

> And why the "__" prefix? Is there a counterpart without the "__" coming?

No. I picked up the patches, that function was named like that. I kept
it. That __ probably denotes that it is an internal function but then it
has to be used outside (KVM) if they plan to "reload" registers (which
happens if they switch between host/guest registers).

> > +{
> > +	preempt_enable();
> > +}
> > +
> >  /*
> >   * Query the presence of one or more xfeatures. Works on any legacy CPU as well.
> >   *
> > diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> > index 03acb9aeb32fc..795a0a2df135e 100644
> > --- a/arch/x86/include/asm/fpu/internal.h
> > +++ b/arch/x86/include/asm/fpu/internal.h
> > @@ -515,6 +515,15 @@ static inline void fpregs_activate(struct fpu *fpu)
> >  	trace_x86_fpu_regs_activated(fpu);
> >  }
> >  
> > +static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
> > +{
> > +	if (!fpregs_state_valid(fpu, cpu)) {
> > +		if (current->mm)
> > +			copy_kernel_to_fpregs(&fpu->state);
> > +		fpregs_activate(fpu);
> > +	}
> > +}
> > +
> >  /*
> >   * FPU state switching for scheduling.
> >   *
> > @@ -550,14 +559,8 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
> >   */
> >  static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
> >  {
> > -	if (static_cpu_has(X86_FEATURE_FPU)) {
> > -		if (!fpregs_state_valid(new_fpu, cpu)) {
> > -			if (current->mm)
> > -				copy_kernel_to_fpregs(&new_fpu->state);
> > -		}
> > -
> > -		fpregs_activate(new_fpu);
> > -	}
> > +	if (static_cpu_has(X86_FEATURE_FPU))
> > +		__fpregs_load_activate(new_fpu, cpu);
> 
> And that second part of a cleanup looks strange in this patch. Why isn't
> it in a separate patch or how is it related to the addition of the
> helpers?

Two helpers are added:
- __fpregs_changes_{begin|end}()
  new.

- __fpregs_load_activate()
  refactored from switch_fpu_finish(),

> Thx.
> 

Sebastian
