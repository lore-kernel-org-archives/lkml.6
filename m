Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3BAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABBA2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WFmUeblu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfA1SuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:50:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47966 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfA1SuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:50:08 -0500
Received: from zn.tnic (p200300EC2BC5DE008821062B415D2F41.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:de00:8821:62b:415d:2f41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C20071EC0B6C;
        Mon, 28 Jan 2019 19:50:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548701407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4S4k11kTKhKf6m2TMUcyKOA1honMmaMMM8uit63w3q8=;
        b=WFmUebluYX5H7r3QsRBKZcqT4bLVMHrzIwUYqJgTrRXck2jZzIB+aiRvYcDiOEhpzSnHhz
        JZlWd+PXocqfnHRzs8nUQapVHZcHJr0+qstzlR/Y+GZUVtgQfO3iWsfKYClQ2E9lBCqfpk
        ofKyLa15oR0KNka8P6BR5yUCWB4kTwg=
Date:   Mon, 28 Jan 2019 19:49:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 11/22] x86/fpu: Make get_xsave_field_ptr() and
 get_xsave_addr() use feature number instead of mask
Message-ID: <20190128184959.GI20487@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-12-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-12-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:33PM +0100, Sebastian Andrzej Siewior wrote:
> After changing the argument of __raw_xsave_addr() from a mask to number
> Dave suggested to check if it makes sense to do the same for
> get_xsave_addr(). As it turns out it does. Only get_xsave_addr() needs
> the mask to check if the requested feature is part of what is
> support/saved and then uses the number again. The shift operation is
> cheaper compared to "find last bit set". Also, the feature number uses
> less opcode space compared to the mask :)
> 
> Make get_xsave_addr() argument a xfeature number instead of mask and fix
> up its callers.
> As part of this use xfeature_nr and xfeature_mask consistently.

Good!

> This results in changes to the kvm code as:
> 	feature -> xfeature_mask
> 	index -> xfeature_nr
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/xstate.h |  4 ++--
>  arch/x86/kernel/fpu/xstate.c      | 23 +++++++++++------------
>  arch/x86/kernel/traps.c           |  2 +-
>  arch/x86/kvm/x86.c                | 28 ++++++++++++++--------------
>  arch/x86/mm/mpx.c                 |  6 +++---
>  5 files changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 48581988d78c7..fbe41f808e5d8 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -46,8 +46,8 @@ extern void __init update_regset_xstate_info(unsigned int size,
>  					     u64 xstate_mask);
>  
>  void fpu__xstate_clear_all_cpu_caps(void);
> -void *get_xsave_addr(struct xregs_state *xsave, int xstate);
> -const void *get_xsave_field_ptr(int xstate_field);
> +void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
> +const void *get_xsave_field_ptr(int xfeature_nr);
>  int using_compacted_format(void);
>  int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
>  int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 0e759a032c1c7..d288e4d271b71 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -830,15 +830,15 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>   *
>   * Inputs:
>   *	xstate: the thread's storage area for all FPU data
> - *	xstate_feature: state which is defined in xsave.h (e.g.
> - *	XFEATURE_MASK_FP, XFEATURE_MASK_SSE, etc...)
> + *	xfeature_nr: state which is defined in xsave.h (e.g. XFEATURE_FP,
> + *	XFEATURE_SSE, etc...)
>   * Output:
>   *	address of the state in the xsave area, or NULL if the
>   *	field is not present in the xsave buffer.
>   */
> -void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
> +void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>  {
> -	int xfeature_nr;
> +	u64 xfeature_mask = 1ULL << xfeature_nr;

You can paste directly BIT_ULL(xfeature_nr) where you need it in this
function...

>  	/*
>  	 * Do we even *have* xsave state?
>  	 */
> @@ -850,11 +850,11 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
>  	 * have not enabled.  Remember that pcntxt_mask is
>  	 * what we write to the XCR0 register.
>  	 */
> -	WARN_ONCE(!(xfeatures_mask & xstate_feature),
> +	WARN_ONCE(!(xfeatures_mask & xfeature_mask),

... and turn this into:

	WARN_ONCE(!(xfeatures_mask & BIT_ULL(xfeature_nr))

which is more readable than the AND of two variables which I had to
re-focus my eyes to see the difference. :)

Oh and this way, gcc generates better code by doing simply a BT
directly:

# arch/x86/kernel/fpu/xstate.c:852:     WARN_ONCE(!(xfeatures_mask & BIT_ULL(xfeature_nr)),
        .loc 1 852 2 view .LVU258
        movq    xfeatures_mask(%rip), %rax      # xfeatures_mask, tmp124
        btq     %rsi, %rax      # xfeature_nr, tmp124


without first computing the shift into xfeature_mask:

# arch/x86/kernel/fpu/xstate.c:841:     u64 xfeature_mask = 1ULL << xfeature_nr;
        .loc 1 841 6 view .LVU249
        movl    %esi, %ecx      # xfeature_nr, tmp120
        movl    $1, %ebp        #, tmp105
        salq    %cl, %rbp       # tmp120, xfeature_mask

and then testing it:

# arch/x86/kernel/fpu/xstate.c:853:     WARN_ONCE(!(xfeatures_mask & xfeature_mask),
        .loc 1 853 2 view .LVU256
        testq   %rbp, xfeatures_mask(%rip)      # xfeature_mask, xfeatures_mask
        movq    %rdi, %rbx      # xsave, xsave


Otherwise a nice cleanup!

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
