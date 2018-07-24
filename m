Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B53C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346CF20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346CF20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbeGXOxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388352AbeGXOxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:53:01 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D58320874;
        Tue, 24 Jul 2018 13:46:25 +0000 (UTC)
Date:   Tue, 24 Jul 2018 09:46:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180724094623.37430032@gandalf.local.home>
In-Reply-To: <20180718091209.u76gzacanj5avhdl@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
        <20180522131004.3012953c@gandalf.local.home>
        <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
        <20180522132429.6f1dcf92@gandalf.local.home>
        <20180522173333.aawadhkcekzvrswp@linutronix.de>
        <20180711092555.268adf7f@gandalf.local.home>
        <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
        <20180711093346.782af07a@gandalf.local.home>
        <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
        <20180716151737.GO9486@e103592.cambridge.arm.com>
        <20180718091209.u76gzacanj5avhdl@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018 11:12:10 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > > @@ -1115,7 +1116,7 @@ void kernel_neon_begin(void)
> > >  
> > >  	BUG_ON(!may_use_simd());
> > >  
> > > -	local_bh_disable();
> > > +	local_lock_bh(fpsimd_lock);
> > >  
> > >  	__this_cpu_write(kernel_neon_busy, true);
> > >  
> > > @@ -1129,8 +1130,14 @@ void kernel_neon_begin(void)
> > >  	fpsimd_flush_cpu_state();
> > >  
> > >  	preempt_disable();
> > > -
> > > -	local_bh_enable();
> > > +	/*
> > > +	 * ballance atomic vs !atomic context of migrate_disable().
> > > +	 * local_lock_bh = get_local_var() + spin_lock_bh (2x migrate_disable)
> > > +	 */
> > > +	migrate_disable();
> > > +	migrate_disable();
> > > +	migrate_disable();
> > > +	local_unlock_bh(fpsimd_lock);  
> > 
> > This looks fragile.
> > 
> > Do we really need to do it 3 times?  
> 
> Unfortunately yes.

Then we need to find another solution, because this is way too ugly and
as Dave said, fragile to keep.


> 
> > Showing my ignorance here, but I'd naively expect that the migrate-
> > disableness changes as follows:
> > 
> > 	/* 0 */
> > 	local_lock_bh(); /* +3 */
> > 
> > 	...
> > 
> > 	preempt_disable(); /* +3 */
> > 
> > 	migrate_disable(); /* +4 */
> > 	migrate_disable(); /* +5 */
> > 	migrate_disable(); /* +6 */
> > 
> > 	local_unlock_bh(); /* +3 */
> > 
> > 
> > If so, I don't understand why it's not OK to call migrate_disable()
> > just once, leaving the count at +1  (?)
> > 
> > I'm making assumptions about the relationship between preempt_disable()
> > and migrate_disable() here.  
> 
> Exactly. So local_lock_bh() does +3 which I try to explain why it is 3.

How does local_lock_bh() do a +3 (not seeing it in the code). And
leaking internal implementation of local_lock_bh() into other parts of
the kernel is a no no.

> Now migrate_disable() has two counters: One for atomic context (irq or
> preemption disabled) and on for non-atomic context. The difference is
> that in atomic context migrate_disable() does nothing and in !atomic
> context it does other things which can't be done in atomic context
> anyway (I can explain this in full detail but you may lose interest so I
> keep it short). To update your example:
> 
> 	/* ATOMIC COUNTER | non-ATOMIC COUNTER  | change */
> 			 /* 0 | 0 | - */
> 	local_lock_bh(); /* 0 | 3 | N+3 */
>  
>  	...
>  
> 	preempt_disable(); /* atomic context */
>  
> 	migrate_disable(); /* 1 | 3 | A+1 */
> 	migrate_disable(); /* 2 | 3 | A+1 */
> 	migrate_disable(); /* 3 | 3 | A+1 */
>  
> 	local_unlock_bh(); /* 0 | 3 | A-3 */
> 
> /* later */
> 	preempt_enable();  /* non-atomic context */
> 	migrate_enable();  /* 0 | 2 | N-1 */
> 	migrate_enable();  /* 0 | 1 | N-1 */
> 	migrate_enable();  /* 0 | 0 | N-1 */

If anything, this needs a wrapper. local_lock_preempt_fixup() ?

-- Steve

> 
> > >  }
> > >  EXPORT_SYMBOL(kernel_neon_begin);
> > >  
> > > @@ -1154,6 +1161,10 @@ void kernel_neon_end(void)
> > >  	WARN_ON(!busy);	/* No matching kernel_neon_begin()? */
> > >  
> > >  	preempt_enable();
> > > +	/* balance migrate_disable(). See kernel_neon_begin() */
> > > +	migrate_enable();
> > > +	migrate_enable();
> > > +	migrate_enable();
> > >  }
> > >  EXPORT_SYMBOL(kernel_neon_end);
> > >  
> > > @@ -1185,9 +1196,7 @@ void __efi_fpsimd_begin(void)
> > >  	if (!system_supports_fpsimd())
> > >  		return;
> > >  
> > > -	WARN_ON(preemptible());
> > > -
> > > -	if (may_use_simd()) {
> > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && may_use_simd()) {  
> > 
> > I suspect this is wrong -- see comments on the commit message.
> >   
> > >  		kernel_neon_begin();
> > >  	} else {  
> > 
> > [...]
> > 
> > Cheers
> > ---Dave  

