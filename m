Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E78C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C331220882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lyC7/EIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfA3Ln2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:43:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbfA3Ln1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:43:27 -0500
Received: from zn.tnic (p200300EC2BCAED00302FA729E39312A6.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:ed00:302f:a729:e393:12a6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 815DE1EC0338;
        Wed, 30 Jan 2019 12:43:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548848605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6dIWZsK/S1Dcdfk00N8urUtaJYC5S5Df1g37fOPLXBo=;
        b=lyC7/EIw71YTNK/MDB15plI8Ft0OrwuiRn8nCxEYBxA7SoFs60Nj0JaGN47bhkxWWza932
        V5yD95lCU5oVctDhI7yB9wa9dC2XWdIU8Snlj4bdvaaQfiuCCZA61eq/Hueu3Y8Di27ZZ/
        /rrmg8d0XvdCOyIeo6biudNUS1HpTVg=
Date:   Wed, 30 Jan 2019 12:43:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 16/22] x86/fpu: Always store the registers in
 copy_fpstate_to_sigframe()
Message-ID: <20190130114322.GD18383@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-17-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109114744.10936-17-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:38PM +0100, Sebastian Andrzej Siewior wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> copy_fpstate_to_sigframe() stores the registers directly to user space.
> This is okay because the FPU register are valid and saving it directly
> avoids saving it into kernel memory and making a copy.
> However… We can't keep doing this if we are going to restore the FPU
> registers on the return to userland. It is possible that the FPU
> registers will be invalidated in the middle of the save operation and
> this should be done with disabled preemption / BH.
> 
> Save the FPU registers to task's FPU struct and copy them to the user
> memory later on.
> 
> This code is extracted from an earlier version of the patchset while
> there still was lazy-FPU on x86.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h | 45 -----------------------------
>  arch/x86/kernel/fpu/signal.c        | 29 +++++++------------
>  2 files changed, 10 insertions(+), 64 deletions(-)

...

> @@ -171,9 +156,15 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
>  			sizeof(struct user_i387_ia32_struct), NULL,
>  			(struct _fpstate_32 __user *) buf) ? -1 : 1;
>  
> -	/* Save the live register state to the user directly. */
> -	if (copy_fpregs_to_sigframe(buf_fx))
> -		return -1;
> +	copy_fpregs_to_fpstate(fpu);
> +
> +	if (using_compacted_format()) {
> +		copy_xstate_to_user(buf_fx, xsave, 0, size);
> +	} else {
> +		fpstate_sanitize_xstate(fpu);
> +		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
> +			return -1;
> +	}
>  
>  	/* Save the fsave header for the 32-bit frames. */
>  	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))

Comments above that function need updating.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
