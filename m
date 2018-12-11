Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541E7C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C1D2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C1D2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLKXG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:06:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34262 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKXGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:06:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so18536474qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IkMmH1mhXU3VW4ObtR4ZJXKnvYitIo1p/cFOmAJ9SzA=;
        b=A5rWtC6enl3dBTnDfno5JzpqH++Mb3+Lno2KN9KQqVTjYfGBbB/IrWPb8mlRI2DaaK
         Dekjb/57rzfKpTlV0GZEX0QhqJ5u+/tOPVWsmxIb0bhlM32xZ7O06FQBkXQGJElzfLHw
         i8QFN84WThMxI1PPluPqHeijQqhqpplWgHmtOv+WFeUXGQNKOhuwAIgucGKBXhfd23B+
         Dp5Lfv1VYmF3jgroF/UkCe4KHe/F22E2Q7bO3LGKcotO4jDf3R9uYyD1juiX9Hd14UBP
         KfpMnrj6LK+mU0oF7dZwZldtP/19r6YpyooS+qIQgZaWG4YwZ6nqKqdkiHoO5CX+eTG6
         C2hw==
X-Gm-Message-State: AA+aEWYEpFerHQAjuXVvCaoNkJD/LvUTtkgL6MglP9fI9TxnXn4joPe5
        i82yCiLLNRrPvRe6Cn5UM7LdJjrGfwJCDKMoW00=
X-Google-Smtp-Source: AFSGD/X8jzW69BTylF8O0Ixvaa950UNnYKIbZ69F/PgNkgC9yD47Wkq1l5jsLWlTz5PBr8KsBbKFCTTa+YsO0f7qZ+o=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr17559848qvj.161.1544569584375;
 Tue, 11 Dec 2018 15:06:24 -0800 (PST)
MIME-Version: 1.0
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us> <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw> <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
 <1544565158.18411.5.camel@lca.pw> <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
 <1544565572.18411.7.camel@lca.pw> <CAK8P3a2kStKc8bB1cXh=PEaVUMcg01o5AqtGM5NyJ0RT0JLPuA@mail.gmail.com>
 <1544566937.18411.9.camel@lca.pw>
In-Reply-To: <1544566937.18411.9.camel@lca.pw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Dec 2018 00:06:07 +0100
Message-ID: <CAK8P3a2T-DDfmpN_KcLB8cZKTszE4tohR8ChtktP3-du76hJog@mail.gmail.com>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
To:     cai@lca.pw
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:22 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2018-12-11 at 23:12 +0100, Arnd Bergmann wrote:
> > On Tue, Dec 11, 2018 at 10:59 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > On Tue, 2018-12-11 at 22:56 +0100, Arnd Bergmann wrote:
> > > > On Tue, Dec 11, 2018 at 10:52 PM Qian Cai <cai@lca.pw> wrote:
> > > > > On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> > > > > > On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
> > > > >
> > > > > I am not too keen to do the version-check considering some LTS versions
> > > > > could
> > > > > just back-port those patches and the render the version-check
> > > > > incorrectly.
> > > >
> > > > I'm not following what the problem is. Do you mean distro versions gcc
> > > > with the compiler bugfix, or LTS kernel versions?
> > > >
> > >
> > > I mean distro versions of GCC where the version is still 8 but keep back-
> > > porting
> > > tons of patches.
> >
> > Ok, but in that case, checking the version would still be no worse
> > than your current patch, the only difference is that for users of a
> > fixed older gcc, the kernel would use more stack than it needs.
> >
>
> I am thinking about something it is probably best just waiting for those major
> distors to complete upgrading to GCC9 or back-porting those stack reduction
> patches first. Then, it is good time to tie up loose ends for those default
> stack sizes in all combinations.

I was basically trying to make sure we don't forget it when it gets to that.

Another alternative would be to just disable KASAN_EXTRA now
for gcc versions before 9, which essentially means for everyone,
but then we get it back once a working version gets released. As
I understand, this kasan option is actually fairly useless given its
cost, so very few people would miss it.

On a related note, I think we have to turn off asan-stack entirely
on all released clang versions. asan-stack in general is much more
useful than the use-after-scope check, but we clang produces some
very large stack frames with it and we probably can't even work
around it with KASAN_THREAD_SHIFT=2 but would need even
more than that otherwise.

         Arnd
