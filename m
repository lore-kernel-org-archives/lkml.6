Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A631CC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEA920663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pToAUWGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEA920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeJWBhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:37:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38092 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbeJWBhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:37:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id p7-v6so435366plk.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oA7xr5QeyWJpzokAhtSgAZl5pfjfuog8CUj3NpYcIkc=;
        b=pToAUWGJxfD4G2VB3Ervq0Msf+5dcWN7zvEuegKdnTlgHJ6Qb5lIIqMf+tXcv3ld2u
         z2IqNhpTlOpPtqgJwA1Sc2LqFliQGIDNdBy4/YEwO+GChHT4cffCgZCainXaRHmLxwW7
         BuSRHuw/EFb71uQVQsUJeERaWGiSRsQzVBAGza763li/0MygUMaVdk3VVOFJLqxCG6Ma
         5eZIldSOi2/Ar3BQz+8z3MAj4WcnYeGi252NgWIV3i/iakLxgJUCPFY5s/VyvZhzI1Z+
         qPoioPtnB9k/M6UpmBheLZ5yUvcuDLUuxYTvw2cxkRmiBFenH8/7GZHJRkC+zm0+79bQ
         4sDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oA7xr5QeyWJpzokAhtSgAZl5pfjfuog8CUj3NpYcIkc=;
        b=Q8g5nyYCzWxVNac0pbzZecpC17e4TRPX2zlRY0ioFSiQCv3B5KmS6F+YZ/CoXehxd9
         rEopXqzFHXujV3DdTfDh9mGVR0sI6zmF/KAXTnkezZ3ssmdYj3yBRi3gE2TJZTptbBcx
         ZstkFW+NhgSymmBYXycsczfa2xWCcTGUGLvgZAfWi2VmHckgwULyNzOMJc3blAPkAjos
         XH+muUO40yBLeFf/BRUj5stccVR4a4k85F3AaSTwdFFewmQMyTzdpnd1mhmf8ZqIOI+z
         e2nu22fcOuOdvgREjCRQ1jpsx5i75/wR8KzIcTQs8OQ1HPKo3XsVidjBL5zdjXuHckBF
         pIhA==
X-Gm-Message-State: AGRZ1gLVlJWHwclHLNT7zu3puqkEHr75IJWeSacGdWgtAkv7GPeP0USq
        OY8dYAMP7Il985aRfaHIBR3E6K28d3nVr3hNHh7v1g==
X-Google-Smtp-Source: AJdET5dzW23d7hR6omCsRZMOYe51E5ruiFFKQlqciLo2n7llX+F9ctIRc9CJ5Qz68T4o0wZZpW6SdnWrA8XKegdf12A=
X-Received: by 2002:a17:902:b412:: with SMTP id x18-v6mr11189744plr.13.1540228676261;
 Mon, 22 Oct 2018 10:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
 <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com>
 <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com> <CANiq72kNnrhi8OPbF7P+Rw4SGYu=JuvhDKtzGtG2J5AOoC1-Dw@mail.gmail.com>
In-Reply-To: <CANiq72kNnrhi8OPbF7P+Rw4SGYu=JuvhDKtzGtG2J5AOoC1-Dw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Oct 2018 10:17:44 -0700
Message-ID: <CAKwvOdn1TOzZYg_i0zB0rU+K3jaQQ8XmWnLXz01NCG9V+8PxHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, gustavo@embeddedor.com,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@oracle.com,
        adilger.kernel@dilger.ca,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org,
        mchehab+samsung@kernel.org, olof@lxom.net,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        sandipan@linux.vnet.ibm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        paul.burton@mips.com, David Rientjes <rientjes@google.com>,
        Willy Tarreau <w@1wt.eu>, msebor@gmail.com, sparse@chrisli.org,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, joe@perches.com,
        Arnd Bergmann <arnd@arndb.de>, asmadeus@codewreck.org,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 2:43 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 22, 2018 at 11:41 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> >   * clang does *not* support the attribute in C.
>
> ...nor the warning at all, by the way (which is why this is OK).
>
> Cheers,
> Miguel

Oh? We're going through and annotating all of Android's C++ source
right now with it.
https://clang.llvm.org/docs/DiagnosticsReference.html#wimplicit-fallthrough

Though it looks like the attribute syntax I like from GCC is not yet
supported in Clang.
https://bugs.llvm.org/show_bug.cgi?id=37135
https://github.com/ClangBuiltLinux/linux/issues/235
I'll take a look at adding support.

So Kees sent me this embarrassing example:
https://godbolt.org/z/gV_c9_
(try changing the language from C++ to C; it works)!  That's embarrassing!
https://bugs.llvm.org/show_bug.cgi?id=39382
https://github.com/ClangBuiltLinux/linux/issues/236
Will get these both fixed up.
-- 
Thanks,
~Nick Desaulniers
