Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15504C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94D52084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Xe/M04di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94D52084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeLEGLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:11:50 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:48625 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeLEGLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:11:50 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wB56BQ5x024859
        for <linux-kernel@vger.kernel.org>; Wed, 5 Dec 2018 15:11:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wB56BQ5x024859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543990287;
        bh=HOQIBPGxhmfjxUen8ioHXZgbxEuLiOVnO/JS61x0USQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xe/M04dimj1bHZhD2o/dlyg6NyDy2J+a3Mbt5YxqnRbxdI18Yfwfejpgqht++mFWm
         crm3+DidCLhevi4fJMDSKg0/hGDFmeQbR1tJaZ1CmZvd8DNog4JGtGANsqx0Lur9B2
         wQRWfGnVl4/KgnKw5ijmgJJXx9vde2bzByuJsFgEryvgv3uRyDP0rVGxu+UeZZYyNj
         eF+8PpVcjbgYTIZsm9XFdRHZuYjzIQB9nBZV4QM/IRQdOddDy68vb8QSELpS9E+88X
         Ew12ISN0uOcxZ4H3m/eHDwVic3H/8ZVYBLb/reS9DscTInMgmvyVCUZqXL54T2UtiB
         o6vWvTKzttFoQ==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id p9so6700110uaa.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:11:26 -0800 (PST)
X-Gm-Message-State: AA+aEWZ1BV1g4Ri0boiMTX4qBScP2/58V+O8uwHTf8c3/oXBWSUHA+v1
        EfErqI0tF1FN2AJfaecxWvDmSOgcR0q6FIk9ukc=
X-Google-Smtp-Source: AFSGD/V8TYOySbnK3Q3JEcoDcvNmIlvrqcB9xj38JpuJa9wGpx/4Y41gKiP8cmawpwgXe29z+mII3roXXXfs6nm5Osw=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr10593921uad.55.1543990285835;
 Tue, 04 Dec 2018 22:11:25 -0800 (PST)
MIME-Version: 1.0
References: <1543978802-24196-1-git-send-email-yamada.masahiro@socionext.com> <de8a06d6-11c5-19ea-07a6-37f8624c8b66@oracle.com>
In-Reply-To: <de8a06d6-11c5-19ea-07a6-37f8624c8b66@oracle.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 5 Dec 2018 15:10:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2HXGXr0YvkqO8eC3hNeVK=oVMOwrn08PgVNFH79Yq=w@mail.gmail.com>
Message-ID: <CAK7LNAR2HXGXr0YvkqO8eC3hNeVK=oVMOwrn08PgVNFH79Yq=w@mail.gmail.com>
Subject: Re: [PATCH] x86/build: fix compiler support check for CONFIG_RETPOLINE
To:     zhenzhong.duan@oracle.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Meelis Roos <mroos@linux.ee>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 3:08 PM Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:
>
>
> On 2018/12/5 11:00, Masahiro Yamada wrote:
> > It is wrong to add CONFIG option diagnostic to the Makefile parse
> > stage.
> >
> > Once you are hit by the error about non-retpoline compiler, the
> > compilation still breaks even after disabling CONFIG_RETPOLINE.
> >
> > The easiest fix is to move this check to the "archprepare" like commit
> > 829fe4aa9ac1 ("x86: Allow generating user-space headers without a
> > compiler") did.
> >
> > Link: https://lkml.org/lkml/2018/12/4/206
> > Reported-by: Meelis Roos <mroos@linux.ee>
> > Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >   arch/x86/Makefile | 14 ++++++++------
> >   1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index f5d7f41..ae0148b 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -219,12 +219,7 @@ KBUILD_CFLAGS += -Wno-sign-compare
> >   KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> >
> >   # Avoid indirect branches in kernel to deal with Spectre
> > -ifdef CONFIG_RETPOLINE
> > -ifeq ($(RETPOLINE_CFLAGS),)
> > -  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
> > -endif
> > -  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
> > -endif
> > +KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
>
> Is it better to also move "# Avoid indirect branches in kernel to deal
> with Spectre"
>
> and "KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)"?
>
> Seems unconditionaly using "KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)" will
> have compiler
>
> using "__x86_indirect_thunk_\reg" call even ifCONFIG_RETPOLINE is
> disabled. I guess
>
> link process will fail?


Good catch.

I will send v2.

Thanks.



> Thanks
>
> Zhenzhong
>
> >
> >   archscripts: scripts_basic
> >       $(Q)$(MAKE) $(build)=arch/x86/tools relocs
> > @@ -307,6 +302,13 @@ ifndef CC_HAVE_ASM_GOTO
> >       @echo Compiler lacks asm-goto support.
> >       @exit 1
> >   endif
> > +ifdef CONFIG_RETPOLINE
> > +ifeq ($(RETPOLINE_CFLAGS),)
> > +     @echo "You are building kernel with non-retpoline compiler." >&2
> > +     @echo "Please update your compiler." >&2
> > +     @false
> > +endif
> > +endif
> >
> >   archclean:
> >       $(Q)rm -rf $(objtree)/arch/i386



-- 
Best Regards
Masahiro Yamada
