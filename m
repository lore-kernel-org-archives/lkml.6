Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7641EC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4630E20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zkBlk2QN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfAKCQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:16:07 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:41450 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfAKCQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:16:06 -0500
X-Greylist: delayed 87258 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2019 21:16:04 EST
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x0B2FwTH004798;
        Fri, 11 Jan 2019 11:15:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x0B2FwTH004798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547172959;
        bh=42GLpL/gpsKXFu8DqqjKXktpxexfEsj5sSrDCB8KNK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zkBlk2QNc9mPtufMq/iEjn53cFumIq9wAjcRocCCI8RgPJoM9H06ehv9oHlliijj2
         VqbqumDlCzSiTikRTbTfXThbA1amJn6fVjQnzAh8FhuCJy+dbuR8foocn623SuGKRX
         PalZQ9tPvDVjPUXv2HPH1v+ZejrZ3xVhpWf9rhS3BrjhBQeLY6sSG2wKXnmRtszfc/
         YL/DBjeigJncwvGX4uRR1hnd16PS13DLbf1mTYjxP9mBx+pBhSIMi15uDm44DhLtQc
         1Ohw/ys088tXIuII3zV3ZpdyHtKu9m8Q/qo9b7sx5aC+PVGWtzsdWjjdleGkBeck5e
         ZoPD9AFKyPYJw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id n10so8296918vso.13;
        Thu, 10 Jan 2019 18:15:59 -0800 (PST)
X-Gm-Message-State: AJcUukcCNanyw0qj2F0puWErTvP8UrXQOTGMU/FU3HZpL6lZVMtlfwNH
        D0hCRDXzNEa6pGWFfdKHByFn3H+ZI2yHA1kZqUo=
X-Google-Smtp-Source: ALg8bN4SQcR8JmaN7fz8IHJOtx1jgiIcL8bQMLKI5tjEzGHJgWel8E4Tq061mmjnOUjlpsSeUvNzf0BEx43rqSWYHTI=
X-Received: by 2002:a67:385a:: with SMTP id f87mr5196361vsa.179.1547172958102;
 Thu, 10 Jan 2019 18:15:58 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdUw9LMVb-8RSNVBEcDMVB9SFOdfF+kb20=gxJiWF1x8sQ@mail.gmail.com>
 <20190109231539.24613-1-paul.burton@mips.com> <CAK7LNAReiEzF1nS8WR_yUmi-boJnfLWw5bjUvL2rDEAYnxwCzw@mail.gmail.com>
 <20190110181106.otlwmiznvq2l67iv@pburton-laptop>
In-Reply-To: <20190110181106.otlwmiznvq2l67iv@pburton-laptop>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 11 Jan 2019 11:15:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-r4gZOxdJCNaQwHtOYbxHbdupu57qncWkE+bhGfb_7g@mail.gmail.com>
Message-ID: <CAK7LNAS-r4gZOxdJCNaQwHtOYbxHbdupu57qncWkE+bhGfb_7g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace
 & GCC <= 4.7
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 3:11 AM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Masahiro,
>
> On Thu, Jan 10, 2019 at 11:00:49AM +0900, Masahiro Yamada wrote:
> > On Thu, Jan 10, 2019 at 8:16 AM Paul Burton <paul.burton@mips.com> wrote:
> > > When building using GCC 4.7 or older, -ffunction-sections & the -pg flag
> > > used by ftrace are incompatible. This causes warnings or build failures
> > > (where -Werror applies) such as the following:
> > >
> > >   arch/mips/generic/init.c:
> > >     error: -ffunction-sections disabled; it makes profiling impossible
> > >
> > > This used to be taken into account by the ordering of calls to cc-option
> > > from within the top-level Makefile, which was introduced by commit
> > > 90ad4052e85c ("kbuild: avoid conflict between -ffunction-sections and
> > > -pg on gcc-4.7"). Unfortunately this was broken when the
> > > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION cc-option check was moved to
> > > Kconfig in commit e85d1d65cd8a ("kbuild: test dead code/data elimination
> > > support in Kconfig"), because the flags used by this check no longer
> > > include -pg.
> > >
> > > Fix this by not allowing CONFIG_LD_DEAD_CODE_DATA_ELIMINATION to be
> > > enabled at the same time as ftrace/CONFIG_FUNCTION_TRACER when building
> > > using GCC 4.7 or older.
> > >
> > > Signed-off-by: Paul Burton <paul.burton@mips.com>
> > > Fixes: e85d1d65cd8a ("kbuild: test dead code/data elimination support in Kconfig")
> > > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Cc: Nicholas Piggin <npiggin@gmail.com>
> > > Cc: stable@vger.kernel.org # v4.19+
> > > ---
> > >  init/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index d47cb77a220e..c787f782148d 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1124,6 +1124,7 @@ config LD_DEAD_CODE_DATA_ELIMINATION
> > >         bool "Dead code and data elimination (EXPERIMENTAL)"
> > >         depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> > >         depends on EXPERT
> > > +       depends on !FUNCTION_TRACER || !CC_IS_GCC || GCC_VERSION >= 40800
> > >         depends on $(cc-option,-ffunction-sections -fdata-sections)
> > >         depends on $(ld-option,--gc-sections)
> > >         help
> >
> > Thanks for the fix.
> >
> > I prefer this explicit 'depends on'.
> >
> > Relying on the order of $(call cc-option, ...) in Makefile is fragile.
> >
> > We raise the compiler minimum version from time to time.
> > So, this 'depends on' will eventually go away in the future.
> >
> > BTW, which one do you think more readable?
> >
> > depends on !FUNCTION_TRACER || !CC_IS_GCC || GCC_VERSION >= 40800
> >
> >     OR
> >
> > depends on !(FUNCTION_TRACER && CC_IS_GCC && GCC_VERSION < 40800)
>
> Thanks - yes I agree it's nice that this is more explicit than the
> ordering we previously relied upon.
>
> I personally don't mind either of the 2 options above - let me know if
> you'd like me to submit a v2 using your second option.
>
> Thanks,
>     Paul



Personally, I slightly prefer this:
   depends on !(FUNCTION_TRACER && CC_IS_GCC && GCC_VERSION < 40800)


It is more consistent with your patch title:
   "Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace & GCC <= 4.7"


May I ask v2?



-- 
Best Regards
Masahiro Yamada
