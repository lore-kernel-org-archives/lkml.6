Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbeDHPlk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 11:41:40 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:42875 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeDHPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 11:41:38 -0400
X-Google-Smtp-Source: AIpwx4/HbZcBmn7L0Gyj/MYf+FRZNFq6kI1pfp+B0X0LWW7Ri7m6dDTR/RQvK4JaribXb132h/bctal6Isd9fi4IDr4=
MIME-Version: 1.0
In-Reply-To: <4564679.HlOejCIXXz@positron.chronox.de>
References: <001a114467482dbc4b05692df8f9@google.com> <CACT4Y+YKnor5e6kT7KeEn3L3gut4M_tCPp7WbjmSTf=44icGxg@mail.gmail.com>
 <CACT4Y+YTjUzk7GFuHi6L4KT74p7xv9W-ACU3Uez4V=YLvy5PhQ@mail.gmail.com> <4564679.HlOejCIXXz@positron.chronox.de>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 8 Apr 2018 17:41:17 +0200
Message-ID: <CACT4Y+Y7hdm6LX5-PZu9zXFSmAKMP_jCYY7Z7g6a0xd_XCEYhA@mail.gmail.com>
Subject: Re: WARNING in kmem_cache_free
To: =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc: Matthew Wilcox <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers3@gmail.com>,
        syzbot <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w38Ffjb0002797

On Sun, Apr 8, 2018 at 5:31 PM, Stephan Müller <smueller@chronox.de> wrote:
> Am Sonntag, 8. April 2018, 13:18:06 CEST schrieb Dmitry Vyukov:
>
> Hi Dmitry,
>
>>
>> Running syz-repro utility on this log, I think I've found the guilty guy:
>> https://gist.githubusercontent.com/dvyukov/1dd75d55efd238e7207af1cc38478b3a/
>> raw/403859b56b161a6fbb158e8953fac5bb6e73b1a1/gistfile1.txt
>>
>
> I am unable to reproduce it with the code. I am using the current
> cryptodev-2.6 tree with kazan enabled. Could you please give me your kernel
> config or a pointer of the used tree?

Hi,

Here is config and kernel commit:
https://groups.google.com/d/msg/syzkaller-bugs/PINYyzoaG1s/ntZPOZdcCAAJ
You can also find compiler and image here if necessary:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md

And note that the program needs to be compiled with -m32. The bugs is
probably not-compat specific, but the program injects fault into a
particular malloc invocation and maybe malloc numbering is affected by
compat path.


>> It crashes as:
>> BUG: KASAN: use-after-free in drbg_kcapi_seed+0x1178/0x12e0
>> and:
>> BUG: unable to handle kernel paging request at ffffebe000000020
>> and with other indications of badly corrupted heap.
>>
>> This points to crypto/drbg.c, so +crypto maintainers.
>
>
> Ciao
> Stephan
>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/4564679.HlOejCIXXz%40positron.chronox.de.
> For more options, visit https://groups.google.com/d/optout.
