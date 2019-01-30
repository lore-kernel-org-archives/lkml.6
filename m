Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91562C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BE320855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="c5DFRKoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfA3L4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:56:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34140 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730308AbfA3L4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:56:20 -0500
Received: from zn.tnic (p200300EC2BCAED00D014CE199A91CB87.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:ed00:d014:ce19:9a91:cb87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 138871EC04F3;
        Wed, 30 Jan 2019 12:56:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548849378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wwFVobSeJGnSQkzACO0nPrAoWxqdCnm8PIo8GBGCqn4=;
        b=c5DFRKoN8hJxWmPYPhp6rT2NPQghZPzIAz5NRAyk4RwbJnmaV2OfnXAXtvScobXMBnXn31
        UwTGllnLqJF5LtBMMQyNKNwNggjL9jMH9KJR1FlU0koA7m5Hl5PmSxci6Q1CImlyL3F7eS
        Jw50tGXfStC8+BIL2G6s1c83Hz0udMI=
Date:   Wed, 30 Jan 2019 12:56:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 17/22] x86/fpu: Prepare copy_fpstate_to_sigframe() for
 TIF_NEED_FPU_LOAD
Message-ID: <20190130115614.GF18383@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-18-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-18-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:39PM +0100, Sebastian Andrzej Siewior wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> The FPU registers need only to be saved if TIF_NEED_FPU_LOAD is not set.
> Otherwise this has been already done and can be skipped.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index bf4e6caad305e..a25be217f9a2c 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -156,7 +156,16 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
>  			sizeof(struct user_i387_ia32_struct), NULL,
>  			(struct _fpstate_32 __user *) buf) ? -1 : 1;
>  
> -	copy_fpregs_to_fpstate(fpu);
> +	__fpregs_changes_begin();
> +	/*
> +	 * If we do not need to load the FPU registers at return to userspace
> +	 * then the CPU has the current state and we need to save it. Otherwise
> +	 * it is already done and we can skip it.
> +	 */
> +	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
> +		copy_fpregs_to_fpstate(fpu);

I wonder if this flag would make the code more easy to follow by calling
it

	TIF_FPU_REGS_VALID

instead, to denote that the FPU registers in the CPU have a valid
content.

Then the test becomes:

	if (test_thread_flag(TIF_FPU_REGS_VALID))
		copy_fpregs_to_fpstate(fpu);

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
