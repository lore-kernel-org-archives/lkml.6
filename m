Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2A4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB81E20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FjD1S8nT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfBUJqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:46:02 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:46026 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfBUJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:46:01 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x1L9jfZ4022371;
        Thu, 21 Feb 2019 18:45:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x1L9jfZ4022371
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550742342;
        bh=so8YRwrlzTAABjqEXNVpXlQbU9Iw1PZU81wAYHPdP5E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FjD1S8nTB5O5dlVMlzt4yZ3XDOObDlLrQQ8J7Kt8FEL2LXPlIGxn735ZvwUu8zI46
         QWaR9FZGiK01cQ0uH+VdUSOXI9YfvKRsY8zcHezYB7GcrRX7vApjPtEK0p1KtsH0Sq
         0W4K/MrpIIyB0DbrhJ1ua86htq0J0r+7DT7IQ4Aqfp6EsD2Uh6KJYTQdR2xrkh8Ekr
         8xQ2i8iTq5PrljFHWdN1bMfFCt7ugx+4ykEapd/YlOpF5ttN9F8xodUaJk6VjHHEoC
         ibt1KO9FemRETiYbnbatdTT5jUrZ7AtnUAwgKImtZ4KKyBcHK7peyvkU60rk3fwLRY
         MhSMChut/TgqQ==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id z18so15794391vso.7;
        Thu, 21 Feb 2019 01:45:42 -0800 (PST)
X-Gm-Message-State: AHQUAuYI7bfU4IBEwSx1lDEKnfdXQ13w121DzB/z+M0fmTGdfajjqRzm
        qniDoUFGkYhcw1ZT9NPrvxjpnXi1R36r3rkl1xU=
X-Google-Smtp-Source: AHgI3IYK6KoCi4MYk5zuuHWTcpuDRCs578CnEO1TwEaCGfdyBa96K39fb155vzfJzFCraXPl+z+Gj2NJYZWB1ReZMOQ=
X-Received: by 2002:a67:7f43:: with SMTP id a64mr20763607vsd.155.1550742341393;
 Thu, 21 Feb 2019 01:45:41 -0800 (PST)
MIME-Version: 1.0
References: <1550722418-9189-1-git-send-email-yamada.masahiro@socionext.com> <CAK8P3a2V+AYbXZC6zG6iJzOM3HugcB3Odx74jzVzSK4mfQ1Ftw@mail.gmail.com>
In-Reply-To: <CAK8P3a2V+AYbXZC6zG6iJzOM3HugcB3Odx74jzVzSK4mfQ1Ftw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 21 Feb 2019 18:45:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5RvSvUA+nXePfQRgEeoFZH0nHGsV-4g2Sv0XoqynDgA@mail.gmail.com>
Message-ID: <CAK7LNAQ5RvSvUA+nXePfQRgEeoFZH0nHGsV-4g2Sv0XoqynDgA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: compute false-positive -Wmaybe-uninitialized
 cases in Kconfig
To:     Arnd Bergmann <arnd@arndb.de>
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

On Thu, Feb 21, 2019 at 6:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 21, 2019 at 5:14 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Since -Wmaybe-uninitialized was introduced by GCC 4.7, we have patched
> > various false positives:
> >
> >  - commit e74fc973b6e5 ("Turn off -Wmaybe-uninitialized when building
> >    with -Os") turned off this option for -Os.
> >
> >  - commit 815eb71e7149 ("Kbuild: disable 'maybe-uninitialized' warning
> >    for CONFIG_PROFILE_ALL_BRANCHES") turned off this option for
> >    CONFIG_PROFILE_ALL_BRANCHES
> >
> >  - commit a76bcf557ef4 ("Kbuild: enable -Wmaybe-uninitialized warning
> >    for "make W=1"") turned off this option for GCC < 4.9
> >    Arnd provided more explanation in https://lkml.org/lkml/2017/3/14/903
> >
> > I think this looks better by shifting the logic from Makefile to Kconfig.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I like how this cleans up the logic and documents it better.
> I've had my own plans to move this (and most other conditional warning
> options) into a header file using the KBUILD_WARN() infrastructure, but
> never got around to doing that. I still think that's what we want eventually,
> but in the meantime your patch seems fine as well.
>
> Also, I see that your patch keeps the existing logic, which is good,
> but we may want to refine this a little afterwards:
>
> - we may want to turn off -Wuninitialized for gcc-4.6 and gcc-4.7
>   instead of turning off -Wmaybe-uninitialized as we do in the later
>   compilers.

Ah, right.

I can do that if it is worthwhile.

But, I'd rather want to raise the minimum compiler version
than taking care of old compilers.
(We will do it eventually.)


> - the proposed CC_OPTIMIZE_FOR_DEBUGGING may need the
>   same workaround as CC_OPTIMZE_FOR_SIZE.


I know this.

First, my patch took care of CC_OPTIMIZE_FOR_DEBUGGING as well.
But, CC_OPTIMIZE_FOR_DEBUGGING was rejected.
(https://patchwork.kernel.org/patch/10744541/)

So, I dropped this.


> - For clang, we may want to /not/ turn off -Wmaybe-uninitialized
>   in all cases. I haven't tried build with with 'clang -Oz
>   -Wmaybe-uninitialized', but if the number of false positives is small
>   enough, we could decide to just leave that on.


Does clang recognize -Wmaybe-uninitialized?

I am using Clang I built a few days ago.


masahiro@pug:~$ clang --version
clang version 9.0.0 (http://llvm.org/git/clang.git
b492883ea31e2046d5725126318911465bc1374f)
(http://llvm.org/git/llvm.git
03a15eec9ef44798cd5c57b4ed6a63e62b2c1db6)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/masahiro/toolchains/clang-latest/bin

masahiro@pug:~$ clang -x c /dev/null  -Wmaybe-uninitialized -c -o  /dev/null
warning: unknown warning option '-Wmaybe-uninitialized'; did you mean
      '-Wuninitialized'? [-Wunknown-warning-option]
1 warning generated.




>       Arnd



-- 
Best Regards
Masahiro Yamada
