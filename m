Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B8FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527542145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527542145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeJSAOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:14:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeJSAOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:14:53 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gDAv3-00059C-DJ; Thu, 18 Oct 2018 18:13:05 +0200
Date:   Thu, 18 Oct 2018 18:13:05 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 04/11] x86/fpu: eager switch PKRU state
Message-ID: <20181018161305.f4t7bdxhmpy5htrs@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-5-bigeasy@linutronix.de>
 <76caafd5-c85d-61bb-62ec-8056cd6d95ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76caafd5-c85d-61bb-62ec-8056cd6d95ac@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-12 10:51:34 [-0700], Dave Hansen wrote:
> > diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> > index 16c4077ffc945..956d967ca824a 100644
> > --- a/arch/x86/include/asm/fpu/internal.h
> > +++ b/arch/x86/include/asm/fpu/internal.h
> > @@ -570,11 +570,23 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
> >   */
> >  static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
> >  {
> > -	bool preload = static_cpu_has(X86_FEATURE_FPU) &&
> > -		       new_fpu->initialized;
> > +	bool load_fpu;
> >  
> > -	if (preload)
> > -		__fpregs_load_activate(new_fpu, cpu);
> > +	load_fpu = static_cpu_has(X86_FEATURE_FPU) && new_fpu->initialized;
> > +	if (!load_fpu)
> > +		return;
> 
> Needs comments, please.  Especially around what an uninitialized new_fpu
> means.

that ->initialized field is gone.

> > +	__fpregs_load_activate(new_fpu, cpu);
> > +
> > +#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> > +	if (static_cpu_has(X86_FEATURE_OSPKE)) {
> 
> FWIW, you should be able to use cpu_feature_enabled() instead of an
> explicit #ifdef here.
okay.

> > +		struct pkru_state *pk;
> > +
> > +		pk = __raw_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
> > +		if (pk->pkru != __read_pkru())
> > +			__write_pkru(pk->pkru);
> > +	}
> > +#endif
> >  }
> 
> Comments here as well, please.
> 
> I think the goal is to keep the PKRU state in the 'init state' when
> possible and also to save the cost of WRPKRU.  But, it would be really
> nice to be explicit.

added:
     /*
      * Writting PKRU is expensive. Only write the PKRU value if it is
      * different from the current one.
      */

> > -static inline void write_pkru(u32 pkru)
> > -{
> > -	if (boot_cpu_has(X86_FEATURE_OSPKE))
> > -		__write_pkru(pkru);
> > -}
> > +void write_pkru(u32 pkru);
> 
> One reason I inlined this was because it enables the the PK code to be
> optimized away entirely.  Putting the checks behind a function call
> makes this optimization impossible.
> 
> Could you elaborate on why you chose to do this and what you think the
> impact is or is not?

One thing let to another. It gets to an include mess once I tried to do
more than just reading / writting the value.
I kept now write_pkru() and added __write_pkru_if_new() which does the
extra pieces. If you don't like the new version we would need to look on
how to make it simpler :)

> > diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
> > index 19b137f1b3beb..b184f916319e5 100644
> > --- a/arch/x86/include/asm/pkeys.h
> > +++ b/arch/x86/include/asm/pkeys.h
> > @@ -119,7 +119,7 @@ extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> >  		unsigned long init_val);
> >  extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> >  		unsigned long init_val);
> > -extern void copy_init_pkru_to_fpregs(void);
> > +extern void pkru_set_init_value(void);
> 
> Could you elaborate on why the name is being changed?

The function name read like init_pkru value is copied to fpregs save
area which is not the case. I could revert it if you prefer.

> > +void write_pkru(u32 pkru)
> > +{
> > +	struct pkru_state *pk;
> > +
> > +	if (!boot_cpu_has(X86_FEATURE_OSPKE))
> > +		return;
> > +
> > +	pk = __raw_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
> > +	/*
> > +	 * Update the PKRU value in cstate and then in the CPU. A context
> 
> "cstate"?  Did you mean xstate?

indeed.

> > +	 * switch between those two operation would load the new value from the
> > +	 * updated xstate and then we would write (the same value) to the CPU.
> > +	 */
> > +	pk->pkru = pkru;
> > +	__write_pkru(pkru);
> > +
> > +}
> 
> There's an unnecessary line there.
> 
> This also needs a lot more high-level context about why it is necessary.
>  I think you had that in the changelog, but we also need the function
> commented.

What is necessary? The manual update of "pk->pkru?

> > -	if (!init_pkru_value_snapshot && !read_pkru())
> > +	if (init_pkru_value_snapshot == read_pkru())
> >  		return;
> > -	/*
> > -	 * Override the PKRU state that came from 'init_fpstate'
> > -	 * with the baseline from the process.
> > -	 */
> > +
> >  	write_pkru(init_pkru_value_snapshot);
> >  }
> 
> Isn't this doing some of the same work (including rdpkru()) as write_pkru()?

Well, yes. Since my write_pkru() checks if the new value the same as the
current I dropped most of the code here.

Sebastian
