Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5176A20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pPUGdl1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391888AbfAPKTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:19:41 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:62311 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732352AbfAPKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:19:41 -0500
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x0GAJR6s004494
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 19:19:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x0GAJR6s004494
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547633968;
        bh=XluTAMMuVTynizhM8TMwuGt9FIM9t7DE2JUqtbv9fic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pPUGdl1l3ZpHL7yLtjuSGOscWpi5WxXiFiYEG8J8Lqd6nnMCaCck2tZe9OGNvhIhq
         A71C4r/MCCp1uNORf6QjuJwQq4XocXJT4tQ5VoVrWCq2tZ+qFYf97KckvRco5bb0UN
         hjvBTLYeMRUKUG4ZUDEXE9JQXnWFQo+xRkSezTgIsPzM7jTSx/QsE6FUr++oELGD+H
         2it3Z0hh/TUu7Qfu74HkKWyzYkekxHhK2ySjI6Jal6sxMkEgB5cFTvUr5y3Zef26An
         KiSkmklDhCcTQCQGqpuJpNhSgQf1Eh2q78cR4TJjPkt/kotJSTW8f7/d7vVpQQd0m4
         9/fF0WHk9o02A==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id t8so1986915uap.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 02:19:28 -0800 (PST)
X-Gm-Message-State: AJcUukcsnS3aIhaycV0BYAhh7AIVa64oVY2etQfB9woEbRw2Nnxh9/mm
        EouEv9nXWrYefP6uOx2DEmTEIQMHtS9v153nui4=
X-Google-Smtp-Source: ALg8bN6SrjnM3StAZGOhmaFFEpGiOk6Ki/SYfPBuegIzLsLL0prTnl9pco7a+FAK9pc1IeuHZrcAgao0L3G+5A0n0O8=
X-Received: by 2002:ab0:66d1:: with SMTP id d17mr3440639uaq.89.1547633966865;
 Wed, 16 Jan 2019 02:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20190115183643.120619-1-trong@google.com> <20190115183643.120619-5-trong@google.com>
 <CAKwvOdkUMpqu3_2bC1DJ47JKg-YVDZDbUOwu63uGkH+wvxA=cg@mail.gmail.com>
In-Reply-To: <CAKwvOdkUMpqu3_2bC1DJ47JKg-YVDZDbUOwu63uGkH+wvxA=cg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 16 Jan 2019 19:18:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQXY-hU+dvgRM15zRKu-noK=esQu+85uASYFPC5UwfnhA@mail.gmail.com>
Message-ID: <CAK7LNAQXY-hU+dvgRM15zRKu-noK=esQu+85uASYFPC5UwfnhA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] gcov: clang: pick GCC vs Clang format depending on compiler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tri Vo <trong@android.com>, oberpar@linux.ibm.com,
        Greg Hackmann <ghackmann@android.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 7:00 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Masahiro
>
> On Tue, Jan 15, 2019 at 10:37 AM Tri Vo <trong@android.com> wrote:
> >
> > From: Tri Vo <trong@android.com>
> >
> > Clang gcov format is only supported by Clang compiler, and Clang
> > compiler only supports Clang format.
> >
> > We set gcov format to depend on which compiler (GCC or Clang) is used.
> >
> > Automatic format detection behavior is preserved because:
> > If GCC is used, one of the GCC gcov formats is selected.
> > If Clang is used, Clang gcov format is selected.
> >
> > Signed-off-by: Tri Vo <trong@android.com>
> > ---
> >  kernel/gcov/Kconfig  | 8 ++------
> >  kernel/gcov/Makefile | 2 +-
> >  2 files changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> > index eb428e570923..f71c1adcff31 100644
> > --- a/kernel/gcov/Kconfig
> > +++ b/kernel/gcov/Kconfig
> > @@ -53,6 +53,7 @@ config GCOV_PROFILE_ALL
> >  choice
> >         prompt "Specify GCOV format"
> >         depends on GCOV_KERNEL
> > +       depends on CC_IS_GCC
> >         ---help---
> >         The gcov format is usually determined by the GCC version, and the
> >         default is chosen according to your GCC version. However, there are
> > @@ -62,7 +63,7 @@ choice
> >
> >  config GCOV_FORMAT_3_4
> >         bool "GCC 3.4 format"
> > -       depends on CC_IS_GCC && GCC_VERSION < 40700
> > +       depends on GCC_VERSION < 40700
> >         ---help---
> >         Select this option to use the format defined by GCC 3.4.
> >
> > @@ -71,11 +72,6 @@ config GCOV_FORMAT_4_7
> >         ---help---
> >         Select this option to use the format defined by GCC 4.7.
> >
> > -config GCOV_FORMAT_CLANG
> > -       bool "Clang format"
> > -       ---help---
> > -       Select this option to use the format defined by Clang.
> > -
> >  endchoice
> >
> >  endmenu
> > diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
> > index 83da4765c18d..d66a74b0f100 100644
> > --- a/kernel/gcov/Makefile
> > +++ b/kernel/gcov/Makefile
> > @@ -4,4 +4,4 @@ ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
> >  obj-y := base.o fs.o
> >  obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_base.o gcc_3_4.o
> >  obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_base.o gcc_4_7.o
> > -obj-$(CONFIG_GCOV_FORMAT_CLANG) += clang.o
> > +obj-$(CONFIG_CC_IS_CLANG) += clang.o
>
> I think this was the suggestion from Masahiro from v1?

Yes.


What is strange is, 2/4 added GCOV_FORMAT_CLANG,
then 4/4 deletes it.


Probably, changing the patch order,
or squashing 4/4 into 2/4 would be cleaner.




-- 
Best Regards
Masahiro Yamada
