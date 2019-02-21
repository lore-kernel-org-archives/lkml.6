Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D871F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfBUPUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:20:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39503 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:20:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id x6so4451168qki.6;
        Thu, 21 Feb 2019 07:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/W3U2vUR32gNWQPlO+z5ZII57FxXXn/iClOl7jfBaE=;
        b=BGn/m8V4WoDcch98rLhW2Z6O5vCGxtrN3m2JEz7yVARFSFN/PjFQQ5p0hO1WfnYqcG
         4xHCzWvfOvYKXDPi2G2q8RCqdXyM5tZZBvja430FuSj7Rm2mP/v9rsiFYE6NQDu0bo2D
         usbKzsnWbLWpuwyTUkeN1pyyxNAHaYWMVjBuYKqwEsNaylXUDCrrE0LydO2MOod8jNS9
         LV8230g3KdFyTX50LBoFSWPWOwtCZMmZs/fL1tS2pwWMPcHhYRLHgHu/lWAM4j2S8vqj
         ZWhcFaRMbJFWaPo4s/vywNwFb/Czycc9v4wXzrZ3a4tKpG2t+aMV2XDdUqYtLyZu1Swi
         xvXg==
X-Gm-Message-State: AHQUAuZd0fMqxHjpMOJordrWcdQ0qpFsr10+0gV9+n5AHe6L7e/szwcs
        dFbFXhYQeAC6/Nc8DQwQ8IxMz9SxmaDLW3vsmI8=
X-Google-Smtp-Source: AHgI3IbERniTYvB5cCYMfz4ftRHKATCmikOVlEemO+jJk3/QYcksCnpZ8h0lU0KZivZXxohonQnSXuEziu/o9QYA8q0=
X-Received: by 2002:a37:d492:: with SMTP id s18mr27848478qks.343.1550762404969;
 Thu, 21 Feb 2019 07:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
 <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
 <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com> <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
 <d50cf232-f38e-4060-2742-27ba07e2ae9c@virtuozzo.com>
In-Reply-To: <d50cf232-f38e-4060-2742-27ba07e2ae9c@virtuozzo.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Feb 2019 16:19:47 +0100
Message-ID: <CAK8P3a0UXcQKgoGYT0gVQynZLpL-ozK6EtA0Q4CaiGYDmxf8ZA@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>, Qian Cai <cai@lca.pw>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:06 AM Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> On 2/20/19 8:35 PM, Arnd Bergmann wrote:
> > On Wed, Feb 20, 2019 at 6:00 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> >> On 2/20/19 5:51 PM, Arnd Bergmann wrote:

> > Maybe bringing it back would be a compromise? That way it's hidden from
> > all the build testing bots (because of the !CONFIG_COMPILE_TEST dependency),
> > but anyone who really wants it can still have the option, and set
> > CONFIG_FRAME_WARN
> > to whichever value they like.
> >
>
>
> I think there is much simpler solution:
>
> ---
>  lib/Kconfig.kasan | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 219cddc913ac..6cd035f06cee 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -105,6 +105,8 @@ endchoice
>
>  config KASAN_STACK
>         int
> +       range 0 1
> +       prompt "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && (CLANG_VERSION < 90000)
>         default 0 if CC_IS_CLANG && (CLANG_VERSION < 90000)
>         default 1
>         help
> --
>
>
> AFAIK, randconfig is not able to randomize int config options, so it will be disabled for build robots,
> but users still will be able to enable it.

Right, this will work, but I find it a bit awkward to require users to
enter 0 or 1.

My assumption is that build bots turn on CONFIG_COMPILE_TEST, so
having a bool option that depends on COMPILE_TEST would be more
conventional. We can debate whether it should also depend on
CONFIG_EXPERT or not. Something like

config KASAN_STACK
         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG
&& !COMPILE_TEST
         default CC_IS_GCC || (CLANG_VERSION >= 90000)

And then a simpler Makefile logic (could also be done in Kconfig) to turn
that bool symbol into an integer argument for asan-stack=

       Arnd
