Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A67C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A318220873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jDH92ecE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfANQYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:24:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49476 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANQYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:24:07 -0500
Received: from zn.tnic (p200300EC2BC4CA0024FBBBED28F98094.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:24fb:bbed:28f9:8094])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBAC81EC0573;
        Mon, 14 Jan 2019 17:24:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547483046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ktyje5iriB+Gk+5OwpC3Vc8LFKZPk0n6IbU+QEixQPc=;
        b=jDH92ecEVOv+Rpa0gSgFcnO17mRrW3fwQg1cnU7/puCRO5s7OTyTCoaAYyjOHJTk7YWDxW
        xd9Jsbt09ctAaUXYd1Ipaz4oooIKBhNFV7wuCSCgtFRiK4x9FrYlugiKDVm3/vWqiL8ogy
        4/HHw9ou9UTftldfIwex02v/BC9JkAY=
Date:   Mon, 14 Jan 2019 17:24:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 01/22] x86/fpu: Remove fpu->initialized usage in
 __fpu__restore_sig()
Message-ID: <20190114162400.GN2773@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-2-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:23PM +0100, Sebastian Andrzej Siewior wrote:
> This is a preparation for the removal of the ->initialized member in the
> fpu struct.
> __fpu__restore_sig() is deactivating the FPU via fpu__drop() and then
> setting manually ->initialized followed by fpu__restore(). The result is
> that it is possible to manipulate fpu->state and the state of registers
> won't be saved/restored on a context switch which would overwrite
> fpu->state.
> 
> Don't access the fpu->state while the content is read from user space
> and examined / sanitized. Use a temporary kmalloc() buffer for the
> preparation of the FPU registers and once the state is considered okay,
> load it. Should something go wrong, return with an error and without
> altering the original FPU registers.
> 
> The removal of "fpu__initialize()" is a nop because fpu->initialized is
> already set for the user task.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/signal.h |  2 +-
>  arch/x86/kernel/fpu/regset.c      |  5 ++--
>  arch/x86/kernel/fpu/signal.c      | 41 ++++++++++++-------------------
>  3 files changed, 19 insertions(+), 29 deletions(-)

...

> @@ -315,40 +313,33 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		 * header. Validate and sanitize the copied state.
>  		 */
>  		struct user_i387_ia32_struct env;
> +		union fpregs_state *state;
>  		int err = 0;
> +		void *tmp;
>  
> -		/*
> -		 * Drop the current fpu which clears fpu->initialized. This ensures
> -		 * that any context-switch during the copy of the new state,
> -		 * avoids the intermediate state from getting restored/saved.
> -		 * Thus avoiding the new restored state from getting corrupted.
> -		 * We will be ready to restore/save the state only after
> -		 * fpu->initialized is again set.
> -		 */
> -		fpu__drop(fpu);
> +		tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
> +		if (!tmp)
> +			return -ENOMEM;
> +		state = PTR_ALIGN(tmp, 64);
>  
>  		if (using_compacted_format()) {
> -			err = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
> +			err = copy_user_to_xstate(&state->xsave, buf_fx);
>  		} else {
> -			err = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
> +			err = __copy_from_user(&state->xsave, buf_fx, state_size);
>  
>  			if (!err && state_size > offsetof(struct xregs_state, header))
> -				err = validate_xstate_header(&fpu->state.xsave.header);
> +				err = validate_xstate_header(&state->xsave.header);
>  		}
>  
>  		if (err || __copy_from_user(&env, buf, sizeof(env))) {
> -			fpstate_init(&fpu->state);
> -			trace_x86_fpu_init_state(fpu);
>  			err = -1;
>  		} else {
> -			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
> +			sanitize_restored_xstate(state, &env,
> +						 xfeatures, fx_only);

Just let that one stick out - there are other lines in this file already
longer than 80.

Notwithstanding, I don't see anything wrong with this patch.

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
