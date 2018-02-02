Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeBBWSY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:18:24 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42980 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeBBWSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:18:16 -0500
X-Google-Smtp-Source: AH8x224TVbEktWSWxYXmzsRrizKo1ybPlvZ/Kk5u9mCoc37frMTB+wNPeaI0JWk7vZ5JgblTkkjRl3Ms5H1otcGxqEA=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1802021414270.1842@knanqh.ubzr>
References: <20180202161550.2106846-1-arnd@arndb.de> <20180202162104.2300532-3-arnd@arndb.de>
 <nycvar.YSQ.7.76.1802021414270.1842@knanqh.ubzr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 23:18:14 +0100
X-Google-Sender-Auth: P9EbYw_uoibw7vf7cvLXz-8aq0E
Message-ID: <CAK8P3a2QuVy5ZO0sOGApphaK1ddK3se_zzvYOJC8ULsLMT7GBA@mail.gmail.com>
Subject: Re: [PATCH 3/7] [HACK] x86: crypto: fix link error with LTO
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 8:49 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 2 Feb 2018, Arnd Bergmann wrote:
>
>> crypto_it_tab and the other symbols like it are defined in
>> crypto/aes_generic.c and exported for loadable modules. When
>> building with LTO and CONFIG_TRIM_UNUSED_KSYMS, the exports
>> are eliminated, since kbuild fails to take the users in
>> the arch/x86/crypto/aes-i586-asm_32.S assembler file into
>> account.
>>
>> This adds an ugly workaround by adding a reference to each symbol
>> into aes_glue.c, which gets linked together with the assembler
>> file.
>>
>> We obviously want to fix the CONFIG_TRIM_UNUSED_KSYMS logic
>> to do the right thing here instead, but I couldn't come up
>> with a good fix, so I use this instead to get a clean build
>> for testing.
>
> Could you give me the .config you used for this? So far I can't
> reproduce, and guessing with LTO takes lots of time.

I've uploaded my randconfig file to

https://pastebin.com/raw/iLk4sSpw

>> This fix only works most of the time, but I still ran into
>> some cases where combining an .S with a .c file did not
>> produce the correct .ko file, as the lto linker apparently
>> did not expect that kind of input. 'nm' on the file after
>> 'ld -r' showed only the contents of the assembler file, and
>> after the lto-ld stage, only the contents of the .c file
>> are there.
>
> 'ld -r' does not support mixed (LTO and non-LTO) objects.

Ok, that would explain it. I checked that CONFIG_THIN_ARCHIVES
is set here, but I see clearly that the module is linked using

x86_64-linux-ld -m elf_x86_64   -r -o arch/x86/crypto/aes-x86_64.o
arch/x86/crypto/aes-x86_64-asm_64.o arch/x86/crypto/aes_glue.o ;
scripts/mod/modpost arch/x86/crypto/aes-x86_64.o

       Arnd
