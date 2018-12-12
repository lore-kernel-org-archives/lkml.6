Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF84E2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kEj7JupK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF84E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeLLMCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:02:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41543 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeLLMCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:02:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so15317902edi.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5A6bzygKyti5SZKp8ifIunM0sIffBNfZvrKZrKiLvD8=;
        b=kEj7JupKx0+6IfDRjPW5C3AcuoskoQr722QxAAna2/IJ5rLYkveB0eC3uBvgD1tfaz
         /X5VV2PEQ92qApIUJY3BsZY08HoVODE1bMt1vBZ3L/dIijmHq+ompmYXc9wplYvjZwwx
         OP9C6kk3mR6FWGxLOU+cM8H6jaNSa11D1taDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5A6bzygKyti5SZKp8ifIunM0sIffBNfZvrKZrKiLvD8=;
        b=UYhWrNZjsynHXVk4/kQ1Wq7l6W/m3UREwdofYtge8Gr2053/M5u698SG536pPOELLb
         FXL5xHX3+2GxV/YfQvWStzL4DmKMBvONsZYc/VdQnvQoBm7Tu0BmDcJLFny01Bkn/LO7
         nOgrbt8ofFL9aZLvr6tZdsKfEn+9oZxOH1Q1WC9yhPCkMeFZO68FGe4uydKO3I5PJXEs
         37BSCrw4BsiswsV17YVbJsM2Py5uXAUDXtjeUCJzcBZ2f2yk/RD89dkEjJt1qguFCq5w
         wJxGwcvkLubxS8P/nQ3KRnAy2ImuUUXoTXN+8tcRJmLIn5xxfvfzwPzNW3+5AGdQw3xg
         P1OQ==
X-Gm-Message-State: AA+aEWbQ0aEFSoHzdEWvGGddSsYU+vWGSqMLo6aFRdipfYQomVbnw9Is
        uAYC3/BaaNDsymGqL/pvh26ZHMZ4Gxtmrw==
X-Google-Smtp-Source: AFSGD/X/T/mchWht0Rn9fvnujrIjz16pJASbDxk2cX+4I4VW5HXnzaQJzDkO4/pgWOSc06Zid8xwfQ==
X-Received: by 2002:a17:906:5fd5:: with SMTP id k21-v6mr15381127ejv.10.1544616140365;
        Wed, 12 Dec 2018 04:02:20 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id l51sm5033083edb.36.2018.12.12.04.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 04:02:19 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:02:12 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Message-ID: <20181212120212.GA9212@andrea>
References: <20181211222326.14581-1-bp@alien8.de>
 <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
 <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
 <20181212095912.GX5289@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212095912.GX5289@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:59:12AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 11, 2018 at 06:24:44PM -0800, Andy Lutomirski wrote:
> > > On Dec 11, 2018, at 3:39 PM, Borislav Petkov <bp@alien8.de> wrote:
> > >
> > >> On Tue, Dec 11, 2018 at 11:12:41PM +0000, Lendacky, Thomas wrote:
> > >> It does seem overloaded in that sense, but the feature means that LFENCE
> > >> is serializing and so can be used in rdtsc_ordered. In the same sense,
> > >> barrier_nospec is looking for whether LFENCE is serializing and preferring
> > >> that over MFENCE since it is lighter weight.
> > >>
> > >> In light of how they're being used now, they could probably stand to be
> > >> renamed in some way.
> > >
> > > Actually, come to think of it, what really matters here is whether
> > > LFENCE is serializing or not. Because if so, you wanna replace with LFENCE
> > > as it is lighter. And in that case a single alternative() - not _2() -
> > > should suffice.
> > >
> > > BUT(!), that still is not good enough if you do some qemu CPU models
> > > like pentium or so which don't even have MFENCE and cause stuff like
> > > this:
> > >
> > > https://lkml.kernel.org/r/20181123200307.GA6223@roeck-us.net
> > >
> > > Which means, that you *do* have to alternate between
> > >
> > > * no insn at all
> > > * MFENCE
> > > * LFENCE, if it is serializing
> > >
> > > so barrier_nospec() does the right thing, AFAICS. And this is why we
> > > need an ALTERNATIVE_3() to add RDTSCP into the mix too.
> > >
> > > WRT renaming, I guess we can do something like:
> > >
> > > * X86_FEATURE_MFENCE_RDTSC -> X86_FEATURE_MFENCE - to mean that CPU has
> > > MFENCE support.
> > >
> > > and
> > >
> > > * X86_FEATURE_LFENCE_RDTSC -> X86_FEATURE_LFENCE_SERIALIZING
> > >
> > > Or something to that effect.
> > 
> > This makes me nervous, since no one knows what “serializing” means.
> > IIRC AMD specifically documents that MFENCE is required before RDTSC
> > to get sensible ordering.  So it’s entirely plausible to me that
> > LFENCE is okay for Spectre mitigation but MFENCE is needed for RDTSC
> > on some CPU.
> 
> What we want is IFENCE, an instruction that flushes the complete
> pipeline. Or alternatively put: holds completion until all prior issued
> instructions complete.
> 
> MFENCE always did that (and a ton more), LFENCE seems to have always
> done that on Intel, but AMD at some point actually implemented LFENCE as
> it was specified (only hold completion until all preceding loads are
> complete) and they (now) have this MSR bit to 'fix' that.

For the record, the "Software techniques for managing speculation on AMD
processors" white paper states:

  "Instructions that cause the machine to temporarily stop inserting
   new instructions into the machine for execution and wait for
   execution of older instructions to finish are referred to as
   dispatch serializing instructions."

and

  "MITIGATION G-2										

   Description: Set an MSR in the processor so that LFENCE is a
   dispatch serializing instruction and then use LFENCE in code
   streams to serialize dispatch (LFENCE is faster than RDTSCP which
   is also dispatch serializing). This mode of LFENCE may be enabled
   by setting MSR C001_1029[1]=1.

   Effect: Upon encountering an LFENCE when the MSR bit is set,
   dispatch will stop until the LFENCE instruction becomes the oldest
   instruction in the machine.

   Applicability: All AMD family 10h/12h/14h/15h/16h/17h processors
   support this MSR. LFENCE support is indicated by CPUID function1
   EDX bit 26, SSE2. AMD family 0Fh/11h processors support LFENCE as
   serializing always but do not support this MSR. AMD plans support
   for this MSR and access to this bit for all future processors."

I could not find similar information in the AMD APM though; Section 7.6.4
("Serializing Instructions") of this manual describe a different/stronger
notion of "serialization", IIUC.


> 
> At some point in the past (when all this spectre LFENCE muck was
> relatively fresh) I suggested we call the thing: instruction_fence() or
> something like that, maybe we ought to still do that now.

FWIW, I do find the name rdtsc_ordered() as somehow too evocative... ;-)
maybe simply rdtsc_nospec() would be a better choice?

  Andrea


> 
> Re RDTSC, waiting for all preceding instructions to complete is
> 'obviously' sufficient for two RDTSC instructions not to get re-ordered
> either.
