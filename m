Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64853C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D74A205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vN4RZ/39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D74A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeK2WwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:52:25 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57621 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeK2WwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:52:25 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wATBlBvr016243;
        Thu, 29 Nov 2018 20:47:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wATBlBvr016243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543492032;
        bh=LjdfDPbnmz4VV5cNPPitHindzrHkJCEMqaI1B72Emm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vN4RZ/39OUGIwY4sO9yrYESTBSQorKUdHTkphghOnAjfBiqtQzT6A9NS/lIqiEDnf
         TIGiFIYlNW3VRj6qC4FJapF859FPeYFkHNaRL1EC7Kf6HPcVFAcuxGL37TAlwYL3rb
         9kFMn4P/G9z8HPChhznN9juXEcgvzDMODXAw9nyKdy6g8i3Mj13MIfJIwTcRXIDlMM
         +f9diXC/wXjUihNq+CqhIomfcR9YTC2H7qithnPFg17P+UZfLs6j1M32szzZZoMUio
         eGRvrmUQ5r6RchB5C6WqbM4wgf1WPhgFGEE6iubt8GDL4f9prMV+JHUInZJE1kSN2X
         V8s06IUVY8i6A==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id e7so952162vsc.2;
        Thu, 29 Nov 2018 03:47:11 -0800 (PST)
X-Gm-Message-State: AA+aEWbvyl/kRYh09f+t2vX7AsdlMtJgEQhSNDSJCO5u2bqiZZCYAy18
        2OTiNJ7a0PlMC2o91nNO7YqHZDnAlOM302+fC7o=
X-Google-Smtp-Source: AFSGD/X3n/GDOUB8HeHslwf+rQXFcSWMAq3opoZjZRd0j3sEU7f7dBrcuMg92k7kH9iAGRZmjMfT7f7cz8VnJ2s67Zs=
X-Received: by 2002:a67:485:: with SMTP id 127mr471709vse.54.1543492030904;
 Thu, 29 Nov 2018 03:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
 <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org>
In-Reply-To: <20181009145330.GT29268@gate.crashing.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 29 Nov 2018 20:46:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com>
Message-ID: <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     rguenther@suse.de, matz@suse.de, Borislav Petkov <bp@alien8.de>,
        gcc@gcc.gnu.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


On Wed, Oct 10, 2018 at 1:14 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Mon, Oct 08, 2018 at 11:07:46AM +0200, Richard Biener wrote:
> > On Mon, 8 Oct 2018, Segher Boessenkool wrote:
> > > On Sun, Oct 07, 2018 at 03:53:26PM +0000, Michael Matz wrote:
> > > > On Sun, 7 Oct 2018, Segher Boessenkool wrote:
> > > > > On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> > > > > > Now, Richard suggested doing something like:
> > > > > >
> > > > > >  1) inline asm ("...")
> > > > >
> > > > > What would the semantics of this be?
> > > >
> > > > The size of the inline asm wouldn't be counted towards the inliner size
> > > > limits (or be counted as "1").
> > >
> > > That sounds like a good option.
> >
> > Yes, I also like it for simplicity.  It also avoids the requirement
> > of translating the number (in bytes?) given by the user to
> > "number of GIMPLE instructions" as needed by the inliner.
>
> This patch implements this, for C only so far.  And the syntax is
> "asm inline", which is more in line with other syntax.
>
> How does this look?


Thank you very much for your work.


https://gcc.gnu.org/ml/gcc-patches/2018-10/msg01932.html

How is the progress of this in GCC ML?



I am really hoping the issue will be solved by compiler
instead of the in-kernel workaround.


Since commit 77b0bf55bc675233d22cd5df97605d516d64525e,
DISTCC breakage was reported.


Then, another problem showed up.

Debian linux-headers package is broken
due to missing arch/x86/kernel/macros.s

https://www.spinics.net/lists/linux-kbuild/msg20037.html

The kernel-devel RPM package is broken as well.

More fundamentally, the external module building itself is broken;
'make clean' must keep all files needed for external modules, but
*.s files are all gone.


Of course, we can fix the problems at the cost of uglifying Makefiles.
I wrote a patch to fix the external module building
and packages, and now have it in hand locally.


But, I'd like to ask if x86 people want to keep this macros.s approach.
Revert 77b0bf55bc675 right now
assuming the compiler will eventually solve the issue?

Do you have ideas? Comments?


-- 
Best Regards
Masahiro Yamada
