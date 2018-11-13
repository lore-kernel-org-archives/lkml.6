Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F09EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B4922360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RVtJbFIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B4922360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeKNJ1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:27:21 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:60359 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:27:20 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wADNQX04011717;
        Wed, 14 Nov 2018 08:26:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wADNQX04011717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542151594;
        bh=H19KUOWN4xazhYwVSeJa/gSibFit0YLjPoV/RmvAHWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RVtJbFILjNpiB9oic/L9EmI1R2kl2BbiQJkqBab0wzTWv5rbr2jjpHJzuzJpMrWoC
         xX399fdes5A0XUlh12o1UKPJEa9exuBxtf6gyeHHj+bb92m1M8Pmr1Rnh2GKAnYnKR
         lkPnPwPqR+7x61qwVZZcAJ3ODuMeIwKtO4Y6fv8l2r7BO4NAwRTD7zQP+FSG+bZcj9
         ITznOrlfTsxBhiTTzgIgreAtsz8CMgpfiESK/MCjuRhqYQez9z3Z3hPxMPD4QecasQ
         KrwLNxjhpZtov30baVG45CLJqLxNxyZtfP2Jv3PRyrGpW8tI711ZwhFllix0OvJglE
         9NNXxb/5XDTCw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id p74so8440832vsc.0;
        Tue, 13 Nov 2018 15:26:33 -0800 (PST)
X-Gm-Message-State: AGRZ1gKChbSOYayX9LPPF6xeO37N6LqkhUW4pM2o2NbRBLKHuAWup/kd
        s4Ht5LnzxaA//D6T9dwOT9Jj5o/EXzwWx+EjXRE=
X-Google-Smtp-Source: AJdET5eBFEGTsWr7p1Fq910Jouat4hvARLD4PzT2AZyCbJkez4rjdALQ7y5NYdrzJCQ2/UgPoPsIILGvpNC0pcKrrgA=
X-Received: by 2002:a67:385a:: with SMTP id f87mr3297449vsa.179.1542151592847;
 Tue, 13 Nov 2018 15:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20181112042116.5271-1-joel@jms.id.au> <20181112042116.5271-3-joel@jms.id.au>
 <CAKwvOd=Sck9MMyq4sBe24iNbcVd=KX7enfxN=+Y7uvL-YrxHrg@mail.gmail.com>
In-Reply-To: <CAKwvOd=Sck9MMyq4sBe24iNbcVd=KX7enfxN=+Y7uvL-YrxHrg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 14 Nov 2018 08:25:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNARF0vKwY7WxjZWPyJxJByqU_a_Fz0NSbny=K=FL9nDZ6A@mail.gmail.com>
Message-ID: <CAK7LNARF0vKwY7WxjZWPyJxJByqU_a_Fz0NSbny=K=FL9nDZ6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/boot: Set target when cross-compiling for clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>, dja@axtens.net,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 4:03 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Nov 11, 2018 at 8:21 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > Clang needs to be told which target it is building for when cross
> > compiling.
>
> Neat! This will help us for continuous integration.
> https://github.com/ClangBuiltLinux/continuous-integration
>
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/259
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> Assuming patch 1/2 gets fixed up (or is fine) and doesn't radically change:
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>



Applied to linux-kbuild.
Thanks!



> > ---
> >  arch/powerpc/boot/Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> > index 39354365f54a..111f97b1ccec 100644
> > --- a/arch/powerpc/boot/Makefile
> > +++ b/arch/powerpc/boot/Makefile
> > @@ -55,6 +55,11 @@ BOOTAFLAGS   := -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
> >
> >  BOOTARFLAGS    := -cr$(KBUILD_ARFLAGS)
> >
> > +ifdef CONFIG_CC_IS_CLANG
> > +BOOTCFLAGS += $(CLANG_FLAGS)
> > +BOOTAFLAGS += $(CLANG_FLAGS)
> > +endif
> > +
> >  ifdef CONFIG_DEBUG_INFO
> >  BOOTCFLAGS     += -g
> >  endif
> > --
> > 2.19.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
