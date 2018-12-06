Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B174C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4085120989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="l3E1w3G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4085120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLFUHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:07:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58704 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeLFUHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:07:31 -0500
Received: from zn.tnic (p200300EC2BCE8F005573F8735857468A.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:8f00:5573:f873:5857:468a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 725181EC0BAD;
        Thu,  6 Dec 2018 21:07:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544126849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vKDO1AONLDvHL6i7cURw2F4Xjrieo7pmPPnlSoIwetA=;
        b=l3E1w3G7ejtXkjvHnSED+VhnE4LweEbHoPrShyGasASEBSYfA0F5LVMp63Nyzx8R5TgH7E
        RXQyaHlBZtxDWgOvaBfhNXwcsgv5clO+DoA3jrAYq5LIFYDQdgosucjteIi8FHQfMtcieX
        OZ+ZUfOFGNqobPKTh6MmXxby7NCkbC0=
Date:   Thu, 6 Dec 2018 21:07:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 08/29] x86/fpu: Remove fpu->initialized usage in
 __fpu__restore_sig()
Message-ID: <20181206200722.GF3986@zn.tnic>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
 <20181128222035.2996-9-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181128222035.2996-9-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:20:14PM +0100, Sebastian Andrzej Siewior wrote:
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

> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index d99a8ee9e185e..9c35598697b94 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -207,11 +207,11 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
>  }
>  
>  static inline void
> -sanitize_restored_xstate(struct task_struct *tsk,
> +sanitize_restored_xstate(union fpregs_state *state,
>  			 struct user_i387_ia32_struct *ia32_env,
>  			 u64 xfeatures, int fx_only)
>  {
> -	struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
> +	struct xregs_state *xsave = &state->xsave;
>  	struct xstate_header *header = &xsave->header;
>  
>  	if (use_xsave()) {
> @@ -238,7 +238,7 @@ sanitize_restored_xstate(struct task_struct *tsk,
>  		 */
>  		xsave->i387.mxcsr &= mxcsr_feature_mask;
>  
> -		convert_to_fxsr(tsk, ia32_env);
> +		convert_to_fxsr(&state->fxsave, ia32_env);
>  	}
>  }
>  
> @@ -284,8 +284,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  	if (!access_ok(VERIFY_READ, buf, size))
>  		return -EACCES;
>  
> -	fpu__initialize(fpu);
> -
>  	if (!static_cpu_has(X86_FEATURE_FPU))
>  		return fpregs_soft_set(current, NULL,
>  				       0, sizeof(struct user_i387_ia32_struct),
> @@ -314,41 +312,34 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		 * thread's fpu state, reconstruct fxstate from the fsave
>  		 * header. Validate and sanitize the copied state.
>  		 */
> +		union fpregs_state *state;
> +		void *tmp;
>  		struct user_i387_ia32_struct env;
>  		int err = 0;

Sort those in reverse xmas order pls.

Otherwise looks ok.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
