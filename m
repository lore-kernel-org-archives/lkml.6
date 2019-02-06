Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4731BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C212186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fFblG7K0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfBFRc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:32:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34652 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfBFRc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:32:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so6015861lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pExDNk1d86YLl7tWUwoe5QG+vMoTttRKZh0dm7/6yc=;
        b=fFblG7K09X25nVyVAMv0PHZAjIon8Y5Y4efBq7/5BRp7fmj+J6bjipjQQaVvhVMaSU
         T2BG3NrQiONgwHCGjYWlBWQEtrY2SHiGlh0Pok8V/q66N4+fo/f5NS4z4aYduHq2Vk5t
         awx7O47jvYb7LmcgzFuKQG97SSuRfkTkPh2p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pExDNk1d86YLl7tWUwoe5QG+vMoTttRKZh0dm7/6yc=;
        b=AMrIbX+CmVuSpUbW5BP4bdgtN3ODznvrUrSpU/A5my/uIZORlLSFHLniFb5NRlLVrE
         S8z2xGOKLpgMQPojzOjkiq+EWzC/5aPPRpSpq582/T17JhTS2BeWSx+AsAKTiECXXXdZ
         Sm99gqExdwuTE/oCraW73DgqYV3+Cw+YqbiIJtjKCsgIlXlhb6MprZ+ngbulre0cjbUg
         Ka/Yybwud4/9+xoZfdwR3sYXoV3/JGz9VXKRRSVZ6ODK0xjkeQ8Fo1Had2g7D5lGsWWK
         GB+1cTbsMhTo7tpSRHE6Mz5QOdkP1It626jZ7sO9A6pH75LKGFEgCZqT4dQNNf4KqmAq
         25Hg==
X-Gm-Message-State: AHQUAubDY49QvE+aNBjHQODQYrSidVKcOEyagV7JintEBpf+Tla7Ff4P
        sgNOHw/LZXtJraupiz8Moa7x2Z+sOFE=
X-Google-Smtp-Source: AHgI3IaLAJQ5wbEPJlTJPUYtY9H5WBd6bouB+Msb0iizEJxQzKrUD9VTJpF0XIR0YldP3kYTASJaGA==
X-Received: by 2002:a19:cfd5:: with SMTP id f204mr6787148lfg.65.1549474345725;
        Wed, 06 Feb 2019 09:32:25 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id q26sm140351lfc.79.2019.02.06.09.32.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:32:24 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id b20so5945767lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:32:24 -0800 (PST)
X-Received: by 2002:a19:6001:: with SMTP id u1mr2095586lfb.56.1549474344072;
 Wed, 06 Feb 2019 09:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20190201210853.244043-1-jflat@chromium.org> <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
 <20190206164528.GA8925@archlinux-ryzen>
In-Reply-To: <20190206164528.GA8925@archlinux-ryzen>
From:   Jon Flatley <jflat@chromium.org>
Date:   Wed, 6 Feb 2019 09:32:12 -0800
X-Gmail-Original-Message-ID: <CACJJ=pyLqhrxka2jXtby9CUqsAr=-_oQUraH5ua3PZpgXHgdOQ@mail.gmail.com>
Message-ID: <CACJJ=pyLqhrxka2jXtby9CUqsAr=-_oQUraH5ua3PZpgXHgdOQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild, LLVMLinux: Don't suppress format warnings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        jflat@chromium.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 8:45 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Feb 05, 2019 at 05:26:05PM +0900, Masahiro Yamada wrote:
> > On Sat, Feb 2, 2019 at 6:10 AM <jflat@chromium.org> wrote:
> > >
> > > From: Jon Flatley <jflat@chromium.org>
> > >
> > > gcc produces format warnings that clang suppresses. To keep behavior
> > > consistent between gcc and clang, don't suppress format warnings in
> > > clang.
> > >
> > > Signed-off-by: Jon Flatley <jflat@chromium.org>
> > > ---
> >
> > Applied to linux-kbuild.
> > Thanks.
> >
> >
>
> Hi Jon and Masahiro,
>
> Just as a heads up, this introduces a ton of warnings (duh). Isn't the
> typical plan behind turning on warnings that were disabled to build with
> 'W=', fix them all, then turn them on so as not to pollute the build?
>
> Log file: https://gist.github.com/443db156e56cd3c0f6b21d9d77728d80
>
> Note a big chunk of them come from one scnprintf call in
> include/linux/usb/wusb.h but still, there are many other warnings that
> make quite a bit of noise. Some seem relatively easy to fix, which I
> suppose I will try to tackle soon.
>
> Thanks,
> Nathan
>

Hi Nathan,

This was definitely not my intention.
I noticed the added warnings this morning and was considering calling
for a revert on this patch.

The intent was to match the behavior of gcc, as it has -Wformat enabled.
It was rather naive of me to assume the behavior of -Wformat would be
the same in both gcc and clang.
Indeed, it seems gcc is more permissive about what format
substitutions it allows.

For example passing int to the "%hu" format specifier is fine in gcc
under -Wformat but produces a warning in clang.
Maybe this was the motivation for adding -Wno-format to clang in the
first place.
This difference is puzzling to me, and I wonder if it's by design.

Considering the whole point of this patch was to sync up this behavior
between gcc and clang I am OK with reverting this.

Thanks,
Jon

> >
> >
> > >  scripts/Makefile.extrawarn | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > > index 768306add591..94daf4e1fc73 100644
> > > --- a/scripts/Makefile.extrawarn
> > > +++ b/scripts/Makefile.extrawarn
> > > @@ -68,7 +68,6 @@ else
> > >  ifdef CONFIG_CC_IS_CLANG
> > >  KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
> > >  KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
> > > -KBUILD_CFLAGS += $(call cc-disable-warning, format)
> > >  KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
> > >  KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
> > >  KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
> > > --
> > > 2.20.1.611.gfbb209baf1-goog
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
