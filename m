Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0594FC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5C62084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5C62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mirbsd.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeLKWPx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:15:53 -0500
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:45957 "EHLO
        herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeLKWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:11 -0500
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2018 17:14:06 EST
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id wBBLxm1T009080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Dec 2018 22:00:06 GMT
Date:   Tue, 11 Dec 2018 21:59:48 +0000 (UTC)
From:   Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can we drop upstream Linux x32 support?
In-Reply-To: <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de>
Message-ID: <Pine.BSM.4.64L.1812112155170.21176@herc.mirbsd.org>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Paul Adrian Glaubitz dixit:

>I can't say anything about the syscall interface. However, what I do know
>is that the weird combination of a 32-bit userland with a 64-bit kernel
>interface is sometimes causing issues. For example, application code usually

Yes, but more and more ${foo}64ilp32 architectures are popping up.

>Additionally, x32 support in many applications is either rudimentary

If a signal is sent that this kind of architectures will stay, some
people might be convinced to fix that.

>It's also that the performance benefits of x32 are often eaten up by
>the fact that none of the scripted languages that I know of provide

Non-JITted languages like yours truly’s shell do benefit from it,
though. (mksh works just fine on LP64 but its internal structures
pack massively better on ILP32, for example.)

>If x32 is eventually to be removed, we should also take care of removing
>x32 support from userland code. From the top of my head, this would at least

I don’t think so. The patches also contain
– stuff to support 64-bit time_t on 32-bit architectures, e.g:
- bugfixes like printf("%lld", (long long)timet_value) instead
  of assuming time_t fits into a long (also important for other
  operating systems…)
- generally switching from generic types like long to specific
  types like size_t, ptrdiff_t, etc.
- there was one more but after having written two eMails I forgot it
- oh and, of course, they lay the base for e.g. amd64ilp32 support

bye,
//mirabilos
-- 
FWIW, I'm quite impressed with mksh interactively. I thought it was much
*much* more bare bones. But it turns out it beats the living hell out of
ksh93 in that respect. I'd even consider it for my daily use if I hadn't
wasted half my life on my zsh setup. :-) -- Frank Terbeck in #!/bin/mksh
