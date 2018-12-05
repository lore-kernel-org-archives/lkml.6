Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F373C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1018020851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="D5hMByL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1018020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeLEErM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 23:47:12 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:56131 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeLEErM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 23:47:12 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wB54l6xV006851
        for <linux-kernel@vger.kernel.org>; Wed, 5 Dec 2018 13:47:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wB54l6xV006851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543985227;
        bh=GzkS4h4Ujv5cjCGlb28VArFAZA7CFiQ8t4vY6W5xyhA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D5hMByL1ZjwYxGOaBlsgvkDm/jDrd62yKWF0YxfAsz4fwxpvy3Ifwlea3szWuFwGG
         IC4nzAIvwKfpf6DQ8jZfLW7T9O3JV+4ebCg08lZ9NTVBK01MdnTwunnO48nraynAQC
         lBnwgBX+MqYxVHUs70GoMChNPQ6Sbq7yzax86w6hzBdZjB5Mg+duXipTEYaCtfdYkr
         wtYHp16p+NrjAtlMe8fc6y8uJTYcC4zzuPysnAHRJbSeG1QSwdVoCOxI8F2nlNony/
         IgqLxYyxdEGxaaE/UKTrGzygA+92/xamh3wkhUlzxyN8H/BfMac9It0FD/3xuzEnJQ
         9Y4ns1F319QlQ==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id x64so11300791vsa.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 20:47:07 -0800 (PST)
X-Gm-Message-State: AA+aEWZe71FB7x3e5rM1w1oF7Nq3QlyAzfFaoKb/wtugaybFL12NP86P
        ejWoXRSJQJiFIgC+vJTV3gu5WVi+fCew/PQwuZI=
X-Google-Smtp-Source: AFSGD/XE+7FxjodUYxt6tU36TJf45fReWoeTS/eWwhHFeSW1wu4LEWH1j6lS129Zk/efb6RJb0gQy8h1CH9GYPNeG6w=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr10118414vsb.155.1543985226168;
 Tue, 04 Dec 2018 20:47:06 -0800 (PST)
MIME-Version: 1.0
References: <1543978802-24196-1-git-send-email-yamada.masahiro@socionext.com> <39eae552-38cb-d6af-4717-e8a1cb1931cd@oracle.com>
In-Reply-To: <39eae552-38cb-d6af-4717-e8a1cb1931cd@oracle.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 5 Dec 2018 13:46:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyTCkhgxGeAvhkuzCqfWSmJ1wZ52vQSqbQkCv=66F-=A@mail.gmail.com>
Message-ID: <CAK7LNASyTCkhgxGeAvhkuzCqfWSmJ1wZ52vQSqbQkCv=66F-=A@mail.gmail.com>
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

On Wed, Dec 5, 2018 at 12:23 PM Zhenzhong Duan
<zhenzhong.duan@oracle.com> wrote:
>
> Hi Masahiro,
>
>
> Thanks for fixing.
> There is a question still confusing me. There are many CONFIG_* used in
> arch/x86/Makefile.
> Will they also be impacted or not?


The top level Makefile (and arch/*/Makefile) is getting huge.
Parsing the whole Makefile everytime means,
it computes variables that may or may not be used.

$(call cc-option,...) is a bit costly,
but other parts are unnoticeable
in terms of performance.


I am addressing the use of $(error ...) / $(warning ...)
in the non-recipe context since they could break the build
for false positive reasons.




> # grep CONFIG_ arch/x86/Makefile
> ifeq ($(CONFIG_X86_32),y)
>          cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
>          cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
>   ......
> drivers-$(CONFIG_MATH_EMULATION) += arch/x86/math-emu/
> drivers-$(CONFIG_PCI)      += arch/x86/pci/
> drivers-$(CONFIG_OPROFILE) += arch/x86/oprofile/
> drivers-$(CONFIG_PM) += arch/x86/power/
> drivers-$(CONFIG_FB) += arch/x86/video/
> ifeq ($(CONFIG_X86_DECODER_SELFTEST),y)
>
> Thanks
> Zhenzhong
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
