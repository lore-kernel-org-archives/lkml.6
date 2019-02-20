Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C600C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E64F2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfBTVkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:40:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34497 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBTVks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:40:48 -0500
Received: by mail-qk1-f195.google.com with SMTP id a15so3044930qkc.1;
        Wed, 20 Feb 2019 13:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czh+n0Hqrebi2h82qZBwQ4Zi9TeI84X+itSN75yXDUo=;
        b=GVJhqg5fnmpC5BYSy4viIFKFs8YgV91qWg2um119zvqNoFMGMdVq1l0VslbpDpiDZJ
         hpVvWvrAgj5GrneddW2+Hg38+a9ZIbS6TgQJ7EV/eKCEewqj2Fy7xZ5TICSBdFFuoR5J
         yO0J1or90UvUKjkIf4Ky0wbY+FNtJETlHJ5JzXa5/AHEahRWLt5CZ6ZXN9TW51SFOyUI
         TIu41gIrNzmyoJRLSZ3uBhmlP/zoqMCwkDi387NY6hYyOzzzsWrPwIlMiqjM76nnRTqJ
         OtXNHGj7j3RjVL7e0rzZnAVBm46OlBh4aUiFwoQDMqraITEmwBtuBvqumXFinpJhsTcC
         wclw==
X-Gm-Message-State: AHQUAub/9K/0XK5P5Oo6yk+HU+AQKKHspSbhFmU7U7ZjBjFmHsmf0c+9
        rxEa2en5zuOUX/raCaT2TF7m3km5uqmxhxfu7H8=
X-Google-Smtp-Source: AHgI3IZLue5+DXekspfQoDlSfnEgiMu9Tuv/OESHntUBeCCJmGmDF6xbTkYtryrqTtVKMQ59SbCJx3o6FprqdZGc0hY=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr26611663qkh.173.1550698847364;
 Wed, 20 Feb 2019 13:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
 <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
 <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com> <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
 <CAKwvOd=XrNNb=r3qgsT8O6JNzL4hg4pqfJJFcY2DzA0Ooc=E3w@mail.gmail.com>
 <20190220184408.GG9878@sirena.org.uk> <CAKwvOdne3aE5bUsQF-2C-L2Xezqq9qb=NqF8FA+B7nvqXKAXFA@mail.gmail.com>
 <CAK8P3a1pop4WqWxV=-R4n1Lh3FYG0mb4iJk4=saq6CgzpsPe4A@mail.gmail.com>
In-Reply-To: <CAK8P3a1pop4WqWxV=-R4n1Lh3FYG0mb4iJk4=saq6CgzpsPe4A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 22:40:29 +0100
Message-ID: <CAK8P3a0z7Y-uLgc8pWrdt712ic4R2nLbceg_zTCAC=ctG9LK9Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
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

On Wed, Feb 20, 2019 at 10:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> In the example in https://bugs.llvm.org/show_bug.cgi?id=38809#c12
> (https://godbolt.org/z/ylsGSQ) there is no inlining, yet clang uses
> over ten times as much stack space as gcc, for reasons I still
> can't explain. My assumption right now is that the underlying bug
> causes most of the problems with excessive stack usage in
> allmodconfig kernels.

Here is an even more minimal example:

struct s { int i[5]; } f(void);
void g(void) { f(); f();}

https://godbolt.org/z/d_KWkh

It's clear that clang does /something/ here when asan-stack=1 is
set, but I fail to see what it is, or why that is necessary.

The output of clang with asan-stack=0 is the expected
code, and basically identical to what gcc produces with or
without asan-stack.

      Arnd
