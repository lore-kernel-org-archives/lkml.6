Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeFEG2m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:28:42 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:42627 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbeFEG2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:28:41 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w556SQZo013269
X-Nifty-SrcIP: [209.85.217.175]
X-Google-Smtp-Source: ADUXVKLjk6/gFYNZHEja5+y3qGPYulNq5Amg1q+bb8e1UkOMR4j4W9/olbBXKLx6DnOyqKn7egMFjzLaoeIxjHmA04E=
MIME-Version: 1.0
In-Reply-To: <9a58f4b4e488a3bfc41aba39bc73f8ff@agner.ch>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
 <1527499328-13213-25-git-send-email-yamada.masahiro@socionext.com>
 <dbd4d0dc92ba45dcae81cbab8ab8ba29@agner.ch> <CAK7LNAQ9t-eRRb_mYunEAocaYksOTr=4sw+pExhMd9AvMx+zOw@mail.gmail.com>
 <9a58f4b4e488a3bfc41aba39bc73f8ff@agner.ch>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 5 Jun 2018 15:27:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASU_hPdd0u-m-eehByP4wU270e+Z6Dy2CVxGF-4JLMgVw@mail.gmail.com>
Message-ID: <CAK7LNASU_hPdd0u-m-eehByP4wU270e+Z6Dy2CVxGF-4JLMgVw@mail.gmail.com>
Subject: Re: [PATCH v5 24/31] kconfig: add CC_IS_GCC and GCC_VERSION
To: Stefan Agner <stefan@agner.ch>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kbuild-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-05 14:50 GMT+09:00 Stefan Agner <stefan@agner.ch>:
> On 05.06.2018 02:07, Masahiro Yamada wrote:
>> Hi Stefan
>>
>> 2018-06-05 6:49 GMT+09:00 Stefan Agner <stefan@agner.ch>:
>>> Hi Masahiro,
>>>
>>> On 28.05.2018 11:22, Masahiro Yamada wrote:
>>>> This will be useful to specify the required compiler version,
>>>> like this:
>>>>
>>>> config FOO
>>>>         bool "Use Foo"
>>>>         depends on GCC_VERSION >= 40800
>>>>         help
>>>>           This feature requires GCC 4.8 or newer.
>>>>
>>>
>>> I tried using CC_IS_GCC today while using clang. It seems that it is set
>>> to y despite I am using CC=clang.
>>>
>>> .config looks like this after config:
>>>
>>> ...
>>> CONFIG_CC_IS_GCC=y
>>> CONFIG_GCC_VERSION=40201
>>> CONFIG_CC_IS_CLANG=y
>>> CONFIG_CLANG_VERSION=60000
>>> ...
>>>
>>>
>>> I am using clang 6.0.0 on Arch Linux, which seems to return a version
>>> when using gcc-version.sh:
>>> ./scripts/gcc-version.sh clang | sed 's/^0*//'
>>> 402
>>>
>>> I guess that should not be the case?
>>>
>>
>>
>> What will 'clang --version' print on your machine?
>
> $ clang --version
> clang version 6.0.0 (tags/RELEASE_600/final)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir:
> /home/ags/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf/bin
>
> I use a symlink to clang in my cross compiler toolchain, that is why
> InstalledDir points to a GCC toolchain.
>

Ah, I see.


I will fix it up like follows:


diff --git a/init/Kconfig b/init/Kconfig
index e5a0d89..efc43c6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -9,7 +9,7 @@ config DEFCONFIG_LIST
        default "arch/$(ARCH)/defconfig"

 config CC_IS_GCC
-       def_bool $(success,$(CC) --version | grep -q gcc)
+       def_bool $(success,$(CC) --version | head -n 1 | grep -q gcc)

 config GCC_VERSION
        int
@@ -17,7 +17,7 @@ config GCC_VERSION
        default 0

 config CC_IS_CLANG
-       def_bool $(success,$(CC) --version | grep -q clang)
+       def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)

 config CLANG_VERSION
        int




Best Regards
Masahiro Yamada
