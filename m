Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1CCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA13213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551113364;
	bh=YkmCLQ46XZh+uU13TXxK6DhZ2lx6FqSkZE+J66zFURU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0nFFcrLIhgxFu0ozzDcumgujUKgNzhdywlopUPDjr/QDpZEMF8HiBgUiqb4I2bm4L
	 stxyidR94FhndKMqERRBZaL/ep+Uu7hwwFYkt5BcLROLZQblSAkXTUNubEqgpKkuKk
	 +7ILpprkdttzz9GDpWA61ekD9TL/Wm9M4Ux7fDig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfBYQtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbfBYQtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:49:21 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33AD1217F9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551113360;
        bh=YkmCLQ46XZh+uU13TXxK6DhZ2lx6FqSkZE+J66zFURU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pQDD/m7uaoVfcyABw+RzmkVi/ik7DF6YiygqXb0KZUKODgtN8jsh/OWiTeVsXH2IK
         VqBckzz8gYSyoDsbwitSNmPla0o50PLhNfAwPLn1DGv3MnHsA0tKcdI5udbuVnlr4L
         mw2Nrn27ioEwDMWyX8JmUf4T8gMpBcNJJR1Hn1ck=
Received: by mail-wr1-f41.google.com with SMTP id n2so10701856wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 08:49:20 -0800 (PST)
X-Gm-Message-State: AHQUAuaXccQMUE6kBiO4J4FPvc5qhN2Gq2rx6saSgT6GIHXpafg5pOIl
        pSj3fdetiVPmMnfnzsMaZvIsqSpJxbPnpQGTkvaR+Q==
X-Google-Smtp-Source: AHgI3IaBA/Ts27yqIeowtO3MtMYnS5wcX7o9Y/5gpkcWj4prVarGvgeGfy3Y5HEESYS9lP7XOaNhUarWuAx1oMh4c70=
X-Received: by 2002:adf:8061:: with SMTP id 88mr12653798wrk.77.1551113358560;
 Mon, 25 Feb 2019 08:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125231.936952143@infradead.org>
 <CALCETrW-p4iF-RMecyNt1JDwKh74c_tw67FCW7Yr_Fd3adtGUw@mail.gmail.com>
 <20190225161003.GL32477@hirez.programming.kicks-ass.net> <3F83AE74-3F9E-42BB-8F9C-3033F72B3EF5@amacapital.net>
 <20190225163745.GF32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190225163745.GF32494@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Feb 2019 08:49:06 -0800
X-Gmail-Original-Message-ID: <CALCETrU7nW8JVbu79VppNhn2RSxvSiqanXgOkwboUqbJYnQyTQ@mail.gmail.com>
Message-ID: <CALCETrU7nW8JVbu79VppNhn2RSxvSiqanXgOkwboUqbJYnQyTQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86/ia32: Fix ia32_restore_sigcontext AC leak
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 8:37 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Mon, Feb 25, 2019 at 08:29:12AM -0800, Andy Lutomirski wrote:
>
> > > diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.=
c
> > > index 321fe5f5d0e9..e04eeeddcc35 100644
> > > --- a/arch/x86/ia32/ia32_signal.c
> > > +++ b/arch/x86/ia32/ia32_signal.c
> > > @@ -53,17 +53,16 @@
> > > #define GET_SEG(seg)        ({            \
> > >    unsigned short tmp;                \
> > >    get_user_ex(tmp, &sc->seg);            \
> > > -    tmp;                        \
> > > +    tmp | 3;                    \
> > > })
> > >
> >
> > Drop this part.
> >
> > > #define COPY_SEG_CPL3(seg)    do {            \
> > > -    regs->seg =3D GET_SEG(seg) | 3;            \
> > > +    regs->seg =3D GET_SEG(seg);            \
> > > } while (0)
> >
> > And this.
> >
> > Unfortunately, whether we want the | 3 varies by segment. For FS and
> > GS, we definitely don=E2=80=99t want it, since 0 is a common and import=
ant
> > value, and 3 is a deeply screwed up value.  (3 is legal to *write* to
> > GS, and it sticks, but IRET silently changes it to 0, because the
> > original 386 designers (I assume) confused themselves.
>
> > >
> > > #define RELOAD_SEG(seg)        {        \
> > > -    unsigned int pre =3D GET_SEG(seg);    \
> > > +    unsigned int pre =3D (seg);        \
> > >    unsigned int cur =3D get_user_seg(seg);    \
> > > -    pre |=3D 3;                \
>
> And here ?
>
> > >    if (pre !=3D cur)                \
> > >        set_user_seg(seg, pre);        \
> > > }
>
> Thing is; afaict the current code _always_ does |3 on any GET_SET()
> result.
>
> If you want to change that; I'm fine with that, but lets not do that in
> this same patch.

Ugh, you're right.  I bet I can come up with some awful case involving
ptrace and sigreturn where this causes problems.

I have a patch series I need to dust off that deletes this entire
file.  It's this and its parents:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=3D=
execve&id=3D0618fe90d8224979f70b15d33dcae75a403592e5

>
> So then?
>
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 321fe5f5d0e9..4d5fcd47ab75 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -61,9 +61,8 @@
>  } while (0)
>
>  #define RELOAD_SEG(seg)                {               \
> -       unsigned int pre =3D GET_SEG(seg);        \
> +       unsigned int pre =3D (seg) | 3;           \
>         unsigned int cur =3D get_user_seg(seg);   \
> -       pre |=3D 3;                               \
>         if (pre !=3D cur)                         \
>                 set_user_seg(seg, pre);         \
>  }
> @@ -72,6 +71,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs=
,
>                                    struct sigcontext_32 __user *sc)
>  {
>         unsigned int tmpflags, err =3D 0;
> +       u16 gs, fs, es, ds;
>         void __user *buf;
>         u32 tmp;
>
> @@ -79,16 +79,10 @@ static int ia32_restore_sigcontext(struct pt_regs *re=
gs,
>         current->restart_block.fn =3D do_no_restart_syscall;
>
>         get_user_try {
> -               /*
> -                * Reload fs and gs if they have changed in the signal
> -                * handler.  This does not handle long fs/gs base changes=
 in
> -                * the handler, but does not clobber them at least in the
> -                * normal case.
> -                */
> -               RELOAD_SEG(gs);
> -               RELOAD_SEG(fs);
> -               RELOAD_SEG(ds);
> -               RELOAD_SEG(es);
> +               gs =3D GET_SEG(gs);
> +               fs =3D GET_SEG(fs);
> +               ds =3D GET_SEG(ds);
> +               es =3D GET_SEG(es);
>
>                 COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
>                 COPY(dx); COPY(cx); COPY(ip); COPY(ax);
> @@ -106,6 +100,17 @@ static int ia32_restore_sigcontext(struct pt_regs *r=
egs,
>                 buf =3D compat_ptr(tmp);
>         } get_user_catch(err);
>
> +       /*
> +        * Reload fs and gs if they have changed in the signal
> +        * handler.  This does not handle long fs/gs base changes in
> +        * the handler, but does not clobber them at least in the
> +        * normal case.
> +        */
> +       RELOAD_SEG(gs);
> +       RELOAD_SEG(fs);
> +       RELOAD_SEG(ds);
> +       RELOAD_SEG(es);
> +
>         err |=3D fpu__restore_sig(buf, 1);
>
>         force_iret();

Looks good to me.  The order of the restores shouldn't matter at all.
