Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67CFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAD92070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbeLNPSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:18:07 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:54862 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbeLNPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:18:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E2D5D6083240;
        Fri, 14 Dec 2018 16:18:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1KDpv6F4BDFH; Fri, 14 Dec 2018 16:18:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1C3C6608324E;
        Fri, 14 Dec 2018 16:18:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id urO14blIPsXz; Fri, 14 Dec 2018 16:18:01 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id EF6236083240;
        Fri, 14 Dec 2018 16:17:59 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Richard Weinberger' <richard.weinberger@gmail.com>,
        "kevin@guarana.org" <kevin@guarana.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "dalias@libc.org" <dalias@libc.org>,
        "x32@buildd.debian.org" <x32@buildd.debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can we drop upstream Linux x32 support?
Date:   Fri, 14 Dec 2018 16:17:59 +0100
Message-ID: <3143388.E8mgBzaflP@blindfold>
In-Reply-To: <d54d7ea7c558474583dfed0d26f05ccd@AcuMS.aculab.com>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com> <CAFLxGvy2sMW1nyMpxGN7xHPdUea713g89MdE3EcUNHJDCvZ3jA@mail.gmail.com> <d54d7ea7c558474583dfed0d26f05ccd@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 14. Dezember 2018, 15:38:53 CET schrieb David Laight:
> From: Richard Weinberger
> > Sent: 13 December 2018 09:05
> > On Thu, Dec 13, 2018 at 6:03 AM Kevin Easton <kevin@guarana.org> wrote:
> > >
> > > On Tue, Dec 11, 2018 at 11:29:14AM +0100, John Paul Adrian Glaubitz wrote:
> > > ...
> > > > I can't say anything about the syscall interface. However, what I do know
> > > > is that the weird combination of a 32-bit userland with a 64-bit kernel
> > > > interface is sometimes causing issues. For example, application code usually
> > > > expects things like time_t to be 32-bit on a 32-bit system. However, this
> > > > isn't the case for x32 which is why code fails to build.
> > >
> > > OpenBSD and NetBSD both have 64-bit time_t on 32-bit systems and have
> > > had for four or five years at this point.
> > 
> > They can also do flag-day changes and break existing applications, Linux not.
> 
> Not true at all.
> The binary compatibility in NetBSD is probably better than that in Linux
> and goes back a long way.
> 
> For the time_t changes new system calls numbers were assigned where needed.
> The system headers and libc were updated so that recompiled code would
> use the new system calls.
> 
> The only real advantage that NetBSD has is that its libc (and standard
> utilities) are released with the kernel making it much easier to get
> applications to use the new features.
> 
> This was also done a very long time ago when file offsets were extended
> to 64 bits.
> 
> Some of the system calls have quite a few 'compatibility' versions.
> As well as the ones for emulations of other operating systems.
> It has been possible to run copies of firefox compiled for Linux
> under NetBSD.

I stand corrected, I was under the impression that NetBSD went the same
path as OpenBSD did. Thanks for pointing this out.

Thanks,
//richard


