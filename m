Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F95C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFECC208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="il4+Fhki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFECC208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389363AbeKPRZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:25:30 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:24450 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPRZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:25:29 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wAG7E9MA025107;
        Fri, 16 Nov 2018 16:14:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wAG7E9MA025107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542352450;
        bh=VwAIx3Eo70JuM1DePhqDSXkBGEkG28c2bnoZdHYjPng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=il4+Fhki/Ny6Y2kEvKB4T7WQIBHEQ5GAChASHid4ELRP68uEW0tnEVegmfNLVuE33
         TbiUOGOJZaINu4Dqa0TNgVJfP1kGNDKR0l//CElICazrF2VD7BdTplW4qb0yJYd4BI
         LfdZ3CMNwzHDR3jb64I39P7DQJwsdwVDQM6bMA5/cQVqW+OmNuo61UmCIFXhknfUtL
         Kjv5vNeDjVB2CHUajzWyA5htGPmZMKDfcX+MlvOKA50KmcXLOf2tl7NqOCgJhyPjg9
         Dl8+XiYnOUximc2zTtsOesi/x4n2GzQ/UARHwGPhCJCC9Na+DBquuB5+y8SkYIZNki
         Fkz1mX59RCWMA==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id p74so13227762vsc.0;
        Thu, 15 Nov 2018 23:14:10 -0800 (PST)
X-Gm-Message-State: AGRZ1gLQAha5jCZ57TzJzgI985JbOdRrdPuNirrj/vvBML7Evn0G43lj
        jj3AomVKIxrcNA0tceZvxLD99aHIYPJSlBPGW/c=
X-Google-Smtp-Source: AJdET5evuWJ7Ew50nh965V6UMiSxOOwvoOENawpCbUPrwDvIUTlGYJPNaAUhrzvfaoh0rTKZBZUZVzE7bZWP2xsuL3Q=
X-Received: by 2002:a67:385a:: with SMTP id f87mr4064061vsa.179.1542352449248;
 Thu, 15 Nov 2018 23:14:09 -0800 (PST)
MIME-Version: 1.0
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
 <1542270435-11181-5-git-send-email-yamada.masahiro@socionext.com> <nycvar.YSQ.7.76.1811152346510.1993@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1811152346510.1993@knanqh.ubzr>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 16 Nov 2018 16:13:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNATT7PYvH-z572MGSjXbCybAW0TcNebz9CgGM4J07aMOvw@mail.gmail.com>
Message-ID: <CAK7LNATT7PYvH-z572MGSjXbCybAW0TcNebz9CgGM4J07aMOvw@mail.gmail.com>
Subject: Re: [PATCH 4/8] kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 2:13 PM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>
> On Thu, 15 Nov 2018, Masahiro Yamada wrote:
>
> > My main motivation of this commit is to clean up scripts/Kbuild.include
> > and scripts/Makefile.build.
> >
> > Currently, CONFIG_TRIM_UNUSED_KSYMS works with a tricky gimmick;
> > possibly exported symbols are detected by letting $(CPP) replace
> > EXPORT_SYMBOL* with a special string '=== __KSYM_*===', which is
> > post-processed by sed, and passed to fixdep. The extra preprocessing
> > is costly, and hacking cmd_and_fixdep is ugly.
> >
> > I came up with a new way to find exported symbols; insert a dummy
> > symbol __ksym_marker_* to each potentially exported symbol. Those
> > dummy symbols are picked up by $(NM), post-processed by sed, then
> > appended to .*.cmd files. I collected the post-process part to a
> > new shell script scripts/gen_ksymdeps.sh for readability. The dummy
> > symbols are put into the .discard.* section so that the linker
> > script rips them off the final vmlinux or modules.
>
> Brilliant!  I really like it.
>
> Minor comments below.
>
> > diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> > index 4d73e6e..294d6ae 100644
> > --- a/include/asm-generic/export.h
> > +++ b/include/asm-generic/export.h
> > @@ -59,16 +59,19 @@ __kcrctab_\name:
> >  .endm
> >  #undef __put
> >
> > -#if defined(__KSYM_DEPS__)
> > -
> > -#define __EXPORT_SYMBOL(sym, val, sec)       === __KSYM_##sym ===
> > -
> > -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> > +#if defined(CONFIG_TRIM_UNUSED_KSYMS)
> >
> >  #include <linux/kconfig.h>
> >  #include <generated/autoksyms.h>
> >
> > +.macro __ksym_marker sym
> > +     .section ".discard.ksym","a"
> > +__ksym_marker_\sym:
> > +      .previous
>
> Does this work as intended? I have vague memories about having problems
> with sections being discarded when they don't allocate any space.

What I can tell is, this patch produces the same size kernel
(after dropping debug info by 'strip' command).


> > +.endm
> > +
> >  #define __EXPORT_SYMBOL(sym, val, sec)                               \
> > +     __ksym_marker sym;                                      \
> >       __cond_export_sym(sym, val, sec, __is_defined(__KSYM_##sym))
> >  #define __cond_export_sym(sym, val, sec, conf)                       \
> >       ___cond_export_sym(sym, val, sec, conf)
> > diff --git a/include/linux/export.h b/include/linux/export.h
> > index ce764a5..0413a3d 100644
> > --- a/include/linux/export.h
> > +++ b/include/linux/export.h
> > @@ -92,22 +92,22 @@ struct kernel_symbol {
> >   */
> >  #define __EXPORT_SYMBOL(sym, sec)
> >
> > -#elif defined(__KSYM_DEPS__)
> > +#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> > +
> > +#include <generated/autoksyms.h>
> >
> >  /*
> >   * For fine grained build dependencies, we want to tell the build system
> >   * about each possible exported symbol even if they're not actually exported.
> > - * We use a string pattern that is unlikely to be valid code that the build
> > - * system filters out from the preprocessor output (see ksym_dep_filter
> > - * in scripts/Kbuild.include).
> > + * We use a symbol pattern __ksym_marker_<symbol> that the build system filters
> > + * from the $(NM) output (see scripts/gen_ksymdep.sh). These symbols are
> > + * discarded in the final link stage.
> >   */
> > -#define __EXPORT_SYMBOL(sym, sec)    === __KSYM_##sym ===
> > -
> > -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> > -
> > -#include <generated/autoksyms.h>
> > +#define __ksym_marker(sym)   \
> > +     static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
>
> Even if this is discarded during the final link, maybe this could save
> a tiny amount of disk space by using a char instead?


I am afraid you missed '[0]' after the symbol name.
This is actually zero-length array.

No memory allocated for this dummy section.

As far as I tested, this is working.





> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 7f3ca6e..e5ba9b1 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -254,9 +254,18 @@ objtool_dep = $(objtool_obj)                                     \
> >             $(wildcard include/config/orc/unwinder.h          \
> >                        include/config/stack/validation.h)
> >
> > +ifdef CONFIG_TRIM_UNUSED_KSYMS
> > +cmd_gen_ksymdeps = \
> > +     $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ > $(dot-target).tmp; \
> > +     cat $(dot-target).tmp >> $(dot-target).cmd; \
> > +     rm -f $(dot-target).tmp;
>
> Why don't you append to $(dot-target).cmd directly?


If scripts/gen_ksymdeps.sh fails for some reasons,
it will error out immediately thanks to 'set -e' flag.

Appending incomplete portion might end up with a corrupted .*.cmd file.

Probably, that would not happen, but I just wanted to ensure it.




>
> Nicolas



--
Best Regards
Masahiro Yamada
