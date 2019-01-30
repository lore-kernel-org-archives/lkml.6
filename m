Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3722CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A1220833
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="k0vZR2U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbfA3V3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:29:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfA3V3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:29:13 -0500
Received: from zn.tnic (p200300EC2BCAED00380C712EC8B20768.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:ed00:380c:712e:c8b2:768])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAEB91EC0338;
        Wed, 30 Jan 2019 22:29:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548883750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEeHe92ZSQkwbo0RtBegqQ7Xoyl6dFsNSQy2ffkBucE=;
        b=k0vZR2U+KtPoCWeLezW26HiylgJlogUo5dFZDSGvETSB64j+DUkwIUFHtOkB6TI8Qi9sa1
        NkXgdf0gzRzBbfKpODYdpQ2WtcA4coc0Gvp82ItdOjobm9uvRSfm1geM/e6estsVAAihI3
        4rEaNMkonmRVObZQNzYwRFtRx8ILOPI=
Date:   Wed, 30 Jan 2019 22:29:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 20/22] x86/fpu: Let __fpu__restore_sig() restore the
 !32bit+fxsr frame from kernel memory
Message-ID: <20190130212903.GI18383@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-21-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109114744.10936-21-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:42PM +0100, Sebastian Andrzej Siewior wrote:
> The !32bit+fxsr case loads the new state from user memory. In case we
      ^^^^^^^^^^^

Let's "decrypt" that: "The 64-bit case where fast FXSAVE/FXRSTOR are used... "

But looking at the patch, it is not only about the fxsr but also the
use_xsave() case. So pls write out exactly what you mean here.

Ditto for the patch title.

> restore the FPU state on return to userland we can't do this. It would
> be required to disable preemption in order to avoid a context switch
> which would set TIF_NEED_FPU_LOAD. If this happens before the "restore"
> operation then the loaded registers would become volatile.
> 
> Disabling preemption while accessing user memory requires to disable the
> pagefault handler. An error during XRSTOR would then mean that either a
> page fault occured (and we have to retry with enabled page fault
> handler) or a #GP occured because the xstate is bogus (after all the
> sig-handler can modify it).
> 
> In order to avoid that mess, copy the FPU state from userland, validate
> it and then load it. The copy_users_…() helper are basically the old
> helper except that they operate on kernel memory and the fault handler
> just sets the error value and the caller handles it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h | 32 ++++++++++-----
>  arch/x86/kernel/fpu/signal.c        | 62 +++++++++++++++++++++++------
>  2 files changed, 71 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 16ea30235b025..672e51bc0e9b5 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -120,6 +120,21 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
>  	err;								\
>  })
>  
> +#define kernel_insn_norestore(insn, output, input...)			\
> +({									\
> +	int err;							\
> +	asm volatile("1:" #insn "\n\t"					\
> +		     "2:\n"						\
> +		     ".section .fixup,\"ax\"\n"				\
> +		     "3:  movl $-1,%[err]\n"				\
> +		     "    jmp  2b\n"					\
> +		     ".previous\n"					\
> +		     _ASM_EXTABLE(1b, 3b)				\
> +		     : [err] "=r" (err), output				\
> +		     : "0"(0), input);					\
> +	err;								\
> +})

user_insn above looks unused - just repurpose it.

> +
>  #define kernel_insn(insn, output, input...)				\
>  	asm volatile("1:" #insn "\n\t"					\
>  		     "2:\n"						\
> @@ -140,15 +155,15 @@ static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
>  	}
>  }
>  
> -static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
> +static inline int copy_users_to_fxregs(struct fxregs_state *fx)

Why "users" ?

>  {
>  	if (IS_ENABLED(CONFIG_X86_32))
> -		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
> +		return kernel_insn_norestore(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
>  	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
> -		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
> +		return kernel_insn_norestore(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
>  
>  	/* See comment in copy_fxregs_to_kernel() below. */
> -	return user_insn(rex64/fxrstor (%[fx]), "=m" (*fx), [fx] "R" (fx),
> +	return kernel_insn_norestore(rex64/fxrstor (%[fx]), "=m" (*fx), [fx] "R" (fx),
>  			  "m" (*fx));
>  }
>  
> @@ -157,9 +172,9 @@ static inline void copy_kernel_to_fregs(struct fregs_state *fx)
>  	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
>  }
>  
> -static inline int copy_user_to_fregs(struct fregs_state __user *fx)
> +static inline int copy_users_to_fregs(struct fregs_state *fx)
>  {
> -	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
> +	return kernel_insn_norestore(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
>  }
>  
>  static inline void copy_fxregs_to_kernel(struct fpu *fpu)
> @@ -339,16 +354,13 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
>  /*
>   * Restore xstate from user space xsave area.
>   */
> -static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
> +static inline int copy_users_to_xregs(struct xregs_state *xstate, u64 mask)
>  {
> -	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
>  	u32 lmask = mask;
>  	u32 hmask = mask >> 32;
>  	int err;
>  
> -	stac();
>  	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
> -	clac();
>  
>  	return err;
>  }
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 970091fb011e9..4ed5c400cac58 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -217,7 +217,8 @@ sanitize_restored_xstate(union fpregs_state *state,
>  		 */
>  		xsave->i387.mxcsr &= mxcsr_feature_mask;
>  
> -		convert_to_fxsr(&state->fxsave, ia32_env);
> +		if (ia32_env)
> +			convert_to_fxsr(&state->fxsave, ia32_env);
>  	}
>  }
>  
> @@ -299,28 +300,63 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		kfree(tmp);
>  		return err;
>  	} else {
> +		union fpregs_state *state;
> +		void *tmp;
>  		int ret;
>  
> +		tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
> +		if (!tmp)
> +			return -ENOMEM;

<---- newline here.

> +		state = PTR_ALIGN(tmp, 64);
> +
>  		/*
>  		 * For 64-bit frames and 32-bit fsave frames, restore the user
>  		 * state to the registers directly (with exceptions handled).
>  		 */
> -		if (use_xsave()) {
> -			if ((unsigned long)buf_fx % 64 || fx_only) {
> +		if ((unsigned long)buf_fx % 64)
> +			fx_only = 1;
> +
> +		if (use_xsave() && !fx_only) {
> +			u64 init_bv = xfeatures_mask & ~xfeatures;

Define that init_bv in the function prologue above and then you don't
need to define it again here and below in a narrower scope.

> +
> +			if (using_compacted_format()) {
> +				ret = copy_user_to_xstate(&state->xsave, buf_fx);
> +			} else {
> +				ret = __copy_from_user(&state->xsave, buf_fx, state_size);
> +
> +				if (!ret && state_size > offsetof(struct xregs_state, header))
> +					ret = validate_xstate_header(&state->xsave.header);
> +			}
> +			if (ret)
> +				goto err_out;

<---- newline here.

> +			sanitize_restored_xstate(state, NULL, xfeatures,
> +						 fx_only);

Let that stick out.

And then do that here:

			init_bv = xfeatures_mask & ~xfeatures;> +
> +			if (unlikely(init_bv))
> +				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);

and add a newline here so that this code above belongs together visually.

> +			ret = copy_users_to_xregs(&state->xsave, xfeatures);
> +

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
