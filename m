Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB5CC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C0F207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SatWb/fY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfBEOHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:07:02 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43371 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfBEOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:07:01 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x15E6l6s012769
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 23:06:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x15E6l6s012769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549375608;
        bh=umIYst3tg+my3pGDs4qdEJzBHRtimUFljkyVUJJhbLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SatWb/fYDY7LFRpmGPKwBStU4+uYu3ndmpyoYof2skZ3jYSkiP7NKkUszqW2xXrbh
         c8Qh+mMUwRDbq/SueedNOA5Ds+5w7ZzZ94429sqzV8h+SJmqfASx4JKFFzYMdZz3ny
         wj4WriygUUZBioyx6gxxBC4XlQQuYTFjzWJAwce+6raHZu1XEad1ukS7fZ9ps9aSv1
         edFk4AiAnBcT2lt5kQxkl2E1YUAFATh1sQVgjwZUS4CrDm2VYEjuWII8NZkGSUtMRq
         2mA8VfwYYYaKHttQaqNGwr7KSv+4oaJ0u5UXuko5FjjYrApOWYzybYEka4leWs8N0N
         q18t1xkNEFcuA==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id v24so1118807uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 06:06:48 -0800 (PST)
X-Gm-Message-State: AHQUAuaDhKFcHeXAs8zw/KMunHlcOREURzk0Hzfceoz/aKQDrF0rmlCA
        up5+RGITWoS/kKj7Iak8UJ5Pkbab6lWgHkI0evc=
X-Google-Smtp-Source: AHgI3IY6sQMysAfTkhnIbFrae1+Ji+g7HQF+pHJlqyle22RgLiJWZnjyelzL1HxQxcehfAmLkBLnQIU4xtbSW0wVjzo=
X-Received: by 2002:ab0:66d1:: with SMTP id d17mr1962444uaq.89.1549375606971;
 Tue, 05 Feb 2019 06:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
 <CAK7LNAQqHgLTJU1tBU+oU+1CrWBrDpnui=dQCrNpzW4N2R-Omw@mail.gmail.com> <e1e125b5-71b4-3694-d7d8-789dfef7a9f5@rasmusvillemoes.dk>
In-Reply-To: <e1e125b5-71b4-3694-d7d8-789dfef7a9f5@rasmusvillemoes.dk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Feb 2019 23:06:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATwpvn8ou+p9snkDFRpDBJvwFWhWY0qcwrdGNSx7W0Hjg@mail.gmail.com>
Message-ID: <CAK7LNATwpvn8ou+p9snkDFRpDBJvwFWhWY0qcwrdGNSx7W0Hjg@mail.gmail.com>
Subject: Re: [PATCH] build_bug.h: add wrapper for _Static_assert
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 6:39 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 05/02/2019 09.05, Masahiro Yamada wrote:
> > On Mon, Feb 4, 2019 at 4:24 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> BUILD_BUG_ON() is a little annoying, since it cannot be used outside
> >> function scope. So one cannot put assertions about the sizeof() a
> >> struct next to the struct definition, but has to hide that in some
> >> more or less arbitrary function.
> >>
> >> Since gcc 4.6 (which is now also the required minimum), there is
> >> support for the C11 _Static_assert in all C modes, including gnu89. So
> >> add a simple wrapper for that.
> >>
> >> _Static_assert() requires a message argument, which is usually quite
> >> redundant (and I believe that bug got fixed at least in newer C++
> >> standards), but we can easily work around that with a little macro
> >> magic, making it optional.
> >>
> >> For example, adding
> >>
> >>   static_assert(sizeof(struct printf_spec) =3D=3D 8);
> >>
> >> in vsprintf.c and modifying that struct to violate it, one gets
> >>
> >> ./include/linux/build_bug.h:78:41: error: static assertion failed: "si=
zeof(struct printf_spec) =3D=3D 8"
> >>  #define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "=
")
> >>
> >> godbolt.org suggests that _Static_assert() has been support by clang
> >> since at least 3.0.0.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >>  include/linux/build_bug.h | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> >> index faeec7433aab..4bf9ba847b44 100644
> >> --- a/include/linux/build_bug.h
> >> +++ b/include/linux/build_bug.h
> >> @@ -58,4 +58,23 @@
> >>   */
> >>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> >>
> >> +/**
> >> + * static_assert - check integer constant expression at build time
> >> + *
> >> + * static_assert() is a wrapper for the C11 _Static_assert, with a
> >> + * little macro magic to make the message optional (defaulting to the
> >> + * stringification of the tested expression).
> >> + *
> >> + * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
> >> + * scope, but requires the expression to be an integer constant
> >> + * expression (i.e., it is not enough that __builtin_constant_p() is
> >> + * true for expr).
> >> + *
> >> + * Also note that BUILD_BUG_ON() fails the build if the condition is
> >> + * true, while static_assert() fails the build if the expression is
> >> + * false.
> >> + */
> >> +#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__,=
 #expr)
> >> +#define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "=
")
> >
> > What is the "" "" for?
>
> Good point. It's a leftover from when I had a fallback-implementation of
> _Static_assert for gcc < 4.6, where I wanted to ensure that the second
> argument was a string literal, even if my fallback implementation
> ignored that argument. Now it's actually a little harmful, because
>
> foobar.c:5:34: error: expected string literal before =E2=80=98expected=E2=
=80=99
>  static_assert(sizeof(long) =3D=3D 8, expected 64 bit machine);
>
> is better than
>
> foobar.c:4:34: error: expected =E2=80=98)=E2=80=99 before =E2=80=98expect=
ed=E2=80=99
>  static_assert(sizeof(long) =3D=3D 8, expected 64 bit machine);
>
> > Bikeshed:
> >
> > There might be room for argument about
> > where this macro should go.
> >
> > Another possible place is <linux/compiler.h>
> > where compiletime_assert() is defined.
>
> I'd rather move compiletime_assert to build_bug.h, and rename it so that
> it becomes an implementation detail of BUILD_BUG. There are not that
> many direct users of compiletime_assert(), and I think we should
> standardize on fewer ways of achieving the same thing. static_assert()
> for checking ICEs, usable at any scope, and BUILD_BUG_* for checking
> that the optimizer is sufficiently smart.
>
> This would also be a step towards another cleanup I'd like to do: make
> build_bug.h not depend on compiler.h,


Probably, you cannot do this.
compiletime_assert relies on __attribute__((__error__(...)))
that is only supported by GCC.


> because we already have a
> dependency in the other direction (ARRAY_SIZE using BUILD_BUG_ON_ZERO).
>
> Rasmus



--=20
Best Regards
Masahiro Yamada
