Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CABC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5532087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0kOATDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5532087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390212AbeKQEDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:03:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45422 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeKQEDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:03:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id d135so38723237qkc.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 09:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Jp2NTy0VgVSyrJbw5GHLRy2cT/Mdo5Wx9S9mVl0UjY0=;
        b=G0kOATDCTsATwP7gNo1uNaIN1Kt1ytYIfLUNX3l0Q3C5B4SXiMFa/aE+UCysIm1JBy
         otY/5GXND/oiFpI2M/rR/rRDZZF/NZ+Rh0eq3aO9SLo+ax0Cqctyzu1n1nwbPT0PZHc9
         uFWCSi9VfONbKiFWoDiwnL/7aStoRF0vl5DQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Jp2NTy0VgVSyrJbw5GHLRy2cT/Mdo5Wx9S9mVl0UjY0=;
        b=FMfexa16Sr6HmZL/xEUu0Onv82tGm1JQV2VUWDv0G1stVEcgLt0M6v3ZNuq2ni9p4O
         vMDppPoy+EcjohdEXOETDQFo2T7jIUwfi7y93eVmKH2MzyKS74nxn00X/TtW6hVb3LEi
         U9nIvmAaU+g90hP9csHlZgcd6fKnfUqmDJfz+aQVopiWq4E+LxnfKd+aXcLdOVHuZnCS
         Zv1k9eMcGs0q65Onc/O3sp9lZFmozbkHvaWY/k2DLgicz900haC+1elLESYjLpQdtVH9
         yhhfWYScOsntCXmo+pk5bJiOJ2Qfwnx52OwAYvqI2XGB1nLD5VimFYyd4V0lrlNIcT35
         xSIw==
X-Gm-Message-State: AGRZ1gKqMJZirrITQxtzZTCvglaJPYckUed62f12FQsRi9mgz40YW9S7
        UpDmR66q+iXLowfPTGpqTwrSmLkDb84=
X-Google-Smtp-Source: AJdET5f7WZSEPImpMUNXBAS7223SKgBwQrUp1IDgb946YPJdGWszjsWu8hEl70+5IxsH/bEUJLvtWQ==
X-Received: by 2002:a0c:92c3:: with SMTP id c3mr11460156qvc.12.1542390600363;
        Fri, 16 Nov 2018 09:50:00 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id n8sm17552607qtk.91.2018.11.16.09.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 09:49:59 -0800 (PST)
Date:   Fri, 16 Nov 2018 12:49:56 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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
Subject: Re: [PATCH 4/8] kbuild: simplify dependency generation for
 CONFIG_TRIM_UNUSED_KSYMS
In-Reply-To: <CAK7LNATT7PYvH-z572MGSjXbCybAW0TcNebz9CgGM4J07aMOvw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1811161234160.1993@knanqh.ubzr>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com> <1542270435-11181-5-git-send-email-yamada.masahiro@socionext.com> <nycvar.YSQ.7.76.1811152346510.1993@knanqh.ubzr>
 <CAK7LNATT7PYvH-z572MGSjXbCybAW0TcNebz9CgGM4J07aMOvw@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Masahiro Yamada wrote:

