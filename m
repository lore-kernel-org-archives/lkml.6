Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69806C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEC820855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbfA3M2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:28:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46910 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfA3M2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:28:25 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gooya-0007D7-KD; Wed, 30 Jan 2019 13:28:20 +0100
Date:   Wed, 30 Jan 2019 13:28:20 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 17/22] x86/fpu: Prepare copy_fpstate_to_sigframe() for
 TIF_NEED_FPU_LOAD
Message-ID: <20190130122820.qyyn4vbtkqelmp54@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-18-bigeasy@linutronix.de>
 <20190130115614.GF18383@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130115614.GF18383@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-30 12:56:14 [+0100], Borislav Petkov wrote:
> > diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> > index bf4e6caad305e..a25be217f9a2c 100644
> > --- a/arch/x86/kernel/fpu/signal.c
> > +++ b/arch/x86/kernel/fpu/signal.c
> > @@ -156,7 +156,16 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
> >  			sizeof(struct user_i387_ia32_struct), NULL,
> >  			(struct _fpstate_32 __user *) buf) ? -1 : 1;
> >  
> > -	copy_fpregs_to_fpstate(fpu);
> > +	__fpregs_changes_begin();
> > +	/*
> > +	 * If we do not need to load the FPU registers at return to userspace
> > +	 * then the CPU has the current state and we need to save it. Otherwise
> > +	 * it is already done and we can skip it.
> > +	 */
> > +	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
> > +		copy_fpregs_to_fpstate(fpu);
> 
> I wonder if this flag would make the code more easy to follow by calling
> it
> 
> 	TIF_FPU_REGS_VALID
> 
> instead, to denote that the FPU registers in the CPU have a valid
> content.
> 
> Then the test becomes:
> 
> 	if (test_thread_flag(TIF_FPU_REGS_VALID))
> 		copy_fpregs_to_fpstate(fpu);

I've been asked to add comment above the sequence so it is understood. I
think the general approach is easy to follow once the concept is
understood. I don't mind renaming the TIF_ thingy once again (it
happend once or twice and I think the current one was suggested by Andy
unless I mixed things up).
The problem I have with the above is that

	if (test_thread_flag(TIF_NEED_FPU_LOAD))
		do_that()

becomes
	if (!test_thread_flag(TIF_FPU_REGS_VALID))
		do_that()

and you could argue again the other way around. So do we want NEED_LOAD
or NEED_SAVE flag which is another way of saying REGS_VALID?
More importantly the logic is changed when the bit is set and this
requires more thinking than just doing sed on the patch series.

Sebastian
