Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D7DC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 23:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AA32174E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 23:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Isf1+pnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AA32174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeH0Dkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 23:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbeH0Dkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 23:40:37 -0400
Received: from mail-qt0-f182.google.com (mail-qt0-f182.google.com [209.85.216.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72BC21765;
        Sun, 26 Aug 2018 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535327787;
        bh=F90uRd00I7qjGkdmQIxWPnXuSayqBXzz3uw1xBDGY/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Isf1+pnV0k2C/o/tf1iWdrlX2nclQYLzfXSzBYI28Y5kIhZtDo+du+62s6rhUjxO3
         5dSUeMLuGn/YUxIve+b/xIhzv/yhlEhSwbaAnbxo9sqMUIS0ZYsxik2QCFStxtCpba
         mnHGwORmeln3hfC/1cATbBj6FfVWDfde72s+IBYI=
Received: by mail-qt0-f182.google.com with SMTP id g44-v6so15459227qtb.12;
        Sun, 26 Aug 2018 16:56:27 -0700 (PDT)
X-Gm-Message-State: APzg51CiLHk1GBf4vIlStquiNYxZOmWmpGN8xcwXOCPFvPcBrP9AVf+Y
        lq/IWZUeVnLaj0toSz9jXD8ONcg4InNDxYip/Q==
X-Google-Smtp-Source: ANB0VdYXaBkzLjjuN6Jl05rlY8/C96tphzzI4yozIiFMzwF28RZMRw6UGqb84nC6UfxRKJX5iV53U1RVtlxoEDFOIWI=
X-Received: by 2002:aed:2da7:: with SMTP id i36-v6mr11904798qtd.164.1535327786794;
 Sun, 26 Aug 2018 16:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180821215524.23040-1-robh@kernel.org> <20180821215524.23040-7-robh@kernel.org>
 <CAK7LNATcYSvwh0BEEdyUuDa_Y9X-AqQAzA5MrbNhOSMmSzqhTg@mail.gmail.com>
In-Reply-To: <CAK7LNATcYSvwh0BEEdyUuDa_Y9X-AqQAzA5MrbNhOSMmSzqhTg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 26 Aug 2018 18:56:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJJ6DCT8AjVYqkbFuJ+fO0VmVch24B=XRp4pJPkUQYAww@mail.gmail.com>
Message-ID: <CAL_JsqJJ6DCT8AjVYqkbFuJ+fO0VmVch24B=XRp4pJPkUQYAww@mail.gmail.com>
Subject: Re: [PATCH 6/8] kbuild: consolidate Devicetree dtb build rules
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 9:06 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Rob,
>
>
> 2018-08-22 6:55 GMT+09:00 Rob Herring <robh@kernel.org>:
> > There is nothing arch specific about building dtb files other than their
> > location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> > The dependencies and supported targets are all slightly different.
> > Also, a cross-compiler for each arch is needed, but really the host
> > compiler preprocessor is perfectly fine for building dtbs. Move the
> > build rules to a common location and remove the arch specific ones. This
> > is done in a single step to avoid warnings about overriding rules.
> >
> > The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> > These pull in several dependencies some of which need a target compiler
> > (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> > All that is really needed is dtc, so adjust the dependencies to only be
> > dtc.
> >
> > This change enables support 'dtbs_install' on some arches which were
> > missing the target.
> >
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: Vineet Gupta <vgupta@synopsys.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Michal Simek <monstr@monstr.eu>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: Ley Foon Tan <lftan@altera.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: linux-snps-arc@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: uclinux-h8-devel@lists.sourceforge.jp
> > Cc: linux-mips@linux-mips.org
> > Cc: nios2-dev@lists.rocketboards.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-xtensa@linux-xtensa.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Makefile                 | 30 ++++++++++++++++++++++++++++++
> >  arch/arc/Makefile        |  6 ------
> >  arch/arm/Makefile        | 20 +-------------------
> >  arch/arm64/Makefile      | 17 +----------------
> >  arch/c6x/Makefile        |  2 --
> >  arch/h8300/Makefile      | 11 +----------
> >  arch/microblaze/Makefile |  4 +---
> >  arch/mips/Makefile       | 15 +--------------
> >  arch/nds32/Makefile      |  2 +-
> >  arch/nios2/Makefile      |  7 -------
> >  arch/nios2/boot/Makefile |  4 ----
> >  arch/powerpc/Makefile    |  3 ---
> >  arch/xtensa/Makefile     | 12 +-----------
> >  scripts/Makefile         |  1 -
> >  scripts/Makefile.lib     |  2 +-
> >  15 files changed, 38 insertions(+), 98 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index c13f8b85ba60..6d89e673f192 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1212,6 +1212,30 @@ kselftest-merge:
> >                 $(srctree)/tools/testing/selftests/*/config
> >         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >
> > +# ---------------------------------------------------------------------------
> > +# Devicetree files
> > +
> > +dtstree := $(wildcard arch/$(SRCARCH)/boot/dts)

BTW, there's an error here too. It doesn't work right with
KBUILD_OUTPUT set and should be:

ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
dtstree := arch/$(SRCARCH)/boot/dts
endif

> > +
> > +ifdef CONFIG_OF_EARLY_FLATTREE
> > +
> > +%.dtb %.dtb.S %.dtb.o: | dtc
>
> I think the pipe operator is unnecessary
> because Kbuild will descend to $(dtstree) anyway.

The pipe means 'order-only', right? So it is just a weaker dependency
for things which are not input files as dtc is not. The 'dtc' here is
just the dtc rule below, not the actual executable. Or am I missing
something?

> > +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> > +
> > +PHONY += dtbs
> > +dtbs: | dtc
>
> Ditto.
>
>
> > +       $(Q)$(MAKE) $(build)=$(dtstree)
> > +
> > +dtbs_install: dtbs
> > +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> > +
> > +all: dtbs
> > +
> > +dtc:
> > +       $(Q)$(MAKE) $(build)=scripts/dtc
> > +
> > +endif
> > +
>
>
> arch/*/boot/dts/ are not only directories that
> require dtc.

Ah yes, of course...

> > diff --git a/scripts/Makefile b/scripts/Makefile
> > index 61affa300d25..a716a6b10954 100644
> > --- a/scripts/Makefile
> > +++ b/scripts/Makefile
> > @@ -39,7 +39,6 @@ build_unifdef: $(obj)/unifdef
> >  subdir-$(CONFIG_MODVERSIONS) += genksyms
> >  subdir-y                     += mod
> >  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
> > -subdir-$(CONFIG_DTC)         += dtc
> >  subdir-$(CONFIG_GDB_SCRIPTS) += gdb
> >
> >  # Let clean descend into subdirs

Looks like I need to leave this line to fix the above and cleaning.

Thanks for the review.

Rob
