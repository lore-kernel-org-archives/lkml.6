Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C196C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E430320868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zaH7D6hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E430320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeK2RLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:11:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbeK2RLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:11:19 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EBB02147C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471626;
        bh=qBhGs5+dFtZOHYuy7lvRQp2lSvzZtBEGEVmFofzHeM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zaH7D6hnTAOrc8Sd/oTcCQmO5Qz/b/jHSzggAayLR6ZTe9sKDpOaOGHfublg3SF0c
         Ij5eswjLjEsaXW/LXFWRsCmVAbDaOY/w5bhJucQbsmK+W9qHnReON9tJ7FyFx3rqG3
         3rPfnpTqcZqdHV+465ZB8T/pINw1a3jgZs1HRqe0=
Received: by mail-wm1-f50.google.com with SMTP id y185so5559151wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 22:07:06 -0800 (PST)
X-Gm-Message-State: AA+aEWa45SOsig2xdzPA7cUKutVg584dIIRm4tB099PZ2L0GS23peY88
        mUvsCP4TJUu4skw0+/gYNwna8ZzJMsg91LpBFRTwYQ==
X-Google-Smtp-Source: AFSGD/UJdiibkvAYpg8Prd4o3kXBPx23gY7icmbOBspR0Sc1aCwmYb4byA7oNUMJbZquOmmCJ2Yh/46WhEej/LOd4BY=
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr436643wme.108.1543471624564;
 Wed, 28 Nov 2018 22:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20181018005420.82993-1-namit@vmware.com> <20181128160849.epmoto4o5jaxxxol@treble>
 <9EACED43-EC21-41FB-BFAC-4E98C3842FD9@vmware.com> <20181129003837.6lgxsnhoyipkebmz@treble>
 <CALCETrUfC37TxuYLgqbN3_pZ1RzfpV03byKMpSt87o+JHtk6FQ@mail.gmail.com>
 <0E75C656-18BF-4967-98A3-35E0BD83D603@vmware.com> <4CD1975E-3B15-4B9C-B2A9-2E5F72E1D95F@amacapital.net>
In-Reply-To: <4CD1975E-3B15-4B9C-B2A9-2E5F72E1D95F@amacapital.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Nov 2018 22:06:52 -0800
X-Gmail-Original-Message-ID: <CALCETrWN5QenBqNpLZ3EWEF2XFje3HGubzck4AEFePCspM6mGQ@mail.gmail.com>
Message-ID: <CALCETrWN5QenBqNpLZ3EWEF2XFje3HGubzck4AEFePCspM6mGQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] x86: dynamic indirect call promotion
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
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

On Wed, Nov 28, 2018 at 7:24 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
>
> On Nov 28, 2018, at 6:06 PM, Nadav Amit <namit@vmware.com> wrote:
>
> >> On Nov 28, 2018, at 5:40 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >>
> >>> On Wed, Nov 28, 2018 at 4:38 PM Josh Poimboeuf <jpoimboe@redhat.com> =
wrote:
> >>> On Wed, Nov 28, 2018 at 07:34:52PM +0000, Nadav Amit wrote:
> >>>>> On Nov 28, 2018, at 8:08 AM, Josh Poimboeuf <jpoimboe@redhat.com> w=
rote:
> >>>>>
> >>>>>> On Wed, Oct 17, 2018 at 05:54:15PM -0700, Nadav Amit wrote:
> >>>>>> This RFC introduces indirect call promotion in runtime, which for =
the
> >>>>>> matter of simplification (and branding) will be called here "relpo=
lines"
> >>>>>> (relative call + trampoline). Relpolines are mainly intended as a =
way
> >>>>>> of reducing retpoline overheads due to Spectre v2.
> >>>>>>
> >>>>>> Unlike indirect call promotion through profile guided optimization=
, the
> >>>>>> proposed approach does not require a profiling stage, works well w=
ith
> >>>>>> modules whose address is unknown and can adapt to changing workloa=
ds.
> >>>>>>
> >>>>>> The main idea is simple: for every indirect call, we inject a piec=
e of
> >>>>>> code with fast- and slow-path calls. The fast path is used if the =
target
> >>>>>> matches the expected (hot) target. The slow-path uses a retpoline.
> >>>>>> During training, the slow-path is set to call a function that save=
s the
> >>>>>> call source and target in a hash-table and keep count for call
> >>>>>> frequency. The most common target is then patched into the hot pat=
h.
> >>>>>>
> >>>>>> The patching is done on-the-fly by patching the conditional branch
> >>>>>> (opcode and offset) that is used to compare the target to the hot
> >>>>>> target. This allows to direct all cores to the fast-path, while pa=
tching
> >>>>>> the slow-path and vice-versa. Patching follows 2 more rules: (1) O=
nly
> >>>>>> patch a single byte when the code might be executed by any core. (=
2)
> >>>>>> When patching more than one byte, ensure that all cores do not run=
 the
