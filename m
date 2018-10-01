Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84681208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0OBUNe/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84681208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJBEmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:42:04 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50194 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBEmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:42:04 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w91M1uJL024911;
        Tue, 2 Oct 2018 07:01:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w91M1uJL024911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538431317;
        bh=6ZbYLhx8ZAmNuHaXT3KJ4h8gHFu+eSa9dzT42iuy+ZI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0OBUNe/UFrPGqMD8NUACJqziKI+ZOO1z1YaAc8L8vyR3Kao6V28AtQbqGXsQHGuq/
         HKlkYeMY7BuqvTp/AQ7ma5jPz/ZdX2Qwi4GAp5XkNTBQN7W+zZEZEDKgSbhfkh1IVQ
         l9I9TDGopsZambCqnxQ+cZJNzUj1NKNSIPKYNgkbvz5yyctLUS5E/F99lomgCWE63E
         Ja9Cpa/OTz5y++QrX+x+wC56/rQsqDY/fYs2VXnO8BCy9d9KJPY3/mONQK3JE1RCQq
         jeSq5WY7USl3cNMhYqPSfv7ttIaKovoi8jBLTdkFQaL7jrTzOsRn/bz4f1SdCSX6cD
         lWG0uNN1S2Teg==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id e206so2312152vsd.0;
        Mon, 01 Oct 2018 15:01:56 -0700 (PDT)
X-Gm-Message-State: ABuFfojav/PO1hU7X97UfqgSdW7pnECIPF7YgmMlK4fC4C8gQB9+biWb
        AN3hxN86noGgeyB/OidYLO1PV5I0xa9EkxDpmws=
X-Google-Smtp-Source: ACcGV62fgYGYcta2EBGjvTZ5SjWdkesVc3D/AbB1jF+WmI7hAqL51ciuS4pDf5Vifk8eHz5PNSidmlVVyqsOT/HjIbc=
X-Received: by 2002:a67:5f85:: with SMTP id t127-v6mr4815589vsb.155.1538431315542;
 Mon, 01 Oct 2018 15:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180918212847.199085-1-namit@vmware.com> <20180918212847.199085-3-namit@vmware.com>
 <1aa5a1f3-ef3d-5cd3-831c-2202d73d3c9e@rasmusvillemoes.dk> <307823F9-DCCF-4384-9FBE-28642FAD6B4E@vmware.com>
In-Reply-To: <307823F9-DCCF-4384-9FBE-28642FAD6B4E@vmware.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 2 Oct 2018 07:01:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT98KZrMLuypS0PZ4jUWC+uRWyYwHPiEJD6LYoYzndJhA@mail.gmail.com>
Message-ID: <CAK7LNAT98KZrMLuypS0PZ4jUWC+uRWyYwHPiEJD6LYoYzndJhA@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] Makefile: Prepare for using macros for inline asm
To:     Nadav Amit <namit@vmware.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.



2018=E5=B9=B49=E6=9C=8827=E6=97=A5(=E6=9C=A8) 2:57 Nadav Amit <namit@vmware=
.com>:
>
> at 1:58 AM, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
> > On 2018-09-18 23:28, Nadav Amit wrote:
> >
> >> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> >> index 8f6e7eb8ae9f..944fa3bc9376 100644
> >> --- a/arch/x86/Makefile
> >> +++ b/arch/x86/Makefile
> >> @@ -214,8 +214,8 @@ ifdef CONFIG_X86_64
> >> KBUILD_LDFLAGS +=3D $(call ld-option, -z max-page-size=3D0x200000)
> >> endif
> >>
> >> -# Speed up the build
> >> -KBUILD_CFLAGS +=3D -pipe
> >> +# We cannot use -pipe flag since we give an additional .s file to the=
 compiler
> >> +#KBUILD_CFLAGS +=3D -pipe
> >
> > Is this really necessary? The gas manual says that one can use -- to
> > name stdin, though that's probably a typo and should just be - . Doing
> >
> > gcc -pipe -Wa,foo.s -Wa,-
>
> Good idea. I didn=E2=80=99t think of it. Yes, this can do the trick. I=E2=
=80=99ll do it in
> v9.
>
> > does seem to work as expected (and would also make it possible to appen=
d
> > some .s file should that ever be required).
> >> +archmacros:
> >> +    $(Q)$(MAKE) $(build)=3Darch/x86/kernel arch/x86/kernel/macros.s
> >> +
> >> +ASM_MACRO_FLAGS =3D -Wa,arch/x86/kernel/macros.s
> >> +export ASM_MACRO_FLAGS
> >> +KBUILD_CFLAGS +=3D $(ASM_MACRO_FLAGS)
> > How does this affect what gets rebuilt when one of the asm/foo.h files
> > going into macros.s changes? Does that cause a global rebuild because
> > everything depends on macros.s, or do we still only rebuild the files
> > that actually include asm/foo.h?
>
> There will not be a global rebuild. Any source file that uses the header
> files that are included in macros.S will be rebuilt.
>
> But your question actually raises two issues:
>
> 1. If macros.S changes, there *should* be a global rebuild,


Looking at this series, I can see this rule:
"macros and inline functions that calls them are placed in the same header"=
.


For example,
REFCOUNT_CHECK_LE_ZERO is defined in <asm/refcount.h>,
and REFCOUNT_CHECK_LE_ZERO is invoked via refcount_sub_and_test() etc.
in the same header.

Therefore, all users of REFCOUNT_CHECK_LE_ZERO must have included
<asm/refcount.h>

This means all C files using REFCOUNT_CHECK_LE_ZERO
will be appropriately recompiled as long as the rule above is observed.



> and currently
> there wouldn=E2=80=99t be one. Do you happen to know what would be the ap=
propriate
> way to trigger one?
>
> 2. Someone might mistakenly use the macros through inline assembly withou=
t
> including the header file.

Right, it is possible to use REFCOUNT_CHECK_LE_ZERO directly.
If this happens, my assumption breaks.

It would be unlikely to happen, though...


> It would be better to detect such cases and fail
> the build. I may be able to create another asm macro in the C part of the
> header that would cause the build to fail. But let me know if you any
> better idea.
>
> Regards,
> Nadav
>


--=20
Best Regards
Masahiro Yamada
