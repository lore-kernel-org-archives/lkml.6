Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160A4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD012082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD012082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbeK3CF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:05:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34981 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbeK3CF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:05:59 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gSNnc-0008Ia-H6; Thu, 29 Nov 2018 16:00:16 +0100
Date:   Thu, 29 Nov 2018 16:00:16 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 29/29] x86/fpu: Defer FPU state load until return to
 userspace
Message-ID: <20181129150016.bqjgc5t5qcafdplz@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
 <20181128222035.2996-30-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181128222035.2996-30-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-28 23:20:35 [+0100], To linux-kernel@vger.kernel.org wrote:
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index fb16d0da71bca..f552b1d6c6958 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -292,43 +295,51 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		u64 init_bv = xfeatures_mask & ~xfeatures;
>  
>  		if (using_compacted_format()) {
> -			ret = copy_user_to_xstate(&state->xsave, buf_fx);
> +			ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
>  		} else {
> -			ret = __copy_from_user(&state->xsave, buf_fx, state_size);
> +			ret = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
>  
>  			if (!ret && state_size > offsetof(struct xregs_state, header))
> -				ret = validate_xstate_header(&state->xsave.header);
> +				ret = validate_xstate_header(&fpu->state.xsave.header);
>  		}
>  		if (ret)
>  			goto err_out;
>  
> -		sanitize_restored_xstate(state, envp, xfeatures, fx_only);
> +		sanitize_restored_xstate(&fpu->state, envp, xfeatures, fx_only);
>  
> +		__fpregs_changes_begin();
>  		if (unlikely(init_bv))
>  			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
> -		ret = copy_users_to_xregs(&state->xsave, xfeatures);
> +		ret = copy_users_to_xregs(&fpu->state.xsave, xfeatures);
>  
>  	} else if (use_fxsr()) {
> -		ret = __copy_from_user(&state->fxsave, buf_fx, state_size);
> -		if (ret)
> +		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
> +		if (ret) {
> +			err = -EFAULT;
>  			goto err_out;
> +		}
>  
> -		sanitize_restored_xstate(state, envp, xfeatures, fx_only);
> +		sanitize_restored_xstate(&fpu->state, &env, xfeatures, fx_only);

This should have remained `envp' and not become `&env'.

Sebastian
