Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3C42147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LwDJBnIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfBGKhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:37:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44916 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfBGKhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:37:54 -0500
Received: from zn.tnic (p200300EC2BD1880034901D79874D129C.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8800:3490:1d79:874d:129c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA29B1EC0375;
        Thu,  7 Feb 2019 11:37:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549535872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OV84EKrVai5e1TV0CCbpF43jg+fUXWVTwRSCP6uBfNg=;
        b=LwDJBnIjQx/au0YlHL3JF2c1rP1AEDrV71TueklOiYVbEbXBSWqWmlJjHrXJx5lzlEXpxn
        SIw/7bcpKJn3Ub7v8TRpzHmeC6C3hnckx9jkcr2dLia9+b2Li+8Ckqqf2zoWunn9Gbyurj
        9gpVsB0cMjUYR+Foy7BK6mn14yUz/0M=
Date:   Thu, 7 Feb 2019 11:37:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 07/22] x86/fpu: Remove fpu->initialized
Message-ID: <20190207103742.GC2414@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-8-bigeasy@linutronix.de>
 <20190124133449.GC11554@zn.tnic>
 <20190205180336.smegi6rz7waprfaf@linutronix.de>
 <20190206140114.GD7314@zn.tnic>
 <20190207101301.vlaiikyqweftemxu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190207101301.vlaiikyqweftemxu@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 11:13:01AM +0100, Sebastian Andrzej Siewior wrote:
> and I *think* that this is enough. This *what* we do and not *why*. I
> don't have an answer towards *why*.

Well, it is a start.

You now have everything in your L1 and it is all clear but I'm sure all
the details will be LRU-evicted out soon :) and then you'd wish you'd
written down at least a small hint explaining the grand scheme at least.

> 
> > Considering that in this very thread we ourselves encountered the fact
> > that stuff is not documented and we complained that it wasn't!
> 
> Yes. We had no idea why we save the FPU registers on user's stack during
> signal handling. Was this an implementation detail on kernel side as
> part of signal handling or is this required/ expected by the user as
> part of a use case?

Well, at least a comment over get_sigframe() would've helped a long way,
right?

Instead of scratching heads why is this being done this way.

> We have now the explanation that signals may cascade. Do we know by
> now if userland is supposed to use it or it accessed the register
> because they were available? The MPX code did access the MPX part of
> the xsave area (others do it for "testing/debug" as per my I google
> research). This kind of things should be part of the ABI document and
> not only a comment in the kernel.

Absolutely agreed.

> Are the MAGIC constants only in-kernel use (to check if the user
> accidentally overwrote its stack) or should be checked by the user
> during signal handling to ensure that the xsave area is available.

I don't think the user should care but what do I know?!

> The part you referred to was:
> |-       /* Update the thread's fxstate to save the fsave header. */
> |-       if (ia32_fxstate) 
> |-               copy_fxregs_to_kernel(fpu);
> 
> and it is not helping because it does not explain why it is done. I can
> see based on the code that the FXstate is saved in case of a 32bit
> frame. It is saved into thread's state. It does not explain why it
> needs to be done. That is the "not helping" part.

This is *exactly* why I propose that we should have a
"grand-scheme-of-things" explanation somewhere about what we're doing
with the FPU context.

Figuring out what exactly to do in which context should be easier then.
I hope.

> I can forward you the IRC pieces offlist if you like. He said I can
> remove it if there are no users and I am not aware of any. He pointed
> out that sched_wakeup had a "success" member which was relied on by
> tools so it remained in order not to break them. So we have
> 	__entry->success        = 1; /* rudiment, kill when possible */
> 
> in the tree now. I can loop him in if this is not enough.

So you're replacing the old member with the new, AFAICT and I guess
that doesn't change offsets so even tools which don't use libtraceevent
should be fine but we better make sure before we break userspace because
we don't break userpace :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
