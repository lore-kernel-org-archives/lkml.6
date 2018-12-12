Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24573C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0822086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uioW8YZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0822086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeLLJ7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:59:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeLLJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pnDuDZnfGwmCzOV6ZdJiUaMvrXVP1vK8421th7bqroQ=; b=uioW8YZjoJGbNf0pHUj/+cU2DE
        uFW7dCeXD8qsvTYmQ2e9z3iAmdWdrF7NI6pSAE4Utf9fUIHJWa6PxK5ncBoPAO7Zyq3Hs5x6/0bK9
        eVeJs6rM0tQHO67RrQSjDlxoXhag/lvxMiZsuKemlzj1SkLKtnipYUCIoKok0TRYtQk6K2dz+1D/d
        5qDaalfvoXZujmgqzbbVqWqy2VrotMoj+kKCacHSGjomUaLSQJq6uMiBFHLnWy/eoTJzB2uOoZZzQ
        wwZPjz2oVNKJkOrOjwb1wr3wHHgiAQ1+cPgv26Lx6u/bhpftItVCuXcCh7JgRDcgn9YoGhDShn872
        ySl1SXGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gX1IP-0006tG-CY; Wed, 12 Dec 2018 09:59:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 286EE2075BF3B; Wed, 12 Dec 2018 10:59:12 +0100 (CET)
Date:   Wed, 12 Dec 2018 10:59:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Message-ID: <20181212095912.GX5289@hirez.programming.kicks-ass.net>
References: <20181211222326.14581-1-bp@alien8.de>
 <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
 <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 06:24:44PM -0800, Andy Lutomirski wrote:
> > On Dec 11, 2018, at 3:39 PM, Borislav Petkov <bp@alien8.de> wrote:
> >
> >> On Tue, Dec 11, 2018 at 11:12:41PM +0000, Lendacky, Thomas wrote:
> >> It does seem overloaded in that sense, but the feature means that LFENCE
> >> is serializing and so can be used in rdtsc_ordered. In the same sense,
> >> barrier_nospec is looking for whether LFENCE is serializing and preferring
> >> that over MFENCE since it is lighter weight.
> >>
> >> In light of how they're being used now, they could probably stand to be
> >> renamed in some way.
> >
> > Actually, come to think of it, what really matters here is whether
> > LFENCE is serializing or not. Because if so, you wanna replace with LFENCE
> > as it is lighter. And in that case a single alternative() - not _2() -
> > should suffice.
> >
> > BUT(!), that still is not good enough if you do some qemu CPU models
> > like pentium or so which don't even have MFENCE and cause stuff like
> > this:
> >
> > https://lkml.kernel.org/r/20181123200307.GA6223@roeck-us.net
> >
> > Which means, that you *do* have to alternate between
> >
> > * no insn at all
> > * MFENCE
> > * LFENCE, if it is serializing
> >
> > so barrier_nospec() does the right thing, AFAICS. And this is why we
> > need an ALTERNATIVE_3() to add RDTSCP into the mix too.
> >
> > WRT renaming, I guess we can do something like:
> >
> > * X86_FEATURE_MFENCE_RDTSC -> X86_FEATURE_MFENCE - to mean that CPU has
> > MFENCE support.
> >
> > and
> >
> > * X86_FEATURE_LFENCE_RDTSC -> X86_FEATURE_LFENCE_SERIALIZING
> >
> > Or something to that effect.
> 
> This makes me nervous, since no one knows what “serializing” means.
> IIRC AMD specifically documents that MFENCE is required before RDTSC
> to get sensible ordering.  So it’s entirely plausible to me that
> LFENCE is okay for Spectre mitigation but MFENCE is needed for RDTSC
> on some CPU.

What we want is IFENCE, an instruction that flushes the complete
pipeline. Or alternatively put: holds completion until all prior issued
instructions complete.

MFENCE always did that (and a ton more), LFENCE seems to have always
done that on Intel, but AMD at some point actually implemented LFENCE as
it was specified (only hold completion until all preceding loads are
complete) and they (now) have this MSR bit to 'fix' that.

At some point in the past (when all this spectre LFENCE muck was
relatively fresh) I suggested we call the thing: instruction_fence() or
something like that, maybe we ought to still do that now.

Re RDTSC, waiting for all preceding instructions to complete is
'obviously' sufficient for two RDTSC instructions not to get re-ordered
either.