> On Fri, Nov 16, 2018 at 2:13 PM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >
> > On Thu, 15 Nov 2018, Masahiro Yamada wrote:
> >
> > > My main motivation of this commit is to clean up scripts/Kbuild.include
> > > and scripts/Makefile.build.
> > >
> > > Currently, CONFIG_TRIM_UNUSED_KSYMS works with a tricky gimmick;
> > > possibly exported symbols are detected by letting $(CPP) replace
> > > EXPORT_SYMBOL* with a special string '=== __KSYM_*===', which is
> > > post-processed by sed, and passed to fixdep. The extra preprocessing
> > > is costly, and hacking cmd_and_fixdep is ugly.
> > >
> > > I came up with a new way to find exported symbols; insert a dummy
> > > symbol __ksym_marker_* to each potentially exported symbol. Those
> > > dummy symbols are picked up by $(NM), post-processed by sed, then
> > > appended to .*.cmd files. I collected the post-process part to a
> > > new shell script scripts/gen_ksymdeps.sh for readability. The dummy
> > > symbols are put into the .discard.* section so that the linker
> > > script rips them off the final vmlinux or modules.
> >
> > Brilliant!  I really like it.
> >
> > Minor comments below.
> >
> > > diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> > > index 4d73e6e..294d6ae 100644
> > > --- a/include/asm-generic/export.h
> > > +++ b/include/asm-generic/export.h
> > > @@ -59,16 +59,19 @@ __kcrctab_\name:
> > >  .endm
> > >  #undef __put
> > >
> > > -#if defined(__KSYM_DEPS__)
> > > -
> > > -#define __EXPORT_SYMBOL(sym, val, sec)       === __KSYM_##sym ===
> > > -
> > > -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> > > +#if defined(CONFIG_TRIM_UNUSED_KSYMS)
> > >
> > >  #include <linux/kconfig.h>
> > >  #include <generated/autoksyms.h>
> > >
> > > +.macro __ksym_marker sym
> > > +     .section ".discard.ksym","a"
> > > +__ksym_marker_\sym:
> > > +      .previous
> >
> > Does this work as intended? I have vague memories about having problems
> > with sections being discarded when they don't allocate any space.
> 
> What I can tell is, this patch produces the same size kernel
> (after dropping debug info by 'strip' command).
> 
> 
> > > +.endm
> > > +
> > >  #define __EXPORT_SYMBOL(sym, val, sec)                               \
> > > +     __ksym_marker sym;                                      \
> > >       __cond_export_sym(sym, val, sec, __is_defined(__KSYM_##sym))
> > >  #define __cond_export_sym(sym, val, sec, conf)                       \
> > >       ___cond_export_sym(sym, val, sec, conf)
> > > diff --git a/include/linux/export.h b/include/linux/export.h
> > > index ce764a5..0413a3d 100644
> > > --- a/include/linux/export.h
> > > +++ b/include/linux/export.h
> > > @@ -92,22 +92,22 @@ struct kernel_symbol {
> > >   */
> > >  #define __EXPORT_SYMBOL(sym, sec)
> > >
> > > -#elif defined(__KSYM_DEPS__)
> > > +#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> > > +
> > > +#include <generated/autoksyms.h>
> > >
> > >  /*
> > >   * For fine grained build dependencies, we want to tell the build system
> > >   * about each possible exported symbol even if they're not actually exported.
> > > - * We use a string pattern that is unlikely to be valid code that the build
> > > - * system filters out from the preprocessor output (see ksym_dep_filter
> > > - * in scripts/Kbuild.include).
> > > + * We use a symbol pattern __ksym_marker_<symbol> that the build system filters
> > > + * from the $(NM) output (see scripts/gen_ksymdep.sh). These symbols are
> > > + * discarded in the final link stage.
> > >   */
> > > -#define __EXPORT_SYMBOL(sym, sec)    === __KSYM_##sym ===
> > > -
> > > -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> > > -
> > > -#include <generated/autoksyms.h>
> > > +#define __ksym_marker(sym)   \
> > > +     static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
> >
> > Even if this is discarded during the final link, maybe this could save
> > a tiny amount of disk space by using a char instead?
> 
> 
> I am afraid you missed '[0]' after the symbol name.
> This is actually zero-length array.

Ah, indeed.

> No memory allocated for this dummy section.

Right, and that makes it identical to the assembly case.

> As far as I tested, this is working.

Yes, it does.

The problem I was alluding to has to do with symbols generated by the 
linker directly which for some reason behaves differently in that case.

> > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > index 7f3ca6e..e5ba9b1 100644
> > > --- a/scripts/Makefile.build
> > > +++ b/scripts/Makefile.build
> > > @@ -254,9 +254,18 @@ objtool_dep = $(objtool_obj)                                     \
> > >             $(wildcard include/config/orc/unwinder.h          \
> > >                        include/config/stack/validation.h)
> > >
> > > +ifdef CONFIG_TRIM_UNUSED_KSYMS
> > > +cmd_gen_ksymdeps = \
> > > +     $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ > $(dot-target).tmp; \
> > > +     cat $(dot-target).tmp >> $(dot-target).cmd; \
> > > +     rm -f $(dot-target).tmp;
> >
> > Why don't you append to $(dot-target).cmd directly?
> 
> 
> If scripts/gen_ksymdeps.sh fails for some reasons,
> it will error out immediately thanks to 'set -e' flag.
> 
> Appending incomplete portion might end up with a corrupted .*.cmd file.
> 
> Probably, that would not happen, but I just wanted to ensure it.

Well, strictly speaking, if scripts/gen_ksymdeps.sh fails and its output 
isn't appended at all to the .*.cmd file, then that .*.cmd file is 
already corrupted as it is missing necessary dependencies. Would be 
better to delete the .*.cmd file entirely in that case.


Nicolas
