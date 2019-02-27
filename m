Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF53EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE3B2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RFr/0ChY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfB0MpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:45:01 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:29073 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfB0MpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:45:01 -0500
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x1RCimcj030736;
        Wed, 27 Feb 2019 21:44:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x1RCimcj030736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551271489;
        bh=P3+XfCxm7/Hc6cVNTsL0cxwubDHi36YbQHzgxlTaGYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RFr/0ChYQUiBK8XSpd5Xd+8iL1GkJ0C6Ylag+mbnUhM/MtDkGWMdWIUDR4F+Q27Rd
         mJBQQKhjbllNgZZjaq5yZ2MnlDCUqMc+zJvBU+F9zYStLFX0F/vcXOfS5MSzv49Vw3
         HkUwBLAbM98TOrQVCHRidL+Tfv7PXU6TDya5rR5ivZYXxtw4XrTj9Gp/Qc3+NNmA9L
         rsLs/UznhuQQthfdWueYmslD+UNdwNgGDC0gnZ4Lfz8SySKgOMrfsYuQ7eIM9KWht9
         o3mAGfkWy1kvgCF7Rbxx1fatji0E1W8R1seribMVxo3LUJ8ZQqOh/v6Ec12CVYZhoX
         9wFugmnyzDzhQ==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id j7so379491uak.8;
        Wed, 27 Feb 2019 04:44:48 -0800 (PST)
X-Gm-Message-State: AHQUAubpLI5b6fLKlK/haMIekWR+PhCMafOlkzVSqnEwfS+hBxJmjSWu
        CnzUSABVc2UNH0sxohwG5D18ig0tKxqzzYSuWEE=
X-Google-Smtp-Source: AHgI3IaeZViBI5cUsgDkHqn5u79usSl7So/VuL3vhGoYdF26lze+P8IzFVb4zhCFGILIEj9+L8KQl2Hd/K11qRFn0Jg=
X-Received: by 2002:a67:f107:: with SMTP id n7mr1688761vsk.54.1551271487753;
 Wed, 27 Feb 2019 04:44:47 -0800 (PST)
MIME-Version: 1.0
References: <1550722418-9189-1-git-send-email-yamada.masahiro@socionext.com> <CAKwvOd=YBsupApffP_5QUB5dbQr8k-43DgKhckqkcsGiuXK=MA@mail.gmail.com>
In-Reply-To: <CAKwvOd=YBsupApffP_5QUB5dbQr8k-43DgKhckqkcsGiuXK=MA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Feb 2019 21:44:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQyOhFq+xxDtHvdbuNH6tV6VU-MOyOdQm5vfp6Ufd0nWQ@mail.gmail.com>
Message-ID: <CAK7LNAQyOhFq+xxDtHvdbuNH6tV6VU-MOyOdQm5vfp6Ufd0nWQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: compute false-positive -Wmaybe-uninitialized
 cases in Kconfig
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 9:53 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Feb 20, 2019 at 8:14 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Since -Wmaybe-uninitialized was introduced by GCC 4.7, we have patched
> > various false positives:
> >
> >  - commit e74fc973b6e5 ("Turn off -Wmaybe-uninitialized when building
> >    with -Os") turned off this option for -Os.
> >
> >  - commit 815eb71e7149 ("Kbuild: disable 'maybe-uninitialized' warning
> >    for CONFIG_PROFILE_ALL_BRANCHES") turned off this option for
> >    CONFIG_PROFILE_ALL_BRANCHES
> >
> >  - commit a76bcf557ef4 ("Kbuild: enable -Wmaybe-uninitialized warning
> >    for "make W=1"") turned off this option for GCC < 4.9
> >    Arnd provided more explanation in https://lkml.org/lkml/2017/3/14/903
> >
> > I think this looks better by shifting the logic from Makefile to Kconfig.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I verified that mainline+this patch did not regression arm64
> allyesconfig clang build.
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Thanks for the patch! Would you mind adding a link tag to:
> Link: https://github.com/ClangBuiltLinux/linux/issues/350

I added the tags, and applied to linux-kbuild.



> > ---
> >
> >  Makefile             | 10 +++-------
> >  init/Kconfig         | 17 +++++++++++++++++
> >  kernel/trace/Kconfig |  1 +
> >  3 files changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 1bb0535..b21aa2e3 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -656,17 +656,13 @@ KBUILD_CFLAGS     += $(call cc-disable-warning, int-in-bool-context)
> >
> >  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> >  KBUILD_CFLAGS  += $(call cc-option,-Oz,-Os)
> > -KBUILD_CFLAGS  += $(call cc-disable-warning,maybe-uninitialized,)
> > -else
> > -ifdef CONFIG_PROFILE_ALL_BRANCHES
> > -KBUILD_CFLAGS  += -O2 $(call cc-disable-warning,maybe-uninitialized,)
> >  else
> >  KBUILD_CFLAGS   += -O2
> >  endif
> > -endif
> >
> > -KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
> > -                       $(call cc-disable-warning,maybe-uninitialized,))
> > +ifdef CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED
> > +KBUILD_CFLAGS   += -Wno-maybe-uninitialized
> > +endif
> >
> >  # Tell gcc to never replace conditional load with a non-conditional one
> >  KBUILD_CFLAGS  += $(call cc-option,--param=allow-store-data-races=0)
> > diff --git a/init/Kconfig b/init/Kconfig
> > index c9386a3..1f05a88 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -26,6 +26,22 @@ config CLANG_VERSION
> >  config CC_HAS_ASM_GOTO
> >         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> >
> > +config CC_HAS_WARN_MAYBE_UNINITIALIZED
> > +       def_bool $(cc-option,-Wmaybe-uninitialized)
> > +       help
> > +         GCC >= 4.7 supports this option.
> > +
> > +config CC_DISABLE_WARN_MAYBE_UNINITIALIZED
> > +       bool
> > +       depends on CC_HAS_WARN_MAYBE_UNINITIALIZED
> > +       default CC_IS_GCC && GCC_VERSION < 40900  # unreliable for GCC < 4.9
> > +       help
> > +         GCC's -Wmaybe-uninitialized is not reliable by definition.
> > +         Lots of false positive warnings are produced in some cases.
> > +
> > +         If this option is enabled, -Wno-maybe-uninitialzed is passed
> > +         to the compiler to suppress maybe-uninitialized warnings.
> > +
> >  config CONSTRUCTORS
> >         bool
> >         depends on !UML
> > @@ -1113,6 +1129,7 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
> >
> >  config CC_OPTIMIZE_FOR_SIZE
> >         bool "Optimize for size"
> > +       imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
> >         help
> >           Enabling this option will pass "-Os" instead of "-O2" to
> >           your compiler resulting in a smaller kernel.
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index fa8b1fe..8bd1d6d 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -370,6 +370,7 @@ config PROFILE_ANNOTATED_BRANCHES
> >  config PROFILE_ALL_BRANCHES
> >         bool "Profile all if conditionals" if !FORTIFY_SOURCE
> >         select TRACE_BRANCH_PROFILING
> > +       imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
> >         help
> >           This tracer profiles all branch conditions. Every if ()
> >           taken in the kernel is recorded whether it hit or miss.
> > --
> > 2.7.4
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
