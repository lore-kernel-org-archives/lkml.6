Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeBALzy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:55:54 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40218 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbeBALzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:55:48 -0500
X-Google-Smtp-Source: AH8x224H4zYfXe506iN0+AMXKZuM9HbH+E9NFC/2GLkehNYnes2e+7b/bzPrVIm2CvaOMjbs8AV0wcpAWJwYpANnJx0=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1Tm7zJf1VEGFPmhwqS=h92=_ssfAENJcrmxGg0eJCqnA@mail.gmail.com>
References: <1517480520-4465-1-git-send-email-geert@linux-m68k.org>
 <1517480520-4465-2-git-send-email-geert@linux-m68k.org> <CAK8P3a1Tm7zJf1VEGFPmhwqS=h92=_ssfAENJcrmxGg0eJCqnA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2018 12:55:47 +0100
X-Google-Sender-Auth: WnYHje8GIrZ_X6JHUHcT0jS3XUY
Message-ID: <CAMuHMdWHZMxRg91LVz6n1GsM+6jezdzzfnDtBTXixHh=Updt5A@mail.gmail.com>
Subject: Re: [PATCH 2/3] compiler-gcc.h: __nostackprotector needs gcc-4.4 and up
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Christopher Li <sparse@chrisli.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        linux-sparse@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11Btw8W030550

Hi Arnd,

On Thu, Feb 1, 2018 at 12:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Feb 1, 2018 at 11:21 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Gcc versions before 4.4 do not recognize the __optimize__ compiler
>> attribute:
>>
>>     warning: ‘__optimize__’ attribute directive ignored
>>
>> Fixes: 7375ae3a0b79ea07 ("compiler-gcc.h: Introduce __nostackprotector function attribute")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> Can anyone please verify this?
>> Apparently __nostackprotector is used on x86 only, which is usually
>> served by modern compilers.
>
> I've checked that __optimize("no-stack-protector") is accepted by exactly those
> compilers that your 40400 version check tests for, across all architectures, so
> that's fine.

Thanks!

> However,  looking at commit 91cfc88c66bf ("x86: Use __nostackprotect for
> sme_encrypt_kernel"), I suspect that gcc-4.1 through 4.3 will now cause
> a runtime failure in sme_encrypt_kernel() without a compile-time warning.

So having this functionality is a hard requirement. Oops...

> I would leave __nostackprotector unchanged here, so we at least get
> a warning for functions that need to disable the stack protector to work
> correctly.

Agreed.

> We might want to add an #ifdef CONFIG_CC_STACKPROTECTOR around
> the __nostackprotector definition, so that we only warn if stackprotector
> is globally enabled.

And we might want to remove the dummy in include/linux/compiler_types.h:

#ifndef __nostackprotector
# define __nostackprotector
#endif

BTW, how does this work with non-gcc compilers?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
