Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBCEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7851020832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxdXc0lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7851020832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeK2MoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbeK2MoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:44:08 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1962A20832
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543455630;
        bh=WFx/PkQAwcK4uTa0v16fHa7h5dbIQGv9lyyvSqwN9Os=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DxdXc0lgmwnQYdhDzaY6sGq+2xdaRf2tsW9aaGMtb1WomgwAFWf5DzBfVMQMoVrFm
         0er/8GDsBsVnbZVVf91mDMFgF80z2JyZQ06sf3uPNHfuB4dSQ277B18uradZT0xt5Y
         60iYbCPLs8bm7DC9VpS5+tj5OSyBAsI324aFMmao=
Received: by mail-wm1-f41.google.com with SMTP id z18so568473wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 17:40:30 -0800 (PST)
X-Gm-Message-State: AA+aEWZocBp93PO7kciwvrMSSHzmskdQu25m/02OVRGUzGwobnftl0tT
        Knv1HPJb6Zx9jkgbQis9UN4PU6YPZiaowCBkTx0NMA==
X-Google-Smtp-Source: AFSGD/XK9cvU0ZXHgQhz/TUtUcxa7puTu3fmT1y4gF9lWE+Z6cONBpe7NHgxwqQz9mNUXrWwlgJ5D6jFj2OqTOoi9xY=
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr5119089wmc.74.1543455628557;
 Wed, 28 Nov 2018 17:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20181018005420.82993-1-namit@vmware.com> <20181128160849.epmoto4o5jaxxxol@treble>
 <9EACED43-EC21-41FB-BFAC-4E98C3842FD9@vmware.com> <20181129003837.6lgxsnhoyipkebmz@treble>
In-Reply-To: <20181129003837.6lgxsnhoyipkebmz@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Nov 2018 17:40:16 -0800
X-Gmail-Original-Message-ID: <CALCETrUfC37TxuYLgqbN3_pZ1RzfpV03byKMpSt87o+JHtk6FQ@mail.gmail.com>
Message-ID: <CALCETrUfC37TxuYLgqbN3_pZ1RzfpV03byKMpSt87o+JHtk6FQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] x86: dynamic indirect call promotion
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 4:38 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Nov 28, 2018 at 07:34:52PM +0000, Nadav Amit wrote:
> > > On Nov 28, 2018, at 8:08 AM, Josh Poimboeuf <jpoimboe@redhat.com> wro=
te:
> > >
> > > On Wed, Oct 17, 2018 at 05:54:15PM -0700, Nadav Amit wrote:
> > >> This RFC introduces indirect call promotion in runtime, which for th=
e
> > >> matter of simplification (and branding) will be called here "relpoli=
nes"
> > >> (relative call + trampoline). Relpolines are mainly intended as a wa=
y
> > >> of reducing retpoline overheads due to Spectre v2.
> > >>
> > >> Unlike indirect call promotion through profile guided optimization, =
the
> > >> proposed approach does not require a profiling stage, works well wit=
h
> > >> modules whose address is unknown and can adapt to changing workloads=
.
> > >>
> > >> The main idea is simple: for every indirect call, we inject a piece =
of
> > >> code with fast- and slow-path calls. The fast path is used if the ta=
rget
> > >> matches the expected (hot) target. The slow-path uses a retpoline.
> > >> During training, the slow-path is set to call a function that saves =
the
> > >> call source and target in a hash-table and keep count for call
> > >> frequency. The most common target is then patched into the hot path.
> > >>
> > >> The patching is done on-the-fly by patching the conditional branch
> > >> (opcode and offset) that is used to compare the target to the hot
> > >> target. This allows to direct all cores to the fast-path, while patc=
hing
> > >> the slow-path and vice-versa. Patching follows 2 more rules: (1) Onl=
y
> > >> patch a single byte when the code might be executed by any core. (2)
> > >> When patching more than one byte, ensure that all cores do not run t=
he
> > >> to-be-patched-code by preventing this code from being preempted, and
> > >> using synchronize_sched() after patching the branch that jumps over =
this
> > >> code.
> > >>
> > >> Changing all the indirect calls to use relpolines is done using asse=
mbly
> > >> macro magic. There are alternative solutions, but this one is
> > >> relatively simple and transparent. There is also logic to retrain th=
e
> > >> software predictor, but the policy it uses may need to be refined.
> > >>
> > >> Eventually the results are not bad (2 VCPU VM, throughput reported):
> > >>
> > >>            base            relpoline
> > >>            ----            ---------
> > >> nginx      22898           25178 (+10%)
> > >> redis-ycsb 24523           25486 (+4%)
> > >> dbench     2144            2103 (+2%)
> > >>
> > >> When retpolines are disabled, and if retraining is off, performance
> > >> benefits are up to 2% (nginx), but are much less impressive.
> > >
> > > Hi Nadav,
> > >
> > > Peter pointed me to these patches during a discussion about retpoline
> > > profiling.  Personally, I think this is brilliant.  This could help
> > > networking and filesystem intensive workloads a lot.
> >
> > Thanks! I was a bit held-back by the relatively limited number of respo=
nses.
>
> It is a rather, erm, ambitious idea, maybe they were speechless :-)
>
> > I finished another version two weeks ago, and every day I think: "shoul=
d it
> > be RFCv2 or v1=E2=80=9D, ending up not sending it=E2=80=A6
> >
> > There is one issue that I realized while working on the new version: I=
=E2=80=99m not
> > sure it is well-defined what an outline retpoline is allowed to do. The
> > indirect branch promotion code can change rflags, which might cause
> > correction issues. In practice, using gcc, it is not a problem.
>
> Callees can clobber flags, so it seems fine to me.

Just to check I understand your approach right: you made a macro
called "call", and you're therefore causing all instances of "call" to
become magic?  This is... terrifying.  It's even plausibly worse than
"#define if" :)  The scariest bit is that it will impact inline asm as
well.  Maybe a gcc plugin would be less alarming?

> >
> > 1. An indirect branch inside the BP handler might be the one we patch
>
> I _think_ nested INT3s should be doable, because they don't use IST.
> Maybe Andy can clarify.

int3 should survive recursion these days.  Although I admit I'm
currently wondering what happens if one thread puts a kprobe on an
address that another thread tries to text_poke.

Also, this relpoline magic is likely to start patching text at runtime
on a semi-regular basis.  This type of patching is *slow*.  Is it a
problem?

> > 2. An indirect branch inside an interrupt or NMI handler might be the
> >    one we patch
>
> But INT3s just use the existing stack, and NMIs support nesting, so I'm
> thinking that should also be doable.  Andy?
>

In principle, as long as the code isn't NOKPROBE_SYMBOL-ified, we
should be fine, right?  I'd be a little nervous if we get an int3 in
the C code that handles the early part of an NMI from user mode.  It's
*probably* okay, but one of the alarming issues is that the int3
return path will implicitly unmask NMI, which isn't fantastic.  Maybe
we finally need to dust off my old "return using RET" code to get rid
of that problem.
