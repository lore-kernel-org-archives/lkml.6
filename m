Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D42C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACE620671
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="afHp5SyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACE620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeKTEep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:34:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59540 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbeKTEeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:34:44 -0500
Received: from zn.tnic (p200300EC2BE2B700F95221CD056129B8.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:b700:f952:21cd:561:29b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30B5F1EC06FB;
        Mon, 19 Nov 2018 19:10:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542651006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/B8qSmj9pVFu5keq5hb7tNgsAbLZcU0p+p1PYZKD6kQ=;
        b=afHp5SyP56m3pFvEcoMJhTRSxLU2N6qzT1fo6cVX2SdS5V0CC5Xwvq61hctO2cHR38cZOl
        GuyggzWK2MY+nOpKcd2vp+4cLCX1CjCelih1QoI/e+JiSXbu6f8AKMqkN2zqyGjPHygLZ2
        y/OOaTbWNYIcpx0qsB5QbK+8DgKKRgM=
Date:   Mon, 19 Nov 2018 19:10:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/fpu: Disable BH while while loading FPU registers
 in __fpu__restore_sig()
Message-ID: <20181119181000.GH14688@zn.tnic>
References: <20181119160410.ne7oiq2gkwt6jiqg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119160410.ne7oiq2gkwt6jiqg@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:04:10PM +0100, Sebastian Andrzej Siewior wrote:
> The sequence
>    fpu->initialized = 1; /* step A */
>    preempt_disable();	 /* step B */
>    fpu__restore(fpu);
>    preempt_enable();
> 
> is racy in regard to a context switch.
> For 32bit frames __fpu__restore_sig() prepares the FPU state within
> fpu->state. To ensure that a context switch (switch_fpu_prepare() in
> particular) does not modify fpu->state it uses fpu__drop() which sets
> fpu->initializes to 0.

"... ->initialized to 0."

Also, a new line here pls.

> With this change the CPU's FPU state is not saved
		  ^

comma:

		 ,

Also, instead of "with this change" I think you mean: "After
->initialized is cleared, the CPU's FPU state..."

> to fpu->state during a context switch.
> It then loads the state to fpu->state from userland and ensures it
> sane.

"... and ensures it is sane."

> The new state is loaded via fpu__restore(). The code sets then
> fpu->initializes to 1 in order to avoid fpu__initialize() doing

fpu->initialized

> anything (overwrite the new state) which is part of fpu__restore().

<---- newline here.

> A context switch between step A and B would save CPU's current FPU
> registers to fpu->state and overwrite the newly prepared state. This
> looks like tiny race window but the Kernel Test Robot reported this back
> in 2016 while we had lazy FPU support. Borislav Petkov made the link
> between that report and another patch that has been posted.
> Since the removal of the lazy FPU support, this race goes unnoticed
> because the warning has been removed.
> 
> Use local_bh_disable() around the restore sequence to avoid the race. BH

Let's write it out once: "Bottom halves need to be... "

> needs to be disabled because BH is allowed to run (even with preemption
> disabled) and might invoke kernel_fpu_begin().

... and let's put the potential example here with IPsec and softirq.

> Link: https://lkml.kernel.org/r/20160226074940.GA28911@pd.tnic
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2: A more verbose commit as message.

Very much needed, thanks!

>  arch/x86/kernel/fpu/signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 61a949d84dfa5..d99a8ee9e185e 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -344,10 +344,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
>  		}
>  
> +		local_bh_disable();
>  		fpu->initialized = 1;
> -		preempt_disable();
>  		fpu__restore(fpu);
> -		preempt_enable();
> +		local_bh_enable();
>  
>  		return err;
>  	} else {
> -- 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
