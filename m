Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13568C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9094020862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cVt79Hka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9094020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeKESiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:38:05 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:48465 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:38:04 -0500
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wA59J1vP001679;
        Mon, 5 Nov 2018 18:19:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wA59J1vP001679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541409542;
        bh=5953TNGqFYaSYDubC/1Efna8xhOdcudA9Ev/Z2VUABQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cVt79HkaEH50XWPku/v1vwNWVL5b/a8365HujavCmNg7nVOizi2OmA4RiKUtVWC6g
         i+7zmy823a2CVeXRd212eksXvXh7mL77wr7q9WaTwO7LaxCh2J5l5An7wyjIF8bV6u
         m64XyvYdagWi6FWRY5tvWDoJiHr7Zw0QTdP9ZbVgJu+CLncaX4PS6c5LLPMibCaCzl
         vEaZrgn1ilvvZALJ8ais6ELsS1NFZG/s/xALjiEmbGGGu+IMPrGlUXpIUND7v5G2PT
         Utlv6lnWTcnzsdk0rYQXUfvcDokb+di5+65J+k8WxTXwOKrIH/HbyEFpVbN2Y3znVB
         P3A8Mvu7LEZFA==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id y14so1551588vky.9;
        Mon, 05 Nov 2018 01:19:02 -0800 (PST)
X-Gm-Message-State: AGRZ1gIEHkPUHxB4H8TchyWu9zzgmYZeHV0s6uRtq71mW47lC8j25aJR
        geeANiQCpjtHAIZ8ArNnPTAZVk6eKX69DOyQvRw=
X-Google-Smtp-Source: AJdET5fcpXmljxPwGWetTE7Kp6ORxX4rZUbuJFeZb9yutRDPnN8qGnqIwhOSqcUYiDXxKWqI5OjrY970Fz+Z+si/rqw=
X-Received: by 2002:a1f:fcc3:: with SMTP id a186mr4045096vki.0.1541409541175;
 Mon, 05 Nov 2018 01:19:01 -0800 (PST)
MIME-Version: 1.0
References: <1541386099-13118-1-git-send-email-yamada.masahiro@socionext.com> <a55e4534ef759585088a037e4cfd8468@agner.ch>
In-Reply-To: <a55e4534ef759585088a037e4cfd8468@agner.ch>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 5 Nov 2018 18:18:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3ftcuNDfEhecMnfjG0Fkkh42wR7XQ1R9Tkr9OMrzAng@mail.gmail.com>
Message-ID: <CAK7LNAT3ftcuNDfEhecMnfjG0Fkkh42wR7XQ1R9Tkr9OMrzAng@mail.gmail.com>
Subject: Re: [PATCH] kbuild: consolidate Clang compiler flags
To:     Stefan Agner <stefan@agner.ch>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chris Fries <cfries@google.com>, Joel Stanley <joel@jms.id.au>,
        dja@axtens.net, Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 6:10 PM Stefan Agner <stefan@agner.ch> wrote:
>
> On 05.11.2018 03:48, Masahiro Yamada wrote:
> > Add basic options for Clang such as --target, --prefix, --gcc-toolchain,
> > -no-integrated-as to a single variable CLANG_FLAGS.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  Makefile | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 93315eb..58c838a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -487,18 +487,17 @@ endif
> >
> >  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> >  ifneq ($(CROSS_COMPILE),)
> > -CLANG_TARGET := --target=$(notdir $(CROSS_COMPILE:%-=%))
> > +CLANG_FLAGS  = --target=$(notdir $(CROSS_COMPILE:%-=%))
> >  GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> > -CLANG_PREFIX := --prefix=$(GCC_TOOLCHAIN_DIR)
> > +CLANG_FLAGS  += --prefix=$(GCC_TOOLCHAIN_DIR)
>
> So this will expand later now, is this ok?
>
> --
> Stefan
>
> >  GCC_TOOLCHAIN        := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
> >  endif
> >  ifneq ($(GCC_TOOLCHAIN),)
> > -CLANG_GCC_TC := --gcc-toolchain=$(GCC_TOOLCHAIN)
> > +CLANG_FLAGS  += --gcc-toolchain=$(GCC_TOOLCHAIN)
> >  endif
> > -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> > -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> > -KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> > -KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
> > +CLANG_FLAGS  += $(call cc-option, -no-integrated-as)
> > +KBUILD_CFLAGS        += $(CLANG_FLAGS)
> > +KBUILD_AFLAGS        += $(CLANG_FLAGS)


CLANG_FLAGS is expanded here because KBUILD_CFLAGS and KBUILD_AFLAGS
are defined by using :=

So, it should be OK, but turning CLANG_FLAGS into a simple variable
will be a little more efficient since $(call cc-option, -no-integrated-as)
is evaluated just once.

(Or, this cc-option may not be necessary any longer.)

Will send v2.


Thanks.




> >  endif
> >
> >  RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern
> > -mindirect-branch-register



-- 
Best Regards
Masahiro Yamada
