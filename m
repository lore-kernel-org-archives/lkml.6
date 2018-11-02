Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02668C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF722082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CvxrVy2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF722082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeKBRcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:32:08 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:45216 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeKBRcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:32:08 -0400
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wA28Paga021682;
        Fri, 2 Nov 2018 17:25:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wA28Paga021682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541147137;
        bh=Mnx7T52qNuJADdc34cPsKyeWc2CixXLm3e/Tc4TwAyU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CvxrVy2BcVJ6ui1bWlkBtbBLTsYPA5WMqDeCyd2kc7ChWX9w+NhT5THU6BOPxw4Fp
         97Yfg2V8dg1UOglIXfaRRvIHX2V5A4Y/WaRtRHyzB0+sN6bouV4O1aK3quTMNQxtBU
         xTtTP5C9NNwnCg47VLvNpfPveRbQGCQ+Qv0S8ggr361N5tN4q7yzFnW0pxE4Rp2a2c
         WVbQ/ulVU6ws3At+CUQV2bS9LhnwhJ55Epk/pmelWzcsF2W2fYAKn2vDMkG8bCXwM9
         lby8VmJbI7Hnblci7vQxXnRt+XtdQNYA/Or9akSRs0jvR9YL6E6k0EevkzdDFrBLmm
         BcBzwaMjJgd+w==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id j20so251252vke.5;
        Fri, 02 Nov 2018 01:25:37 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIfPbk/4quANBBDQxL9QxoAYGrf2DdE1EBC7/d/8RE9Y1ngBtFb
        bKF776CIGyP5spLaXuAfDZ7AiDMEdqwsxlymdCI=
X-Google-Smtp-Source: AJdET5cU4toWYEOt6EBNAyJroeE7TyMS9awuWHZAUwfQ17V00Pr98F3Sz5mdmPjfnZv41EarmzDk/y5r7iLnGDKnGNU=
X-Received: by 2002:a1f:b215:: with SMTP id b21-v6mr4875383vkf.0.1541147135981;
 Fri, 02 Nov 2018 01:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181031145907.1ee2e866@canb.auug.org.au> <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
 <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com> <20181101142946.u5luuctqav6fec6k@mail.google.com>
In-Reply-To: <20181101142946.u5luuctqav6fec6k@mail.google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 2 Nov 2018 17:25:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQbBG=KV5Q8o5-JiNCswuse94jECoqT+T+UEY7bLCRPNw@mail.gmail.com>
Message-ID: <CAK7LNAQbBG=KV5Q8o5-JiNCswuse94jECoqT+T+UEY7bLCRPNw@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 11:32 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> On Thu, Nov 01, 2018 at 12:32:48PM +0900, Masahiro Yamada wrote:
> > Hi Arnd,
> >
> >
> > On Thu, Nov 1, 2018 at 6:42 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On 10/31/18, Randy Dunlap <rdunlap@infradead.org> wrote:
> > > > On 10/30/18 8:59 PM, Stephen Rothwell wrote:
> > > >> Hi all,
> > > >>
> > > >> Please do not add any v4.21/v5.1 code to your linux-next included trees
> > > >> until after the merge window closes.
> > > >>
> > > >> Changes since 20181030:
> > > >>
> > > >
> > > >
> > > > on i386:
> > > >
> > > > ld: drivers/virt/vboxguest/vboxguest_core.o: in function
> > > > `vbg_ioctl_hgcm_call':
> > > > vboxguest_core.c:(.text+0x212b): undefined reference to `vbg_hgcm_call32'
> > > >
> > > >
> > > > Full randconfig file is attached.
> > > >
> > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > >
> > > I ran into the same thing, and lots of others like it; they all go back to
> > > the -Og compiler option introduced in commit 94c7dfd01652 ("kernel
> > > hacking: support building kernel with -Og optimization level").
> > >
> > >
> > > I have patches for most of these, but I'd prefer if we could leave
> > > that patch out of 4.20 for now, and have it in linux-next for merging
> > > into the next merge window, to give us more time to fix up all the
> > > regressions. This particular instance is fixed by the patch below.
> >
> >
> > Hmm, I was considering the -Og support for the current MW,
> > but it might be better to postpone it for 4.21-rc1...
> >
> >
> >
> > > Other symptoms caused by the change are tons of 'section mismatch'
> > > warnings for functions that are no longer automatically inlined, and
> > > sprintf format string overflow warnings when gcc fails to propagate
> > > an upper bound on an integer argument that is printed into a fixed
> > > length string.
> > >
> > >      Arnd
> > > ---
> > > From 8172e650c6797b9cc64c6f7b1c9e5433156290cc Mon Sep 17 00:00:00 2001
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > Date: Wed, 31 Oct 2018 16:24:35 +0100
> > > Subject: [PATCH] vbox: fix link error with 'gcc -Og'
> > >
> > > With the new CONFIG_CC_OPTIMIZE_FOR_DEBUGGING option, we get a link
> > > error in the vboxguest driver, when that fails to optimize out the
> > > call to the compat handler:
> > >
> > > drivers/virt/vboxguest/vboxguest_core.o: In function `vbg_ioctl_hgcm_call':
> > > vboxguest_core.c:(.text+0x1f6e): undefined reference to `vbg_hgcm_call32'
> > >
> > > Another compile-time check documents better what we want and avoids
> > > the error.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > diff --git a/drivers/virt/vboxguest/vboxguest_core.c
> > > b/drivers/virt/vboxguest/vboxguest_core.c
> > > index 3093655c7b92..1475ed5ffcde 100644
> > > --- a/drivers/virt/vboxguest/vboxguest_core.c
> > > +++ b/drivers/virt/vboxguest/vboxguest_core.c
> > > @@ -1312,7 +1312,7 @@ static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
> > >                 return -EINVAL;
> > >         }
> > >
> > > -       if (f32bit)
> > > +       if (IS_ENABLED(CONFIG_COMPAT) && f32bit)
> > >                 ret = vbg_hgcm_call32(gdev, client_id,
> > >                                       call->function, call->timeout_ms,
> > >                                       VBG_IOCTL_HGCM_CALL_PARMS32(call),
> >
> > Right, but adding the CONFIG_COMPAT guard to both the caller and the callee
> > looks a bit redundant...
> >
> >
> > I think most cases causing this kind of problem
> > rely on the assumption that 'static' functions are inlined.
> >
> > We can force the compiler to do so
> > by replacing 'static' with 'static __always_inline'
> >
> Declaring it as normal 'inline' is enough. The inline functions are
> still inlined by gcc. Thanks.


How about clang?

For clang, -Og might be equivalent to -O1 at this moment, but I am not sure.

In my understanding, Clang does not inline functions marked with 'static inline'
for -Og (or -O1) optimization level.

Theoretically, 'inline' keyword is a just hint for the compiler, after all.


-- 
Best Regards
Masahiro Yamada
