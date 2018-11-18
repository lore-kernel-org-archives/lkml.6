Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14577C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C565F20817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vllnvCb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C565F20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeKROkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:40:22 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:24940 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeKROkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:40:22 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAI4LGuN016166;
        Sun, 18 Nov 2018 13:21:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAI4LGuN016166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542514877;
        bh=YfUrfFwqFWq6r1Qt+5F0HSltn/cAJb+2J8gNubMOHcE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vllnvCb1FqigjGCA7+0wJhv0U90zqu/tQMRW4v/8Yj7afpmngLwgxxInVV3Yye+Hd
         gJLIDMkCoHY+/axZcCkCHLc7UcqweaKV8KfpSNI/LiHx0Ey+V+cFBDxGNTqYd6THAe
         ECjdvY5vw20RlpDVHa+ltxOmxkpOcs1ommzSZ8paNJYfw23JaV56j/KHRmF9jYqS84
         ZLiC6mrhYdYOxXZXHAsDha9yuVXGIQDxkpm8576aIAyThf3OKqyJ49O+SKGi8P6Vn+
         1fFh36UFh/lU23IPQnDuuxEZyWlBcPXEHH+zjKXotUmfbiqeMJJGWCy9pnzXoJYrBJ
         W3L7d5emTZ0wg==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id x64so15963455vsa.5;
        Sat, 17 Nov 2018 20:21:16 -0800 (PST)
X-Gm-Message-State: AGRZ1gLQpiR90YyfZPHIhuDrs2F23veBGouf8YNcnc4ebTImJ8xV390l
        cD2qLq3vKD5g37F6RP7CvVwg9ZCDcW2pvdJOWCk=
X-Google-Smtp-Source: AJdET5fAtTimnvi7g5Z2OdRYbDALxTMpNkHudY5vfjJxq98B3tVGCeUGtk9H6SclA1yq3qvTmAoCIdJAa9qqnJZ8wRQ=
X-Received: by 2002:a67:485:: with SMTP id 127mr7411117vse.54.1542514875811;
 Sat, 17 Nov 2018 20:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20181114204309.18645-1-namit@vmware.com> <20181114204309.18645-2-namit@vmware.com>
 <CAK7LNAREF_Pcejq1LJ=3K7h0M4o4oSRLfbeJc73O+8HV420Ziw@mail.gmail.com> <1C316B94-8F27-439C-B049-9947DC329780@vmware.com>
In-Reply-To: <1C316B94-8F27-439C-B049-9947DC329780@vmware.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 18 Nov 2018 13:20:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFVHnPXh-uEA+T9QNw3OnSvkLLKMuJ_tF1v8bEveStSg@mail.gmail.com>
Message-ID: <CAK7LNATFVHnPXh-uEA+T9QNw3OnSvkLLKMuJ_tF1v8bEveStSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: Fix distcc compilation with x86 macros
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 6:02 AM Nadav Amit <namit@vmware.com> wrote:
>
> From: Masahiro Yamada
> Sent: November 16, 2018 at 7:45:45 AM GMT
> > To: Nadav Amit <namit@vmware.com>
> > Cc: Ingo Molnar <mingo@redhat.com>, Michal Marek <michal.lkml@markovi.n=
et>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, =
H. Peter Anvin <hpa@zytor.com>, X86 ML <x86@kernel.org>, Linux Kbuild maili=
ng list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-ke=
rnel@vger.kernel.org>
> > Subject: Re: [PATCH v2 1/2] Makefile: Fix distcc compilation with x86 m=
acros
> >
> >
> > On Thu, Nov 15, 2018 at 1:01 PM Nadav Amit <namit@vmware.com> wrote:
> >> Introducing the use of asm macros in c-code broke distcc, since it onl=
y
> >> sends the preprocessed source file. The solution is to break the
> >> compilation into two separate phases of compilation and assembly, and
> >> between the two concatenate the assembly macros and the compiled (yet
> >> not assembled) source file. Since this is less efficient, this
> >> compilation mode is only used when distcc or icecc are used.
> >>
> >> Note that the assembly stage should also be distributed, if distcc is
> >> configured using "CFLAGS=3D-DENABLE_REMOTE_ASSEMBLE".
> >>
> >> Reported-by: Logan Gunthorpe <logang@deltatee.com>
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >
> >
> > Wow, this is so ugly.
>
> Indeed, it is not pretty from the Makefile system point of view.
>
> But it does have merits when it comes to the actual use (by developers). =
If
> you look on x86, there are a lot of duplicated implementation for C and A=
sm
> and crazy C macros, for example for PV function call or the alternative
> mechanism. The code is also less readable in its current form.
>
> > I realized how much I hated this by now.
> >
> > My question is, how long do we need to carry this?
>
> If it is purely about performance, I am not sure it would make sense to
> put it in, as it will indeed be (eventually) solved by the compiler, and
> the penalty is not too great.


It is unfortunate to mess up the code
by having two different ways to achieve the same goal.

When GCC with asm inline support is shipped,
would you revert 77b0bf55 ?



> There is also an advantage for having assembly macros that can override t=
he
> generated assembly that was generated by the compiler. I think HPA (cc=E2=
=80=99d)
> looks in this direction (and so do I).
>
> Regards,
> Nadav



--=20
Best Regards
Masahiro Yamada
