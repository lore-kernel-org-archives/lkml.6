Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E72C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C056C20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVEhQtmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C056C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeLETao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:30:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34257 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLETao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:30:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so12483307wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ewfe0w25rqowReqHV6TpWvacevriFTKv9Ol1/yY+UJQ=;
        b=JVEhQtmwxsXYVL2QlhHOakAgD/aB9iOrGk5kZH3hKCAaep9lDYZIXSS39hUVjPK2dW
         wJsqb/XvuHAC724m3tEh2I5ADqjDzG3jg71Niu+tLGQrqLqMmZMz+nWX8IIGHFZZqGs0
         lcbS3e2ja4LUAGNuQ7Fo9q79Lsco+sMAZLBs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ewfe0w25rqowReqHV6TpWvacevriFTKv9Ol1/yY+UJQ=;
        b=SGLM2xeo3q4KKNZi8UDV4zXEye1astIJmcCjHCUQZIYOvVLkAYSp9+VVa3vw0CNaxC
         f3MFHWmy0PMB89XMOpd/2ge/oFC/B9y6f56wVXSAGiQq2qq2DiAK2+BmPXKMNucCXsMz
         kc/UmKm7gde6Vy+xCDzsRu0lYXwsMYDmL/dYnVR6X9n3YAXQt5UQqkn3nJC4DEpMLVly
         NPonJKgd5UcWlliadWqCqi7cv1q43+QYj3A33YoKVeN9gZS1ttETwX/iJUX2gHBA38lR
         EL941jCXfCiUU52vIWj/7Ugj0AFVMNTxXKOIZNEScvy82l4yno1I39zPwCTQLPiXnZJF
         n/Bw==
X-Gm-Message-State: AA+aEWbj2WsuJZkrz2JGySGSHyh4CYfz6vKNQXLrW1Km2h5m/CbYKWrO
        TdIGRd7ts0CNLpEuBqwrtdc0mUCILZV1OU0Ioqho1Q==
X-Google-Smtp-Source: AFSGD/WZsm5yEpkFYWvohekYBZiL6AvbYJVqCmJ4QRUiKAuVHhVmyz3vk2mM7GOKRO9F3o9vlajd6uNFLXUiIA2+yOs=
X-Received: by 2002:a1c:400b:: with SMTP id n11mr17431022wma.85.1544038241906;
 Wed, 05 Dec 2018 11:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com> <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox> <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <CAKwvOdno9AdzNvMVmzqV7y+_u_z7VgfbRvKm73rRZ+iUuraYtw@mail.gmail.com>
In-Reply-To: <CAKwvOdno9AdzNvMVmzqV7y+_u_z7VgfbRvKm73rRZ+iUuraYtw@mail.gmail.com>
From:   Peter Smith <peter.smith@linaro.org>
Date:   Wed, 5 Dec 2018 19:30:30 +0000
Message-ID: <CAEt-8LCXxU=Lo9Kc6K5FDvMV7xyfCbA3yF=VrLkuYJ8RrcviBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        natechancellor@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stefan@agner.ch,
        nicolas.pitre@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 18:22, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Dec 5, 2018 at 12:10 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > (+ Arnd)
> >
> > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > >
> > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > > >
> > > > > This flag is not supported by lld:
> > > > >
> > > > >     ld.lld: error: unknown argument: --pic-veneer
> > > > >
> > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > >
> > > > Hi Nate,
> > > >
> > > > Does this mean ld.lld is guaranteed to produce position independent
> > > > veneers if you build kernels that are bigger than the typical range of
> > > > a relative branch?
>
> (+ Peter) who might be able to answer this.
>

LLD will only use position independent veneers when --shared or --pie
is used, otherwise it will use veneers with absolute addresses. If the
kernel must use position independent veneers even when the rest of the
code isn't then we'll have to implement --pic-veneer.

Peter

> > > >
> > >
> > > Hi Ard,
> > >
> > > Honestly, I'm not quite sure. I saw your commit that introduced this
> > > flag and I wasn't quite sure what to make of it for lld. What
> > > configuration would I use to verify and what would I check for?
> > >
> >
> > Try building allyesconfig, and check the resulting binary for veneers
> > (which have 'veneer' in the symbol name, at least when ld.bfd emits
> > them). These veneers should not take the [virtual] address of the
> > branch target directly, but take a PC relative offset (as in the
> > example in the commit log of that patch you are referring to)
>
> Not sure clang can compile an arm32 allyesconfig (haven't tried
> personally, yet, TODO), but we could try gcc+lld.
>
> >
> > > Additionally, I have filed an LLVM bug for the lld developers to
> > > check and see if this is a flag they should support:
> > >
> > > https://bugs.llvm.org/show_bug.cgi?id=39886
> > >
> > > Thanks for the quick reply,
> > > Nathan
> > >
> > > > > ---
> > > > >  arch/arm/Makefile | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > > > index e2a0baf36766..4fab2aa29570 100644
> > > > > --- a/arch/arm/Makefile
> > > > > +++ b/arch/arm/Makefile
> > > > > @@ -10,7 +10,7 @@
> > > > >  #
> > > > >  # Copyright (C) 1995-2001 by Russell King
> > > > >
> > > > > -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> > > > > +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
> > > > >  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> > > > >  LDFLAGS_vmlinux        += --be8
> > > > >  KBUILD_LDFLAGS_MODULE  += --be8
> > > > > --
> > > > > 2.20.0.rc1
> > > > >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
