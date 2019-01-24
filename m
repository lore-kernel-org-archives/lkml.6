Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1261AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E7521872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RvF1AaqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfAXLRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:17:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41324 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfAXLRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:17:21 -0500
Received: from zn.tnic (p200300EC2BCBCF00857058CDE16DF962.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:cf00:8570:58cd:e16d:f962])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D76021EC0242;
        Thu, 24 Jan 2019 12:17:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548328640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/KSM/VoEYI/MPnLijAH75DGL4jqkkOcKozx0d7kIps=;
        b=RvF1AaqAvVlYTEzHp2XA4OzKE3LititkJnlIBIDtLYU30kdobfCv1/kCjidMnh4MYQ9+4g
        DlD8UGp8PT+MrwU2dmnHJwqriLaJMBKgZ3T2GvGkS5F7lia2OFV+fwM5GVbPDlmOTVRtjb
        fKYUEESgQ2Lu47Ff1w5Mds/j3xrDmbg=
Date:   Thu, 24 Jan 2019 12:17:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 06/22] x86/fpu: Don't save fxregs for ia32 frames in
 copy_fpstate_to_sigframe()
Message-ID: <20190124111714.GA11554@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109114744.10936-7-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:28PM +0100, Sebastian Andrzej Siewior wrote:
> Why does copy_fpstate_to_sigframe() do copy_fxregs_to_kernel() in the
> ia32_fxstate case? I don't know. It just does.
> Maybe it was required at some point, maybe it was added by accident and
> nobody noticed it because it makes no difference.

So

  72a671ced66d ("x86, fpu: Unify signal handling code paths for x86 and x86_64 kernels")

talks about some exclusion of legacy fsave state.

> In copy_fpstate_to_sigframe() we stash the FPU state into the task's
> stackframe. Then the CPU's FPU registers (and its fpu->state) are
> cleared (handle_signal() does fpu__clear()).

So that fpu__clear() name is not optimal. It should be
fpu__reinitialize() or so. The comment above it says so too:

/*
 * Clear the FPU state back to init state.

> So it makes *no* difference
> what happens to fpu->state after copy_fpregs_to_sigframe().
> 
> Remove copy_fxregs_to_kernel() since it does not matter what it does and
> save a few cycles.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index c136a4327659d..047390a45e016 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -174,9 +174,6 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
>  	/* Save the live register state to the user directly. */
>  	if (copy_fpregs_to_sigframe(buf_fx))
>  		return -1;
> -	/* Update the thread's fxstate to save the fsave header. */
> -	if (ia32_fxstate)
> -		copy_fxregs_to_kernel(fpu);

Need to get rid of that local "fpu" var too:

arch/x86/kernel/fpu/signal.c: In function ‘copy_fpstate_to_sigframe’:
arch/x86/kernel/fpu/signal.c:159:14: warning: unused variable ‘fpu’ [-Wunused-variable]
  struct fpu *fpu = &current->thread.fpu;
              ^~~

>  	/* Save the fsave header for the 32-bit frames. */
>  	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
> -- 
> 2.20.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
