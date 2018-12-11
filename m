Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF885C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7812081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7812081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLKLhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:37:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbeLKLhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:37:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 989C5308212D;
        Tue, 11 Dec 2018 11:37:47 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-82.ams2.redhat.com [10.36.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01F445D9CC;
        Tue, 11 Dec 2018 11:37:43 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, vapier@gentoo.org,
        Rich Felker <dalias@libc.org>, x32@buildd.debian.org,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can we drop upstream Linux x32 support?
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
        <CAMe9rOp0m5sn59AsD2F2i2Ad2tb7ufPU1mMg-vUOfh+TnGMeaw@mail.gmail.com>
        <CALCETrU5xw61=me1YcTO3VPzjNEZahMPpi-20-oiSGs+CHcj4g@mail.gmail.com>
        <CAK8P3a0adxnXr9JLfpR5MBeEJXSCK2Rt4w7NFLUUwO6s6LBVPQ@mail.gmail.com>
        <20181211113230.GB35824@arrakis.emea.arm.com>
Date:   Tue, 11 Dec 2018 12:37:42 +0100
In-Reply-To: <20181211113230.GB35824@arrakis.emea.arm.com> (Catalin Marinas's
        message of "Tue, 11 Dec 2018 11:32:31 +0000")
Message-ID: <87efaoxpix.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 11 Dec 2018 11:37:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Catalin Marinas:

> On Tue, Dec 11, 2018 at 10:02:45AM +0100, Arnd Bergmann wrote:
>> On Tue, Dec 11, 2018 at 6:35 AM Andy Lutomirski <luto@kernel.org> wrote:
>> > I tried to understand what's going on.  As far as I can tell, most of
>> > the magic is the fact that __kernel_long_t and __kernel_ulong_t are
>> > 64-bit as seen by x32 user code.  This means that a decent number of
>> > uapi structures are the same on x32 and x86_64.  Syscalls that only
>> > use structures like this should route to the x86_64 entry points.  But
>> > the implementation is still highly dubious -- in_compat_syscall() will
>> > be *true* in such system calls,
>> 
>> I think the fundamental issue was that the intention had always been
>> to use only the 64-bit entry points for system calls, but the most
>> complex one we have -- ioctl() -- has to use the compat entry point
>> because device drivers define their own data structures using 'long'
>> and pointer members and they need translation, as well as
>> matching in_compat_syscall() checks. This in turn breaks down
>> again whenever a driver defines an ioctl command that takes
>> a __kernel_long_t or a derived type like timespec as its argument.
>
> With arm64 ILP32 we tried to avoid the ioctl() problem by having
> __kernel_long_t 32-bit, IOW mimicking the arm32 ABI (compat). The
> biggest pain point is signals where the state is completely different
> from arm32 (more, wider registers) and can't be dealt with by the compat
> layer.

I would expect to approach this from the opposite direction: use 64-bit
types in places where the 64-bit kernel interface uses 64-bit types.
After all, not everyone who is interested in ILP32 has a companion
32-bit architecture which could serve as a model for the application
ABI.

(If there are conflicts with POSIX, then POSIX needs to be fixed to
support this.)

Thanks,
Florian
