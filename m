Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C30C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839B42064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LPptIHJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfANSzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:55:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45200 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfANSzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:55:13 -0500
Received: from zn.tnic (p200300EC2BC4CA000555087DEC7D7788.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:555:87d:ec7d:7788])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A9E31EC0230;
        Mon, 14 Jan 2019 19:55:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547492112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zQUWLxNfiXTBCJZstDnk5WvniFBosJUqWtd8UKSnxao=;
        b=LPptIHJoZmj6/pt8T4Lqbe5/tKklmj3SlT80jfAEXWFnDZxT46TrhbLvSfMlVoBbj61Lka
        QQXnI85VkcXa4yPsK4VEeUTS4ytECIBK0ado/6q00FSjGuiWwc/PpFp4/JLfYJh2gpsehW
        M9L7s+Juqbq3Hkp4YTBk/jWsYHub3Ow=
Date:   Mon, 14 Jan 2019 19:55:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 03/22] x86/fpu: Remove preempt_disable() in fpu__clear()
Message-ID: <20190114185506.GP2773@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-4-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:25PM +0100, Sebastian Andrzej Siewior wrote:
> The preempt_disable() section was introduced in commit

<---- newline here.

>   a10b6a16cdad8 ("x86/fpu: Make the fpu state change in fpu__clear() scheduler-atomic")

<---- newline here.

> and it was said to be temporary.
> 
> fpu__initialize() initializes the FPU struct to its "init" value and
> then sets ->initialized to 1. The last part is the important one.
> The content of the `state' does not matter because it gets set via
> copy_init_fpstate_to_fpregs().
> A preemption here has little meaning because the register will always be

s/register/registers/

> set to the same content after copy_init_fpstate_to_fpregs(). A softirq
> with a kernel_fpu_begin() could also force to save FPU's register after

ditto.

> fpu__initialize() without changing the outcome here.
> 
> Remove the preempt_disable() section in fpu__clear(), preemption here
> does not hurt.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/fpu/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 1d3ae7988f7f2..1940319268aef 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -366,11 +366,9 @@ void fpu__clear(struct fpu *fpu)
>  	 * Make sure fpstate is cleared and initialized.
>  	 */
>  	if (static_cpu_has(X86_FEATURE_FPU)) {
> -		preempt_disable();
>  		fpu__initialize(fpu);
>  		user_fpu_begin();
>  		copy_init_fpstate_to_fpregs();
> -		preempt_enable();
>  	}
>  }
>  
> -- 

With the above addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
