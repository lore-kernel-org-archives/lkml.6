Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92EAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9992082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v4aX5Q/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9992082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeLJIR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:17:28 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:64549 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:17:27 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wBA8H5EE019171;
        Mon, 10 Dec 2018 17:17:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wBA8H5EE019171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544429826;
        bh=yrnmbVARLvLoB7gQY4S8uqBOm9/1ztUzDv1T+RRbN/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v4aX5Q/TGmjsSUTi/tPWVMmwr9BvMgOXY79XWlkbix8NI/XIAdeAZbds/Ycc2VRWV
         CH7zppg7Q3wQF86G8Hlk89kaH0xEyAf4JUgG6g5FdvEP/9z3BV5EJro3XQ0NCLchSM
         JCKslyX9Z3UFaHlZQ+JZQRBl4CRGdPV+KHE1diWpnGY6oyYquTogpieIwCIeWYzuNB
         ++XywbkSppPiCzSAma+wa6SSKmPDZjx0+gTgYT3SiZwafK5Kkkzlcc6LvPcm1uQZ9k
         rWSgR08lbCZWEc/gqjrEeGV//yWveeKyE2tx41+wFGfjLVyA9B1idtHY6onx/3grFv
         VmiKzfwfmDO6w==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id g68so6081507vsd.11;
        Mon, 10 Dec 2018 00:17:05 -0800 (PST)
X-Gm-Message-State: AA+aEWbDL2fUl69P1X52Wa3U7cz3ouM8Xt7nET25zcCfHOeXB7uPRPJt
        4qwSNdHd3/a9R3XB1Ml4eocz99UZITM9C6uKI8g=
X-Google-Smtp-Source: AFSGD/UNAaVSV1yygO59hDEIjP0KhJCxJM2KxbthoNWxfbuaAhLJUC30LyX9u2RicxYCqozLNfIaY1klYcvOaZjiMEw=
X-Received: by 2002:a67:485:: with SMTP id 127mr5057572vse.54.1544429824508;
 Mon, 10 Dec 2018 00:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
 <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org> <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com>
 <20181129122500.GX23873@gate.crashing.org> <CF26ACBE-500C-47E8-B79D-E1ABE938031D@alien8.de>
 <20181130131633.GU23873@gate.crashing.org>
In-Reply-To: <20181130131633.GU23873@gate.crashing.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 10 Dec 2018 17:16:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSRZEctnTGiB8GOC-D5Q9_d5GpNm8JQ1EJ--WioDe_DA@mail.gmail.com>
Message-ID: <CAK7LNARSRZEctnTGiB8GOC-D5Q9_d5GpNm8JQ1EJ--WioDe_DA@mail.gmail.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Borislav Petkov <bp@alien8.de>, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, rguenther@suse.de, matz@suse.de,
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

Hi Segher,


On Sun, Dec 2, 2018 at 3:48 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Fri, Nov 30, 2018 at 10:06:02AM +0100, Boris Petkov wrote:
> > On November 29, 2018 1:25:02 PM GMT+01:00, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > >This will only be fixed from GCC 9 on, if the compiler adopts it.  The
> > >kernel wants to support ancient GCC, so it will need to have a
> > >workaround
> > >for older GCC versions anyway.
> >
> > What about backporting it, like Richard says?
>
> Let me first get it into GCC trunk :-)
>
> It should backport fine, sure; and I'll work on that.
>



Now, I can see it in the GCC trunk.  Hooray!!!



commit 6de46ad5326fc5e6b730a2feb8c62d09c1561f92
Author: segher <segher@138bc75d-0d04-0410-961f-82ee72b054a4>
Date:   Thu Dec 6 17:56:58 2018 +0000

    asm inline

    The Linux kernel people want a feature that makes GCC pretend some
    inline assembler code is tiny (while it would think it is huge), so
    that such code will be inlined essentially always instead of
    essentially never.

    This patch lets you say "asm inline" instead of just "asm", with the
    result that that inline assembler is always counted as minimum cost
    for inlining.  It implements this for C and C++, making "inline"
    another asm-qualifier (supplementing "volatile" and "goto").




-- 
Best Regards
Masahiro Yamada
