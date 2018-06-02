Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeFBUjY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 16:39:24 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46766 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeFBUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 16:39:22 -0400
X-Google-Smtp-Source: ADUXVKLohLAEn1tpV7AKjBIwJHO3VLxkplgrc5+7W8GX7izleOZ7OH1QrtVv6UEHPay0DzvHZwfBqEbmL+Kc/KV10WY=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK8F_R-CAt8h92ZG51s5eSnV+6FASLmYCWWgRX_2_m8zA@mail.gmail.com>
References: <20180531084037.2f8b4c1e@canb.auug.org.au> <CAK7LNAQjVCPwfJ-opUkW3+XTM0uk9PSo3XiyGwCAMKkK05WnxA@mail.gmail.com>
 <CAGXu5jK8OSJXT5eGK=J0msL9kc+fjOxFUyv=5NYbOH8savc5Xw@mail.gmail.com>
 <CAGXu5jKb9f7Or9z3eBzAUci2teE6ULVjkuqv00O_j3VuowwbJw@mail.gmail.com>
 <CAK7LNASYTVNque5kgq7FnyOSjX4byBsWhfB-0Jy9Fp0ZmpuqYA@mail.gmail.com> <CAGXu5jK8F_R-CAt8h92ZG51s5eSnV+6FASLmYCWWgRX_2_m8zA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 2 Jun 2018 22:39:20 +0200
X-Google-Sender-Auth: Kd6V6bZaVtIYEEdRtWLwBm8AmGo
Message-ID: <CAK8P3a2h1WZ=Jg4MAHoyCt_YLNRCCBG-JRUfy2qZpQ6trRHesg@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the kbuild tree
To: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 6:01 AM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, May 31, 2018 at 6:56 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-05-31 12:53 GMT+09:00 Kees Cook <keescook@chromium.org>:
>>> On Wed, May 30, 2018 at 6:26 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> On Wed, May 30, 2018 at 6:12 PM, Masahiro Yamada

>>>>> This has been triggered by the following commit:
>>>>>
>>>>>
>>>>> commit 0e461945f3504e09b8ecf947b6398adce1287a28
>>>>> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>> Date:   Mon May 28 18:22:07 2018 +0900
>>>>>
>>>>>     gcc-plugins: allow to enable GCC_PLUGINS for COMPILE_TEST
>>>>>
>>>>>
>>>>>
>>>>> CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL was previously disabled
>>>>> for COMPILE_TEST, which is now enabled.
>
> For the moment, can you add "depends on !COMPILE_TEST" to
> CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL in your tree and I'll continue
> to figure out what's happening?
>

I ran into the same thing indepently and bisected it (which led me to
arrive at this thread).
One additional bit of information I have is that this happens with all
versions of
gcc-7 for me, but not gcc-6.3 or older.

Another finding was the particular instance I noticed:

fs/ext4/inode.c: In function 'ext4_inode_csum':
fs/ext4/inode.c:83:1: warning: the frame size of 1688 bytes is larger
than 500 bytes [-Wframe-larger-than=]

comes from inlining the same function multiple times; ext4_inode_csum()
repeatedly calls ext4_chksum(), which has a struct on the stack. Apparently
this normally only takes up stack space only once, but when initializing it
to zero, each instance takes an additional two CRYPTO_MINALIGN bytes
of stack space (the size of the locally defined structure).


       Arnd
