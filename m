Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D543C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3061D2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DbzflONf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3061D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLHGwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 01:52:20 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:41949 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeLHGwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 01:52:20 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wB86qGKb000626;
        Sat, 8 Dec 2018 15:52:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wB86qGKb000626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544251937;
        bh=K0V/brdv1afN59ArpYbZlRexSGKTC+L144URixQKO5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DbzflONfaZdT7jVYMezKpa2p/tyZhlTH/bg+XB1Sdk8kbskUon2Z0njHwdXMi3zyq
         vIfYleIhYQ54FFcDPL9wNCcv7jGj3MfpXS6mi+RWqm/glETWlxwms1hvK5irJDmv8p
         eQRc7rBOPLFraOyaA5kDQ0BYt4Nr6PkVFuZiGZq4DJE57buKTpjlfGskGo4vs9revQ
         K9Y5VHE76lQbLPRzp7uHiMdWhRPICLrvoYEANaNj0RdTKEJt1mijq2A6s9SOmaDfXE
         iqxN6oNPoJg4eDrWqGouZC7YmdU17PD0rpmjP3hKv0LYoxloTSz+ERA8yYaMFjICyK
         xniJEXNqe22/w==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id e7so3811277vsc.2;
        Fri, 07 Dec 2018 22:52:17 -0800 (PST)
X-Gm-Message-State: AA+aEWZ97tbVNb78ZAXS4cWGU2a67OeTidixYPxYnTu+lpsuV4HH6xZx
        9kMnr+fgD9XWWuJB93mYFUJU6U5M/dJRSG2b1XQ=
X-Google-Smtp-Source: AFSGD/WfXTz0ce1UOpg8ekMUQFyG751UwJw600dX+QSbFBb0WHFe+8oEZPhB3fIlQFeowvaTL9aL61ZAxPwkzvJbhZ4=
X-Received: by 2002:a67:a858:: with SMTP id r85mr2111685vse.215.1544251935736;
 Fri, 07 Dec 2018 22:52:15 -0800 (PST)
MIME-Version: 1.0
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-7-git-send-email-yamada.masahiro@socionext.com> <ccf309af-f225-2c12-cb2f-1d8787d2e4fa@monstr.eu>
In-Reply-To: <ccf309af-f225-2c12-cb2f-1d8787d2e4fa@monstr.eu>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 8 Dec 2018 15:51:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASP4nifHrWRzUr2sHM=2ytg1fxi0=u4mLnTfrcbQc1U6g@mail.gmail.com>
Message-ID: <CAK7LNASP4nifHrWRzUr2sHM=2ytg1fxi0=u4mLnTfrcbQc1U6g@mail.gmail.com>
Subject: Re: [PATCH 6/7] microblaze: fix race condition in building boot images
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 1:32 AM Michal Simek <monstr@monstr.eu> wrote:
>
> On 03. 12. 18 8:50, Masahiro Yamada wrote:
> > I fixed a race condition in the parallel building of ARM in commit
> > 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
> > generate invalid images").
> >
> > I see the same problem for MicroBlaze too.
> >
> > "make -j<N> ARCH=microblaze all linux.bin.ub" results in a broken build
> > since two threads descend into arch/microblaze/boot simultaneously.
>
> I see also different problem that when I run that make above
> linux.bin.ub is not generated at all.


That's why I am fixing the problem.

Before the fix, the parallel build fails.


/usr/bin/mkimage: Can't read arch/microblaze/boot/linux.bin: Invalid argument
arch/microblaze/boot/Makefile:14: recipe for target
'arch/microblaze/boot/linux.bin.ub' failed
make[1]: *** [arch/microblaze/boot/linux.bin.ub] Error 1
make[1]: *** Deleting file 'arch/microblaze/boot/linux.bin.ub'
arch/microblaze/Makefile:87: recipe for target 'linux.bin.ub' failed
make: *** [linux.bin.ub] Error 2
make: *** Waiting for unfinished jobs....
  MODPOST 6 modules
Kernel: arch/microblaze/boot/linux.bin is ready  (#2)





>
> >
> > Add proper dependencies to avoid it.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/microblaze/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> > index 7a5df02..544796d 100644
> > --- a/arch/microblaze/Makefile
> > +++ b/arch/microblaze/Makefile
> > @@ -79,13 +79,15 @@ all: linux.bin
> >  archclean:
> >       $(Q)$(MAKE) $(clean)=$(boot)
> >
> > +linux.bin.ub linux.bin.gz: linux.bin
> > +
> >  PHONY += linux.bin linux.bin.gz linux.bin.ub
> >  linux.bin linux.bin.gz linux.bin.ub: vmlinux
> >       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> >       @echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
> >
> >  PHONY += simpleImage.$(DTB)
> > -simpleImage.$(DTB): vmlinux
> > +simpleImage.$(DTB): linux.bin.ub
>
> It looks weird that simpleImage requires linux.bin.ub.
> Is it really linux.bin.ub here or just linux.bin?


This is intentional to avoid a race in
"make simpleImage.<dt> linux.bin.ub"


But, I chose to make simpleImage* independent of linux.bin* in v2.

I hope you will like it.



> >       $(Q)$(MAKE) $(build)=$(boot) simple_images
> >       @echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
> >
> >
>
>
> Thanks,
> Michal
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
>
>


-- 
Best Regards
Masahiro Yamada
