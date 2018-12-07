Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE3CC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E035F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WwJgDjVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E035F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeLGJvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:51:12 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:41839 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLGJvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:51:12 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wB79p6Q4021671;
        Fri, 7 Dec 2018 18:51:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wB79p6Q4021671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544176267;
        bh=tC4pLKXe7cYPj56m/gRdJtE80wxKsTy9wYda3oxXOVk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WwJgDjVAhjxaP+i0AZXPedwS6A0wkDuLbR1392L5elHvpT5RRNUKhQQa0VQufemWk
         2pWPvMCx+pEcDfbIOYe1S57IQca3uY8tqf5lPHcRIeXycZttwlUabGH18iwkJmvDpf
         VY+Dq7DMKsKL2/nFTYl2Iz0TCmxG1aZ+sfCTiYAaox65kHH3IkVO4XukrcbBezwXga
         r60eG0lWoaJx+Zll7AJOzXBJfeTuTbweh3spujmc4by//gpUyaih8ps/60gQHZM/IB
         PpU0czUU07yKy/DXT5fDT1gcn24qCV8EXVEqknqz8PO3BoZm4StuyVVWH4qWLA2lPQ
         dkSXbLbI1+26w==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id g68so2076624vsd.11;
        Fri, 07 Dec 2018 01:51:06 -0800 (PST)
X-Gm-Message-State: AA+aEWYA+y8P8BgzeBXb3sWmfiix51ArBsiaggM/W3YShuVHC/a98jAb
        RYEWp1QteanGPwxwr5l+2Adi1NvhWGtocvJ4LFk=
X-Google-Smtp-Source: AFSGD/V5g0jqyQVenJmRZXtOxseyg82bz4TfXxmPlyHs12UnBi0aTpGEj4KdvMO8OM6QyGSOIjGwAiRzJp/SPEwedF8=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr578485vsm.181.1544176265715;
 Fri, 07 Dec 2018 01:51:05 -0800 (PST)
MIME-Version: 1.0
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com>
 <80bf0f6e-8f1f-314e-b22d-6e786cf15e45@monstr.eu> <CAK7LNAQBFfaJbFXf5h9LX689RUwA4kSeqPrimVOWDWq0XAVJ_Q@mail.gmail.com>
 <c8283f39-2d68-f7f7-82ee-c0da75755e5b@monstr.eu>
In-Reply-To: <c8283f39-2d68-f7f7-82ee-c0da75755e5b@monstr.eu>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 7 Dec 2018 18:50:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASLxKgBJ7m9+02ODZ_Cq8D7KRejPwnHNmzTxd-HGa5Rdw@mail.gmail.com>
Message-ID: <CAK7LNASLxKgBJ7m9+02ODZ_Cq8D7KRejPwnHNmzTxd-HGa5Rdw@mail.gmail.com>
Subject: Re: [PATCH 2/7] microblaze: adjust the help to the real behavior
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 9:54 PM Michal Simek <monstr@monstr.eu> wrote:
>
> On 06. 12. 18 6:27, Masahiro Yamada wrote:
> > Hi Michal,
> >
> > On Thu, Dec 6, 2018 at 12:41 AM Michal Simek <monstr@monstr.eu> wrote:
> >>
> >> On 03. 12. 18 8:50, Masahiro Yamada wrote:
> >>> "make ARCH=microblaze help" mentions simpleImage.<dt>.unstrip,
> >>> but it never works because Makefile assumes "system.unstrip" is
> >>> the name of DT.
> >>>
> >>> $ make ARCH=microblaze CROSS_COMPILE=microblaze-linux- simpleImage.system.unstrip
> >>>   [ snip ]
> >>> make[1]: *** No rule to make target 'arch/microblaze/boot/dts/system.unstrip.dtb', needed by 'arch/microblaze/boot/dts/system.dtb'.  Stop.
> >>> make: *** [Makefile;1060: arch/microblaze/boot/dts] Error 2
> >>> make: *** Waiting for unfinished jobs....
> >>>
> >>> Rip off the never-working target.
> >>>
> >>> In my understanding, simpleImage.<dt> works like a phony target that
> >>> generates multiple images. Reflect the behavior to the help message.
> >>>
> >>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>> ---
> >>>
> >>>  arch/microblaze/Makefile | 4 +---
> >>>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>>
> >>> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> >>> index 0823d29..97e1384 100644
> >>> --- a/arch/microblaze/Makefile
> >>> +++ b/arch/microblaze/Makefile
> >>> @@ -89,9 +89,7 @@ define archhelp
> >>>    echo '* linux.bin    - Create raw binary'
> >>>    echo '  linux.bin.gz - Create compressed raw binary'
> >>>    echo '  linux.bin.ub - Create U-Boot wrapped raw binary'
> >>> -  echo '  simpleImage.<dt> - ELF image with $(arch)/boot/dts/<dt>.dts linked in'
> >>> -  echo '                   - stripped elf with fdt blob'
> >>> -  echo '  simpleImage.<dt>.unstrip - full ELF image with fdt blob'
> >>> +  echo '  simpleImage.<dt> - Create images with $(arch)/boot/dts/<dt>.dts linked in'
> >>>    echo '  *_defconfig      - Select default config from arch/microblaze/configs'
> >>>    echo ''
> >>>    echo '  Targets with <dt> embed a device tree blob inside the image'
> >>>
> >>
> >> I understand what you are trying to say but I would still like to keep
> >> information about unstrip file.
> >> It is correct that it is not build target. It is just generated file and
> >> message above was used for description what it is.
> >> Definitely agree that this should be the part of targets but it should
> >> be in description.
> >> The same is for missing description for simpleImage.<dt>.strip and
> >> simpleImage.<dt>.ub files.
> >>
> >> Thanks,
> >> Michal
> >>
> >
> > If we want to be precise to the current behavior,
> > we could describe more.
> > (Is it too much?)
> >
> >
> > Architecture specific targets (microblaze):
> > * linux.bin    - Create raw binary
> >   linux.bin.gz - Create compressed raw binary
> >   linux.bin.ub - Create U-Boot wrapped raw binary
> >   simpleImage.<dt> - Create the following images with
> > arch/macroblaze/boot/dts/<dt>.dts linked in
>
> type - microblaze
> maybe <dtb> here.
>
> >                      simpleImage.<dt>        : raw image
> >                      simpleImage.<dt>.ub     : raw image with U-Boot header
> >                      simpleImage.<dt>.unstrip: ELF (identical to vmlinux)
> >                      simpleImage.<dt>.strip  : stripped ELF
> >   *_defconfig      - Select default config from arch/microblaze/configs
> >
> >
> >
> >
> > If you want to modify as you like,
> > I will not touch it though.
>
> what you have above is fine for me.


OK, I will send v2
with the typo fixed.

Thanks.




-- 
Best Regards
Masahiro Yamada
