Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AC32084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfBUNQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:16:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35520 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:16:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id z13so2889428qki.2;
        Thu, 21 Feb 2019 05:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLopUsnzhXentzxeWdCfrvh5YpA4RQgyMPyE1+Fepnw=;
        b=DsR6zg9JPGC1IfLMnY3z98WES5hahnhdUr1H2hqQZoTewmYjoyGqkjcdt/6r4wl71M
         C5/CoJ8KZGhTaZQwEjretoszJuzyNFuCUz/cdzEycYXIT+To8RLjnbh9yBOoG3S0R/1y
         2RjiWllCLkgtnxfzLaMG3zyY5AV3eW7jHuXdUfN8g+lS/ATVvx3ES29mjehOxhSGWgWH
         yrw+uarZE9qH1DT5wZGfxMulAQBXXY5YAxUHsMHuS1rkTsk+FfkSEXmzgl1ZpkZgjDBh
         n60v+kmm0AxrNXHAYj/V8ba+Y/wgEeQoop8iuqnu+inqP2oagCYOVht+T4JawPQBNL9s
         NCRQ==
X-Gm-Message-State: AHQUAubKUiTIvQSK9jD3USgXIg6U5BJ9iUwO4HsQyPk/7nmT3QuoZVp5
        BwXdSUIZqA/QvegCNKN841ZPvsRNP+UNoXnPgUk=
X-Google-Smtp-Source: AHgI3Iat1RkYqKtgTdV1SVwmP0IPf6xYzP45OqGjczRTwanF9KEOgaF2H3oMdCgJe+gjtsnKUNep78y56fPf1Ac7lhg=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr1288820qkf.107.1550754990317;
 Thu, 21 Feb 2019 05:16:30 -0800 (PST)
MIME-Version: 1.0
References: <1550722418-9189-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a2V+AYbXZC6zG6iJzOM3HugcB3Odx74jzVzSK4mfQ1Ftw@mail.gmail.com> <CAK7LNAQ5RvSvUA+nXePfQRgEeoFZH0nHGsV-4g2Sv0XoqynDgA@mail.gmail.com>
In-Reply-To: <CAK7LNAQ5RvSvUA+nXePfQRgEeoFZH0nHGsV-4g2Sv0XoqynDgA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Feb 2019 14:16:13 +0100
Message-ID: <CAK8P3a1aef+rqxtfj5CJr_roZHysUAm3p9BHMTQO9OvtNhGJcg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: compute false-positive -Wmaybe-uninitialized
 cases in Kconfig
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:45 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Thu, Feb 21, 2019 at 6:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Feb 21, 2019 at 5:14 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >
> > I like how this cleans up the logic and documents it better.
> > I've had my own plans to move this (and most other conditional warning
> > options) into a header file using the KBUILD_WARN() infrastructure, but
> > never got around to doing that. I still think that's what we want eventually,
> > but in the meantime your patch seems fine as well.
> >
> > Also, I see that your patch keeps the existing logic, which is good,
> > but we may want to refine this a little afterwards:
> >
> > - we may want to turn off -Wuninitialized for gcc-4.6 and gcc-4.7
> >   instead of turning off -Wmaybe-uninitialized as we do in the later
> >   compilers.
>
> Ah, right.
>
> I can do that if it is worthwhile.
>
> But, I'd rather want to raise the minimum compiler version
> than taking care of old compilers.
> (We will do it eventually.)

I was hoping that with gcc-4.6 being the minimum version, we could
actually get all supported compilers to produce clean builds on
all configurations, possibly at the cost of just turning off all
unreliable warning options on older compilers.

I don't mind regularly raising the minimum version, but I would
also wait several years before I'd consider gcc-4.9 a good
choice for the minimum, and all older versions have problems
here.

> Does clang recognize -Wmaybe-uninitialized?
>
> I am using Clang I built a few days ago.
>
>
> masahiro@pug:~$ clang --version
> clang version 9.0.0 (http://llvm.org/git/clang.git
> b492883ea31e2046d5725126318911465bc1374f)
> (http://llvm.org/git/llvm.git
> 03a15eec9ef44798cd5c57b4ed6a63e62b2c1db6)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /home/masahiro/toolchains/clang-latest/bin
>
> masahiro@pug:~$ clang -x c /dev/null  -Wmaybe-uninitialized -c -o  /dev/null
> warning: unknown warning option '-Wmaybe-uninitialized'; did you mean
>       '-Wuninitialized'? [-Wunknown-warning-option]
> 1 warning generated.

Ah, that's right. I also see -Wconditional-uninitialized and
-Wsometimes-uninitialized, but they are something different again.

       Arnd
