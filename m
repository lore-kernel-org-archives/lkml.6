Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B01EC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A7520851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A7520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLKXiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:38:10 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58778 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKXiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:38:10 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gWrbJ-0007pV-00; Tue, 11 Dec 2018 23:38:05 +0000
Date:   Tue, 11 Dec 2018 18:38:05 -0500
From:   Rich Felker <dalias@libc.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     tg@mirbsd.de, Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Can we drop upstream Linux x32 support?
Message-ID: <20181211233805.GO23599@brightrain.aerifal.cx>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org>
 <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:22:43PM -0800, Andy Lutomirski wrote:
> On Tue, Dec 11, 2018 at 2:14 PM Thorsten Glaser <tg@mirbsd.de> wrote:
> > I was also considering investing a nontrivial amount of
> > work into porting klibc to x32, since hpa does not wish
> > to do it himself. Thankfully I have only done a bit yet.
> >
> > Furthermore, x32 was the first of the many *64ilp32
> > architectures; I know I’ve seen amd64ilp32 and at least
> > one other I don’t recall. It will have prototyped many
> > of the problems users of these will run in, and I’d prefer
> > to keep it (completely selfish because I don’t wish to
> > have to crossgrade a whole system yet again).
> 
> it kind of seems like arm64's lesson is "don't do it like x32".
> 
> There's some effort going on right now to make it possible to add
> syscalls without having to muck with every single architecture.  I
> don't really want x32 to derail that effort.  I suppose we could say
> that x32 stays but that it simply gets no new syscalls, but that seems
> a bit lame.  Unfortunately, on x86, x32 really is a third ABI that is
> not compatible in a structure-memory-layout sense with the other two.
> What happens if someone adds a struct like:
> 
> struct nasty_on_x32 {
>   __kernel_long_t a;
>   void * __user b;
> };
> 
> On x86_64, that's two 8-byte fields.  On x86_32, it's two four-byte
> fields.  On x32, it's an 8-byte field and a 4-byte field.  Now what?
> 
> I'm sure we could have some magic gcc plugin or other nifty tool that gives us:
> 
> copy_from_user(struct struct_name, kernel_ptr, user_ptr);
> 
> where it automatically generates code for all possible ABIs to copy
> over the struct and dispatches dynamically based on the current
> syscall ABI, but I have trouble imagining anyone volunteering to
> actually do this work.  Instead we get ad hoc fixes for each syscall,
> along the lines of preadv64v2(), which get done when somebody notices
> a problem.

For what it's worth, this is exactly what I plan to do if/when I ever
get to doing my kernel with multiple/universal userspace ABI support:
pure-data markup for the data structures (and syscall argument
arrangements) userspace is speaking, with generic marshalling code.
But I don't think it's easy to retrofit to Linux, and probably
wouldn't be welcome there.

Rich
