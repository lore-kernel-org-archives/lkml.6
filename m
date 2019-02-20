Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E678C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FB920880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBTVNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:13:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43136 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:13:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id y4so28990644qtc.10;
        Wed, 20 Feb 2019 13:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYAM8803DgMBsb+plIT908312TQzSVQLnERb5Qtg750=;
        b=XjUOsRuxe8B1+rOcfoJGFXb1vZmTNNqDa+HABT0DZk65GhLT5q5EQXNQb1WFaXTuYe
         pw2dHDfsEmmOj1O1uaSKiNSIEcpGaYE37C5tBvXeD5q050kwB5H+uXguvDtRqXxGqJun
         MNDlPhZp2WpQJlS1+HsXTj6IYiYbkU233z0vORs12jhNkMcUTFZdYK17kk8kK++1/xH6
         dlJgpjQOXN3qkLPAmWb4WhS2XSGgJWyxYQ42N5bwmkgRDxjc2naJZ3RRAVrP2uTtAWdd
         em5LNzOA67emRRS4wBekWxEPSvIiAB0YGmxKQWlMuCB+OmfgmnHMTma5ezWvVXHh2jAR
         u/Kw==
X-Gm-Message-State: AHQUAuaFl/x+uaP7l4T1nUUAVkhWhg4XEO2EjzxcCVDLaOieGYONu4CT
        Ga5lNpLWSKBU9FR2R7oObybra+jcBi7q4JnkW4I=
X-Google-Smtp-Source: AHgI3IbvvWfrxSH/Cv41CJi7HaZ7Ih38IWIFoQv0x80kdcuA+g7UUJqZn6OaGDz4NupwvzyCVdKJeoIciycCe78pZH4=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr29107490qta.152.1550697219940;
 Wed, 20 Feb 2019 13:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
 <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
 <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com> <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
 <CAKwvOd=XrNNb=r3qgsT8O6JNzL4hg4pqfJJFcY2DzA0Ooc=E3w@mail.gmail.com>
 <20190220184408.GG9878@sirena.org.uk> <CAKwvOdne3aE5bUsQF-2C-L2Xezqq9qb=NqF8FA+B7nvqXKAXFA@mail.gmail.com>
In-Reply-To: <CAKwvOdne3aE5bUsQF-2C-L2Xezqq9qb=NqF8FA+B7nvqXKAXFA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 22:13:22 +0100
Message-ID: <CAK8P3a1pop4WqWxV=-R4n1Lh3FYG0mb4iJk4=saq6CgzpsPe4A@mail.gmail.com>
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

On Wed, Feb 20, 2019 at 9:02 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Feb 20, 2019 at 10:44 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Wed, Feb 20, 2019 at 10:07:36AM -0800, Nick Desaulniers wrote:
> >
> > > I like Evgenii's idea:
> > > https://bugs.llvm.org/show_bug.cgi?id=38809#c10
> >
> > That's a suggestion to tune the inlining heuristics.
>
> Yes; but it will also improve KASAN (if feasible).

From my experiments that I cited in the bug report, very few cases
seem to actually be the result of different inlining decisions, and those
that are tend to be kernel bugs (e.g. in drivers/scsi/bfa/bfa_fcs_lport.c
clang reports a larger stack than gcc because it combines two functions
that individually use 800 bytes each, but if one calls the other, we
use even more stack than the combined function).

In the example in https://bugs.llvm.org/show_bug.cgi?id=38809#c12
(https://godbolt.org/z/ylsGSQ) there is no inlining, yet clang uses
over ten times as much stack space as gcc, for reasons I still
can't explain. My assumption right now is that the underlying bug
causes most of the problems with excessive stack usage in
allmodconfig kernels.

> > > While I myself share Arnd's goal of driving compiler warnings to zero,
> > > in general I'd prefer not to disable warning-producing-features or
> > > disable warnings outright for cases where we have some ideas of
> > > changes we can make to the compiler.  There's probably a list now of
> > > false warnings produced by old versions of Clang from bugs in Clang
> > > that we fixed.  I'm not interested in additionally trying to work
> > > around those somehow in kernel sources.
> >
> > We do have infrastructure in the kernel for managing warnings based on
> > compiler version (Arnd was looking at some improvements to that IIRC),
> > if we've got a kernel that builds with a given compiler it's worth
> > looking at tuning what we do with that compiler.  If newer versions of
> > the compiler work better or have new options we can turn things on for
> > them.
>
> so maybe something like (pseudocode):
> if kasan && clang && clang_version < 9:
>   disable -Wframe-larger-than=
>
> If you overrun the stack with KASAN, a warning would be nice, but
> you'll hopefully find out the hard way at runtime.  And that doesn't
> require up to 114 Makefile changes, which would be kind of obnoxious
> for this papercut.

That would mean that build testing allmodconfig with clang would
ignore all the interesting stack overflow bugs that happen in real
user systems without KASAN.

       Arnd
