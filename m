Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D65AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133602082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133602082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeLKLch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:32:37 -0500
Received: from foss.arm.com ([217.140.101.70]:44936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbeLKLcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:32:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D90CEBD;
        Tue, 11 Dec 2018 03:32:36 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F4753F6A8;
        Tue, 11 Dec 2018 03:32:33 -0800 (PST)
Date:   Tue, 11 Dec 2018 11:32:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>, vapier@gentoo.org,
        Rich Felker <dalias@libc.org>, x32@buildd.debian.org,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can we drop upstream Linux x32 support?
Message-ID: <20181211113230.GB35824@arrakis.emea.arm.com>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAMe9rOp0m5sn59AsD2F2i2Ad2tb7ufPU1mMg-vUOfh+TnGMeaw@mail.gmail.com>
 <CALCETrU5xw61=me1YcTO3VPzjNEZahMPpi-20-oiSGs+CHcj4g@mail.gmail.com>
 <CAK8P3a0adxnXr9JLfpR5MBeEJXSCK2Rt4w7NFLUUwO6s6LBVPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0adxnXr9JLfpR5MBeEJXSCK2Rt4w7NFLUUwO6s6LBVPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:02:45AM +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 6:35 AM Andy Lutomirski <luto@kernel.org> wrote:
> > I tried to understand what's going on.  As far as I can tell, most of
> > the magic is the fact that __kernel_long_t and __kernel_ulong_t are
> > 64-bit as seen by x32 user code.  This means that a decent number of
> > uapi structures are the same on x32 and x86_64.  Syscalls that only
> > use structures like this should route to the x86_64 entry points.  But
> > the implementation is still highly dubious -- in_compat_syscall() will
> > be *true* in such system calls,
> 
> I think the fundamental issue was that the intention had always been
> to use only the 64-bit entry points for system calls, but the most
> complex one we have -- ioctl() -- has to use the compat entry point
> because device drivers define their own data structures using 'long'
> and pointer members and they need translation, as well as
> matching in_compat_syscall() checks. This in turn breaks down
> again whenever a driver defines an ioctl command that takes
> a __kernel_long_t or a derived type like timespec as its argument.

With arm64 ILP32 we tried to avoid the ioctl() problem by having
__kernel_long_t 32-bit, IOW mimicking the arm32 ABI (compat). The
biggest pain point is signals where the state is completely different
from arm32 (more, wider registers) and can't be dealt with by the compat
layer.

Fortunately, we haven't merge it yet as we have the same dilemma about
real users and who's going to regularly test the ABI in the long run. In
the meantime, watching this thread with interest ;).

-- 
Catalin
