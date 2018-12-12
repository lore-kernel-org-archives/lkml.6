Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D079AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F3D2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eyBJsRCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F3D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeLLSpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:45:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbeLLSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:45:08 -0500
Received: from zn.tnic (p200300EC2BCDD8007CFD4A6887308591.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:d800:7cfd:4a68:8730:8591])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09D3C1EC0AC4;
        Wed, 12 Dec 2018 19:45:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544640307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8EEzVwbJSnq5zQmBptdnyW9u44R7hAzK9i+qfnnKTGw=;
        b=eyBJsRCqvI3mxrz1tUxS6JQiaugEEY/B3d6WkEpZIFdZfYcwY0R5FZMXqiZ0PhWPsl+Ois
        VYR6Gx8+OJ2cQMpZmWx/uHwIn57Nez0Knk6BAAFhzEdYAO3KCOpT6KHlnSgFO1gxBXE8ku
        FxpKuRHeeuX60C7X2pL/Tw2bC8+Fm1E=
Date:   Wed, 12 Dec 2018 19:44:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tom Lendacky <Thomas.Lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Message-ID: <20181212184459.GE6653@zn.tnic>
References: <20181211222326.14581-1-bp@alien8.de>
 <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
 <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
 <20181212100814.GB6653@zn.tnic>
 <CALCETrWSG5825HrxwEJGqbSoRz=A_2O-GSBD+K_q9YPHu2TB6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWSG5825HrxwEJGqbSoRz=A_2O-GSBD+K_q9YPHu2TB6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:07:03AM -0800, Andy Lutomirski wrote:
> You're proving my point, I think.  CPUID, IRET, MOV to CR, etc are
> "serializing".  LFENCE, on many CPUd and depending on MSRs, is a
> different kind of serializing.  MFENCE is something else.  All LOCK
> instructions are some kind of barrier, but I don't think anyone calls
> them "serializing".

Yeah, peterz and I hashed it out a bit today on IRC about the different
meanings of serializing. I see your point now.

> The uaccess users of barrier_nospec() are presumably looking for a
> speculation barrier in the sense of "CPU, please don't execute the
> code after this until you're sure that this code should be executed
> for real and until all inputs are known, not guessed."

Yeah, I believe AMD's paper has this nicely written:

"MITIGATION G-2

Description: Set an MSR in the processor so that LFENCE is a dispatch
serializing instruction and then use LFENCE in code streams to
serialize dispatch (LFENCE is faster than RDTSCP which is also dispatch
serializing). This mode of LFENCE may be enabled by setting MSR
C001_1029[1]=1.

Effect: Upon encountering an LFENCE when the MSR bit is set, dispatch
will stop until the LFENCE instruction becomes the oldest instruction in
the machine."

https://developer.amd.com/wp-content/resources/90343-B_SoftwareTechniquesforManagingSpeculation_WP_7-18Update_FNL.pdf

which is basically what you want for the whole mitigation crap if you
want to kill speculation - you simply hold dispatch until the LFENCE
retires.

> The property I want for RDTSC ordering is much weaker: I want it to be
> ordered like a load.  Imagine that, instead of an on-chip TSC, the TSC
> is literally a location in main memory that gets incremented by an
> extra dedicated CPU every nanosecond or so.  I want users of RDTSC to
> work as if they were reading such a location in memory using an
> ordinary load.  I believe this gives the real desired property that it
> should be impossible to observe the TSC going backwards.  This is a
> much weaker form of serialization.

Well, in that case you need something new.

Because, the moment you have a RDTSC in flight and a second RDTSC comes
in and that second RDTSC must *not* bypass the first one and execute
earlier due to OoO, you need to impose some ordering. And that's pretty
much uarch-dependent, I'd say.

And I guess on AMD the way to do that is to stop dispatch until the
first RDTSC retires.

Can it be done faster? Sure. And I'm pretty sure there's a lot of pesky
little hw details we're not even hearing of, which get in the way.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