> >>>>>> to-be-patched-code by preventing this code from being preempted, a=
nd
> >>>>>> using synchronize_sched() after patching the branch that jumps ove=
r this
> >>>>>> code.
> >>>>>>
> >>>>>> Changing all the indirect calls to use relpolines is done using as=
sembly
> >>>>>> macro magic. There are alternative solutions, but this one is
> >>>>>> relatively simple and transparent. There is also logic to retrain =
the
> >>>>>> software predictor, but the policy it uses may need to be refined.
> >>>>>>
> >>>>>> Eventually the results are not bad (2 VCPU VM, throughput reported=
):
> >>>>>>
> >>>>>>          base            relpoline
> >>>>>>          ----            ---------
> >>>>>> nginx      22898           25178 (+10%)
> >>>>>> redis-ycsb 24523           25486 (+4%)
> >>>>>> dbench     2144            2103 (+2%)
> >>>>>>
> >>>>>> When retpolines are disabled, and if retraining is off, performanc=
e
> >>>>>> benefits are up to 2% (nginx), but are much less impressive.
> >>>>>
> >>>>> Hi Nadav,
> >>>>>
> >>>>> Peter pointed me to these patches during a discussion about retpoli=
ne
> >>>>> profiling.  Personally, I think this is brilliant.  This could help
> >>>>> networking and filesystem intensive workloads a lot.
> >>>>
> >>>> Thanks! I was a bit held-back by the relatively limited number of re=
sponses.
> >>>
> >>> It is a rather, erm, ambitious idea, maybe they were speechless :-)
> >>>
> >>>> I finished another version two weeks ago, and every day I think: "sh=
ould it
> >>>> be RFCv2 or v1=E2=80=9D, ending up not sending it=E2=80=A6
> >>>>
> >>>> There is one issue that I realized while working on the new version:=
 I=E2=80=99m not
> >>>> sure it is well-defined what an outline retpoline is allowed to do. =
The
> >>>> indirect branch promotion code can change rflags, which might cause
> >>>> correction issues. In practice, using gcc, it is not a problem.
> >>>
> >>> Callees can clobber flags, so it seems fine to me.
> >>
> >> Just to check I understand your approach right: you made a macro
> >> called "call", and you're therefore causing all instances of "call" to
> >> become magic?  This is... terrifying.  It's even plausibly worse than
> >> "#define if" :)  The scariest bit is that it will impact inline asm as
> >> well.  Maybe a gcc plugin would be less alarming?
> >
> > It is likely to look less alarming. When I looked at the inline retpoli=
ne
> > implementation of gcc, it didn=E2=80=99t look much better than what I d=
id - it
> > basically just emits assembly instructions.
>
> To be clear, that wasn=E2=80=99t a NAK.  It was merely a =E2=80=9Cthis is=
 alarming.=E2=80=9D

Although... how do you avoid matching on things that really don't want
this treatment?  paravirt ops come to mind.
