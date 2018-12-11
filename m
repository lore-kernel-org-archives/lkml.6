Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5130AC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591F20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1591F20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeLKXzk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:55:40 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34345 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:55:39 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so9767753qkg.1;
        Tue, 11 Dec 2018 15:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RWHElSqwRh5MDQ86kO/UBNuOkR+yOjYHlHsVhLxfWxo=;
        b=o8wmaWqFL5Sw3AHQdZ45kPWVUa8ArerrAfiK0HptZaJXSu4Fstgvr1VW2urNQB6m+H
         DXPSkMJXrrC6tSM3mQtOgSD/bE2OUinsIcCxnwBfIE41WTufXd3zSa4+bqelKGtMe+bI
         n8ky38EMcv4B2Wgta+3eu0Dusz57HosYA0XtsT5FBw9p/ZQB6lQKTC1TxtA7UNKkaY48
         RyN6e1DOyiRGkkBsCLiFHosBtOCPXeo8CoflAdKWa4SLyAC5z5H0o30Ehpmj1BLJY5jj
         enZsLVhdIfG4kKOVF1ilX/9aLO5PU34YFd78ynhu/YbS/TrOtdsTmiQgfQW60xpc5PWy
         96FA==
X-Gm-Message-State: AA+aEWZjAyo5KqdA1TWPOZH1y1gZUhuKBMldImJzOH2qP762iNoyWzJM
        fTAxzF71KR5HTskcbTZSrf0d6DX9G1YTVvm40TY=
X-Google-Smtp-Source: AFSGD/Xafx7SKB4VErR7ZnsLKE/7AeBfeEjAId0zWLfXzIgwBeUqAHc3HuSxPSlaIxSc9wLPmhJfA3uYDYh8zMdt/54=
X-Received: by 2002:a37:324a:: with SMTP id y71mr16550264qky.291.1544572538477;
 Tue, 11 Dec 2018 15:55:38 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org> <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
 <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org>
In-Reply-To: <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Dec 2018 00:55:20 +0100
Message-ID: <CAK8P3a1aue66QS32OkZv-j1r3wX4a_iqox=uyHFN=RGoUx_SMg@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     tg@mirbsd.de
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>, vapier@gentoo.org,
        "H.J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:38 AM Thorsten Glaser <tg@mirbsd.de> wrote:
>
> Andy Lutomirski dixit:
>
> >What happens if someone adds a struct like:
> >
> >struct nasty_on_x32 {
> >  __kernel_long_t a;
> >  void * __user b;
> >};
> >
> >On x86_64, that's two 8-byte fields.  On x86_32, it's two four-byte
> >fields.  On x32, it's an 8-byte field and a 4-byte field.  Now what?
>
> Yes, that’s indeed ugly. I understand. But don’t we already have
> this problem with architectures which support multiple ABIs at the
> same time? An amd64 kernel with i386 userspace comes to mind, or
> the multiple MIPS ABIs.

The main trouble that I see with x32 is in how it's different
from all the other compat architectures. We have a number
of drivers that support not only two ABIs (native and compat)
but also a third one specifically for x32, and more drivers
that fail on x32 because they never implemented the third
case.

Note that this is not a problem for MIPS n32 and aarch64ilp32,
which generally stick to the regular compat ABI (each compat
architecture has some minor quirks somewhere, much less so
than x32 does).

> >actually do this work.  Instead we get ad hoc fixes for each syscall,
> >along the lines of preadv64v2(), which get done when somebody notices
>
> Yes, that’s absolutely ugly and ridiculous and all kinds of bad.
>
> On the other hand, from my current experience, someone (Arnd?) noticed
> all the currently existing baddies for x32 already and fixed them.

I did some, and others did more, but it's hard to ever do a complete
job, and even harder to prevent new bugs from creeping in.

> New syscalls are indeed an issue, but perhaps something generating
> copyinout stubs could help. This might allow other architectures
> that could do with a new ABI but have until now feared the overhead
> as well. (IIRC, m68k could do with a new ABI that reserves a register
> for TLS, but Geert would know. At the same time, time_t and off_t could
> be bumped to 64 bit. Something like that. If changing sizes of types
> shared between kernel and user spaces is not something feared…)

Creating a completely new ABI for an existing architecutre is generally
something you want to avoid, as this means all existing user space
has to be recompiled.

All architectures support 64-bit off_t already, and soon will support
64-bit time_t as well, at this point (as of this week's linux-next)
we mostly just need to assign a couple of syscall numbers for each
32-bit architectures.

        Arnd
