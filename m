Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581E8C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0016B23D65
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNV+Rb8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0016B23D65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeJVV6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:58:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39184 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeJVV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:58:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id p11-v6so3979338lfc.6;
        Mon, 22 Oct 2018 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8sQfTUcLqE8TApD3u96Q2vEEW2OfQeFAA+2Uyiw28k=;
        b=QNV+Rb8mbd8RR9TR0kmkIsA4awKsTC6rLUIYmb8YNk9PiJtpkWrSFlPGV93GEvQR/b
         MOe4yx++K+9FYqaoG9IiWD5jYohQJeNrZjBzHx4ys/ToJrd4xQ4VT6eSqKhpggV9RLl1
         mGalG7Ty0J8qJEriXY0WptLIhSU6iSrpFCwdLmHgPmD8q9EXaDh9j5ap//NPjkd80BZc
         krQ541rKPQTtEkus5EGm6bZWbbXgjSrr1N8gQ4i5W8r1slGavX+kXEaCPelnwOw/ofwZ
         7RQdX1srDOGiA8K+gf8H5YQhc73cyVDswNflrQhhpobEx+wDMqgOp5XZLllDEnqjDmgp
         ofeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8sQfTUcLqE8TApD3u96Q2vEEW2OfQeFAA+2Uyiw28k=;
        b=aqxoMdP03JKQJ1oQuLwF3JjfIjZptYMXHv+MKO1BKWNMdBQLx/fs7z4lOmGGM4sqoj
         UV92krHFzwhQ/sMSvTW3kXkbmVadtur1SYI9OQidwhWFMx1GeSn0S01sCQaLtibemq7B
         IJ3XS1HbPYe50TvN1aiHi82zEoQ/cvIAd5cmVm0XKJkK/r9uUZ7DYC9JQxoJc7i/MxzW
         c8sYtlS+Z11z3GORpmC2K76uS8orE9tCoh49ugaGBx8prNuwte3SilnjazX7nkvg+xuG
         vxC65ESNcK+5dCcSDerjYWT/DDB8oaGjH1owOdMuHH3l964SSDHwowqV8K901h4LaWBo
         HK4g==
X-Gm-Message-State: ABuFfohMumVnMZ13yggc56KQTRtCq2H6aPBbWfqAYWbnPbx3AtjtJb8C
        luHHuVnMD+Y8Svb6kevAUwtC0BWsHze2vmUzPSI=
X-Google-Smtp-Source: ACcGV62YuzbWOrVcbB77xv1qRltSvNdQ0hyhvNFXhF+NpIqYY0RsAr5673XN9NRVmXRiPfuJa5ilwyBpz0U4Xh5VEa0=
X-Received: by 2002:a19:11c2:: with SMTP id 63mr9060920lfr.131.1540215598557;
 Mon, 22 Oct 2018 06:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
 <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com>
 <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com>
 <CAGXu5jLzfuEnWpJFL1Caq94nKbPps-QTaYGpge2CfZWj1Zzf9g@mail.gmail.com> <CANiq72kpCoVwCzMUVYB_km+9xr41gBZLo_K203e_t4_QZ9-r1Q@mail.gmail.com>
In-Reply-To: <CANiq72kpCoVwCzMUVYB_km+9xr41gBZLo_K203e_t4_QZ9-r1Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 15:39:47 +0200
Message-ID: <CANiq72k_uBxjzguG8YBmSaV5XUYoOsuHk+UHFdgCarr4--uGDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Ted Ts'o" <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 1:24 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 22, 2018 at 12:53 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Oct 22, 2018 at 2:41 AM, Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > >   * clang does *not* support the attribute in C.
> >
> > Well that's not good. :)
>
> I will see with clang if they plan to add it.
>

So I have looked in the clang sources and I have seen that clang is
already preparing for C2x: since clang >= 6 we can actually enable the
C++-like attributes with "-fdouble-square-bracket-attributes" in C
mode, which in turn makes the warning work in C mode and can be
suppressed with [[fallthrough]]. This would give us the warning also
in clang, which would be a win vs. the comments. Nick?

However, I don't see a way to enable [[fallthrough]] in C mode for gcc
>= 7.1 -- from a quick look, the C parser does not know about [[]]
attributes, so I don't think we can use [[fallthrough]] for both
compilers (yet).

Cheers,
Miguel
