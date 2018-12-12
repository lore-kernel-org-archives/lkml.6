Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362F2C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDAA20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDAA20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeLLOB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:01:59 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58812 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLOB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:01:59 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gX559-00022j-00; Wed, 12 Dec 2018 14:01:47 +0000
Date:   Wed, 12 Dec 2018 09:01:47 -0500
From:   Rich Felker <dalias@libc.org>
To:     Steven Newbury <steve@snewbury.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        macro@linux-mips.org, tg@mirbsd.de, luto@kernel.org, arnd@arndb.de,
        s@ecloud.org, catalin.marinas@arm.com, fweimer@redhat.com,
        glaubitz@physik.fu-berlin.de, christian.brauner@canonical.com,
        hjl.tools@gmail.com, hpa@zytor.com
Subject: Re: Can we drop upstream Linux x32 support?
Message-ID: <20181212140147.GR23599@brightrain.aerifal.cx>
References: <1544605954.117529.27.camel@snewbury.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544605954.117529.27.camel@snewbury.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 09:12:34AM +0000, Steven Newbury wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> First off I'd like to request: Please don't break my userspace!
> 
> I have a number of systems running with x32-abi as native.  They work
> well, I've no want or desire to upgrade their memory or CPUs to make
> keep them working as well as they do now.  Let alone the hassle of
> having to redeploy with a completely different ABI.
> 
> 
> I've been working on getting as much userspace as I can working with
> x32 since it first became somewhat usable, I've sent patches upstream
> and pushed to encourage projects to write portable code.  Sometimes
> that has meant just little tweaks to build systems, or sometimes
> disabling asm where I consider it isn't worth the effort of making it
> work.  For other projects I've converted the asm or even in some cases
> got the JIT working, mozjs17 for example.
> 
> So I'm both a user and a developer.
> 
> Breaking support for x32 would be really bad for me, but if I'm the
> only one using it I suppose I can't really justify it being kept on
> that basis.  I know CERN has sucessfully experimented with it over the
> years though, so I wouldn't be surprised if there are other users
> hiding out there.
> 
> I can't help but wonder if it wouldn't make more sense to drop x86
> support from long mode than x32.  AMD64 x86 support was always intended
>  as a compatibility feature, I very much doubt there are more people
> out there using an x86 native userspace on a 64 bit kernel than there

I am. The only reason I'm using a 64-bit kernel with it is to get the
full 4GB address space for userspace rather than just 3GB. I suspect
there are more users like me than like you.

Unlike x32, i386 is actually widely supported and works, and achieves
most of the benefits of x32, but with marginally worse performance due
to register scarcity, lack of native 64-bit arithmetic, bad function
call ABI, and bad PC-relative addressing. For applications that aren't
performance sensitive it's the right choice for shipping static
binaries, especially if they may be memory-hungry, since it works on
pretty much any box.

> are native x32 users.  x86 support could be implemented via KVM and/or
> qemu-user.  There is no reason to keep the extra complexity in the
> kernel for what is effectively an emulation layer anyway.

qemu-user is a non-solution. Not only does it result in being much
slower and using more resources than just running a 64-bit userspace
(defeating the purpose); it's also incapable of correctly emulating
lots of corner cases. I've never been able to get it to work with
thread cancellation, and doing so is fundamentally hard because it
would require heavy emulation of signals rather than passing them
through.

Rich
