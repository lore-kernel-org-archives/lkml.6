Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCCPfW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:35:22 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:53938 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeCCPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:35:21 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w23FZB4X018127
X-Nifty-SrcIP: [209.85.217.178]
X-Google-Smtp-Source: AG47ELtemcTieaHtaIX9itUPaVfwp3FpAWU6EGh7XsqiNSZUxk8jlybFc+fq4Kv+gBqnsARlJDecWXXtJZVCqqHwqEs=
MIME-Version: 1.0
In-Reply-To: <1519974312-20477-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519974312-20477-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 4 Mar 2018 00:34:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARDFMoPQ4iwV-FKXxWiNOSxU5cFcSw18tHChMEqAmrQNg@mail.gmail.com>
Message-ID: <CAK7LNARDFMoPQ4iwV-FKXxWiNOSxU5cFcSw18tHChMEqAmrQNg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix line number in recursive inclusion error message
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-02 16:05 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> When recursive inclusion is detected, the line number of the last
> 'included from:' is wrong.
>
> [Test Case]
>
> Kconfig:
>   -------->8--------
>   source "Kconfig2"
>   -------->8--------
>
> Kconfig2:
>   -------->8--------
>   source "Kconfig3"
>   -------->8--------
>
> Kconfig3:
>   -------->8--------
>   source "Kconfig"
>   -------->8--------
>
> [Result]
>
>   $ make allyesconfig
>   scripts/kconfig/conf  --allyesconfig Kconfig
>   Kconfig:1: recursive inclusion detected. Inclusion path:
>     current file : 'Kconfig'
>     included from: 'Kconfig3:1'
>     included from: 'Kconfig2:1'
>     included from: 'Kconfig:3'
>   scripts/kconfig/Makefile:89: recipe for target 'allyesconfig' failed
>   make[1]: *** [allyesconfig] Error 1
>   Makefile:512: recipe for target 'allyesconfig' failed
>   make: *** [allyesconfig] Error 2
>
> where we expect
>
>     current file : 'Kconfig'
>     included from: 'Kconfig3:1'
>     included from: 'Kconfig2:1'
>     included from: 'Kconfig:1'
>
> The 'iter->lineno+1' in the second fpinrtf() should be 'iter->lineno-1'.
> I refactored the code to merge two fprintf().
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

Applied to linux-kbuild/fixes.



-- 
Best Regards
Masahiro Yamada
