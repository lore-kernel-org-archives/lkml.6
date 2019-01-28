Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1238EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D591D2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="p41YQ41n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfA1SYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:24:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44124 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfA1SX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:23:58 -0500
Received: from zn.tnic (p200300EC2BC5DE008821062B415D2F41.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:de00:8821:62b:415d:2f41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 735A31EC0229;
        Mon, 28 Jan 2019 19:23:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548699836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GF5R7JIYQon2VlhGA1APYJi4dQvVwzwr7dXn4buTckY=;
        b=p41YQ41nRH5JQAmekfvWolk/5vjiGuLeWKkfWH10OvWxryLbNhTVWYagtgcsbcgTdsvxkQ
        TC+HvvZGKVNl165djusdM+gG4Alk4ANDLR2pHGviHr2asyw4GH4b91bfDKIaq48WO9OlHM
        VH6Iz/P77rwMGCFvB/ermJLl8NaN+8U=
Date:   Mon, 28 Jan 2019 19:23:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 09/22] x86/fpu: Add (__)make_fpregs_active helpers
Message-ID: <20190128182349.GG20487@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-10-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-10-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:31PM +0100, Sebastian Andrzej Siewior wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Add helper function that ensures the floating point registers for
> the current task are active. Use with preemption disabled.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/api.h      | 11 +++++++++++
>  arch/x86/include/asm/fpu/internal.h | 19 +++++++++++--------
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index b56d504af6545..31b66af8eb914 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -10,6 +10,7 @@
>  
>  #ifndef _ASM_X86_FPU_API_H
>  #define _ASM_X86_FPU_API_H
> +#include <linux/preempt.h>
>  
>  /*
>   * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
> @@ -22,6 +23,16 @@ extern void kernel_fpu_begin(void);
>  extern void kernel_fpu_end(void);
>  extern bool irq_fpu_usable(void);
>  
> +static inline void __fpregs_changes_begin(void)
> +{
> +	preempt_disable();
> +}
> +
> +static inline void __fpregs_changes_end(void)

How am I to understand that "fpregs_changes" thing? That FPU registers
changes will begin and end respectively?

I probably would call them fpregs_lock and fpregs_unlock even if
it isn't doing any locking to denote that FPU regs are locked and
inaccessible inside the region.

And why the "__" prefix? Is there a counterpart without the "__" coming?

> +{
> +	preempt_enable();
> +}
> +
>  /*
>   * Query the presence of one or more xfeatures. Works on any legacy CPU as well.
>   *
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 03acb9aeb32fc..795a0a2df135e 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -515,6 +515,15 @@ static inline void fpregs_activate(struct fpu *fpu)
>  	trace_x86_fpu_regs_activated(fpu);
>  }
>  
> +static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
> +{
> +	if (!fpregs_state_valid(fpu, cpu)) {
> +		if (current->mm)
> +			copy_kernel_to_fpregs(&fpu->state);
> +		fpregs_activate(fpu);
> +	}
> +}
> +
>  /*
>   * FPU state switching for scheduling.
>   *
> @@ -550,14 +559,8 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
>   */
>  static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
>  {
> -	if (static_cpu_has(X86_FEATURE_FPU)) {
> -		if (!fpregs_state_valid(new_fpu, cpu)) {
> -			if (current->mm)
> -				copy_kernel_to_fpregs(&new_fpu->state);
> -		}
> -
> -		fpregs_activate(new_fpu);
> -	}
> +	if (static_cpu_has(X86_FEATURE_FPU))
> +		__fpregs_load_activate(new_fpu, cpu);

And that second part of a cleanup looks strange in this patch. Why isn't
it in a separate patch or how is it related to the addition of the
helpers?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
