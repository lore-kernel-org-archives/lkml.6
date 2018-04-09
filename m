Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeDINcL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:32:11 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:34080 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeDINby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:31:54 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w39DVh16027797
X-Nifty-SrcIP: [209.85.217.175]
X-Google-Smtp-Source: AIpwx48Yu88yFQKgyd6ZWs1rRwEG7zA+feCGJHeUhOzYcFvZE6S/RfthsKEbmiLgPZagsAwXi83S4eSdqooYQZbvlhQ=
MIME-Version: 1.0
In-Reply-To: <20180408213528.26758-1-linux@rasmusvillemoes.dk>
References: <CAK7LNARvTJJR=fa9_NyvwfX9z+f51Ha9XQzLrmVakVWUV4eAQw@mail.gmail.com>
 <20180408213528.26758-1-linux@rasmusvillemoes.dk>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 9 Apr 2018 22:31:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmy0COjgWgSa7uB426Me_jAmeJCDSQkJWZoTVwqoA1CA@mail.gmail.com>
Message-ID: <CAK7LNARmy0COjgWgSa7uB426Me_jAmeJCDSQkJWZoTVwqoA1CA@mail.gmail.com>
Subject: Re: [PATCH v2] Kbuild: fix # escaping in .cmd files for future Make
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w39DWH8I005583

2018-04-09 6:35 GMT+09:00 Rasmus Villemoes <linux@rasmusvillemoes.dk>:
> I tried building using a freshly built Make (4.2.1-69-g8a731d1), but
> already the objtool build broke with
>
> orc_dump.c: In function ‘orc_dump’:
> orc_dump.c:106:2: error: ‘elf_getshnum’ is deprecated [-Werror=deprecated-declarations]
>   if (elf_getshdrnum(elf, &nr_sections)) {
>
> Turns out that with that new Make, the backslash was not removed, so cpp
> didn't see a #include directive, grep found nothing, and
> -DLIBELF_USE_DEPRECATED was wrongly put in CFLAGS.
>
> Now, that new Make behaviour is documented in their NEWS file:
>
>   * WARNING: Backward-incompatibility!
>     Number signs (#) appearing inside a macro reference or function invocation
>     no longer introduce comments and should not be escaped with backslashes:
>     thus a call such as:
>       foo := $(shell echo '#')
>     is legal.  Previously the number sign needed to be escaped, for example:
>       foo := $(shell echo '\#')
>     Now this latter will resolve to "\#".  If you want to write makefiles
>     portable to both versions, assign the number sign to a variable:
>       C := \#
>       foo := $(shell echo '$C')
>     This was claimed to be fixed in 3.81, but wasn't, for some reason.
>     To detect this change search for 'nocomment' in the .FEATURES variable.
>
> This also fixes up the two make-cmd instances to replace # with $(pound)
> rather than with \#. There might very well be other places that need
> similar fixup in preparation for whatever future Make release contains
> the above change, but at least this builds an x86_64 defconfig with the
> new make.
>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=197847
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

Applied to linux-kbuild.  Thanks!


-- 
Best Regards
Masahiro Yamada
