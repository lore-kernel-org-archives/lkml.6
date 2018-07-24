Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74634ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3FF20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHWrDD+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3FF20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbeGXQWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:22:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38431 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388298AbeGXQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:22:19 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so4177696itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h8Ma4tYq2JIPzfnTuIfw2xwco7Df0iF3S4YCgAwc7xw=;
        b=DHWrDD+k1YB2dInv5p9oWEjSLgrdWYYEK8FQcu6rcsXcNkC0vOgEb5OPV0QZkyCnCc
         Xs5TbPFj0Oviqx4j5xq4khDp7jmc+wr75HAMPhrG7wvBrQZClqbDlchHTPzeJ9eBVkvV
         gLZwTiigZYR/CMlhDaGUPHXX1AQbDdsOvNz34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h8Ma4tYq2JIPzfnTuIfw2xwco7Df0iF3S4YCgAwc7xw=;
        b=cHSeFQxoXnwRHDIC2IXf42QFzp4TVBE9m9qfedUfFnL6Z1a4wiRWXRzgjaFcWRWeNq
         xne+fsT2gAz0VYDurtPFYCydoeaohonJZQ7dBuNhiLrsZc19fNiPxoZGy0LeSbWDvfd6
         UO/9Dgz1E5jFcHXrzThBnBIgm2ZEdLexV2KugBWggsArawA9q5GC5b6v0FWHe9dikfPU
         /GVNhbUgiNz/F83f75GxXHfsvcjlUOOPsStYuFxTdsi/pDv4ilkMvkMTXSqjjGIir2XA
         W+2yKY3Iq7Nzew86lFMQUxUpBhxrOYPM1M8xRrS9F/OZE06JL+KNcjQD6Qs4NuyCIPf6
         z5RQ==
X-Gm-Message-State: AOUpUlHRGzH7rpKndb2aDO3qLz14AB0zS6YdSwegEY9VQS2fSHgFygqX
        AFzm7bina0/w3SDbLJ7Te+gG2JaBuFMoM4miWlx+nQ==
X-Google-Smtp-Source: AAOMgpcxnC4Rj/Gu7X52DnDDVpXyf6miI0+n37mCEPHog9FxiREwfVaOqrxhJT3o6Q5ZXRj4YhEq3tDNJYfrHtwri1M=
X-Received: by 2002:a02:a1d9:: with SMTP id o25-v6mr16034740jah.86.1532445321369;
 Tue, 24 Jul 2018 08:15:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 08:15:20
 -0700 (PDT)
In-Reply-To: <20180724144522.GA4240@e103592.cambridge.arm.com>
References: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home> <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home> <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home> <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com> <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180718092448.v6j7wdahtsediqhh@linutronix.de> <20180724144522.GA4240@e103592.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 24 Jul 2018 17:15:20 +0200
Message-ID: <CAKv+Gu_WdooOKAvqBJCespZmYYNLcmYsy2cxJ-MP4pjKhPaqrw@mail.gmail.com>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to local_bh_disable()
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 July 2018 at 16:45, Dave Martin <Dave.Martin@arm.com> wrote:
> On Wed, Jul 18, 2018 at 11:24:48AM +0200, Sebastian Andrzej Siewior wrote:
>> On 2018-07-18 11:12:10 [+0200], To Dave Martin wrote:
>> > > > -       if (may_use_simd()) {
>> > > > +       if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && may_use_simd()) {
>> > >
>> > > I suspect this is wrong -- see comments on the commit message.
>>
>> I'm sorry, I pressed send too early, I was aiming for the draft folder.
>> So yes, based on that EFI that might be interruptible, let me try to
>> look at the initial issue again and maybe I get another idea how to deal
>> with this.
>> One question: If EFI is interruptible that means, we call into EFI - how
>> do we get out? Does EFI enable interrupts and the kernel receives an
>> interrupt and treats this EFI call like a regular context switch?
>
> AFAIK the only safe way to get out permanently is for the call to
> return.  Note, I've not gone through the spec in fine detail myself.
>
> The OS may handle interrupts occurring during the EFI call, but we
> still have to return to EFI afterwards to finish off the call.  From
> the Linux perspective, I think this means that EFI calls are non-
> preemptible.
>
> Under RT, I'm pretty sure that we can't safely resume the interrupted
> EFI call on a different cpu from the one it was interrupted on.  Even
> if it doesn't say this explicitly in the UEFI spec, I think it will be
> assumed in implementations.
>

This is a can of worms I would rather not open, although I don't think
the UEFI spec makes it explicit that you cannot migrate runtime
service calls while in progress.

Also, I don't think EFI calls are worth obsessing about, given that
they shouldn't be that common under normal operation. I know that RT
is not about the common case but about the worst case, though. What
problem is migrating a non-preemptible task intended to solve?

>
> Certain EFI calls are not long-running and may need to be called from
> interrupt context in Linux,

This suggests that the need to be called in interrupt context is a
property of the firmware implementation but it is not.

In the kernel, we have efi-pstore which may attempt to invoke runtime
services to record the kernel's dying gasp into a EFI variable. Other
than that, I don't think there are any reasons to call EFI services
from non-process context.

> which means that there may be live kernel-
> mode NEON state.  This is why there are separate FPSIMD/SVE percpu stash
> buffers for EFI specifically.
>

So given the above, and the fact that you can panic() in an interrupt
handler, we needed those buffers, although I wonder if we'd ever reach
the point where we end up resuming execution of the code that uses the
restored contents of those buffers.

> Does this make sense?  It's is probably not very clear, but I'm trying
> to hide the fact that I haven't looked at the UEFI spec for ages...
>
> Cheers
> ---Dave
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
