Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD6CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14B52070D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbeLNQNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:13:33 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58994 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeLNQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:13:33 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gXq5X-0004dk-00; Fri, 14 Dec 2018 16:13:19 +0000
Date:   Fri, 14 Dec 2018 11:13:19 -0500
From:   Rich Felker <dalias@libc.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andy Lutomirski <luto@kernel.org>, tg@mirbsd.de,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: Can we drop upstream Linux x32 support?
Message-ID: <20181214161319.GX23599@brightrain.aerifal.cx>
References: <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
 <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org>
 <CALCETrUYn=S=hmJ0tKdm2LoSgkWchY2_65sH7hJZp7wfS30giw@mail.gmail.com>
 <20181212165237.GT23599@brightrain.aerifal.cx>
 <CALCETrV6+YAazq7vY_aR=4kXc4ykXb1Se7hgvHeEVJtbZ91=Qg@mail.gmail.com>
 <20181213124025.bczxzj6ez34joo6v@localhost>
 <20181213155744.GU23599@brightrain.aerifal.cx>
 <87o99pl8es.fsf@oldenburg2.str.redhat.com>
 <20181213162828.GW23599@brightrain.aerifal.cx>
 <875zvwibbp.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zvwibbp.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:42:34PM +0100, Florian Weimer wrote:
> * Rich Felker:
> 
> > On Thu, Dec 13, 2018 at 05:04:59PM +0100, Florian Weimer wrote:
> >> * Rich Felker:
> >> 
> >> >> If the compiler can handle the zeroing, that would be great, though not
> >> >> sure how (some __attribute__((zero)) which generates a type constructor
> >> >> for such structure; it kind of departs from what the C language offers).
> >> >
> >> > The compiler fundamentally can't. At the very least it would require
> >> > effective type tracking, which requires shadow memory and is even more
> >> > controversial than -fstrict-aliasing (because in a sense it's a
> >> > stronger version thereof).
> >> 
> >> It's possible to do it with the right types.  See _Bool on 32-bit Darwin
> >> PowerPC for an example, which is four bytes instead of the usual one.
> >> 
> >> Similarly, we could have integer types with trap representations.
> >> Whether it is a good idea is a different matter, but the amount of
> >> compiler magic required is actually limited.
> >
> > If you do this you just have LP64 with value range restricted to
> > 32-bit.
> 
> You have to a type different from long int for the relevant struct
> fields.  This type would have zero padding.

Just upthread (Message-ID: <20181212165237.GT23599@brightrain.aerifal.cx>)
I explained why this does not work:

>>> If on the other hand you tried to make just some pointers "wide
>>> pointers", you'd also be completely breaking the specified API
>>> contracts of standard interfaces. For example in struct iovec's
>>> iov_base, &foo->iov_base is no longer a valid pointer to an object of
>>> type void* that you can pass to interfaces expecting void**. Sloppy
>>> misunderstandings like what you're making now are exactly why x32 is
>>> already broken and buggy (&foo->tv_nsec already has wrong type for
>>> struct timespec foo).

Rich
