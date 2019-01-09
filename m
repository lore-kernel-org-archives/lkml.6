Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB428C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19B6206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbfAIMlW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:41:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730792AbfAIMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:41:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93BC02CD7E9;
        Wed,  9 Jan 2019 12:41:20 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-219.str.redhat.com [10.33.192.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC994608DD;
        Wed,  9 Jan 2019 12:41:15 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Thomas =?utf-8?Q?Sch=C3=B6bel-Theuer?= <thomas@schoebel-theuer.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can we drop upstream Linux x32 support?
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
        <6577ac4f-524c-37f4-a4d0-6eb94ec7d9a5@schoebel-theuer.de>
Date:   Wed, 09 Jan 2019 13:41:14 +0100
In-Reply-To: <6577ac4f-524c-37f4-a4d0-6eb94ec7d9a5@schoebel-theuer.de>
        ("Thomas \=\?utf-8\?Q\?Sch\=C3\=B6bel-Theuer\=22's\?\= message of "Fri, 14 Dec 2018
 22:16:17
        +0100")
Message-ID: <871s5muhp1.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 09 Jan 2019 12:41:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Schöbel-Theuer:

> 2) please _announce_ _now_ that after the _next_ LTS kernel (whichever
> you want to declare as such), you will _afterwards_ drop the legacy
> 32bit support for 64 kernels (I am deliberately using "management
> speak" here).
>
> => result: the industry should have to fair chance to deal with such a
> roadmap. Yes, it will hurt some people, but they will have enough time
> for their migration projects.
>
> Example: I know that out of several millions of customers of
> webhosting, a very low number of them have some very old legacy 32bit
> software installed in their webspace. This cannot be supported
> forever. But the number of such cases is very small, and there just
> needs to be enough time for finding a solution for those few
> customers.
>
> 3) the next development kernel _after_ that LTS release can then
> immediately drop the 32bit support. Enterprise users should have
> enough time for planning, and for lots of internal projects
> modernizing their infrastructure. Usually, they will need to do this
> anyway in the long term.

We've already phased out support for all 32-bit architectures except
i386 in our products, and i386 is obviously next.  (We never supported
x32 in the first place.)

It becomes increasingly difficult to build a 32-bit userspace that meets
backwards-compatibility needs.  We want to use SSE2 (to avoid excess
precision for double) and avoid relying on stack realignment (for
compatibility with applications that use the old i386 ABI which did not
require stack realignment).  We also have to build the distribution with
a full complement of hardening flags.  This results in a combination of
flags that is poorly tested in upstream GCC.  The i386 register file
isn't large enough to support all these features at the same time and
combine them with function arguments passed in registers (which some
programs enable manually via function attributes).

So even if we keep the kernel interface, in the forseeable future, I
expect that it will be difficult to build a full, contemporary 32-bit
userspace on i386.

Thanks,
Florian
